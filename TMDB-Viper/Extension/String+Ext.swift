//
//  String+Ext.swift
//  TMDB-Viper
//
//  Created by Icung on 27/08/23.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSZ"
        let date = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
