//
//  UsingTouchAndFaceID.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-11.
//

import SwiftUI
import LocalAuthentication

struct UsingTouchAndFaceID: View {
    
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        VStack {
            if self.isUnlocked {
                Text("Unlocked")
            } else {
                Text("Lock")
            }
        }
        .onAppear(perform: authenticate)
        
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        //there was a problem
                    }
                }
                
            }
        } else {
            //No biometrics
        }
    }
}

struct UsingTouchAndFaceID_Previews: PreviewProvider {
    static var previews: some View {
        UsingTouchAndFaceID()
    }
}
