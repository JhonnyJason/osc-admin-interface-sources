############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("settingsmodule")
#endregion

############################################################
export initialize = ->
    log "initialize"
    settingsoffButton.addEventListener("click", settingsoffButtonClicked)
    #Implement or Remove :-)
    return

settingsoffButtonClicked = ->
    settingsButton.classList.remove("on")
    document.body.classList.remove("settings") 