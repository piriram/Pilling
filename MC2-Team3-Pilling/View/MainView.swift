//
//  MainView.swift
//  MC2-Team3-Pilling
//
//  Created by Groo on 5/15/24.
//

import SwiftUI

struct MainView: View {
    @State private var showingPopover = false
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(stops: [.init(color: .customGreen.opacity(0.3), location: 0), .init(color: .white, location: 0.15)], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    // navigation icons
                    HStack {
                        Spacer()
                        Button(action: {
                            showingPopover = true
                        }, label: {
                            Image(systemName: "info.circle.fill")
                                .Icon()
                        })
                        .popover(isPresented: $showingPopover, attachmentAnchor: .point(.bottom),
                                 arrowEdge: .top) {
                            PopoverView()
                                .padding()
                                .presentationCompactAdaptation(.popover)
                        }
                        NavigationLink(destination: SettingView(), label: {
                            Image(systemName: "gearshape")
                                .Icon()
                        })
                    }
                    
                    // status header
                    HStack(alignment: .center) {
                        Image("1case")
                            .resizable()
                            .frame(width: 200, height: 200)
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("4일차")
                                    .largeTitle()
                                Text("/28")
                                    .secondaryTitle()
                            }
                            Label("24/4", systemImage: "calendar")
                                .secondaryRegular()
                            Label("17:00", systemImage: "clock.fill")
                                .secondaryRegular()
                        }
                        Spacer()
                    }
                    
                    // now statement
                    HStack {
                        Image(systemName: "drop")
                            .foregroundColor(.customGreen)
                        Text("잔디를 심어주세요")
                            .boldRegular()
                        Spacer()
                    }
                    .padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.customGray, lineWidth: 1)
                    )
                    
                    // calendar view
                    VStack(spacing: 10) {
                        HStack {
                            Text("화")
                                .frame(width: 45, height: 45)
                            Text("수")
                                .frame(width: 45, height: 45)
                            Text("목")
                                .frame(width: 45, height: 45)
                            Text("금")
                                .frame(width: 45, height: 45)
                            Text("토")
                                .frame(width: 45, height: 45)
                            Text("일")
                                .frame(width: 45, height: 45)
                            Text("월")
                                .frame(width: 45, height: 45)
                        }
                        .regular()
                        ForEach(0..<4) { _ in
                            HStack {
                                ForEach(0..<7) { _ in
                                    Button(action: {}, label: {})
                                    .frame(width: 45, height: 45)
                                        .background(.customGray)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                    }
                    Spacer()
                    
                    // footer button
                    Button(action: {}, label: {
                        Text("잔디 심기")
                            .largeBold()
                    })
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                    .background(.customGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(.black)
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView()
}
