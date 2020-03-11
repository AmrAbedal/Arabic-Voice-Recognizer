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
    let name: String
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
    static let baseURLString = ""
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
        
        case .loadResturant(let area, let text):
            return .requestParameters(parameters: ["arwa":area], encoding: JSONEncoding.default)
        }
    }
    /// Switch headers depend on Case
    var headers: [String : String]? {
        return [:]
    }
    /// Switch baseURL depend on Case
    var baseURL :URL {
        return URL(string : "")!
    }
    /// Switch baseURL depend on Case
    var path: String {
        switch self {
        case .loadResturant: return ""
        }
    }
}
