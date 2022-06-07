//
//  JsonParsingDecoder.swift
//  WildberriesTest
//
//  Created by Админ on 07.06.2022.
//

import Foundation

final class JsonParsingDecoder {
    
    static let shared = JsonParsingDecoder()
    
    static var flightsArray: [Flight] = []
    static var flightSection: FlightSection = FlightSection.init(flightes: flightsArray)
    static let flightSectionsArray: [FlightSection] = .init()
    static var flightStorage: FlightStorage = FlightStorage.init(tableModel: [])
    
    
    /// Метод загрузки данных из JSON
    static func jsonDecodeToModel(url: URL, completion: @escaping (Data?) -> Void) -> Void{
        
        // создаем задачу запроса
        let requestForJSON = URLRequest(url: url as URL)
        
        let task =
            URLSession.shared.dataTask(with: requestForJSON) {data, response, error in
                
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    print(error.debugDescription)
                    return
                }
                
                guard let data = data else {
                    print(error.debugDescription)
                    return
                }
                
                do {
                    let tickets = try JSONDecoder().decode(JsonDefaultModel.self, from: data)
                    
                    // сохраняем данные согласно модели
                    for ticket in tickets.data {
                        let model = Flight(startCity: ticket.startCity,
                                           startCityCode: ticket.startCityCode,
                                           endCity: ticket.endCity,
                                           endCityCode: ticket.endCityCode,
                                           startDate: ticket.startDate,
                                           endDate: ticket.endDate,
                                           price: ticket.price,
                                           searchToken: ticket.searchToken,
                                           like: false)
                        self.flightsArray.append(model)
                    }
                    
                    self.flightSection.flightes.append(contentsOf: flightsArray)
                    self.flightStorage.tableModel.append(flightSection)
                   
                    
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
                catch let error {
                    print(error.localizedDescription)
                }
            }
        task.resume()
    }
    
}
