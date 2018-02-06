//
//  Article.swift
//  NewNews
//
//  Created by Roman on 2/6/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import Foundation
import UIKit

class Articles:Decodable {
    let status:String
    let totalResults:Int
    let articles:[Article]
    
    init(status:String, totalResults:Int, articles:[Article]) {
        self.status = status
        self.totalResults = totalResults
        self.articles = articles
    }
}


class Article: Decodable {
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
    
    init(author:String, title:String, description:String, url:String, urlToImage:String, publishedAt:String) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
