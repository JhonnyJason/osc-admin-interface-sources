############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("settingsmodule")
#endregion

currentShownSettings = null

############################################################
export initialize = ->
    log "initialize"
    settingsoffButton.addEventListener("click", settingsoffButtonClicked)
    
    #specific settings
    settingsSignallingServer.addEventListener("click", settingsSignallingServerClicked)
    #Implement or Remove :-)
    backButtons = document.getElementsByClassName("settingspage-backbutton")
    b.addEventListener("click", settingsBackButtonClicked) for b in backButtons
    return

settingsoffButtonClicked = ->
    document.body.classList.remove("settings") 

settingsSignallingServerClicked = ->
    currentShownSettings = settingsSignallingserver
    settingsSignallingserver.classList.add("here")

settingsBackButtonClicked = ->
    return unless currentShownSettings?
    currentShownSettings.classList.remove("here")
    currentShownSettings = null
    return



