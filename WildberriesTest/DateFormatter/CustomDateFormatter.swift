//
//  CustomDateFormatter.swift
//  WildberriesTest
//
//  Created by Админ on 06.06.2022.
//

import Foundation

final class CustomDateFormatter {
    
    
    //Выполняем конвертацию в совместную строку вывода Даты и Времени
    func convertToDateAndTimeString(from stringDate: String)->String{
        var formatterOutputString = ""
        
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: stringDate)
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormater.dateFormat = "dd MMMM y г., HH:mm"
        if let customDate = date {
            let currentDate = dateFormater.string(from: customDate)
            formatterOutputString = currentDate
        }
        
        return formatterOutputString
    }
    
    //Выполняем конвертацию в строку вывода Даты
    func convertToDateOnlyString(from stringDate: String)->String{
        var formatterOutputString = ""
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: stringDate)
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormater.dateFormat = "dd MMMM y г."
        if let customDate = date {
            let currentDate = dateFormater.string(from: customDate)
            formatterOutputString = currentDate
        }
        return formatterOutputString
    }
    
    //Выполняем конвертацию в совместную вывода Времени
    func convertToTimeOnlyString(from stringDate: String)->String{
        var formatterOutputString = ""
        let formatter = ISO8601DateFormatter()
        let date = formatter.date(from: stringDate)
        let dateFormater = DateFormatter()
        dateFormater.locale = Locale(identifier: "ru_RU")
        dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormater.dateFormat = "HH:mm"
        if let customDate = date {
            let currentDate = dateFormater.string(from: customDate)
            formatterOutputString = currentDate
        }
        return formatterOutputString
    }
}
