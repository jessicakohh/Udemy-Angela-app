//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "YOUR_API_KEY_HERE"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        //스트링 연결을 사용하여 베이스 끝에 선택한 통화 추가API 키와 함께 URL을 입력합니다.
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        //선택적 바인딩을 사용하여 urlString에서 생성된 URL을 언랩합니다.
        if let url = URL(string: urlString) {
            
            //기본 구성으로 새 URLsession 개체를 만듭니다.
            let session = URLSession(configuration: .default)
            
            //URL 세션에 대한 새 데이터 작업 생성
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                //받은 데이터를 문자열로 포맷하여 인쇄할 수 있습니다.
                let dataAsString = String(data: data!, encoding: .utf8)
                print(dataAsString)
            }
            
            //비트코인 평균 서버에서 데이터를 가져오는 작업을 시작합니다.
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
