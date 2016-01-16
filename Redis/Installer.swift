//
//  Installer.swift
//  Redis
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Foundation

//
// Installer Delegate
//

protocol InstallerDelegate {
    func installerDidFinish( installer: Installer )
}

class Installer {
    
    //
    // App delegate
    //
    var delegate : InstallerDelegate?
    
    //
    // MARK: Parameters
    //
    let user     : String = NSUserName()
    let fileurl  : String = "http://download.redis.io/releases/redis-3.0.6.tar.gz"
    let filename : String = "redis-3.0.6.tar.gz"
    let folder   : String = "redis-3.0.6"
    
    let curlPath = "/usr/bin/curl"
    
    //
    // MARK: Init Installer
    //
    init () {
        startDownload()
    }
    
    //
    // Start Redis Download
    //
    func startDownload () {
        Task.launch(
            self.curlPath ,
            arguments: [ self.fileurl, "-o", "/Users/\(self.user)/\(self.filename)" ],
            onTerminate: self.onDownloadFinish
        )
    }
    
    //
    // On Redis Download Finish
    //
    func onDownloadFinish ( task: NSTask ) {
        
        print("download finished")
        
        system("cd ~/ && tar xzf ~/\(self.filename)")
        
        Task.launch(
            "/usr/bin/make" ,
            arguments: [ "-C", "/Users/\(self.user)/\(self.folder)" ],
            onTerminate: self.onMakeFinish
        )
   
    }
    
    //
    // On Make in Redis Folder finish
    //
    func onMakeFinish ( task: NSTask ) {
        print("make finished")
        
        system("mv ~/\(self.folder)/src/redis-cli /usr/local/bin/redis-cli")
        system("mv ~/\(self.folder)/src/redis-server /usr/local/bin/redis-server")
        
        RedisPath = "/usr/local/bin/redis-server"
        RedisCliPath = "/usr/local/bin/redis-cli"
        
        // Call delegate function
        delegate?.installerDidFinish( self )
    }
    
}
