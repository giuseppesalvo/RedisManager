//
//  Task.swift
//  Redis
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Foundation

//
// TASK Class
//
class Task {
    
    //
    // This launch a NSTask with termination handler
    // Void
    class func launch ( launchPath: String, arguments:[String], onTerminate : ( (NSTask) -> Void ) ) {
       
        let task = NSTask.init()
        task.launchPath = launchPath
        
        if arguments.count > 0 {
            task.arguments = arguments
        }
        
        task.terminationHandler = onTerminate
        
        task.waitUntilExit()
        task.launch()
   
    }
    
}