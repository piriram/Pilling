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
            }
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.bottom) {
                    Text("잔디 심을 시간")
                    Text(context.state.restOfTime, style: .relative)
                    Button("click") {}
                }
            } compactLeading: {
                Image(systemName: "leaf.fill")
            } compactTrailing: {
                Text(context.state.restOfTime, style: .relative)
            } minimal: {
                Text(context.state.restOfTime, style: .relative)
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

