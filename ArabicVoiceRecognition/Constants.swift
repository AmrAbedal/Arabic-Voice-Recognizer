//
//  Constants.swift
//  ArabicVoiceRecognition
//
//  Created by Amr AbdelWahab on 2/27/20.
//  Copyright © 2020 Orcas. All rights reserved.
//

import Foundation


struct Constants {
    static let getHtmlEvaluator = "document.documentElement.outerHTML.toString()"
    static let uberSearch = "https://www.ubereats.com/en-US/search"
    static let searchTextKey = "q"
    static let areaTextKey = "pl"
}


func getHeaders(area: String,text: String) -> [String: String] {
    
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
    "referer": "https://www.ubereats.com/en-US/search?pl=\(getString(text: area))&q=\(getString(text: text))",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "same-origin",
    "user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",
    "x-csrf-token": "x"]
}

func getString(text: String ) -> String {
    return  text.fixedArabicURL!
}

extension String {
var fixedArabicURL: String?  {
       return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics
           .union(CharacterSet.urlPathAllowed)
           .union(CharacterSet.urlHostAllowed))
   } }


func getLoadAddressAutoCompleteHeaders(area: String) -> [String: String] {
    ["authority": "www.ubereats.com",
"method": "POST",
"path": "/api/getLocationAutocompleteV1?localeCode=eg",
"scheme": "https",
"accept":" */*",
"accept-encoding": "gzip, deflate, br",
"accept-language": "ar,en-US;q=0.9,en;q=0.8",
"content-length": "16",
"content-type": "application/json",
"cookie": "uev2.id.xp=00b8cbdc-be47-44dd-9f60-51bcbdcd22f4; dId=39961ab1-d0e0-4bbd-9317-c2a094ee125d; uev2.id.session=0b4b89a5-6921-488e-8530-1b520d79e132; uev2.ts.session=1584016824112; jwt-session=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1ODQwMTY4MjQsImV4cCI6MTU4NDEwMzIyNH0.LD_CkKRJQoj2fvyNQs-v_-DcVdNb1hofKyV_UdqD7js; marketing_vistor_id=67bbfd91-387d-4c98-a45d-87a185658c2b; _userUuid=; _scid=95fb408c-343e-4933-a249-4f08ff289edd; _fbp=fb.1.1584016830227.2004027010; _gcl_au=1.1.2035325398.1584016830; _ga=GA1.2.1462486633.1584016830; _gid=GA1.2.535390884.1584016830; QSI_HistorySession=https%3A%2F%2Fwww.ubereats.com%2Feg~1584016830653; _sctr=1|1583964000000; uev2.loc=%7B%22address%22%3A%7B%22address1%22%3A%22%D8%A7%D9%84%D8%AF%D9%82%D9%8A%22%2C%22address2%22%3A%22%D8%A7%D9%84%D8%AF%D9%82%D9%89%D8%8C%20%D8%A7%D9%84%D8%AC%D9%8A%D8%B2%D8%A9%22%2C%22aptOrSuite%22%3A%22%22%2C%22city%22%3A%22%22%2C%22country%22%3A%22%22%2C%22eaterFormattedAddress%22%3A%22%D8%A7%D9%84%D8%AF%D9%82%D9%8A%D8%8C%20%D8%A7%D9%84%D8%AF%D9%82%D9%89%D8%8C%20%D8%A7%D9%84%D8%AC%D9%8A%D8%B2%D8%A9%D8%8C%20%D9%85%D8%B5%D8%B1%22%2C%22postalCode%22%3A%22%22%2C%22region%22%3A%22%22%2C%22subtitle%22%3A%22%D8%A7%D9%84%D8%AF%D9%82%D9%89%D8%8C%20%D8%A7%D9%84%D8%AC%D9%8A%D8%B2%D8%A9%22%2C%22title%22%3A%22%D8%A7%D9%84%D8%AF%D9%82%D9%8A%22%2C%22uuid%22%3A%22%22%7D%2C%22latitude%22%3A30.03945109999999%2C%22longitude%22%3A31.2025336%2C%22reference%22%3A%22ChIJkx2HJc1GWBQRSNzstAXvoXQ%22%2C%22referenceType%22%3A%22google_places%22%2C%22type%22%3A%22google_places%22%2C%22source%22%3A%22manual_auto_complete%22%7D; utag_main=v_id:0170cec2ab5d001ecde2b60827df03079001b07100838$_sn:1$_se:22$_ss:0$_st:1584018898424$ses_id:1584016829279%3Bexp-session$_pn:1%3Bexp-session",
"origin": "https://www.ubereats.com",
"referer": " https://www.ubereats.com/eg/search?pl=JTdCJTIyYWRkcmVzcyUyMiUzQSUyMiVEOCVBNyVEOSU4NCVEOCVBRiVEOSU4MiVEOSU4QSUyMiUyQyUyMnJlZmVyZW5jZSUyMiUzQSUyMkNoSUpreDJISmMxR1dCUVJTTnpzdEFYdm9YUSUyMiUyQyUyMnJlZmVyZW5jZVR5cGUlMjIlM0ElMjJnb29nbGVfcGxhY2VzJTIyJTJDJTIybGF0aXR1ZGUlMjIlM0EzMC4wMzk0NTEwOTk5OTk5OSUyQyUyMmxvbmdpdHVkZSUyMiUzQTMxLjIwMjUzMzYlN0Q%3D&q=%D9%83%D8%B4%D8%B1%D9%8A",
"sec-fetch-dest": "empty",
"sec-fetch-mode": "cors",
"sec-fetch-site": "same-origin",
"user-agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36",
"x-csrf-token": "x"]
    
}



