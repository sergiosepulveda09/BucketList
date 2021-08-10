//
//  ComparableForCustomTypes.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-09.
//

import SwiftUI

struct UserExample: Identifiable, Comparable {
    
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func < (lhs: UserExample, rhs: UserExample) -> Bool {
        lhs.lastName < rhs.lastName
    }
    
}

struct ComparableForCustomTypes: View {
    
    let users = [UserExample(firstName: "Arnold", lastName: "Rimmer"),
                UserExample(firstName: "Kristine", lastName: "Kochanski"),
                UserExample(firstName: "David", lastName: "Liste")].sorted() //Don't need a a closure because of Comparable.
    
    let values = [1,5,3,6,2,9].sorted()
    
    var body: some View {
        List(users) { user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ComparableForCustomTypes_Previews: PreviewProvider {
    static var previews: some View {
        ComparableForCustomTypes()
    }
}
