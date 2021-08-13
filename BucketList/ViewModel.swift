//
//  ViewModel.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-13.
//

import SwiftUI
import LocalAuthentication
import MapKit

final class ViewModel: ObservableObject {
    
    @Published var locations = [CodableMKPointAnnotation]()
    @Published var isUnlocked: Bool = false
    @Published var biometricsRejected = false
    @Published var selectedPlace: MKPointAnnotation?
    @Published var centerCoordinate = CLLocationCoordinate2D()

    init() {
        loadData()
    }
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.authenticate()
                    }
                }
            }
        } else {
            biometricsRejected = true
            print("\(error?.localizedDescription)")
        }
    }
//
//
}