func LoadResturantsHeaders(area: String,text: String) -> [String: String] {
    
    ["method": "POST",
    "scheme": "https",
    "authority": "www.ubereats.com",
    "path": "/api/getFeedV1?localeCode=eg",
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "en-us",
    "Host": "www.ubereats.com",
    "Origin": "https://www.ubereats.com",
    "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_2) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.4 Safari/605.1.15",
    "Connection": "keep-alive",
    "Referer": "https://www.ubereats.com/eg/search?pl=\(area.fixedArabicURL!))&q=\(text.fixedArabicURL!))",
    "Content-Length": "514",
    "Cookie": "_fbp=fb.1.1584130379510.1423175676; _gcl_au=1.1.2005771371.1584130380; _userUuid=; utag_main=v_id:0170d5874c3800146e1fbd05930f01077017d06f00838$_sn:1$_se:8$_ss:0$_st:1584132222154$ses_id:1584130378816%3Bexp-session$_pn:1%3Bexp-session; marketing_vistor_id=732d345c-77ea-4ce1-bde8-068796bd3873; uev2.id.session=229629fd-7198-49e7-9fde-a4868b3a5b02; uev2.ts.session=1584130357687; _ga=GA1.2.635740806.1584130379; _gid=GA1.2.357878062.1584130379; _scid=9aac0303-9b82-46ae-8c6b-dfc504a6ecdf; uev2.loc=%7B%22address%22%3A%7B%22address1%22%3A%22Zamalek%22%2C%22address2%22%3A%22Cairo%20Governorate%22%2C%22aptOrSuite%22%3A%22%22%2C%22city%22%3A%22%22%2C%22country%22%3A%22%22%2C%22eaterFormattedAddress%22%3A%22Zamalek%2C%20Cairo%20Governorate%2C%20Egypt%22%2C%22postalCode%22%3A%22%22%2C%22region%22%3A%22%22%2C%22subtitle%22%3A%22Cairo%20Governorate%22%2C%22title%22%3A%22Zamalek%22%2C%22uuid%22%3A%22%22%7D%2C%22latitude%22%3A30.061339%2C%22longitude%22%3A31.2188964%2C%22reference%22%3A%22ChIJJYLZWeBAWBQRXCGLLlhvy5E%22%2C%22referenceType%22%3A%22google_places%22%2C%22type%22%3A%22google_places%22%2C%22source%22%3A%22rev_geo_reference%22%7D; dId=78d0e740-8bbc-4a13-86c4-6913196c6e4d; uev2.id.xp=caea8df0-b47a-4015-a303-62c9aea20b32; jwt-session=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOjE1ODQxMzAzNTcsImV4cCI6MTU4NDIxNjc1N30.JvN6qjNg9yfsDoRikJG6j2Dvh4FxPX5iNNyiQ23mOk8",
    "x-csrf-token": "x"]

}
