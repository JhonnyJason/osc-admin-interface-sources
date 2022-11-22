import { addModulesToDebug } from "thingy-debug"

############################################################
export modulesToDebug = 
    configmodule: true
    # qrreadermodule: true
    authclientmodule: true
    authclient: true
    accountsettingsmodule: true
    contentmodule: true

addModulesToDebug(modulesToDebug)