//
//  Utils.swift
//  Redis
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Cocoa
import Foundation

class Popup {
    
    private class func getPopup ( title: String, text: String ) -> NSAlert {
        let p : NSAlert = NSAlert()
        p.messageText = title
        p.informativeText = text
        return p
    }
    
    // Create dialog box on screen
    class func error(title: String, text: String) -> Bool {
        let p = self.getPopup(title, text: text)
        p.window.title = "Error"
        p.alertStyle = NSAlertStyle.CriticalAlertStyle
        p.addButtonWithTitle("OK")
        let res = p.runModal()
        if res == NSAlertFirstButtonReturn {
            return true
        }
        return false
    }
    
    // Create informational dialog box on screen
    class func normal(title: String, text: String) -> Bool {
        let p = self.getPopup(title, text: text)
        p.window.title = "Message"
        p.alertStyle = NSAlertStyle.InformationalAlertStyle
        p.addButtonWithTitle("OK")
        let res = p.runModal()
        if res == NSAlertFirstButtonReturn {
            return true
        }
        return false
    }
    
    // Create custom dialog box
    class func custom ( title: String, text: String, buttons:[String] ) -> NSModalResponse {
        let p = self.getPopup(title, text: text)
        p.window.title = "Error"
        p.alertStyle = NSAlertStyle.CriticalAlertStyle
        for b in buttons {
            p.addButtonWithTitle( b )
        }
        return p.runModal()
    }
    
}
