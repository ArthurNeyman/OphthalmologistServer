const ApiError = require("../error/apiError");
const { validationResult } = require("express-validator");
const editorService = require("../services/editor-service");
const { User, Role } = require("../models/models");
const logHandling = require("../middleware/LogHandling");

class EditorController {
    async regEditor(req, res, next) {
        try {
            const errors = validationResult(req);

            if (!errors.isEmpty()) {
                return next(ApiError.badRequest("Validation error!", errors.array()));
            }

            const regData = req.body;
            const userData = await editorService.regEditor(regData);
            
            if (userData.error) {
                return next(ApiError.badRequest(userData.error));
            }

            res.json(userData);
        } catch (error) {
            logHandling.writeLog("Registration error: " + error.message);
            return next(ApiError.internal("Registration editor error: " + error.message));
        }
    }

    async addService(req, res, next) {
        try {
            const errors = validationResult(req);

            if (!errors.isEmpty()) {
                return next(ApiError.badRequest("Не заполнены обязательные поля", errors.array()));
            }

            const insertData = req.body;
            const serviceData = await editorService.addService(insertData);

            if (serviceData.error) {
                return next(ApiError.badRequest(serviceData.error));
            }

            res.json(serviceData);
        } catch (error) {
            logHandling.writeLog("Add service error: " + error.message);
            return next(ApiError.internal("Add service error: " + error.message));
        }
    }

    async editService(req, res, next) {
        try {
            const editData = req.body;
            const serviceData = await editorService.editService(editData);

            if (serviceData.error) {
                return next(ApiError.badRequest(serviceData.error));
            }

            res.json(serviceData);
        } catch (error) {
            logHandling.writeLog("Edit service error: " + error.message);
            return next(ApiError.internal("Edit service error: " + error.message));
        }
    }

    async deleteService(req, res, next) {
        try {
            const deleteData = req.body;
            const serviceData = await editorService.deleteService(deleteData);

            if (serviceData.error) {
                return next(ApiError.badRequest(serviceData.error));
            }

            res.json(serviceData);
        } catch (error) {
            logHandling.writeLog("Delete service error: " + error.message);
            return next(ApiError.internal("Delete service error: " + error.message));
        }
    }

    async addDoctorService(req, res, next) {
        try {
            const doctorService = req.body;
            const serviceData = await editorService.addDoctorService(doctorService);

            if (serviceData.error) {
                return next(ApiError.badRequest(serviceData.error));
            }

            res.json(serviceData);
        } catch (error) {
            logHandling.writeLog("Add doctor service error: " + error.message);
            return next(ApiError.internal("Add doctor service error: " + error.message));
        }
    }

    async removeDoctorService(req, res, next) {
        try {
            const doctorService = req.body;
            const serviceData = await editorService.removeDoctorService(doctorService);

            if (!serviceData) {
                return next(ApiError.badRequest("Data are not deleted"));
            }

            res.json(serviceData);
        } catch (error) {
            logHandling.writeLog("Remove doctor service error: " + error.message);
            return next(ApiError.internal("Remove doctor service error: " + error.message));
        }
    }

    async addDoctor(req, res, next) {
        try {
            const errors = validationResult(req);

            if (!errors.isEmpty()) {
                return next(ApiError.badRequest("Не заполнены обязательные поля", errors.array()));
            }

            const doctor = req.body;
            const doctorData = await editorService.addDoctor(doctor);

            if (!doctorData) {
                return next(ApiError.badRequest("Data are not inserted"));
            }

            res.json(doctorData);
        } catch (error) {
            logHandling.writeLog("Add doctor service error: " + error.message);
            return next(ApiError.internal("Add doctor service error: " + error.message));
        }
    }

    async editDoctor(req, res, next) {
        try {
            const editData = req.body;
            const doctorData = await editorService.editDoctor(editData);

            if (doctorData.error) {
                return next(ApiError.badRequest(doctorData.error));
            }

            res.json(doctorData);
        } catch (error) {
            logHandling.writeLog("Edit service error: " + error.message);
            return next(ApiError.internal("Edit service error: " + error.message));
        }
    }

    async deleteDoctor(req, res, next) {
        try {
            const deleteData = req.body;
            const serviceData = await editorService.deleteDoctor(deleteData);

            if (serviceData.error) {
                return next(ApiError.badRequest(serviceData.error));
            }

            res.json(serviceData);
        } catch (error) {
            logHandling.writeLog("Delete service error: " + error.message);
            return next(ApiError.internal("Delete service error: " + error.message));
        }
    }
}

module.exports = new EditorController();