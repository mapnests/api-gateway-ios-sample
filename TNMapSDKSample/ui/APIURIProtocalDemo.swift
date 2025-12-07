//
//  APIURIProtocalDemo.swift
//  TNMapSDKSample
//
//  Created by TechnoNext on 2/12/25.
//

import UIKit

class APIURIProtocalDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let url = URL(string: "http://192.168.61.103:9080/load-test/api/auth-casbin-success-plugin-test")!

        let clientHeaders = [
            "Client-Header-Name1": "xxxxxx",
            "Client-Header-Name2": "yyyyyy"
        ]

        NetworkManager.shared.request(
            url: url,
            method: "GET",
            clientHeaders: clientHeaders,
        ) { data, response, error in
            if let data = data, let text = String(data: data, encoding: .utf8) {
                print("Response:\n\(text)")
            }
        }
    }
}
