//
//  WeatherView.swift
//  ForeCast
//
//  Created by Sultan on 05.08.2024.
//

import SwiftUI

struct WeatherView: View {
    @State private var forecasts: [List] = []
    private let networkManager = NetworkManager.shared
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(forecasts.indices, id: \.self) { index in
                        let forecast = forecasts[index]
                        VStack(alignment: .leading) {
                            Text(formatDate(dayIncrement: index))
                                .font(.headline)
                            Text("Temp: \(String(format: "%.1f", forecast.main.temp - 273.15))°C")
                            Text("Feels like: \(String(format: "%.1f", forecast.main.feelsLike - 273.15))°C")
                            Text("Description: \(forecast.weather.first?.description ?? "N/A")")
                        }
                        .frame(width: 280, alignment: .leading)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(8)
                        .shadow(radius: 4)
                        .padding(.horizontal)
                        .padding(.top, 8)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationTitle("Astana")
            .onAppear {
                networkManager.getWeatherInfo { fetchedWeather in
                    if let fetchedWeather = fetchedWeather {
                        self.forecasts = fetchedWeather.list
                    }
                }
            }
        }
    }
    
    func formatDate(dayIncrement: Int) -> String {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let forecastDate = calendar.date(byAdding: .day, value: dayIncrement, to: today) ?? today
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        
        let formattedDate = dateFormatter.string(from: forecastDate)
        
        switch dayIncrement {
        case 0:
            return "Today"
        case 1:
            return "\(formattedDate)"
        default:
            return formattedDate
        }
    }
}

#Preview {
    WeatherView()
}
