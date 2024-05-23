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
    let progressTotal = 10.0
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveTimeAttributes.self) { context in
            // lock screen & standby(잠금 화면과 notification center, 그리고 전체화면 버전)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("필링")
                        .font(.caption)
                    Text("잔디를 심을 시간이")
                        .bold()
                    HStack(alignment: .bottom) {
                        Text(context.state.restOfTime)
                            .font(.title)
                        Text(context.state.step <= 1 ? "남았어요" : "지났어요")
                    }
                    .foregroundStyle(context.state.step >= 3 ? .red : .customGreen)
                    ProgressView(value: context.state.progressAmount, total: progressTotal)
                        .tint(context.state.step >= 3 ? .red : .customGreen)
                }
                Image(context.state.step >= 3 ? "pilling" : "alarm")
            }
            .padding()
        } dynamicIsland: { context in
            // dynamic island
            DynamicIsland {
                // expanded dynamic island(다이나믹 아일랜드 꾹 눌러서 확장되는 버전)
                DynamicIslandExpandedRegion(.center) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("잔디를 심을 시간이")
                                .font(.headline)
                                .bold()
                            HStack(alignment: .bottom) {
                                Text(context.state.restOfTime)
                                    .foregroundStyle(context.state.step >= 3 ? .red : .customGreen)
                                    .font(.title)
                                Text(context.state.step <= 1 ? "남았어요" : "지났어요")
                                    .font(.headline)
                                    .foregroundStyle(context.state.step >= 3 ? .red : .customGreen)
                            }
                            ProgressView(value: context.state.progressAmount, total: progressTotal)
                                .tint(context.state.step >= 3 ? .red : .customGreen)
                        }
                        Image(context.state.step >= 3 ? "pilling" : "alarm")
                            .resizable()
                            .scaledToFit()
                    }
                }
            } compactLeading: {
                // compact leading(다이나믹 아일랜드 소형 버전 왼쪽)
                Image(context.state.step >= 3 ? "pilling" : "alarm")
                    .resizable()
                    .scaledToFit()
            } compactTrailing: {
                // compact trailing(다이나믹 아일랜드 소형 버전 오른쪽)
                Text(context.state.restOfTime)
                    .foregroundStyle(context.state.step >= 3 ? .red : .customGreen)
            } minimal: {
                // minimal(다이나믹 아일랜드 가장 작은 버전)
                ProgressView(value: context.state.progressAmount, total: progressTotal)
                    .progressViewStyle(.circular)
                    .tint(context.state.step >= 3 ? .red : .customGreen)
            }
        }
    }
}

struct TimeWidgetView: View {
    let context: ActivityViewContext<LiveTimeAttributes>
    
    var body: some View {
        Text(context.state.restOfTime)
    }
}


// preview 설정
extension LiveTimeAttributes.ContentState {
    fileprivate static var start: LiveTimeAttributes.ContentState {
        LiveTimeAttributes.ContentState(restOfTime: "3분 3초", progressAmount: 0, step: 1)
    }
    
    fileprivate static var middle: LiveTimeAttributes.ContentState {
        LiveTimeAttributes.ContentState(restOfTime: "28분 58초", progressAmount: 300, step: 2)
    }
    
    fileprivate static var end: LiveTimeAttributes.ContentState {
        LiveTimeAttributes.ContentState(restOfTime: "3시간 37분", progressAmount: 600, step: 3)
    }
}

#Preview(as: .content, using: LiveTimeAttributes(), widget: {
    LiveTimeWidget()
}, contentStates: {
    LiveTimeAttributes.ContentState.start
    LiveTimeAttributes.ContentState.middle
    LiveTimeAttributes.ContentState.end
})
