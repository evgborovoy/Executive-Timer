//
//  ContentView.swift
//  Executive Timer
//
//  Created by Evgeniy Borovoy on 11/17/24.
//

import SwiftUI

let defaultTime: CGFloat = 20


struct ContentView: View {
    @State private var isRunning: Bool = false
    @State private var countdownTime: CGFloat = defaultTime
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var countdownColor: Color {
           switch countdownTime {
           case 6...:
               return Color.green
           case 3...:
               return Color.yellow
           default:
               return Color.red
           }
       }
       
       var strokeStyle: StrokeStyle {
           StrokeStyle(lineWidth: 15, lineCap: .round)
       }
       
       var buttonIcon: String {
           isRunning ? "pause.rectangle.fill" : "play.rectangle.fill"
       }
    
    var body: some View {
        VStack {
            ZStack{
                Circle().stroke(Color.gray.opacity(0.2), style: strokeStyle)
                Circle()
                    .trim(from: 0, to: 1 - ((defaultTime - countdownTime) / defaultTime))
                    .stroke(countdownColor, style: strokeStyle)
                    .rotationEffect(.degrees(90))
                    .animation(.easeInOut, value: countdownTime)
                HStack(spacing: 30) {
                    Label("", systemImage: buttonIcon).foregroundStyle(.black).font(.title).onTapGesture {
                        isRunning.toggle()
                    }
                    Text("\(Int(countdownTime))").font(.largeTitle)
                    Label("",systemImage: "gobackward").foregroundStyle(.red).font(.title).onTapGesture {
                        isRunning = false
                        countdownTime = defaultTime
                    }
                }
            }.padding(20).onReceive(timer, perform: { _ in
                guard isRunning else { return }
                if countdownTime > 0 {
                    countdownTime -= 1
                } else {
                    isRunning = false
                    countdownTime = defaultTime
                }
                
            })
        }
    }
}


#Preview {
    ContentView()
}
