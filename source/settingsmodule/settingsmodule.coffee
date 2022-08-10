############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("settingsmodule")
#endregion

############################################################
currentlyShownSettingspage = null

############################################################
export initialize = ->
    log "initialize"
    settingsoffButton.addEventListener("click", settingsoffButtonClicked)
    
    #specific settings
    settingsbuttonAccount.addEventListener("click", settingsbuttonAccountClicked)
    settingsbuttonSignallingserver.addEventListener("click", settingsbuttonSignallingserverClicked)    
    settingsbuttonTurnserver.addEventListener("click", settingsbuttonTurnserverClicked)
    
    #Implement or Remove :-)
    backButtons = document.getElementsByClassName("settingspage-backbutton")
    b.addEventListener("click", settingsBackButtonClicked) for b in backButtons
    return

############################################################
#region eventListeners
settingsoffButtonClicked = ->
    document.body.classList.remove("settings") 
    return

############################################################
settingsbuttonAccountClicked = ->
    # settingspageAccount.
    currentlyShownSettingspage = settingspageAccount
    currentlyShownSettingspage.classList.add("here")
    return

settingsbuttonSignallingserverClicked = ->
    # settingspageSignallingserver.
    currentlyShownSettingspage = settingspageSignallingserver
    currentlyShownSettingspage.classList.add("here")
    return

settingsbuttonTurnserverClicked = ->
    # settingspageTurnserver.
    currentlyShownSettingspage = settingspageTurnserver
    currentlyShownSettingspage.classList.add("here")
    return

############################################################
settingsBackButtonClicked = ->
    return unless currentlyShownSettingspage?
    currentlyShownSettingspage.classList.remove("here")
    currentlyShownSettingspage = null
    return

#endregion