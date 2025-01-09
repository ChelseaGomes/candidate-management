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

            // Stap 1: Controleer of het aantal kandidaten in de afdeling de maxRound overschrijdt
            const departmentID = oCandidateData.department; // Verwijst naar de ID van de afdeling

            // Haal de huidige kandidaten en maxRound op voor de afdeling
            const oDepartmentBinding = oModel.bindContext(`/Departments(${departmentID})`);
            oDepartmentBinding.requestObject().then((oDepartmentData) => {
                const maxRound = oDepartmentData.maxRound; // Maximum aantal kandidaten
                const departmentCode = oDepartmentData.code;

                // Haal het huidige aantal kandidaten in deze afdeling op
                const oCandidateListBinding = oModel.bindList("/Candidates", undefined, undefined, undefined, {
                    $filter: `department_ID eq '${departmentID}'`
                });

                oCandidateListBinding.requestContexts().then((aContexts) => {
                    const currentCount = aContexts.length;

                    // Controleer of het maximum wordt overschreden
                    if (currentCount >= maxRound) {
                        sap.m.MessageBox.error(
                            `Het maximum aantal kandidaten (${maxRound}) voor de afdeling ${departmentCode} is al bereikt. De kandidaat kan niet worden toegevoegd.`
                        );
                        return;
                    }

                    // Stap 2: Maak een payload aan voor de kandidaat
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

                    // Stap 3: Voeg de kandidaat toe via het OData-model
                    const oCandidateListBinding = oModel.bindList("/Candidates"); // Verbind met de "Candidates"-entiteit
                    const oCandidateContext = oCandidateListBinding.create(oPayload);

                    oCandidateContext
                        .created()
                        .then(() => {
                            // Succesmelding
                            sap.m.MessageBox.success("Kandidaat met succes aangemaakt!");

                            // Stap 4: Reset het formulier
                            this._resetCandidateForm();
                        })
                        .catch((oError) => {
                            console.error("Error creating Candidate:", oError);
                            sap.m.MessageBox.error("Fout bij het aanmaken van de kandidaat: " + oError.message);
                        });
                });
            }).catch((oError) => {
                console.error("Error fetching department data:", oError);
                sap.m.MessageBox.error("Fout bij het ophalen van de afdeling gegevens: " + oError.message);
            });
        },



        _resetCandidateForm: function () {
            // Reset het formulier naar standaardwaarden
            this.getView().getModel("candidateModel").setData({
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
        },

        onShowCandidatesPerDepartment: function () {
            const oModel = this.getOwnerComponent().getModel(); // Haal het OData V4-model op

            if (!oModel) {
                sap.m.MessageBox.error("OData-model is niet beschikbaar!");
                return;
            }

            // Maak een binding voor de query
            const oListBinding = oModel.bindList("/Candidates", undefined, undefined, undefined, {
                "$apply": "groupby((department_ID),aggregate($count as count))"
            });

            oListBinding.requestContexts().then((aContexts) => {
                // Verwerk de resultaten van de Candidates-query
                const aResults = aContexts.map(oContext => oContext.getObject());

                console.log("Aantal kandidaten per afdeling:", aResults);

                // Haal alle unieke department_ID's op
                const aDepartmentIDs = aResults.map(res => res.department_ID);

                // Maak een binding om de bijbehorende Departments op te halen
                const oDepartmentsBinding = oModel.bindList("/Departments");
                oDepartmentsBinding.requestContexts().then((aDeptContexts) => {
                    const aDepartments = aDeptContexts.map(oContext => oContext.getObject());

                    // Maak een mapping van department_ID naar description
                    const departmentMap = aDepartments.reduce((map, department) => {
                        map[department.ID] = department.description;
                        return map;
                    }, {});

                    // Combineer de resultaten
                    const results = aResults.map(res => {
                        const departmentDescription = departmentMap[res.department_ID] || "Onbekend";
                        return `Afdeling: ${departmentDescription} - Aantal kandidaten: ${res.count}`;
                    }).join("\n");

                    // Toon de resultaten in een MessageBox
                    sap.m.MessageBox.information("Kandidaten per afdeling:\n" + results);
                }).catch((oError) => {
                    console.error("Error fetching departments:", oError);
                    sap.m.MessageBox.error("Fout bij het ophalen van de afdelingen: " + oError.message);
                });
            }).catch((oError) => {
                console.error("Error fetching candidates per department:", oError);
                sap.m.MessageBox.error("Fout bij het ophalen van de gegevens: " + oError.message);
            });
        }







    });
});
