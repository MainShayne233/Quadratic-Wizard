//
//  QuadraticCalculator.swift
//  Quadratic Wizard
//
//  Created by shayne on 10/25/15.
//  Copyright © 2015 Open Sourcery. All rights reserved.
//

import Foundation

class QuadraticCalculatorModel{
    
    
    func inner_sqrt_value(nums: [Double]) -> Double{
        let a = Double(nums[0]);
        let b = Double(nums[1]);
        let c = Double(nums[2]);
        return Double(pow(b,2.0)-4.0*a*c);
    }
    
    func neq_pos_zero(sqrt: Double) -> Double{
        if (sqrt < 0){
            return -1
        }
        else if (sqrt == 0){
            return 0
        }
        return 1
    }
    
    func is_sqr(n: Double) -> Bool{
        if (pow(n,0.5) == round(pow(n,0.5))){
            return true;
        }
        return false;
    }
    
    
    func sqr_fact(sqrt: Double) -> Double{
        for index in 1...5{
            if (is_sqr(sqrt/Double(index))){
                return sqrt/Double(index)
            }
        }
        return 1
    }
    
    func sqrt_case(var sqrt: Double) -> [Double]{
        if (sqrt < 0){
            sqrt = abs(sqrt)
        }
        let fac = sqr_fact(sqrt)
        if (fac == sqrt){
            return [pow(sqrt,0.5),1]
        }
        else if (fac == 1){
            return [1,sqrt]
        }
        else{
            return [pow(fac,0.5),sqrt/fac]
        }
    }
    
    func sqrt_properties(sqrt: Double) -> [Double]{
        var sqrt_prop = [0,0]
        sqrt[0] = neq_pos_zero(sqrt)
        sqrt[1] = sqrt_case(sqrt)
        return sqrt_prop
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
