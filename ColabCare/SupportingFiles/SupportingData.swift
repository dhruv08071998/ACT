//
//  SupportingData.swift
//  ColabCare
//
//  Created by Dhruv Upadhyay on 22/04/21.
//

import Foundation
import CoreData

protocol ModalTransitionListener {
    func popoverDismissed()
}

class ModalTransitionMediator {
    /* Singleton */
    class var instance: ModalTransitionMediator {
        struct Static {
            static let instance: ModalTransitionMediator = ModalTransitionMediator()
        }
        return Static.instance
    }
    
    private var listener: ModalTransitionListener?
    
    private init() {
        
    }
    
    func setListener(listener: ModalTransitionListener) {
        self.listener = listener
    }
    
    func sendPopoverDismissed(modelChanged: Bool) {
        listener?.popoverDismissed()
    }
}


var selectGoal:  [String:Any]?
var changeIndex = -1
var currentGoals = [Goal]()
var completedGoals = [Goal]()


extension CompletedGoalViewController {

    
}
