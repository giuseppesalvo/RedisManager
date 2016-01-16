//
//  ViewController.swift
//  Redis
//
//  Created by Giuseppe Salvo on 15/01/16.
//  Copyright © 2016 Giuseppe Salvo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:Selector("showPreferences:"), name: "ShowPreferences", object: nil)
    }
    
    func showPreferences(notification: NSNotification) {
        let mainStoryboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = mainStoryboard.instantiateControllerWithIdentifier("PreferencesController") as? NSWindowController
        

        self.view.window?.addChildWindow(windowController!.window!, ordered: NSWindowOrderingMode.Above )
        windowController?.window?.makeMainWindow()
        windowController?.window?.makeKeyAndOrderFront(nil)
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

