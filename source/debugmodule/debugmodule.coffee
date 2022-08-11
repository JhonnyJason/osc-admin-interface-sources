import { addModulesToDebug } from "thingy-debug"

############################################################
export modulesToDebug = 
    configmodule: true
    # qrreadermodule: true
    accountsettingsmodule: true

addModulesToDebug(modulesToDebug)