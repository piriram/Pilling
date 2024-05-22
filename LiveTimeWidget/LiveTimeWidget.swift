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
    let progressTotal = 2400.0
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LiveTimeAttributes.self) { context in
            // lock screen & standby(잠금 화면과 notification center, 그리고 전체화면 버전)
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Pilling")
                        .font(.caption)
                    Text("잔디를 심을 시간이")
                        .bold()
                    HStack(alignment: .bottom, spacing: 0) {
                        Text(context.state.restOfTime, style: .relative)
                            .font(.title)
                            .frame(maxWidth: 125, maxHeight: 25)
                        Text("남았어요")
                    }
                    .foregroundStyle(.customGreen)
                    ProgressView(value: context.state.progressAmount, total: progressTotal)
                        .tint(.customGreen)
                }
                Image("alarm")
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
                                Text(context.state.restOfTime, style: .relative)
                                    .foregroundStyle(.customGreen)
                                    .font(.title)
                                    .frame(maxWidth: 125)
                                Text("남았어요")
                                    .font(.headline)
                                    .foregroundStyle(.customGreen)
                            }
                            ProgressView(value: context.state.progressAmount, total: progressTotal)
                                .tint(.customGreen)
                        }
                        Image("alarm")
                            .resizable()
                            .scaledToFit()
                    }
                }
            } compactLeading: {
                // compact leading(다이나믹 아일랜드 소형 버전 왼쪽)
                Image("alarm")
                    .resizable()
                    .scaledToFit()
            } compactTrailing: {
                // compact trailing(다이나믹 아일랜드 소형 버전 오른쪽)
                Text(context.state.restOfTime, style: .relative)
                    .foregroundStyle(.customGreen)
                    .frame(width: 66)
            } minimal: {
                // minimal(다이나믹 아일랜드 가장 작은 버전)
                ProgressView(value: context.state.progressAmount, total: progressTotal)
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


// preview 설정
extension LiveTimeAttributes.ContentState {
    fileprivate static var start: LiveTimeAttributes.ContentState {
        LiveTimeAttributes.ContentState(restOfTime: Date.now, progressAmount: 0)
    }
    
    fileprivate static var middle: LiveTimeAttributes.ContentState {
        LiveTimeAttributes.ContentState(restOfTime: Date.now, progressAmount: 300)
    }
    
    fileprivate static var end: LiveTimeAttributes.ContentState {
        LiveTimeAttributes.ContentState(restOfTime: Date.now, progressAmount: 600)
    }
}

#Preview(as: .content, using: LiveTimeAttributes(), widget: {
    LiveTimeWidget()
}, contentStates: {
    LiveTimeAttributes.ContentState.start
    LiveTimeAttributes.ContentState.middle
    LiveTimeAttributes.ContentState.end
})
