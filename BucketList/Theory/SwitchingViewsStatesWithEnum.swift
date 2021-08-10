//
//  SwitchingViewsStatesWithEnum.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-10.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}
struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}
struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}


struct SwitchingViewsStatesWithEnum: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
    var loadingState = LoadingState.loading
    
    var body: some View {
        Group {
            if loadingState == .loading {
                LoadingView()
            } else if loadingState == .success {
                SuccessView()
            } else if loadingState == .failed {
                FailedView()
            }
        }
    }
}

struct SwitchingViewsStatesWithEnum_Previews: PreviewProvider {
    static var previews: some View {
        SwitchingViewsStatesWithEnum()
    }
}
