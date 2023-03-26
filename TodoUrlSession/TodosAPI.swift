//
//  TodosAPI.swift
//  TodoUrlSession
//
//  Created by 김라영 on 2023/03/22.
//

import Foundation
import UIKit

enum TodosAPI {
    static let version = "v1"
    //가장 기본이 되는 URL
    //if Debug는 전처리가로 컴파일이 되기전에 if debug부분이 먼저 탄다
    #if DEBUG //디버그용
    static let baseUrl = "https://phplaravel-574671-2962113.cloudwaysapps.com/api/\(version)"
    #else //릴리즈용
    static let baseUrl = "https://phplaravel-574671-2962113.cloudwaysapps.com/api\(version)"
    #endif
    
    //어떤 API에러들이 오는지를 작업해주는 부분
    enum ApiError : Error {
        case parsingError
        case noContent
        case decodingError
        case badStatus(code: Int)
    }
    
    //completion은 데이터 reponse가 되고 난 후에 어떤 작업을 할 것인지를 의미한다
    //이 함수가 불려지고 바로 할 작업은 아니므로 @escaping을 써준다
    //Result를 사용한 이유는 response가 성공을 하면 TodoResponse 자료형으로 나오고 response가 실패를 하면 Error자료형으로 나온다
    static func fetchTodos(_ page: Int = 1, completion: @escaping (Result<TodoResponse, Error>) -> Void) { //Todo목록가져오기
        //1. url Request를 만든다
        let urlString = baseUrl + "/todos?" + "page=\(page)" //Url만들때 쓰일 주소 만들기
        print(#fileID, #function, #line, "- urlString: \(urlString)")
        let url = URL(string: urlString)! //url 만들기
        
        var urlRequest = URLRequest(url: url) //urlRequest만들기
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "accept")
        
        //2. urlSession으로 API를 호출한다 -> URLSession.shared.dataTask가 호출을 해주는 부분
        //3. API 호출에 대한 응답을 받는다
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let jsonData = data {
                do {
                    //json으로 되어있는 data를 struct로 파싱
                    let todoResponse = try JSONDecoder().decode(TodoResponse.self, from: jsonData)
                    let todoData = todoResponse.data
                    print(#fileID, #function, #line, "- todoResonse: \(todoResponse)")
                    completion(.success(todoResponse))
                } catch {
                    completion(.failure(ApiError.decodingError))
                }
                
            }
        }.resume() //resume을 통해서 응답을 받는다
    }
}
