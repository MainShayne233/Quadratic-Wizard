//
//  QuadraticCalculator.swift
//  Quadratic Wizard
//
//  Created by shayne on 10/25/15.
//  Copyright © 2015 Open Sourcery. All rights reserved.
//

import Foundation

class QuadraticCalculatorModel{
    
    var good_input = true
    
    var input_nums: [Int]
    
    init(input_nums: [Int]){
        self.input_nums = input_nums
    }
    
    
    func inner_sqrt_value(nums: [Int]) -> Int{
        let a = Int(nums[0])
        let b = Double(nums[1])
        let c = Int(nums[2])
        return (Int(pow(b,2.0))-4*a*c)
    }
    
    func neq_pos_zero(sqrt: Int) -> Int{
        if (sqrt < 0){
            return -1
        }
        else if (sqrt == 0){
            return 0
        }
        return 1
    }
    
    func is_sqr(n: Double) -> Bool{
        if (pow(Double(n),0.5) == round(pow(Double(n),0.5))){
            return true
        }
        return false
    }
    
    
    func sqr_fact(sqrt: Int) -> Int{
        if sqrt == 0{
            return 1
        }
        for index in 1...sqrt{
            if (is_sqr(Double(sqrt)/Double(index))){
                return sqrt/index
            }
        }
        return 1
    }
    
    func sqrt_case(var sqrt: Int) -> [Int]{
        if (sqrt < 0){
            sqrt *= (-1)
        }
        let fac = sqr_fact(sqrt)
        if (fac == sqrt){
            return [Int(pow(Double(sqrt),0.5)),1]
        }
        else if (fac == 1){
            return [1,sqrt]
        }
        else{
            return [Int(pow(Double(fac),0.5)),sqrt/fac]
        }
    }
    
    func sqrt_properties(sqrt: Int) -> [[Int]]{
        var sqrt_prop = [[0],[0]]
        sqrt_prop[0][0] = neq_pos_zero(sqrt)
        sqrt_prop[1] = sqrt_case(sqrt)
        return sqrt_prop
    }
    
    func gcd(values: [Int]) -> Int{
        var largest = 0
        var flag : Int
        for val in values{
            if abs(val) > largest{
                largest = abs(val)
            }
        }
        var fac = largest
        while fac > 0{
            flag = 0
            for val in values{
                if val%fac != 0{
                    flag = 1
                }
            }
            if flag == 0{
                return fac
            }
            fac--
        }
        return 1
    }
    
    
    func sol_form(nums: [Int], sqrt_prop: [[Int]], which: Int) -> [Int]{
        var form = [0,0,0,0,0]
        var div: Int
        var w_val = 1
        form[0] = nums[1]*(-1)
        form[1] = sqrt_prop[1][0]
        form[2] = sqrt_prop[1][1]
        form[3] = sqrt_prop[0][0]
        form[4] = nums[0]*2
        if form[0] < 0 && form[4] < 0{
            form[0] *= -1
            form[4] *= -1
        }
        //if the whole square root is just 0
        if form[3] == 0{
            form[1] = 0
            form[2] = 0
            div = gcd([form[0],form[4]])
            form[0] /= div
            form[4] /= div
        }
        //if there is a mixed whole number and square root
        else if form[1] > 1 && form[2] > 1{
            div = gcd([form[0],form[1],form[4]])
            form[0] /= div
            form[1] /= div
            form[4] /= div
        }
        //if there is just a whole number on the right, and no i
        else if form[1] > 0 && form[2] == 1 && form[3] == 1{
            if which == 1{
                w_val = form[0] + form[1]
            }
            else{
                w_val = form[0] - form[1]
            }
            div = gcd([w_val, form[4]])
            form[0] = w_val / div
            form[4] /= div
            form[1] = 0
            form[2] = 0
            form[3] = 0
        }
        //if there is just a whole number on the right, and an i
        else if form[1] > 1 && form[2] == 1 && form[3] == -1{
            div = gcd([form[0],form[1],form[4]])
            form[0] /= div
            form[1] /= div
            form[4] /= div
        }
        //if there is just a square root on the right
        else if form[1] == 1 && form[2] > 1{
            //nada
        }
        if form[4] == -1{
            form[0] *= -1
            form[4] = 1
            w_val *= -1
        }
        else if (form[4] < -1){
            form[0] *= -1
            form[4] *= -1
            w_val *= -1
        }
        return form
    }
    
