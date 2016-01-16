//
//  PreferencesController.swift
//  Redis Manager
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Foundation
import Cocoa

class PreferencesController : NSViewController {
    
    @IBOutlet weak var redisCliPath: NSTextField!
    @IBOutlet weak var redisServerPath: NSTextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redisServerPath.stringValue = RedisPath
        redisCliPath.stringValue = RedisCliPath
        
        print("Preferences")
    }
    
    @IBAction func savePaths(sender: AnyObject) {
        
        var success = true
        
        let filemanager = NSFileManager.init()
        
        // Error function
        func error ( scriptname: String ) {
            Popup.error("Error", text: "\(scriptname) path not valid")
            success = false
        }
        
        if !filemanager.fileExistsAtPath( redisServerPath.stringValue ) {
            error("redis-server")
        }
        
        if !filemanager.fileExistsAtPath( redisCliPath.stringValue ){
            error("redis-cli")
        }
        
        if success {
            if !Redis.instance.stop() {
                Redis.instance.build()
            }
            
            NSNotificationCenter.defaultCenter()
                .postNotificationName("UpdateStatus", object: [ "status": false ] )
            
            RedisPath    = redisServerPath.stringValue
            RedisCliPath = redisCliPath.stringValue
            
            Popup.normal("Success", text: "Paths successfully updated")
            self.view.window?.close()
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
