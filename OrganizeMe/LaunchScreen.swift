//
//  LaunchScreen.swift
//  OrganizeMe
//
//  Created by Vedant on 
// 101398199

import SwiftUI

struct LaunchScreen: View {
    @State private var isStartButtonClicked = false
    @State private var animate = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Organize Me")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.blue)
                    .padding()
                    .scaleEffect(animate ? 1.0 : 0.8)
                    .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: animate)
                
                Text("Developed by Vedantsinh Gohel")
                    .font(.title3)
                    .foregroundColor(Color.gray)
                    .opacity(animate ? 1.0 : 0.0)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.5), value: animate)
                
                Text("Student ID: 101398199")
                    .font(.title3)
                    .foregroundColor(Color.gray)
                    .opacity(animate ? 1.0 : 0.0)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.5), value: animate)
                
                Spacer()
                
                NavigationLink(
                    destination: TaskListView(),
                    isActive: $isStartButtonClicked,
                    label: { EmptyView() }
                )
                
                Button(action: {
                    withAnimation {
                        isStartButtonClicked = true
                    }
                }) {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20)
            }
            .padding()
            .onAppear {
                self.animate.toggle()
            }
        }
    }
}



struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