    func determine_oper(a: Int, which: Int) -> String{
        if which == 1 && a == 0{
            return ""
        }
        else if which == 1{
            return "+"
        }
        return "-"
    }
    
    
    func determine_i(d: Int) -> String{
        if d == -1{
            return "i"
        }
        return ""
    }
    
    func sol_string(arg: [Int],which: Int) -> String{
        let has_i = determine_i(arg[3])
        let oper = determine_oper(arg[0],which: which)
        if (arg[0] == 0){
            //0 where coe = 0
            if (arg[1] == 0){
                return "0"
            }
            else if (arg[1] == 1){
                if (arg[2] == 1){
                    if (arg[3] == 1){
                        //+-sqrt(1)
                        if (arg[4] == 1){
                            return oper + "1"
                        }
                            //+-sqrt(1)/den
                        else{
                            return "\\frac{" + oper + "1}{" + String(arg[4]) + "}"
                        }
                    }
                    else{
                        //+-i
                        if (arg[4] == 1){
                            return oper + "i"
                        }
                            //+-i/den
                        else{
                            return "\\frac{" + oper + "i}{" + String(arg[4]) + "}"
                        }
                    }
                }
                else{
                    //sqrt*(i)
                    if (arg[4] == 1){
                        return oper + "\\sqrt{" + String(arg[2]) + "}" + has_i
                    }
                        //sqrt*(i)/den
                    else{
                        return "\\frac{" + oper + "\\sqrt{" + String(arg[2]) + "}" + has_i + "}{" + String(arg[4]) + "}"
                    }
                }
            }
            else{
                if (arg[2] == 1){
                    //coe*(i)
                    if (arg[4] == 1){
                        return oper + String(arg[1]) + has_i
                    }
                        //coe*(i)/den
                    else{
                        return "\\frac{" + oper + String(arg[1]) + has_i + "}{" + String(arg[4]) + "}"
                    }
                }
                else{
                    //coe*sqrt*(i)
                    if (arg[4] == 1){
                        return oper + String(arg[1]) + "\\sqrt{" + String(arg[2]) + "}" + has_i
                    }
                        //coe*sqrt*(i)/den
                    else{
                        return "\\frac{" + oper + String(arg[1]) + "\\sqrt{" + String(arg[2]) + "}" + has_i + "}{" + String(arg[4]) + "}"
                    }
                }
            }
        }
        else{
            if (arg[1] == 0){
                //a
                if (arg[4] == 1){
                    return String(arg[0])
                }
                    //a/den
                else{
                    return "\\frac{" + String(arg[0]) + "}{" + String(arg[4]) + "}"
                }
            }
            else if (arg[1] == 1){
                if arg[2] == 1{
                    if arg[3] == -1{
                        //a+-i
                        if arg[4] == 1{
                            return String(arg[0]) + oper + "i"
                        }
                        //(a+-i)/den
                        else{
                            return "\\frac{" + String(arg[0]) + oper + "i}{" + String(arg[4]) + "}"
                        }
                    }
                    else{
                        return "error"
                    }
                    
                }
                else{
                    //a+-sqrt(c)*(i)
                    if (arg[4] == 1){
                        return String(arg[0]) + oper + "\\sqrt{" + String(arg[2]) + "}" + has_i
                    }
                        //(s+-sqrt(c)*(i))/den
                    else{
                        return "\\frac{" + String(arg[0]) + oper + "\\sqrt{" + String(arg[2]) + "}" + has_i + "}{" + String(arg[4]) + "}"
                    }
                }
            }
            else{
                //a+-bsqrt(c)*(i)
                if (arg[4] == 1){
                    return String(arg[0]) + oper + String(arg[1]) + "\\sqrt{" + String(arg[2]) + "}" + has_i
                }
                    //(a+-bsqrt(c)*(i))/den
                else{
                    return "\\frac{" + String(arg[0]) + oper + String(arg[1]) + "\\sqrt{" + String(arg[2]) + "}" + has_i + "}{" + String(arg[4]) + "}"
                }
            }
        }
    }
    
