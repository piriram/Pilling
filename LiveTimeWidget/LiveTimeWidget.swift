//
//  LiveTimeWidget.swift
//  LiveTimeWidget
//
//  Created by Groo on 5/20/24.
//

import WidgetKit
import SwiftUI
import ActivityKit

struct LiveTimeWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveTimeAttributes.self) { context in
            // lock screen & standby(잠금 화면과 notification center, 그리고 전체화면 버전)
            VStack {
                HStack {
                    Image(systemName: "leaf.fill")
                        .foregroundStyle(.customGreen)
                    Text("잔디를 심을 시간이에요!")
                    Spacer()
                    Text(context.state.restOfTime, style: .relative)
                        .foregroundStyle(.customGreen)
                        .frame(width: 77, height: 30)
                }
                Divider()
                ProgressView(value: context.state.progressAmount, total: 600)
                    .tint(.customGreen)
                    .padding()
            }
        } dynamicIsland: { context in
            // dynamic island
            DynamicIsland {
                // expanded dynamic island(다이나믹 아일랜드 꾹 눌러서 확장되는 버전)
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("잔디를 심을 시간이에요!")
                                .font(.headline)
                                .bold()
                            Text(context.state.restOfTime, style: .relative)
                                .foregroundStyle(.customGreen)
                                .font(.title2)
                            Spacer()
                            ZStack {
                                ProgressView(value: context.state.progressAmount, total: 600)
                                    .tint(.customGreen)
                                Image(systemName: "mappin")
                                    .foregroundColor(.secondary)
                                    .offset(x: -20, y: -10)
                            }
                        }
                        Spacer()
                        Image("alarm")
                            .resizable()
                            .scaledToFit()
                    }
                }
            } compactLeading: {
                // compact leading(다이나믹 아일랜드 소형 버전 왼쪽)
                Image("alarm")
            } compactTrailing: {
                // compact trailing(다이나믹 아일랜드 소형 버전 오른쪽)
                Text(context.state.restOfTime, style: .relative)
                    .foregroundStyle(.customGreen)
                    .frame(width: 66)
            } minimal: {
                // minimal(다이나믹 아일랜드 가장 작은 버전)
                ProgressView(value: context.state.progressAmount, total: 600)
                    .progressViewStyle(.circular)
                    .tint(.customGreen)
            }
        }
    }
}

struct TimeWidgetView: View {
    let context: ActivityViewContext<LiveTimeAttributes>
    
    var body: some View {
        Text(context.state.restOfTime, style: .relative)
    }
}

