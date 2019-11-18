//
//  searchTests.swift
//  searchTests
//
//  Created by Affandy Murad on 10/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import XCTest
import RxSwift
import Moya
@testable import search

class searchTests: XCTestCase {
    
    let viewModel = ReactiveSearchListViewModel()

    let disposeBag = DisposeBag()
    
    func testWidth() {
        let startstring = "meong"
        let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 13.0)!)
//        XCTAssertNil(width)
        
        XCTAssertEqual(width, 44.60498046875)
        
    }
    
    func testData() {
        let a = NetworkSearchService().reactiveFetchSearchs(start: "0", rows: "10")
                
        a.subscribe(onNext:{ result in
            XCTAssertEqual(result.count, 10)
            }).disposed(by: disposeBag)
    }
    
    func testHelloWorld() {
        var helloWorld: String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello world"
        XCTAssertEqual(helloWorld, "hello world")
    }

}
