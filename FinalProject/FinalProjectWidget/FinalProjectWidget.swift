//
//  FinalProjectWidget.swift
//  FinalProjectWidget
//
//  Created by Neel Joshi on 4/28/25.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), emoji: "😀")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), emoji: "😀")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        let entry = SimpleEntry(date: Date(), emoji: "🙂")
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let emoji: String
}

struct FinalProjectWidgetEntryView: View {
    @Query() var items: [WidgetModel]
    var entry: Provider.Entry

    var body: some View {
        if let item = items.first {
            VStack(alignment: .leading, spacing: 8) {
                Text(item.displayName ?? "")
            }
            .padding()
            .containerBackground(.blue.gradient, for: .widget)
        } else {
            VStack {
                Text("Failed to retrieve trending media. Try again later.")
                    .font(.headline)
            }
            .padding()
            .containerBackground(.blue.gradient, for: .widget)
        }
    }
}

struct FinalProjectWidget: Widget {
    let kind: String = "FinalProjectWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FinalProjectWidgetEntryView(entry: entry)
                .modelContainer(for: WidgetModel.self)
        }
        .configurationDisplayName("Timestamp Widget")
        .description("View the most recent timestamp in your list.")
    }
}

#Preview(as: .systemSmall) {
    FinalProjectWidget()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
