//
//  ViewController.swift
//  API
//
//  Created by Gustavo Nascimento on 10/11/14.
//  Copyright (c) 2014 Gustavo Nascimento. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func apiCall(sender: AnyObject) {
        var private_key = "]Dp=fm@@)-p}]TCo$Y^OdRDq3A7c$5XG$((1XcMA8AC-dI(FGn5U}t9[xd=2q^EJ"
        var public_key = "21F~ly5KQm6VC0@{aQDVsfitIx1FqkeKMVLiEu|Pq|uuln@nVXH_gG3EVKrK0ADb"
        
        let gengo = Gengo(public_key: public_key, private_key: private_key, useSandbox: true)
        
        
        //gengo.getLanguagePairs(/*lc_src: "fr"*/)
        gengo.getAccountStats()
        //gengo.getAccountBalance()
        //gengo.getPreferredTranslators()
        
        var data = [
            "jobs": [
                "job_1": [
                    "type": "text",
                    "slug": "Single :: English to Japanese",
                    "body_src": "Testing Gengo API library calls.",
                    "lc_src": "en",
                    "lc_tgt": "ja",
                    "tier": "standard",
                    "auto_approve": 0,
                    "comment": "HEY THERE TRANSLATOR",
                    "custom_data": "your optional custom data, limited to 1kb.",
                    "force":  0,
                    "use_preferred": 0
                ]
            ]
        ]
        //gengo.postTranslationJobs(data)
        //gengo.getTranslationJob(1056501)
        var action = [
            "action": "approve"
        ]
        //gengo.updateTranslationJob(1056501, action: action)
        //gengo.deleteTranslationJob(1056265)
        //gengo.getTranslationJobRevisions(1056501)
        //gengo.getTranslationJobRevision(1056501, rev_id: 2319703)
        //gengo.getTranslationJobFeedback(1056501)
        var comment = [
            "body": "This is a comment"
        ]
        //gengo.postTranslationJobComment(1056501, comment: comment)
        //gengo.getTranslationJobComments(1056501)
        //gengo.getTranslationJobs(status: "reviewable")
        //gengo.getTranslationJobs(["1053535", "1053533"])
        //gengo.getGlossaryList()
    }
}

