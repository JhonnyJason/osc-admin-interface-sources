indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.mainframe = document.getElementById("mainframe")
    global.settings = document.getElementById("settings")
    global.settingsbuttonAccount = document.getElementById("settingsbutton-account")
    global.settingsbuttonSignallingserver = document.getElementById("settingsbutton-signallingserver")
    global.settingsbuttonTurnserver = document.getElementById("settingsbutton-turnserver")
    global.content = document.getElementById("content")
    global.settingsButton = document.getElementById("settings-button")
    global.qrreaderBackground = document.getElementById("qrreader-background")
    global.qrreaderVideoElement = document.getElementById("qrreader-video-element")
    global.messagebox = document.getElementById("messagebox")
    global.qrdisplayBackground = document.getElementById("qrdisplay-background")
    global.qrdisplayContent = document.getElementById("qrdisplay-content")
    global.qrdisplayQr = document.getElementById("qrdisplay-qr")
    global.settingsoffButton = document.getElementById("settingsoff-button")
    global.settingspageAccount = document.getElementById("settingspage-account")
    global.settingspageSignallingserver = document.getElementById("settingspage-signallingserver")
    global.settingspageTurnserver = document.getElementById("settingspage-turnserver")
    return
    
module.exports = indexdomconnect