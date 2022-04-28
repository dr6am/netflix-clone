//
//  TV.swift
//  Netflix Clone
//
//  Created by Alejandro on 4/26/22.
//

import Foundation

struct TrendingTvResponse: TrendingResponse, Codable {
        var results: [Tv]
}

struct Tv: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let overview: String?
    let poster_path: String?
    let vote_count: Int?
    let vote_average: Float?
}

/*
 {
             "backdrop_path" = "/9PsOhpCNa4Vi3vaJt47rWn9XHTT.jpg";
             "first_air_date" = "2022-04-25";
             "genre_ids" =             (
                 80,
                 18
             );
             id = 125949;
             "media_type" = tv;
             name = "We Own This City";
             "origin_country" =             (
                 US
             );
             "original_language" = en;
             "original_name" = "We Own This City";
             overview = "The story of the rise and fall of the Baltimore Police Department's Gun Trace Task Force \U2014 and the corruption and moral collapse that befell an American city in which the policies of drug prohibition and mass arrest were championed at the expense of actual police work.";
             popularity = "73.955";
             "poster_path" = "/qNOYmU6JYMeu2I0xOX9pgCBOBXi.jpg";
             "vote_average" = "5.5";
             "vote_count" = 2;
         },
 */
