![image](https://partners.salesforce.com/servlet/servlet.FileDownload?file=00P4V00000rWbwsUAC)
[Click Here For More Information On the Certification](http://sfdc.co/B2BSolutionArchitectCurriculum-PLC)

# Codebase for the Designing Data Strategies for Complex Customer Relationships

The codebase you find here is related to a Learning Lab created by the B2B Solution Architect Program. The codebase is meant for education purposes and is not built for purposes of production.

### Note

You will see a file within the repository called _config.yml. Its purpose is to create the Github Page you see based on the Readme.md. To ignore it within your pulls do the following:
* Add _config.yml to your .gitignore file
* Add **/_config.yml to your .forceignore file

## Learning Lab Videos

Feel free to engage in the Learning Lab or simply take the repo here and work at your own pace. You will find videos related to the lab at our Video hub [here](). 

## Learning Lab Courses

To fully engage in the Learning Lab or at least understand the context of this codebase we recommend taking the following courses in Partner Learning Camp:
* [Architect a B2B Customer-Centric Data Strategy](https://sfdc.co/PLC-B2BDataStrategy)
* [Customer-Centric Data Strategy with your Accounts](https://sfdc.co/PLC-CustomerCentricAccounts)
* [Customer-Centric Data Strategy with your Contacts](https://sfdc.co/PLC-CustomerCentricContacts)
* [Customer-Centric Data Strategy with your Transactions](https://sfdc.co/PLC-CustomerCentricTransactions)

## Repo Inventory

* FindDuplicateAccountsinHeirarchy.flow - The purpose of this flow is to navigate the entire Account hierarchy on a specific Account record and find duplicates related to the corporate name of the Account record thats been created. This is a screen flow versus a record triggered flow because account data could be coming from multiple sources and duplicate names is not an indication that one account is not unique versus the other. 
* FindDuplicateAccounts.cls - Purpose of this class is to be used by Invokable Action from a Flow Screen on an Account Record. This class traverses Account records heirarchy and returns all children record associated to account. Then using retrieved data new DataCloud classes eval records for duplicates against existing record within heirarchy. Returns all Account records matching this Account.
* Account.matchingRule-meta.xml - Metadata file for custom Matching Role on Account object by Company Name
* Account.Finding_Same_Name.duplicateRule-meta.xml - Metadata file for Duplicate Rule on Account record to use the Matching Rule
 
## Org Setup

One of the capabilities afforded to partners is to be able to create SDOs, or Simple Demo Orgs, within Partner Learning Camp. The Simple Demo Org (SDO), Industry Demo Orgs (IDOs), and the Smartbytes Demo Org all give you the features and data you need to start showcasing the technologythat quickly demonstrates value and closes deals. 

For the purposes of this lab we will be using SDOs created from Partner Learning Camp. The data and metadata required to work through this lab will be within an SDO today with the ability to create additional data and metadata for the purposes of this Lab. 

Partners Learners will go to Partner Learning Camp to complete the SDO Fundamentals course to access the Demo Org Tab, which houses the Demo Org Request Form. From here, Partners can request auto-provisioning for 8 different Demo Orgs. Here are the steps required:

1. Step 1: Complete the SDO Fundamentals Course
 * [Access Partner Learning Camp](https://partnerlearningcamp.salesforce.com/login?ec=302&startURL=%2Fs%2Flearner-dashboard)
 * Search “Simple Demo Org Fundamentals”
 * Hover over course Card to see details
 * Click “Enroll”
 * Complete the course to access the “Demo Org” Tab
3. Step 2: Submit the Demo Org Request Form
 * Click the “Demo Org” Tab
 * Select the “Demo Type” you want to request
 * Read details on the right side (changes based on selected demo org)
 * Check your information. Your username will auto-populate.
 * Check the box for the Master Subscription Agreement after reading
 * Click “Submit”
6. Step 3: Click the Demo Org Link
 * After the request has been submitted, the Partner Learner will receive an email with a link to access the provisioned Demo Org. 
 * Auto-provisioning takes approximately 1 hour to complete.

## Deploy this Codebase

Thanks to Andrew Fawcett [@andyinthecloud](https://twitter.com/andyinthecloud) we have this incredible single click process to deploy the code in this Github repo to the org you just generated

[http://githubsfdeploy.herokuapp.com/app/githubdeploy/b2bsolutionarchitectprogram/b2bdatastratlearninglabv1](http://githubsfdeploy.herokuapp.com/app/githubdeploy/b2bsolutionarchitectprogram/b2bdatastratlearninglabv1)

To learn more about githubsfdeploy please check out his Github Repo: [https://github.com/afawcett/githubsfdeploy](https://github.com/afawcett/githubsfdeploy)

While this is the easiest way to deploy you may choose other options. If so we recommend SFDX. 

## Metadata To Add

## Data Setup

