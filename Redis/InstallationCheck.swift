//
//  InstallationCheck.swift
//  Redis
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Cocoa
import Foundation

class InstallationCheck : InstallerDelegate {

    let pathRedisServer = "/usr/local/bin/redis-server"
    
    init () {
        
        let filemanager = NSFileManager.init()
        let exists      = filemanager.fileExistsAtPath( self.pathRedisServer )
        
        if !exists {
            
            let choise = Popup.custom(
                    "Error",
                    text: "Redis not found in /usr/local/bin",
                    buttons: [ "Install Redis", "Set Redis path", "Quit" ]
            )
            
            if choise == NSAlertFirstButtonReturn {
                
                print( "Install it" )
                let installer      = Installer()
                installer.delegate = self
            
            }
            else if choise == NSAlertSecondButtonReturn {
                
                NSNotificationCenter.defaultCenter()
                    .postNotificationName("ShowPreferences", object: nil)
            
            }
            else {
                NSApp.terminate(self)
            }
        
        }
    }
    
    //
    // On installer did finish
    //
    func installerDidFinish(installer: Installer) {
    
        Popup.normal("Success", text: "Redis was successfully installed")
    
    }
    
}