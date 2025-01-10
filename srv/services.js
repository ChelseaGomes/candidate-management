/* const httpclient = require("@sap-cloud-sdk/http-client");

module.exports = async function (srv) {
  srv.after("CREATE", "Candidates", async (oReq) => {
    let oData = {
        "definitionId": "us10.17c9f2b8trial.kandidaatmanagement.kandidaatProcess",
      "context": {
          "candidatedetails": {
              "firstName": oReq.firstName,
              "lastName": oReq.lastName,
              "birthDate": oReq.birthDate,
              "city": oReq.city,
              "email": oReq.email,
              "department": oReq.department,
              "contractType": oReq.contractType,
              "reportsTo": oReq.reportsTo,
              "preferredLanguage": oReq.preferredLanguage,
              "startDate": oReq.star7,
              "seniority": oReq.seniority
          }
      }
    }
    let oResponse = await startBusinessProcess(oData)
    
  });

 

  srv.on("TriggerBusinessProcess", async (oReq) => {
    console.log(`We krijgen het volgende van data binnen: ${oReq.data.Context}`)
    await startBusinessProcess(oReq.data.Context)
})
}
    

async function startBusinessProcess(payload) {
  let oResponse = await httpclient.executeHttpRequest({
    destinationName: 'bpmworkflowruntime'
  }, {
    method: 'POST',
    url: '/public/workflow/rest/v1/workflow-instances',
    headers: {
      "Content-Type": 'application/json'
    },
    data: oData
  }).catch(oError => {
    console.log(`Something went wrong connecting to the Build Process Automation destination`)
    return null
  });
  return oResponse.data;
} */