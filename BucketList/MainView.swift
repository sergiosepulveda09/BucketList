//
//  MainViewChallenge2.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-13.
//

import SwiftUI

struct MainView: View {
    @State private var showingDetails: Bool = false
    @State private var showingEditScreen: Bool = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        ZStack {
            MapView(centerCoordinate: $vm.centerCoordinate, selectedPlace: $vm.selectedPlace , showingPlaceDetails: $showingDetails, annotations: vm.locations)
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
                        newLocation.coordinate = self.vm.centerCoordinate
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
        .onAppear(perform: self.vm.loadData)
    }
    
    
    
}


struct MainViewChallenge2_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ViewModel())
    }
}
