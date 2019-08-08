//
//  ContentView.swift
//  SwiftUIEX
//
//  Created by Justin Bengtson on 8/1/19.
//  Copyright © 2019 Justin Bengtson. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    
    var dueDate = Date()
    
    var body: some View {
        guard let img = UIImage(named: "example-image") else {
            fatalError("Unable to load image")
        }
        
        return Image(uiImage: img)
    }
    
    
    /*
    var body: some View {
       Image(systemName: "cloud.heavyrain.fill")
    }
    */
    
    /*
    var body: some View {
        Text("Task due date: \(dueDate, formatter: Self.taskDateFormat)")
    }
   */
    
    /*
    var body: some View {
        Text("SwiftUI is awesome and iOS 13, iPadOS and macOS Catalina will be amazing when they officially release.")
            .font(.largeTitle)
            .foregroundColor(Color.red)
    }
   */
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
