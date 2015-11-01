//
//  ViewController.swift
//  Quadratic Wizard
//
//  Created by shayne on 10/23/15.
//  Copyright © 2015 Open Sourcery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var a_input: UITextField!
    @IBOutlet weak var b_input: UITextField!
    @IBOutlet weak var c_input: UITextField!
    
    var final_sol_string : String = ""
    
    @IBOutlet weak var submit: UIButton!
    
    
    @IBOutlet weak var a_jax: UIWebView!
    @IBOutlet weak var b_jax: UIWebView!
    @IBOutlet weak var c_jax: UIWebView!
    @IBOutlet weak var s_jax: UIWebView!
    
    
    let quad_form = QuadraticCalculatorModel(input_nums: [1,2,1])
    
    func refreshUI(){
        s_jax.loadHTMLString(sol_1html + final_sol_string + sol_2html, baseURL: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        a_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("a_html", ofType: "html")!)))
        b_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("b_html", ofType: "html")!)))
        c_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("c_html", ofType: "html")!)))
        s_jax.loadHTMLString(sol_1html + final_sol_string + sol_2html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func submit_pressed(sender : AnyObject){
        quad_form.input_nums[0] = Int(a_input.text!)!
        quad_form.input_nums[1] = Int(b_input.text!)!
        quad_form.input_nums[2] = Int(c_input.text!)!
        final_sol_string = quad_form.quad_equation()
        refreshUI()
        print(final_sol_string)
    }

}

