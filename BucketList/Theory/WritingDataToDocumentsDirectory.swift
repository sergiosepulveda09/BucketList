//
//  WritingDataToDocumentsDirectory.swift
//  BucketList
//
//  Created by Sergio Sepulveda on 2021-08-09.
//

import SwiftUI

struct WritingDataToDocumentsDirectory: View {
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onTapGesture {
                let str = "Test Message"
                let url = self.getDocumentDirectory().appendingPathComponent("message.txt")
                
                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
}

struct WritingDataToDocumentsDirectory_Previews: PreviewProvider {
    static var previews: some View {
        WritingDataToDocumentsDirectory()
    }
}
