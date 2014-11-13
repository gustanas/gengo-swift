//
//  Gengo.swift
//  API
//
//  Created by Gustavo Nascimento on 10/13/14.
//  Copyright (c) 2014 Gustavo Nascimento. All rights reserved.
//


//TODO Change ids to String
import Foundation

//cases for all endpoints.
enum Endpoints {
    case Languages
    case LanguagePairs
    case AccountStats
    case AccountBalance
    case AccountPreferredTranslators
    case PreferredTranslators
    case TranslationJobs
    case TranslationJob
    case Order
    case Glossary
}

//The Path protocal describes how to turn a given type into a String value.
protocol Path {
    var path : String { get }
}


extension Endpoints : Path {
    var path: String {
        switch self {
        case .Languages: return "/translate/service/languages"
        case .LanguagePairs: return "/translate/service/language_pairs"
        case .AccountStats: return "/account/stats"
        case .AccountBalance: return "/account/balance"
        case .AccountPreferredTranslators: return "account/preferred_translators"
        case .PreferredTranslators: return "/account/preferred_translators"
        case .TranslationJobs: return "/translate/jobs"
        case .TranslationJob: return "/translate/job/"
        case .Order: return "/translate/order"
        case .Glossary: return "/translate/glossary"
            }
    }
}

let api_urls: [String: String] = [
    "sandbox": "http://api.sandbox.gengo.com/",
    "base": "https://api.gengo.com/"
]

class Gengo {
    let baseURl: String
    let api_version: Int
    let public_key: String
    let private_key: String
    
    let request: HTTPTask
    var params: [String: AnyObject]
    
    init(public_key: String, private_key: String, useSandbox: Bool = false, api_version: Int = 2) {
        self.public_key = public_key
        self.private_key = private_key
        
        if useSandbox{
            self.baseURl = api_urls["sandbox"]!
        }else{
            self.baseURl = api_urls["base"]!
        }
        
        //TODO raise exception if version not correct
        self.api_version = api_version
        self.baseURl = baseURl + "v\(self.api_version)"
        
        self.request = HTTPTask()
        self.request.baseURL = self.baseURl
        self.request.requestSerializer = HTTPRequestSerializer()
        self.request.requestSerializer.headers["Accept"] = "application/json"
        
        let date = NSDate()
        let timestamp = Int(date.timeIntervalSince1970)
        
        self.params = [
            "api_key": self.public_key,
            "api_sig": self.private_key,
            "ts": timestamp.description
        ]
        
        
        let hmac = SwiftHMAC().hmac(timestamp.description, key: self.private_key)
        params["api_sig"] = hmac

    }
    
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        var options = prettyPrinted ? NSJSONWritingOptions.PrettyPrinted : nil
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = NSJSONSerialization.dataWithJSONObject(value, options: options, error: nil) {
                var string = ""
                string = NSString(data: data, encoding: NSUTF8StringEncoding)!
                
                return string
            }
        }
        return ""
    }
    
    func sendRequest(url: String, method: HTTPMethod, parameters: Dictionary<String, AnyObject>!){
        let operationQueue = NSOperationQueue()
        var opt = self.request.create(url, method: method, parameters: parameters, success: {(response: HTTPResponse) in
            if response.responseObject != nil {
                let data = response.responseObject as NSData
                let response = NSString(data: data, encoding: NSUTF8StringEncoding)!
                println(response)
            }
            },failure: {(error: NSError) in
                println("error: \(error)")
        })
        if opt != nil {
            opt!.start()
        }
    }
    
    func getLanguagePairs(lc_src: String = ""){
        let path = Endpoints.LanguagePairs.path
        self.params["lc_src"] = lc_src
        
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getAccountStats(){
        let path = Endpoints.AccountStats.path
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getAccountBalance(){
        let path = Endpoints.AccountBalance.path
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getAccountPreferredTranslators(){
        let path = Endpoints.PreferredTranslators.path
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getPreferredTranslators(){
        let path = Endpoints.PreferredTranslators.path
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func postTranslationJobs(jobs: Dictionary<String, AnyObject>){
        let path = Endpoints.TranslationJobs.path
        var jobs_json = JSONStringify(jobs, prettyPrinted: false)
        self.params["data"] = jobs_json
        sendRequest(path, method: HTTPMethod.POST, parameters: self.params)

    }
    
    func getTranslationJob(id: Int){
        let path = Endpoints.TranslationJob.path + String(id)
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func updateTranslationJob(id: Int, action: Dictionary<String, AnyObject>){
        let path = Endpoints.TranslationJob.path + String(id)
        var action_json = JSONStringify(action, prettyPrinted: false)
        self.params["data"] = action_json
        sendRequest(path, method: HTTPMethod.PUT, parameters: self.params)
    }
    
    func deleteTranslationJob(id: Int){
        let path = Endpoints.TranslationJob.path + String(id)
        sendRequest(path, method: HTTPMethod.DELETE, parameters: self.params)
    }
    
    func getTranslationJobRevision(job_id: Int, rev_id: Int){
        let path = Endpoints.TranslationJob.path + String(job_id) + "/revision/" + String(rev_id)
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
     }
    
    func getTranslationJobRevisions(id: Int){
        let path = Endpoints.TranslationJob.path + String(id) + "/revisions"
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getTranslationJobFeedback(id: Int){
        let path = Endpoints.TranslationJob.path + String(id) + "/feedback"
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func postTranslationJobComment(id: Int, comment: Dictionary<String, AnyObject>){
        let path = Endpoints.TranslationJob.path + String(id) + "/comment"
        var comment_json = JSONStringify(comment, prettyPrinted: false)
        self.params["data"] = comment_json
        sendRequest(path, method: HTTPMethod.POST, parameters: self.params)
    }
    
    func getTranslationJobComments(id: Int){
        let path = Endpoints.TranslationJob.path + String(id) + "/comments"
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getTranslationJobs(status: String="", count: Int=10){
        let path = Endpoints.TranslationJobs.path + "/"
        self.params["status"] = status
        self.params["count"] = String(count)
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)//TODO timestamp_after
    }
    
    func getTranslationJobs(ids: [String]){
        let path = Endpoints.TranslationJobs.path + "/" + ",".join(ids)
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getTranslationOrderJobs(id: String){
        let path = Endpoints.Order.path + "/" + id
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func deleteTranslationOrder(id: String){
        let path = Endpoints.Order.path + "/" + id
        sendRequest(path, method: HTTPMethod.DELETE, parameters: self.params)
    }
    
    func getGlossaryList(){
        let path = Endpoints.Glossary.path
        println(path)
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getGlossary(id: String){
        let path = Endpoints.Glossary.path + "/" + id
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
    
    func getServiceLanguages(){
        let path = Endpoints.Languages.path
        sendRequest(path, method: HTTPMethod.GET, parameters: self.params)
    }
}