//
//  NetworkConstants.swift
//  NetworkLayer
//
//  Created by Irving Delgado Silva on 16/01/22.
//

 struct NetworkConstants {
    struct MockData {
        static let mockMovieBaseurl = "https://api.themoviedb.org"
        static let mockMovieEndpoint = "/3/trending/movie/day"
        static let mockMovieParameters = ["api_key": "f6cd5c1a9e6c6b965fdcab0fa6ddd38a",
                                          "language": "en",
                                          "region": "US",
                                          "page": "1"]
        static let mockAbsoluteURL = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=en&region=US&page=1"
        static let mockHeaders = ["application/json": "Accept"
                                    ]
    }
}
