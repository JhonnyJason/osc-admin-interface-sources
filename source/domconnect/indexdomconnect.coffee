indexdomconnect = {name: "indexdomconnect"}

############################################################
indexdomconnect.initialize = () ->
    global.mainframe = document.getElementById("mainframe")
    global.settings = document.getElementById("settings")
    global.settingsbuttonAccount = document.getElementById("settingsbutton-account")
    global.settingsbuttonSecretManager = document.getElementById("settingsbutton-secret-manager")
    global.settingsbuttonDataManager = document.getElementById("settingsbutton-data-manager")
    global.settingsbuttonSignallingserver = document.getElementById("settingsbutton-signallingserver")
    global.settingsbuttonTurnserver = document.getElementById("settingsbutton-turnserver")
    global.content = document.getElementById("content")
    global.clientIdInput = document.getElementById("client-id-input")
    global.addClientButton = document.getElementById("add-client-button")
    global.removeClientButton = document.getElementById("remove-client-button")
    global.getClientsButton = document.getElementById("get-clients-button")
    global.clientsToServeList = document.getElementById("clients-to-serve-list")
    global.siteUrlInput = document.getElementById("site-url-input")
    global.addSiteButton = document.getElementById("add-site-button")
    global.removeSiteButton = document.getElementById("remove-site-button")
    global.getSitesButton = document.getElementById("get-sites-button")
    global.sitesList = document.getElementById("sites-list")
    global.settingsButton = document.getElementById("settings-button")
    global.qrreaderBackground = document.getElementById("qrreader-background")
    global.qrreaderVideoElement = document.getElementById("qrreader-video-element")
    global.messagebox = document.getElementById("messagebox")
    global.qrdisplayBackground = document.getElementById("qrdisplay-background")
    global.qrdisplayContent = document.getElementById("qrdisplay-content")
    global.qrdisplayQr = document.getElementById("qrdisplay-qr")
    global.settingsoffButton = document.getElementById("settingsoff-button")
    global.settingspageAccount = document.getElementById("settingspage-account")
    global.settingspageSecretManager = document.getElementById("settingspage-secret-manager")
    global.settingspageDataManager = document.getElementById("settingspage-data-manager")
    global.settingspageSignallingserver = document.getElementById("settingspage-signallingserver")
    global.settingspageTurnserver = document.getElementById("settingspage-turnserver")
    return
    
module.exports = indexdomconnect