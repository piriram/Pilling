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
            HStack {
                Image(systemName: "leaf.fill")
                    .foregroundStyle(.customGreen)
                Text("잔디를 심을 시간이에요!")
                Spacer()
                Text(context.state.restOfTime, style: .relative)
                    .foregroundStyle(.customGreen)
                    .frame(width: 77, height: 30)
            }
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        Text("잔디 심을 시간이에요!")
                        Text(context.state.restOfTime, style: .relative)
                            .foregroundStyle(.customGreen)
                        Button("click") {}
                            .tint(.customGreen)
                    }
                    .padding()
                }
            } compactLeading: {
                Image(systemName: "leaf.fill")
                    .foregroundStyle(.customGreen)
            } compactTrailing: {
                Text(context.state.restOfTime, style: .relative)
                    .foregroundStyle(.customGreen)
                    .frame(width: 66)
            } minimal: {
                Text(context.state.restOfTime, style: .relative)
                    .foregroundStyle(.customGreen)
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

