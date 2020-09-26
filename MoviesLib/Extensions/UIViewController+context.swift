//
//  UIViewController+context.swift
//  MoviesLib
//
//  Created by Welton Dornelas on 26/09/20.
//  Copyright © 2020 Welton Dornelas. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
