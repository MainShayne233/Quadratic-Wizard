//
//  ViewController.swift
//  Quadratic Wizard
//
//  Created by shayne on 10/23/15.
//  Copyright © 2015 Open Sourcery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var a_input: UITextField!
    @IBOutlet weak var b_input: UITextField!
    @IBOutlet weak var c_input: UITextField!
    
    
    @IBOutlet weak var opbutton1: UIButton!
    @IBOutlet weak var opbutton2: UIButton!
    
    

    

    @IBAction func op1pressed(sender: AnyObject) {
        if opbutton1.titleLabel!.text == "+"{
            opbutton1.setTitle("-", forState: UIControlState.Normal)
        }
        else if opbutton1.titleLabel!.text == "-"{
            opbutton1.setTitle("+", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func op2pressed(sender: AnyObject) {
        if opbutton2.titleLabel!.text == "+"{
            opbutton2.setTitle("-", forState: UIControlState.Normal)
        }
        else if opbutton2.titleLabel!.text == "-"{
            opbutton2.setTitle("+", forState: UIControlState.Normal)
        }
    }


    
    
    
    
    var final_sol_string : String = ""
    
    
    @IBOutlet weak var submit: UIButton!
    
    
    @IBOutlet weak var s_jax: UIWebView!
    
    
    let quad_form = QuadraticCalculatorModel(input_nums: [1,2,1])
    
    func refreshUI(){
        s_jax.loadHTMLString(sol_1html + final_sol_string + sol_2html, baseURL: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        s_jax.loadHTMLString(sol_1html + final_sol_string + sol_2html, baseURL: nil)
    }
    




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    @IBAction func submit_pressed(sender : AnyObject){
        quad_form.good_input = true;
        if Int(a_input.text!) != nil{
            quad_form.input_nums[0] = Int(a_input.text!)!
        }
        else{
            quad_form.good_input = false;
            quad_form.input_nums[0] = 0
        }
        if Int(b_input.text!) != nil{
            quad_form.input_nums[1] = Int(b_input.text!)!
            if opbutton1.titleLabel!.text == "-"{
                quad_form.input_nums[1] *= -1
            }
        }
        else{
            quad_form.good_input = false;
            quad_form.input_nums[1] = 0
        }
        if Int(c_input.text!) != nil{
            quad_form.input_nums[2] = Int(c_input.text!)!
            if opbutton2.titleLabel!.text == "-"{
                quad_form.input_nums[2] *= -1
            }
        }
        else{
            quad_form.good_input = false;
            quad_form.input_nums[2] = 0
        }
        
        final_sol_string = quad_form.quad_equation()
        refreshUI()
        print(final_sol_string)
    }
    
    
    @IBAction func viewTapped(sender : AnyObject) {
        a_input.resignFirstResponder()
    }
    
    
    
    
    
    
    

}

