indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.settingsSignallingserver = document.getElementById("settings-signallingserver")
    global.settingsSignallingServer = document.getElementById("settings-signalling-server")
    global.settingsButton = document.getElementById("settings-button")
    global.settingsoffButton = document.getElementById("settingsoff-button")
    return
    
module.exports = indexdomconnect