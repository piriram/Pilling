//
//  CellView.swift
//  MC2-Team3-Pilling
//
//  Created by ram on 5/23/24.
//

import Foundation
import SwiftUI
import SwiftData
struct ActivateCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var isToday:Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: 45, height: 45)
            .foregroundColor(backgroundColor)
            .overlay(
                isToday ? RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(hex:"#507E20"), lineWidth: 4)
                : nil
            )
            
    }
    
}


struct PlaceboCell: View {
    @Binding var isModal: Bool
    var dayData: DayData
    var backgroundColor: Color
    var isToday: Bool
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color.white)
            .frame(width: 45, height: 45)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 0.5)
                    .stroke(isToday ? Color.green : Color(red: 0.91, green: 0.91, blue: 0.92), lineWidth: isToday ? 4 : 1)
            )
            
    }
}

struct TodayCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 45, height: 45)
            .background(.clear)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .inset(by: 1)
                    .stroke(Color.green,lineWidth: 3)
                
            )
    }
    
}
struct TwoCell: View {
    @Binding var isModal:Bool
    var backgroundColor: Color
    var isToday: Bool
    var body: some View {
        HStack(spacing: 5){
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 20, height: 45)
                .background(.customGreen)
                .cornerRadius(10)
                .overlay(
                    isToday ? RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex:"#507E20"), lineWidth: 4)
                    : nil
                )
            
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 20, height: 45)
                .background(Color(red: 0.5, green: 0.87, blue: 0.11))
                .cornerRadius(10)
                .overlay(
                    isToday ? RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex:"#507E20"), lineWidth: 4)
                    : nil
                )
            
            
        }
        .frame(width: 45, height: 45)
        
        
    }
    
}