    func if_a_zero(b: Int, c: Int) -> String{
        if b == c{
            return "-1"
        }
        if b == -c{
            return "1"
        }
        let div = gcd([b,c])
        if div == b{
            return String(-c/div)
        }
        return "\\frac{" + String(-c/div) + "}{" + String(b/div) + "}"
    }
    
    
    func ax_b(nums: [Int]) -> String{
        var frac = [-nums[2],nums[1]]
        if frac[0] < 0 && frac[1] < 0{
            frac[0] *= -1
            frac[1] *= -1
        }
        let div = gcd([abs(frac[0]), abs(frac[1])])
        frac[0] /= div
        frac[1] /= div
        if frac[1] == 1{
            return String(frac[0])
        }
        if frac[1] == -1{
            return String(-frac[0])
        }
        return "\\frac{" + String(frac[0]) + "}{" + String(frac[1]) + "}"
    }
    
    func not_quad(nums: [Int]) -> String{
        if (nums[1] == 0){
            if (nums[2] == 0){
                return "Looks like you entered all zeros. Good for you, but this doesn't concern the quadratic formula. However, the equation \\(0=0\\) will hold true for all \\(x\\)."
            }
            return "Do you see what you did there? You entered zeroes for everything except the constant. Did you do that on purpose? Regardless, the equation won't be true for any \\(x\\), because \\(" + String(nums[2]) + "\\neq 0\\), no matter what \\(x\\) is."
        }
        if (nums[2] == 0){
            return "You do realize this is just \\(" + String(nums[1]) + "x=0\\), right? It's plain to see that the equation will be true when, and only when, \\(x=0\\)."
        }
        let sol = ax_b(nums)
        return "You plugged in a \\(0\\) for the coeffecient of \\(x^2\\). That's fine, but an equation in this form does not concern the quadratic formula. Despite that, we can still solve for x, and in this case, \\(x=" + String(sol) + "\\)."
    }

    func nan_input() -> String{
        return "You left one or more of the input boxes empty, or put in invalid data. We won't get anywhere if you hold out on me like this."
    }
    
    func isNaN(num: NSObject) -> Bool{
        return false
    }
    
    func quad_equation() -> String {
        let nums = input_nums
        if good_input == false{
            let sol = nan_input()
            return sol;
        }
        else if nums[0] == 0{
            let sol = not_quad(nums)
            return sol;
        }
        else{
            let sqrt = inner_sqrt_value(nums)
            let sqrt_prop = sqrt_properties(sqrt)
            let sol1 = sol_form(nums,sqrt_prop: sqrt_prop,which: 1)
            let sol2 = sol_form(nums,sqrt_prop: sqrt_prop,which: -1)
            let sol1_string = sol_string(sol1,which: 1)
            let sol2_string = sol_string(sol2 ,which: -1)
            //1 solution
            if (sol1_string == sol2_string){
                return "<br>Soluton: \\(x =" + sol1_string + "\\)"
            }
            //2 solutions
            else{
                return "Soluton 1: \\(x=" + sol1_string + "\\)" + "<br><br>Solution 2:   \\(x=" + sol2_string + "\\)"
            }
        }
    }
}
