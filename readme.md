Gengo Swift Library (for the [Gengo API](http://gengo.com/api/))
================================================================================================================================

This is a swift library made for the [Gengo](http://www.gengo.com) API. It allows users to order and manage their translations directly from their iOS devices. This is still a work in progress so any contributions are welcome :) 

## Installing

Just include the SwiftHTTP folder in your project and the Gengo.swift file as well.

## Usage
```swift
//Initialization
let private_key = "MY_PRIVATE_KEY"
let public_key = "MY_PUBLIC_KEY"
let gengo = Gengo(public_key: public_key, private_key: private_key, useSandbox: true)
    
//post a translation job
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
gengo.postTranslationJobs(data)
```

Output:

    {"opstat":"ok","response":{"order_id":"306930","job_count":1,"credits_used":"0.25","currency":"USD"}}

##Supported Endpoints

- account/stats (GET) : Retrieves account stats, such as orders made. TESTED
- account/balance (GET) : Retrieves account balance in credits.TESTED
- account/preferred_translators (GET) : Retrieves preferred translators set by user.TESTED
- translate/job/{id} (GET) : Retrieves a specific job.TESTED
- translate/job/{id} (PUT) : Updates a job to translate.TESTED
- translate/job/{id} (DELETE) : Cancels the job. You can only cancel a job if it has not been started already by a translator.TESTED
- translate/job/{id}/revision/{rev_id} (GET) : Gets a specific revision for a job.TESTED
- translate/job/{id}/revisions (GET) : Gets list of revision resources for a job. Revisions are created each time a translator or Senior Translator updates the text.TESTED
- translate/job/{id}/feedback (GET) : Retrieves the feedback you have submitted for a particular job.TESTED
- translate/job/{id}/comment (POST) : Submits a new comment to the job’s comment thread.TESTED
- translate/job/{id}/comments (GET) : Retrieves the comment thread for a job.TESTED
- translate/jobs (GET) : Retrieves a list of resources for the most recent jobs filtered by the given parameters.TESTED
- translate/jobs/{ids} (GET) : Retrieves a list of jobs. They are requested by a comma-separated list of job ids. TESTED
- translate/jobs (POST) : Submits a job or group of jobs to translate. TESTED
- translate/order (GET) : Retrieves a specific order containing all jobs.
- translate/order (DELETE) : Deletes all available jobs in an order.
- translate/glossary (GET) : Retrieves a list of glossaries that belongs to the authenticated user
- translate/glossary/{id} (GET) : Retreives a glossary by Id
- translate/service/language_pairs (GET) : Returns supported translation language pairs, tiers, and credit prices.
- translate/service/languages (GET) : Returns a list of supported languages and their language codes.

##To do
- [ ] Better documentation
- [ ] More test
- [ ] translate/service/quote (POST) : Returns credit quote and unit count for text based on content, tier, and language pair for job or jobs submitted.
- [ ] translate/service/quote/file (POST) : Uploads files to Gengo and returns a quote for each file, with an identifier for when client is ready to place the actual order. Price quote is based on content, tier, and language pair.



Twitter: [@gusta_nas](https://twitter.com/gusta_nas)

Website: [gustanas.co](http://www.gustanas.co/)
