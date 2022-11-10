############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("contentmodule")
#endregion

############################################################
import * as authInterface from "./authenticationinterface.js"

############################################################
export initialize = ->
    log "initialize"
    addClientButton.addEventListener("click", addClientButtonClicked)
    removeClientButton.addEventListener("click", removeClientButtonClicked)

    getClientsButton.addEventListener("click", getClientsButtonClicked)
    return


############################################################
addClientButtonClicked = (evnt) ->
    log "addClientButtonClicked"
    
    return

removeClientButtonClicked = (evnt) ->
    log "removeClientButtonClicked"
    
    return

getClientsButtonClicked = (evnt) ->
    log "getClientsButtonClicked"

    return