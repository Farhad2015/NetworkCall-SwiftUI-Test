//
//  LoginModel.swift
//  NetworkCall Test
//
//  Created by Artificial-Soft Air on 4/7/21.
//

import Foundation

struct loginData: Codable {
    let id, name, user_catagory, catagory_type, mobile, address, image_url, institute_name, error_report: String
    let error: Int
}
