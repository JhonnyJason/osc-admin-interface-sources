############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion

############################################################
import * as secUtl from "secret-manager-crypto-utils"

import * as sci from "./authenticationinterface.js"
import * as validatableStamp from "./validatabletimestampmodule.js"
import * as state from "./statemodule.js"
import { info, error } from "./messageboxmodule.js"


############################################################
nonce = 0


############################################################
export initialize = ->
    log "initialize"
    addClientButton.addEventListener("click", addClientButtonClicked)
    removeClientButton.addEventListener("click", removeClientButtonClicked)

    getClientsButton.addEventListener("click", getClientsButtonClicked)
    return


############################################################
createSignature = (payload, route, secretKeyHex) ->
    content = route+JSON.stringify(payload)
    return await secUtl.createSignature(content, secretKeyHex)


############################################################
addClientButtonClicked = (evnt) ->
    log "addClientButtonClicked"
    try
        secretKey = state.get("secretKeyHex")

        clientPublicKey = clientIdInput.value
        sciURL = "https://localhost:6999"
        timestamp = validatableStamp.create()

        payload = {clientPublicKey, timestamp, nonce}
        # olog payload

        route = "/addClientToServe"
        signature = await createSignature(payload, route, secretKey)
        
        reply = await sci.addClientToServe(sciURL, clientPublicKey, timestamp, nonce++, signature)

        if reply.error then throw new Error(reply.error)
        olog {reply}
        info("ADD appearently successful!")

    catch err 
        m = "Error on trying to add a new client: #{err.message}"
        log(m)
        error(m)
    return

removeClientButtonClicked = (evnt) ->
    log "removeClientButtonClicked"
    try
        secretKey = state.get("secretKeyHex")

        clientPublicKey = clientIdInput.value
        sciURL = "https://localhost:6999"
        timestamp = validatableStamp.create()


        payload = {clientPublicKey, timestamp, nonce}
        # olog payload

        route = "/removeClientToServe"
        signature = await createSignature(payload, route, secretKey)
        
        reply = await sci.removeClientToServe(sciURL, clientPublicKey, timestamp, nonce++, signature)

        if reply.error then throw new Error(reply.error)
        olog {reply}
        info("REMOVE appearently successful!")

    catch err 
        m = "Error on trying to remove client: #{err.message}"
        error(m)
        log(m)     
    return

getClientsButtonClicked = (evnt) ->
    log "getClientsButtonClicked"
    try
        secretKey = state.get("secretKeyHex")

        sciURL = "https://localhost:6999"
        timestamp = validatableStamp.create()

        payload = {timestamp, nonce}
        # olog payload
        
        route = "/getClientsToServe"
        signature = await createSignature(payload, route, secretKey)
        
        reply = await sci.getClientsToServe(sciURL, timestamp, nonce++, signature)
        
        if reply.error then throw new Error(reply.error)
        olog {reply}
        info("GETCLIENTS appearently successful!")

        {toServeList} = reply
        html = ""
        for client in toServeList
            html += "<li>#{client}</li>"
        clientsToServeList.innerHTML = html

    catch err
        m = "Error on retrieveing clients to serve: #{err.message}"
        log(m)
        error(m)
    return

