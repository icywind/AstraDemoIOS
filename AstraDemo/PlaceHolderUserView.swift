//
//  PlaceHolderUserView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/9/24.
//

import SwiftUI

struct PlaceHolderUserView: View {
    let uid: UInt
    
    init(user: UInt) {
       uid = user
    }
    var body: some View {
        ZStack(alignment: .center) {
            Image("agora-icon-logo").resizable().aspectRatio(contentMode: .fit)
            VStack {
                Text("UID" + String(uid))
                    .font(.callout)
                    .foregroundColor(.black)
            }
        }
    }
}

#Preview {
    PlaceHolderUserView(user: 1234)
}
