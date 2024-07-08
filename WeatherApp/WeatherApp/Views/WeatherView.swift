//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Michelle Yeoh on 6/27/24.
//

import SwiftUI
import Foundation
import UIKit

let trackCellHeight: CGFloat = 72

struct WeatherView: View {
    var weather: ResponseBody
    let music: [[Track]] = [playlists, artists, albums]
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            Image(systemName: "sun.max")
                                .font(.system(size: 40))
                            
                            Text(weather.weather[0].main)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "°")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
//                    Spacer()
//                        .frame(height: 80)
                    
//                    AsyncImage(url: URL(string: "https://pngimg.com/d/city_PNG16.png")) { image in image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 350)
//                    } placeholder: {
//                        ProgressView()
//                    }
                    TrackView(track: Track(imageName: "duck_skateboard", title: "Beat the \(weather.weather[0].main)", artist: "Mixed Artists"))
                    TrackView(track: Track(imageName: "duck_sleep", title: "Embrace the \(weather.weather[0].main)", artist: "Mixed Artists"))
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold().padding(.bottom)
                    
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.tempMin.roundDouble() + "°"))
                        
                        Spacer ()
                        
                        WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.tempMax.roundDouble() + "°"))
                    }
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.roundDouble() + "m/s"))
                        
                        Spacer ()
                        
                        WeatherRow(logo: "humidity", name: "Humidity", value: (weather.main.humidity.roundDouble() + "%"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(hue: 0.675, saturation: 1.0, brightness: 0.151))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.675, saturation: 1.0, brightness: 0.151))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
