//
//  ViewController.swift
//  ProtoTest
//
//  Created by Joshua Buhler on 4/2/19.
//  Copyright © 2019 JB. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let _dataService:DataServiceProtocol = DataService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupNotifications()
    }
    
    func setupNotifications () {
        
        let id = 123
        
        let token = _dataService.addNotificationBlockForId(id,
                                                       withNotificationBlock: { [weak self] changes in
                                                        self?.handleChanges(changes: changes)
        })
        
        print ("token: \(String(describing: token))")
    }
    
    func handleChanges<T: InfinityStone>(changes: RealmCollectionChange<Results<T>>) { // Will build in Xcode 10.1, but not 10.2
//    func handleChanges (changes: RealmCollectionChange<Results<InfinityStone>>) { // Good in 10.2
        print ("handle changes")
    }
    
    /**
     Looks like in the handleChanges() method, we need to specify the type that we expect there, instead of using a generic.
     */

}

class InfinityStone: (Object & Identifiable) {
    var id: Int = 1
    var name: String = "Reality"
}
