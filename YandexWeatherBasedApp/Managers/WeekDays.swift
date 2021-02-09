//
//  WeekDays.swift
//  YandexWeatherBasedApp
//
//  Created by Звягинцев Михаил on 29.01.2021.
//

import Foundation

struct WeekDays{
    
    private func getDay(number: Int) -> String{
             
            switch number{
                 
                case 1:
                    return "Понедельник"
                case 2:
                    return "Вторник"
                case 3:
                    return "Среда"
                case 4:
                    return "Четверг"
                case 5:
                    return "Пятница"
                case 6:
                    return "Суббота"
                case 7:
                    return "Воскресенье"
                default:
                    return "undefined"
            }
        }
    
   func getWeekday(fromDate: String?) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let _ = fromDate, let date = formatter.date(from: fromDate!) {
            return self.getDay(number: Calendar.current.component(.weekday, from: date))
        }
        print("ERROR: Inccorect Date format")
        return "Понедельник"
    }
}
