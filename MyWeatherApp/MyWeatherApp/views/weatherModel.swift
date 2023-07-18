//
//  weatherModel.swift
//  MyWeatherApp
//
//  Created by Mehmet Yumurtacı on 7/12/23.
//

import Foundation

struct WeatherResponseApi: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: CurrentResponseModel?
    let hourly: [HourlyResponse]?

}

struct HourlyResponse: Codable {
    var dt: Int?
    var temp: Double?
    var weather: [HourlyWeatherResponseModel?]

}
struct HourlyWeatherResponseModel: Codable {
    var id : Int?
    var main: CurrentWeatherMain?
    var description: String?
}

enum HourlyWeatherMain: String {
    case Thunderstorm
    case Clouds
    case Clear
    case Snow
    case Drizzle
    case Rain
    case Atmosphere
    case none
}

extension HourlyWeatherMain: Codable {
    public init(from decoder: Decoder) throws {
            self = try HourlyWeatherMain(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .none
    }
}


struct CurrentResponseModel: Codable {
    var dt: Int?
    var sunrise: Int?
    var temp: Double?
    var weather: [CurrentWeatherResponseModel?]
    

}

struct CurrentWeatherResponseModel: Codable {
    var id : Int?
    var main: CurrentWeatherMain?
    var description: String?

}

enum CurrentWeatherMain: String {
    case Thunderstorm
    case Clouds
    case Clear
    case Snow
    case Drizzle
    case Rain
    case Atmosphere
    case none
}

extension CurrentWeatherMain: Codable {
    public init(from decoder: Decoder) throws {
        self = try CurrentWeatherMain(rawValue: decoder.singleValueContainer().decode(String.self)) ?? .none
        }
}
