//
//  CalculateBrain.swift
//  BMI Calculator
//
//  Created by juyeong koh on 2022/09/05.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi: BMI?
    
    func getBMIValue() -> String {
        let bmi1To1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
            return bmi1To1DecimalPlace
        }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "조언없음"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }

    
    mutating func calculateBMI(height: Float, weight: Float) {
        let bmiValue = weight / (height * height)

        if bmiValue < 18.5 {
            bmi = BMI(value: bmiValue, advice: "저체중", color: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        } else if bmiValue < 24.9 {
            bmi = BMI(value: bmiValue, advice: "정상체중", color: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1))
        } else {
            bmi = BMI(value: bmiValue, advice: "과체중", color: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
    }
}
 

