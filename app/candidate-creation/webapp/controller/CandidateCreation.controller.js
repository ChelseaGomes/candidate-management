sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/m/MessageBox"
], function (Controller, MessageBox) {
    "use strict";

    return Controller.extend("candidatecreation.controller.CandidateCreation", {
        onInit: function () {
            // JSON-model maken voor een nieuwe kandidaat
            let oCandidateModel = new sap.ui.model.json.JSONModel({
                firstName: "",
                lastName: "",
                birthDate: "",
                city: "",
                email: "",
                department: "",
                contractType: "",
                reportsTo: "",
                preferredLanguage: "",
                startDate: "",
                seniority: ""
            });

            // Model binden aan de view
            this.getView().setModel(oCandidateModel, "candidateModel");
        },

        onCreateCandidate: function () {
            const oModel = this.getOwnerComponent().getModel(); // Haal het OData-model op
            const oCandidateData = this.getView().getModel("candidateModel").getData(); // Haal de gegevens van het kandidaat-model op

            // Controleer verplichte velden
            const requiredFields = [
                { field: "firstName", label: "Voornaam" },
                { field: "lastName", label: "Familienaam" },
                { field: "email", label: "E-mailadres" },
                { field: "department", label: "Afdeling" },
                { field: "contractType", label: "Contracttype" }
            ];

            for (let field of requiredFields) {
                if (!oCandidateData[field.field] || oCandidateData[field.field].toString().trim() === "") {
                    sap.m.MessageBox.error(`Het veld ${field.label} is verplicht.`);
                    return;
                }
            }

            // Stap 1: Maak een payload aan voor de kandidaat
            const oPayload = {
                firstName: oCandidateData.firstName,
                lastName: oCandidateData.lastName,
                birthDate: oCandidateData.birthDate,
                city: oCandidateData.city,
                email: oCandidateData.email,
                department_ID: oCandidateData.department, // Verwijst naar de ID van de afdeling
                contractType_ID: oCandidateData.contractType, // Verwijst naar de ID van het contracttype
                reportsTo_ID: oCandidateData.reportsTo, // Verwijst naar de ID van de manager
                preferredLanguage_ID: oCandidateData.preferredLanguage, // Verwijst naar de ID van de taal
                startDate: oCandidateData.startDate,
                seniority: oCandidateData.seniority
            };

            console.log("Candidate Payload:", oPayload);

            // Stap 2: Voeg de kandidaat toe via het OData-model
            const oCandidateListBinding = oModel.bindList("/Candidates"); // Verbind met de "Candidates"-entiteit
            const oCandidateContext = oCandidateListBinding.create(oPayload);

            oCandidateContext
                .created()
                .then(() => {
                    // Succesmelding
                    sap.m.MessageBox.success("Kandidaat met succes aangemaakt!");

                    // Stap 3: Reset het formulier
                    this._resetCandidateForm();
                })
                .catch((oError) => {
                    console.error("Error creating Candidate:", oError);
                    sap.m.MessageBox.error("Fout bij het aanmaken van de kandidaat: " + oError.message);
                });
        },

        
        
    });
});
