//
//  LoadResturantsUseCase.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 3/11/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation
import RxSwift
import Moya


struct Resturant {
    let name: String
}
struct ResturantResponce: Codable {
    let data: [ResponceData]
}
struct ResponceData: Codable {
    let store: Store
}

struct Store: Codable {
    let title: String
}
func loadResturantsUseCase(dataSource: LoadResturantDataSource,area: String,searchText: String) -> Single <[Resturant]>{
    return dataSource.loadResturat(area: area, searchText: searchText).map({
        getResturantFrom(resturantResponce: $0)
    })
}
fileprivate func getResturantFrom(resturantResponce: ResturantResponce) -> [Resturant] {
    return []
}

protocol LoadResturantDataSource {
    func loadResturat(area: String,searchText: String) -> Single<ResturantResponce>
}

class MoyaLoadResturantDataSource: LoadResturantDataSource {
    func loadResturat(area: String, searchText: String) -> Single<ResturantResponce> {
        return provider.rx
                   .request(.loadResturant(area, searchText))
                   .map{
                       try JSONDecoder().decode(ResturantResponce.self, from: $0.data)
               }
    }
    
    private let provider = MoyaProvider<ResturantApi>(plugins: [NetworkLoggerPlugin(verbose: true)])

}

enum ResturantApi {
    case loadResturant(String,String)
}



extension ResturantApi: TargetType {
    /// Switch method depend on Case
    static let baseURLString = "https://www.ubereats.com/api/getSearchSuggestionsV1?localeCode=en-US"
    var method: Moya.Method {
        switch self {
        case .loadResturant : return .post
        }
    }
    var sampleData: Data {
        return Data()
    }
    /// Switch task depend on Case
    var task: Task {
        switch self{
        
        case .loadResturant(_, let text):
            return .requestParameters(parameters: ["userQuery":"كريب","date":"","startTime":0,"endTime":0], encoding: JSONEncoding.default)
        }
    }
    /// Switch headers depend on Case
    var headers: [String : String]? {
        return getHeaders()
    }
    /// Switch baseURL depend on Case
    var baseURL :URL {
        return URL(string : ResturantApi.baseURLString)!
    }
    /// Switch baseURL depend on Case
    var path: String {
        switch self {
        case .loadResturant: return ""
        }
    }
}


func getHeaders() -> [String: String] {
    
    ["authority": "www.ubereats.com",
    "method": "POST",
    "path": "/api/getSearchSuggestionsV1?localeCode=en-US",
    "scheme": "https",
    "accept": "*/*",
    "accept-encoding": "gzip, deflate, br",
    "accept-language": "ar,en-US;q=0.9,en;q=0.8",
    "content-length": "60",
    "content-type": "application/json",
    "cookie": "uev2.id.xp=3bf08b4d-7601-48e6-b428-ff491fcb2414; dId=b0e630bd-c4d3-4ab8-9d98-96363edb4f2e; uev2.id.session=b5d51f1e-5b51-4341-8194-67b7260dfd30; uev2.ts.session=1583954948056; jwt-session=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1ODM5NTQ5NDgsImV4cCI6MTU4NDA0MTM0OH0.RqLw8ciRIbw7zqXQnFeTlLVhv8v3RrkA-1VI_Lx3njg; uev2.loc=%7B%22address%22%3A%7B%22address1%22%3A%22Ad%20Doqi%22%2C%22address2%22%3A%22Dokki%2C%20Giza%20Governorate%22%2C%22aptOrSuite%22%3A%22%22%2C%22city%22%3A%22%22%2C%22country%22%3A%22%22%2C%22eaterFormattedAddress%22%3A%22Ad%20Doqi%2C%20Dokki%2C%20Giza%20Governorate%2C%20Egypt%22%2C%22postalCode%22%3A%22%22%2C%22region%22%3A%22%22%2C%22subtitle%22%3A%22Dokki%2C%20Giza%20Governorate%22%2C%22title%22%3A%22Ad%20Doqi%22%2C%22uuid%22%3A%22%22%7D%2C%22latitude%22%3A30.03945109999999%2C%22longitude%22%3A31.2025336%2C%22reference%22%3A%22ChIJkx2HJc1GWBQRSNzstAXvoXQ%22%2C%22referenceType%22%3A%22google_places%22%2C%22type%22%3A%22google_places%22%2C%22source%22%3A%22rev_geo_reference%22%7D; marketing_vistor_id=ce4bbe29-61ed-4cf6-ab90-fb95ce905b78; _userUuid=; _scid=6bc2c3e5-d2da-445d-8cf1-10b75138a6e3; _gcl_au=1.1.2122845426.1583954957; _fbp=fb.1.1583954957338.1127446566; _ga=GA1.2.1760238369.1583954957; _gid=GA1.2.1214331454.1583954957; QSI_HistorySession=https%3A%2F%2Fwww.ubereats.com%2Fen-US%2Fsearch%2F%3Fpl%3DJTdCJTIyYWRkcmVzcyUyMiUzQSUyMkFkJTIwRG9xaSUyMiUyQyUyMnJlZmVyZW5jZSUyMiUzQSUyMkNoSUpreDJISmMxR1dCUVJTTnpzdEFYdm9YUSUyMiUyQyUyMnJlZmVyZW5jZVR5cGUlMjIlM0ElMjJnb29nbGVfcGxhY2VzJTIyJTJDJTIybGF0aXR1ZGUlMjIlM0EzMC4wMzk0NTEwOTk5OTk5OSUyQyUyMmxvbmdpdHVkZSUyMiUzQTMxLjIwMjUzMzYlN0Q%253D%26q%3D%25D8%25A7%25D9%2584%25D9%2583%25D8%25B4%25D8%25B1%25D9%258A~1583954957656; _sctr=1|1583877600000; utag_main=v_id:0170cb1290eb001f4540dd6cb85a03079016307100838$_sn:1$_se:5$_ss:0$_st:1583956788366$ses_id:1583954956525%3Bexp-session$_pn:1%3Bexp-session",
    "origin": "https://www.ubereats.com",
    "referer": "https://www.ubereats.com/en-US/search?pl=JTdCJTIyYWRkcmVzcyUyMiUzQSUyMkFkJTIwRG9xaSUyMiUyQyUyMnJlZmVyZW5jZSUyMiUzQSUyMkNoSUpreDJISmMxR1dCUVJTTnpzdEFYdm9YUSUyMiUyQyUyMnJlZmVyZW5jZVR5cGUlMjIlM0ElMjJnb29nbGVfcGxhY2VzJTIyJTJDJTIybGF0aXR1ZGUlMjIlM0EzMC4wMzk0NTEwOTk5OTk5OSUyQyUyMmxvbmdpdHVkZSUyMiUzQTMxLjIwMjUzMzYlN0Q%3D&q=%D8%A7%D9%84%D9%83%D8%B4%D8%B1%D9%8A",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "same-origin",
    "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",
    "x-csrf-token": "x"]
}
