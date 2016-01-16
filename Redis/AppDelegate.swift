//
//  AppDelegate.swift
//  Redis
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Cocoa
import Foundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    //
    // MARK: Parameters
    //
    @IBOutlet weak var menuBar: NSMenu!
    @IBOutlet weak var redisState: NSMenuItem!
    
    @IBOutlet weak var toggleRedisBtn: NSMenuItem!
    @IBOutlet weak var preferencesBtn: NSMenuItem!
    
    let redisWebsiteURL = "http://redis.io"
    let myGithub = "https://github.com/giuseppesalvo"
    
    let statusItem = NSStatusBar
                        .systemStatusBar()
                        .statusItemWithLength(NSVariableStatusItemLength)
    //
    // MARK: appDidFinishLaunching
    //
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let _ = InstallationCheck()
        
        let icon = NSImage(named: "dbs_redis")
        icon?.template = true
        statusItem.image = icon
        statusItem.menu = self.menuBar
        statusItem.highlightMode = true
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: Selector("notificationStatus:"), name: "UpdateStatus", object:nil)
    }
    
    //
    // MARK: appWillTerminate
    //
    func applicationWillTerminate(aNotification: NSNotification) {
        Redis.instance.stop()
    }
    
    //===============================
    // MARK: Redis Functions
    //===============================
    
    func notificationStatus (notification: NSNotification) {
        let status = notification.object!["status"] as? Bool
        self.updateStatus( status! )
    }
    
    func updateStatus ( state:Bool ) {
        if state {
            redisState.title = "State: listen on port 6379"
            toggleRedisBtn.title = "Stop"
        }
        else {
            redisState.title = "State: inactive"
            toggleRedisBtn.title = "Start"
        }
    }
    
    //
    // Terminate Redis
    //
    func stopRedis() {
        if !Redis.instance.stop() {
            Popup.normal("Message", text: Redis.error! )
        } else {
            self.updateStatus(false)
        }
    }
    
    //
    // Start Redis
    //
    func startRedis() {
        if !Redis.instance.start() {
            Popup.normal("Message", text: Redis.error! )
        } else {
            self.updateStatus(true)
            
        }
    }
    
    @IBAction func toggleRedis ( sender: AnyObject ) {
        if !Redis.isRunning {
            startRedis()
        } else {
            stopRedis()
        }
    }
    
    //
    // Quit From Redis Manager
    //
    @IBAction func quitRedis(sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    //
    // Open Redis Website
    //
    @IBAction func openRedisWebsite(sender: AnyObject) {
        
        let url : NSURL = NSURL(string: self.redisWebsiteURL )!
        NSWorkspace.sharedWorkspace().openURL( url )
        
    }
    
    //
    // Open Giuseppe Salvo GitHub
    //
    @IBAction func forkMeOnGithub(sender: AnyObject) {
        let url : NSURL = NSURL(string: self.myGithub )!
        NSWorkspace.sharedWorkspace().openURL( url )
    }
    
    //
    // Open Redis Cli in terminal App
    //
    @IBAction func openRedisCli(sender: AnyObject) {
        
        if Redis.isRunning {
            let command = "tell application \"Terminal\" to do script \"\(RedisCliPath)\""
            let appleScript = NSAppleScript.init( source: command )
            appleScript?.executeAndReturnError(nil)
        } else {
            Popup.normal("Message", text: "start Redis before")
            print( "Redis is not running" )
        }
        
    }

}

