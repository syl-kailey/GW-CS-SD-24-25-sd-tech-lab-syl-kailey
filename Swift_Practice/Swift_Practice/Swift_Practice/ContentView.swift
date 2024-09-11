//
//  ContentView.swift
//  Swift_Practice
//
//  Created by Sylmira Kailey on 9/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var activities = ["Archery", "Baseball", "Basketball", "Bowling", "Boxing", "Cricket", "Curling", "Fencing", "Golf", "Hiking", "Lacrosse", "Rugby", "Squash"]

    @State private var selected = "Baseball"
    
    @State private var id = 1
    
    var colors: [Color] = [.blue, .cyan, .gray, .green, .indigo, .mint, .orange, .pink, .purple, .red]

    var body: some View {
//        Text("Hello, SwiftUI!")
        Text("Why not try…")
                .font(.largeTitle.bold())
        Spacer()
        Circle()
            .fill(colors.randomElement() ?? .blue)
            .padding()
            .overlay(
                Image(systemName: "figure.\(selected.lowercased())")
                    .font(.system(size: 144))
                    .foregroundColor(.white)
            )
        Text("\(selected)!")
            .font(.title)
        Spacer()
        Button("Try again") {
            withAnimation (.easeInOut(duration: 1)){
                    selected = activities.randomElement() ?? "Archery"
                    id += 1
                }
        }
        .buttonStyle(.borderedProminent)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
