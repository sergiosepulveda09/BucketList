//
//  ContentView.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-08.
//
import LocalAuthentication
import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingDetails: Bool = false
    @State private var showingEditScreen: Bool = false
    @State private var isUnlocked: Bool = false
    
    var body: some View {
        if isUnlocked {
            ZStack {
                MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingDetails, annotations: locations)
                    .ignoresSafeArea(.all)
                Circle()
                    .fill(Color.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            let newLocation = CodableMKPointAnnotation()
                            newLocation.title = "Example Location"
                            newLocation.coordinate = self.centerCoordinate
                            self.locations.append(newLocation)
                            self.selectedPlace = newLocation
                            self.showingEditScreen = true
                        }, label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.blue.opacity(0.75))
                                .foregroundColor(.white)
                                .font(.title)
                                .clipShape(Circle())
                                .padding()
                        })
                    }
                }
            }
            .alert(isPresented: $showingDetails) {
                Alert(title: Text("\(selectedPlace?.title ?? "Unkown")"), message: Text("\(selectedPlace?.subtitle ?? "Missing Place information")"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                })
            }
            .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
                if self.selectedPlace != nil {
                    EditView(placemark: self.selectedPlace!)
                }
            }
            .onAppear(perform: loadData)
        } else {
            //button here
            Button("Unlock places") {
                self.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
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
                        // error
                    }
                }
            }
        } else {
            // no biometric
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
