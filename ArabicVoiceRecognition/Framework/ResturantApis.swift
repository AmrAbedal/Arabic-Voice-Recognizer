//
//  ResturantApis.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/14/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import Moya

extension ResturantApi: TargetType {
    static let baseURLString = "https://www.ubereats.com/api/getSearchSuggestionsV1?localeCode=en-US"
    static let getLocationsURL = "https://www.ubereats.com/api/getLocationAutocompleteV1?localeCode=eg"
    static let getFeed = "https://www.ubereats.com/api/getFeedV1?localeCode=eg"
    var method: Moya.Method {
        switch self {
        case .loadResturant, .getLocations , .getFeed : return .post
        }
    }
    var sampleData: Data {
        return Data()
    }
    /// Switch task depend on Case
    var task: Task {
        switch self{
        case .loadResturant(_, let text):
            return .requestParameters(parameters: ["userQuery":text,"date":"","startTime":0,"endTime":0], encoding: JSONEncoding.default)
        case .getLocations(area: let areaName): return .requestParameters(parameters: ["query":areaName], encoding: JSONEncoding.default)
        case .getFeed( _, let text):
            return .requestParameters(parameters: ["cacheKey":"JTdCJTIyYWRkcmVzcyUyMiUzQSUyMiVEOCVBNyVEOSU4NCVEOCVCMiVEOSU4NSVEOCVBNyVEOSU4NCVEOSU4MyUyMiUyQyUyMnJlZmVyZW5jZSUyMiUzQSUyMkNoSUpKWUxaV2VCQVdCUVJYQ0dMTGxodnk1RSUyMiUyQyUyMnJlZmVyZW5jZVR5cGUlMjIlM0ElMjJnb29nbGVfcGxhY2VzJTIyJTJDJTIybGF0aXR1ZGUlMjIlM0EzMC4wNjEzMzklMkMlMjJsb25naXR1ZGUlMjIlM0EzMS4yMTg4OTY0JTdE/DELIVERY/\(text)//0/0//JTVCJTVE/","feedSessionCount":[
            "announcementCount":0,
            "announcementLabel":""],"userQuery":"كشري","date":"","startTime":0,"endTime":0,"carouselId":"","sortAndFilters":[]], encoding: JSONEncoding.default)        }
    }
    /// Switch headers depend on Case
    var headers: [String : String]? {
        switch self {
        case .loadResturant(let area, let text):
            return getHeaders(area: area,text: text)
        case .getLocations(area: let areaName): return getLoadAddressAutoCompleteHeaders(area: areaName)
        case .getFeed(let area, let text) : return LoadResturantsHeaders(area: area, text: text)
        }
    }
    /// Switch baseURL depend on Case
    var baseURL :URL {
        switch self {
        case .loadResturant:
            return URL(string : ResturantApi.baseURLString)!
        case .getLocations:  return URL(string : ResturantApi.getLocationsURL)!
        case .getFeed: return URL(string : ResturantApi.getFeed)!
      
        }
    }
    /// Switch baseURL depend on Case
    var path: String {
        switch self {
        case .loadResturant , .getLocations, .getFeed : return ""
        }
    }
}
