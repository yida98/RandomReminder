//
//  CreateAlarmView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import SwiftUI

struct CreateAlarmView: View {
    
    @State var alarmName: String = ""
    
    var body: some View {
        TextField("Alarm Name", text: $alarmName)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
//    var text: String
//    var id: UUID
//    var duration: [Time]
//    var occurence: Int
//    var randomFrequency: Bool
}

struct CreateAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAlarmView()
    }
}
