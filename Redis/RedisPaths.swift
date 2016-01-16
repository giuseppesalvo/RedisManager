//
//  RedisPaths.swift
//  Redis Manager
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Foundation

//
// Redis Server
// Computed Variable
//
var RedisPath : String {

    get {
        let path = NSUserDefaults
            .standardUserDefaults()
            .objectForKey( "RedisPath" )
        if path != nil {
            return path as! String
        }
        else {
            return "/usr/local/bin/redis-server"
        }
    }

    set( value ) {
        NSUserDefaults
            .standardUserDefaults()
            .setObject( value , forKey: "RedisPath" )
    }
}

//
// Redis Cli
// Computed Variable
//
var RedisCliPath : String {

    get {
        let path = NSUserDefaults
            .standardUserDefaults()
            .objectForKey( "RedisCliPath" )
        if path != nil {
        	return path as! String
        }
        else {
            return "/usr/local/bin/redis-cli"
        }
    }

    set( value ) {
        NSUserDefaults
            .standardUserDefaults()
            .setObject( value , forKey: "RedisCliPath" )
    }

}