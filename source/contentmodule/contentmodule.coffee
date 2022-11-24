############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion

############################################################
import { createClient } from "./authclientmodule.js"
import * as state from "./statemodule.js"
import { info, error } from "./messageboxmodule.js"
import * as osc from "./oscinterface.js"

############################################################
masterClient = null

############################################################
export initialize = ->
    log "initialize"

    ## Master Functions
    addClientButton.addEventListener("click", addClientButtonClicked)
    removeClientButton.addEventListener("click", removeClientButtonClicked)
    getClientsButton.addEventListener("click", getClientsButtonClicked)

    ## Chat Sites
    addSiteButton.addEventListener("click", addSiteButtonClicked)
    removeSiteButton.addEventListener("click", removeSiteButtonClicked)
    getSitesButton.addEventListener("click", getSitesButtonClicked)

    ## Client Setup
    secretKeyHex = state.get("secretKeyHex")
    serverURL = "https://localhost:6999"
    o = {serverURL, secretKeyHex}
    
    masterClient = createClient(o)
    return

############################################################
addClientButtonClicked = (evnt) ->
    log "addClientButtonClicked"
    try
        clientId = clientIdInput.value
        reply = await masterClient.addClient(clientId)
        olog reply
        info("ADD appearently successful!")
    catch err 
        m = "Error on trying to add a new client: #{err.message}"
        log(m)
        error(m)
    return

removeClientButtonClicked = (evnt) ->
    log "removeClientButtonClicked"
    try
        clientId = clientIdInput.value
        reply = await masterClient.removeClient(clientId)
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
        clients = await masterClient.getClients() 
        olog {clients}
        info("GETCLIENTS appearently successful!")

        html = ""
        for client in clients
            html += "<li>#{client}</li>"
        clientsToServeList.innerHTML = html

    catch err
        m = "Error on retrieveing clients to serve: #{err.message}"
        log(m)
        error(m)
    return


############################################################
addSiteButtonClicked = (evnt) ->
    log "addSiteButtonClicked"
    try
        serverURL = "https://localhost:6999"
        authCode = await masterClient.getAuthCode()
        siteURL = siteUrlInput.value

        reply = await osc.addChatSite(serverURL, authCode, siteURL)
        olog reply
        info("ADD appearently successful!")
    catch err 
        m = "Error on trying to add a chat site: #{err.message}"
        log(m)
        error(m)
    return

removeSiteButtonClicked = (evnt) ->
    log "removeSiteButtonClicked"
    try
        serverURL = "https://localhost:6999"
        authCode = await masterClient.getAuthCode()
        siteURL = siteUrlInput.value

        reply = await osc.removeChatSite(serverURL, authCode, siteURL)
        olog {reply}
        info("REMOVE appearently successful!")
    catch err
        m = "Error on trying to remove a chat site: #{err.message}"
        error(m)
        log(m)     
    return

getSitesButtonClicked = (evnt) ->
    log "getSitesButtonClicked"
    try
        serverURL = "https://localhost:6999"
        authCode = await masterClient.getAuthCode()
        
        { chatSites } = await osc.getAllChatSites(serverURL, authCode)
        olog {chatSites}
        info("GETCHATSITES appearently successful!")

        html = ""
        for siteURL in chatSites
            html += "<li>#{siteURL}</li>"
        sitesList.innerHTML = html
    catch err
        m = "Error on retrieveing all chat sites: #{err.message}"
        log(m)
        error(m)
    return

