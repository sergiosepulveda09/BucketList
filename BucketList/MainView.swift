//
//  MainViewChallenge2.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-13.
//

import SwiftUI
import MapKit

struct MainView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var showingDetails: Bool = false
    @State private var showingEditScreen: Bool = false

    
    var vm: ViewModel
    
    var body: some View {
        
        let selected =  Binding<MKPointAnnotation?>(
            get: {
                self.vm.selectedPlace
                
            }, set: {
                self.vm.selectedPlace = $0
                print("New value is \(String(describing: self.vm.selectedPlace))")
            }
            )

        return ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: selected, showingPlaceDetails: $showingDetails, annotations: vm.locations)
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
                        self.vm.locations.append(newLocation)
                        self.vm.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }, label: {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding()
                    })
                }
            }
        }
        .alert(isPresented: $showingDetails) {
            Alert(title: Text("\(vm.selectedPlace?.title ?? "Unkown")"), message: Text("\(vm.selectedPlace?.subtitle ?? "Missing Place information")"), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: vm.saveData) {
            if self.vm.selectedPlace != nil {
                EditView(placemark: self.vm.selectedPlace!)
            }
        }
    }
    
    
    
}


struct MainViewChallenge2_Previews: PreviewProvider {
    static var previews: some View {
        MainView(vm: ViewModel())
    }
}
