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
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        if vm.isUnlocked {
            MainView(vm: self.vm)
        } else {
            //button here
            Button("Unlock places") {
                vm.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

