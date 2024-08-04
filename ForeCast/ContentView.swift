//
//  ContentView.swift
//  ForeCast
//
//  Created by Sultan on 04.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            ScrollView(
                LazyVStack {
                    ForEach(NetworkManager.shared.forecasts, id: \.id) {forcast in
                        Text(forcast)
                    }
                }
            )
        }
        .padding()
        .onAppear {
            NetworkManager.shared.getWeatherInfo()
        }
    }
}


#Preview {
    ContentView()
}
