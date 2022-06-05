const {Patient} = require("../models/models");
const ApiError = require("../error/apiError");

class PatientController {
    async add(req, res, next){
        try {
            // const {firstName, lastName, patronymic, userId} = req.body;
            const {first_name, last_name, patronymic, userId} = req.body;
            // const {lastName} = req.body;
            // const {patronymic} = req.body;

            // const patient = await Patient.create({firstName, lastName, patronymic, userId});
            const patient = await Patient.create({first_name, last_name, patronymic, userId});
            // console.log("name ", {firstName});
            return res.json(patient);
        } catch (err) {
            next(ApiError.badRequest(err.message));
        }
        
    }

    async editInfo(req, res){

    }

    async getInfoOne(req, res){
        const query = req.query;
        res.json(query);
    }
}

module.exports = new PatientController();