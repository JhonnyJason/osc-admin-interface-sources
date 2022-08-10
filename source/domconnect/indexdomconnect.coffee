indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.settingsbuttonAccount = document.getElementById("settingsbutton-account")
    global.settingsbuttonSignallingserver = document.getElementById("settingsbutton-signallingserver")
    global.settingsbuttonTurnserver = document.getElementById("settingsbutton-turnserver")
    global.settingsButton = document.getElementById("settings-button")
    global.settingsoffButton = document.getElementById("settingsoff-button")
    global.settingspageAccount = document.getElementById("settingspage-account")
    global.settingspageSignallingserver = document.getElementById("settingspage-signallingserver")
    global.settingspageTurnserver = document.getElementById("settingspage-turnserver")
    return
    
module.exports = indexdomconnect