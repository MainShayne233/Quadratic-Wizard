//
//  ViewController.swift
//  Quadratic Wizard
//
//  Created by shayne on 10/23/15.
//  Copyright © 2015 Open Sourcery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var op1: UIPickerView!
    @IBOutlet weak var a_input: UITextField!
    @IBOutlet weak var b_input: UITextField!
    @IBOutlet weak var c_input: UITextField!
    
    var final_sol_string : String = ""
    
    var op1Data: [String] = [String]()
    
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
        
        
        self.op1.delegate = self
        self.op1.dataSource = self
        
        op1Data = ["+","-"]
    }
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return op1Data.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return op1Data[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        var pickerLabel = view as! UILabel!
        if view == nil {  //if no label there yet
            pickerLabel = UILabel()
        }
        let titleData = op1Data[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        pickerLabel!.textAlignment = .Center
        
        return pickerLabel
        
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
        }
        else{
            quad_form.good_input = false;
            quad_form.input_nums[1] = 0
        }
        if Int(c_input.text!) != nil{
            quad_form.input_nums[2] = Int(c_input.text!)!
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
    }
    
    
    
    
    
    
    

}

