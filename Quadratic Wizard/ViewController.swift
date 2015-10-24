//
//  ViewController.swift
//  Quadratic Wizard
//
//  Created by shayne on 10/23/15.
//  Copyright © 2015 Open Sourcery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var a_jax: UIWebView!
    @IBOutlet weak var b_jax: UIWebView!
    @IBOutlet weak var c_jax: UIWebView!
    @IBOutlet weak var s_jax: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        a_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("a_html", ofType: "html")!)))
        b_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("b_html", ofType: "html")!)))
        c_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("c_html", ofType: "html")!)))
        s_jax.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("2_s_html", ofType: "html")!)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

