############################################################
#region imports
import * as secUtl from "secret-manager-crypto-utils"
import * as tbut from "thingy-byte-utils"

############################################################
import * as sci from "./authenticationinterface.js"
import * as validatableStamp from "./validatabletimestampmodule.js"

#endregion

############################################################
export class Client
    constructor: (@serverURL, @secretKeyHex) ->
        @nonce = 0
        @serverId = null
        @nextAuthCode = null

    ########################################################
    updateServerURL: (serverURL) ->
        @serverURL = serverURL
        @nonce = 0
        @serverId = null
        @nextAuthCode = null
        return

    updateSecretKey: (secretKeyHex) ->
        @secretKeyHex = secretKeyHex
        @nonce = 0
        @nextAuthCode = null
        return

    ########################################################
    incNonce: ->
        @nonce = ++@nonce % 10000000
        return

    ########################################################
    addClient: (clientId) -> await addClientToServe(clientId, this)

    removeClient: (clientId) -> await removeClientToServe(clientId, this)

    getClients:  ->
        { toServeList } = await getClientsToServe(this)
        return toServeList


    ########################################################
    getServerId: ->
        if !@publicKeyHex? then @publicKeyHex = await secUtl.createPublicKeyHex(@secretKeyHex)
        if !@serverId? then @serverId = await getValidatedNodeId(this)
        return @serverId
    
    getAuthCode: ->
        serverId = await @getServerId()
        if @nextAuthCode? then return @nextAuthCode

        # await indirectSessionSetup(this)
        await directSessionSetup(this)

        return @nextAuthCode
    

############################################################
#region internalFunctions

############################################################
#region misc Helpers

directSessionSetup = (client) ->
    
    return

############################################################
indirectSessionSetup = (client) ->
    return

############################################################
getValidatedNodeId = (client) ->
    try 
        response = await getNodeId(client)
        # {
        #     "serverNodeId": "...",
        #     "timestamp": "...",
        #     "signature": "..."
        # }
        idHex = response.serverNodeId
        timestamp = response.timestamp
        sigHex = response.signature
        
        delete response.signature
        content = JSON.stringify(response)
        console.log(content)

        await authenticateResponse(content, sigHex, idHex, timestamp)
    catch err then throw new Error("getValidatedNodeId - #{err.message}")
    return idHex
    
############################################################
authenticateResponse = (content, sigHex, idHex, timestamp) ->
    try
        if !timestamp then throw new Error("No Timestamp!") 
        if !sigHex then throw new Error("No Signature!")
        if !idHex then throw new Error("No Public key!")

        validatableStamp.assertValidity(timestamp) 
        verified = await secUtl.verify(sigHex, idHex, content)

        if !verified then throw new Error("Invalid Signature!")
        
    catch err then throw new Error("Error on authenticateResponse! " + err)
    return

#endregion


############################################################
#region cryptoHelpers
decrypt = (content, secretKey) ->
    content = await secUtl.asymmetricDecrypt(content, secretKey)
    content = secUtl.removeSalt(content)
    try content = JSON.parse(content) 
    catch err then return content # was no stringified Object


    if content.encryptedContent? || content.encryptedContentHex? 
        content = await secUtl.asymmetricDecrypt(content, secretKey)
        content = secUtl.removeSalt(content)
        try content = JSON.parse(content)
        catch err then return content # was no stringified Object

    return content

############################################################
encrypt = (content, publicKey) ->
    if typeof content == "object" then content = JSON.stringify(content)
    salt = secUtl.createRandomLengthSalt()    
    content = salt + content

    content = await secUtl.asymmetricEncrypt(content, publicKey)
    return JSON.stringify(content)

############################################################
createSignature = (payload, route, secretKeyHex) ->
    content = route+JSON.stringify(payload)
    return await secUtl.createSignature(content, secretKeyHex)

#endregion

############################################################
#region effectiveSCI
getNodeId = (client) ->
    secretKey = client.secretKeyHex
    publicKey = client.publicKeyHex
    sciURL = client.serverURL
    timestamp = validatableStamp.create()

    nonce = client.nonce
    client.incNonce()

    payload = { publicKey, timestamp, nonce}
    route = "/getNodeId"

    signature = await createSignature(payload, route, secretKey)    
    reply = await sci.getNodeId(sciURL, publicKey, timestamp, nonce, signature)
    if reply.error? then throw new Error("getNodeId replied with error: "+reply.error)
    return reply



############################################################
startSession = (action, client) ->
    server = client.serverURL
    publicKey = client.publicKeyHex
    secretKey = client.secretKeyHex
    timestamp = validatableStamp.create()

    nonce = client.nonce
    client.incNonce()

    payload = {publicKey, action, timestamp, nonce}
    route = "/createAuthCode"
    signature = await createSignature(payload, route, secretKey)
    reply =  await sci.createAuthCode(server, publicKey, action, timestamp, signature, nonce)
    if reply.error? then throw new Error("createAuthCode replied with error: "+reply.error)
    return reply
    
############################################################
addClientToServe = (clientPublicKey, client) ->
    secretKey = client.secretKeyHex
    sciURL = client.serverURL
    timestamp = validatableStamp.create()
    
    nonce = client.nonce
    client.incNonce()

    payload = {clientPublicKey, timestamp, nonce}
    route = "/addClientToServe"

    signature = await createSignature(payload, route, secretKey)    
    reply = await sci.addClientToServe(sciURL, clientPublicKey, timestamp, nonce, signature)

    if reply.error then throw new Error("addClientToServe replied with error: #{reply.error}")
    return reply


############################################################
removeClientToServe = (clientPublicKey, client) ->
    secretKey = client.secretKeyHex
    sciURL = client.serverURL
    timestamp = validatableStamp.create()
    
    nonce = client.nonce
    client.incNonce()

    payload = {clientPublicKey, timestamp, nonce}
    route = "/removeClientToServe"

    signature = await createSignature(payload, route, secretKey)    
    reply = await sci.removeClientToServe(sciURL, clientPublicKey, timestamp, nonce, signature)

    if reply.error then throw new Error("removeClientToServe replied with error: #{reply.error}")
    return reply

############################################################
getClientsToServe = (client) ->
    secretKey = client.secretKeyHex
    sciURL = client.serverURL
    timestamp = validatableStamp.create()
    
    nonce = client.nonce
    client.incNonce()

    payload = {timestamp, nonce}
    route = "/getClientsToServe"

    signature = await createSignature(payload, route, secretKey)    
    reply = await sci.getClientsToServe(sciURL, timestamp, nonce, signature)

    if reply.error then throw new Error("getClientsToServe replied with error: #{reply.error}")
    return reply

#endregion

#endregion

