const ApiError = require("../error/apiError");
const { validationResult } = require("express-validator");
const userService = require("../services/user-service");
const { User, Role } = require("../models/models");
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);
const logHandling = require("../middleware/LogHandling");

class UserController {
    async registration(req, res, next) {
        try {
            const errors = validationResult(req);

            if (!errors.isEmpty()) {
                return next(ApiError.badRequest("Validation error!", errors.array()));
            }

            const { phoneNumber, code, roleId } = req.body;
            const userData = await userService.registration(phoneNumber, code, roleId);
            res.cookie("accessToken", userData.accessToken, { maxAge: 3600 * 1000, httpOnly: true })
            res.cookie("refreshToken", userData.refreshToken, { maxAge: 3600 * 1000, httpOnly: true })
            return res.json(userData);
        } catch (error) {
            logHandling.writeLog("Registration error: " + error.message);
            return next(ApiError.internal("Registration error: " + error.message));
        }
    }

    async login(req, res, next) {
        try {
            // console.log("body ", req);
            const { login, password } = req.body;
            const userData = await userService.login(login, password);
            res.cookie("accessToken", userData.accessToken, { maxAge: 3600 * 1000, httpOnly: true })
            res.cookie("refreshToken", userData.refreshToken, { maxAge: 3600 * 1000, httpOnly: true })
            return res.json(userData);
        } catch (error) {
            logHandling.writeLog("Login error: " + error.message);
            return next(ApiError.internal("Login error: " + error.message));
        }
    }

    async logout(req, res, next) {
        try {
            const { refreshToken } = req.cookies;
            const token = await userService.logout(refreshToken);
            res.clearCookie("refreshToken");
            res.json(token);
        } catch (error) {
            logHandling.writeLog("Logout error: " + error.message);
            return next(ApiError.internal("Logout error: " + error.message));
        }
    }

    async refresh(req, res, next) {
        try {
            const { refreshToken } = req.cookies;
            const userData = await userService.refresh(refreshToken);
            res.cookie("refreshToken", userData.refreshToken, { maxAge: 3600 * 1000, httpOnly: true })
            return res.json(userData);
        } catch (error) {
            logHandling.writeLog("Refresh error: " + error.message);
            return next(ApiError.internal("Refresh error: " + error.message));
        }
    }

    async checkAuth(req, res, next) {
        const { userId } = req.query;

        if (!userId) {
            return next(ApiError.badRequest("Not id"));
        }

        res.json(userId);
    }

    async sendCode(req, res) {
        const { phoneNumber } = req.body;
        const code = Math.floor(
            Math.random() * (999999 - 100000 + 1) + 100000
        );

        // console.log("code ", code);

        if (!phoneNumber) {
            return next(ApiError.badRequest("Not phone number"));
        }

        // client.messages
        //     .create({
        //         body: code,
        //         from: process.env.TWILIO_PHONE_NUMBER,
        //         to: phoneNumber
        //     })
        //     .then(message => console.log(message.sid));
        res.json({ "message": code });
    }

    async getNews(req, res, next) {
        try {
            const { newsId } = req.query;
            const newsData = await userService.getNews(newsId);

            if (!newsData) {
                return next(ApiError.badRequest("News are not exist"));
            }

            res.json(newsData);
        } catch (error) {
            logHandling.writeLog("Get news error: " + error.message);
            return next(ApiError.internal("Get news error: " + error.message));
        }
    }

    async getServices(req, res, next) {
        try {
            const { serviceId } = req.query;
            const servicesData = await userService.getServices(serviceId);

            if (!servicesData) {
                return next(ApiError.badRequest("Service are not exist"));
            }

            res.json(servicesData);
        } catch (error) {
            logHandling.writeLog("Get services error: " + error.message);
            return next(ApiError.internal("Get services error: " + error.message));
        }
    }

    async getDoctors(req, res, next) {
        try {
            const { doctorId } = req.query;
            const doctorsData = await userService.getDoctors(doctorId);

            if (!doctorsData) {
                return next(ApiError.badRequest("Doctor is not exist"));
            }

            res.json(doctorsData);
        } catch (error) {
            logHandling.writeLog("Get doctors error: " + error.message);
            return next(ApiError.internal("Get doctors error: " + error.message));
        }
    }

    async getServiceCategories(req, res, next) {
        try {
            const categoriesData = await userService.getServiceCategories();

            if (!categoriesData) {
                return next(ApiError.badRequest("Categories are not exist"));
            }

            res.json(categoriesData);
        } catch (error) {
            logHandling.writeLog("Get services error: " + error.message);
            return next(ApiError.internal("Get services error: " + error.message));
        }
    }

    async getInfoClinic(req, res, next) {
        try {
            const { clinicId } = req.query;
            const infoClinic = await userService.getInfoClinic(clinicId);

            if (!infoClinic) {
                return next(ApiError.badRequest("Clinic is not exist"));
            }

            res.json(infoClinic);
        } catch (error) {
            logHandling.writeLog("Get services error: " + error.message);
            return next(ApiError.internal("Get services error: " + error.message));
        }
    }

    async getFaq(req, res, next) {
        try {
            const faq = await userService.getFaq();

            if (!faq) {
                return next(ApiError.badRequest("FAQ are not exist"));
            }

            res.json(faq);
        } catch (error) {
            logHandling.writeLog("Get faq error: " + error.message);
            return next(ApiError.internal("Get faq error: " + error.message));
        }
    }

    // async getNewsById(req, res, next) {
    //     try {
    //         const {newsId} = req.body;
    //         const newsData = await userService.getNewsById(newsId);

    //         if(!newsData) {
    //             return next(ApiError.badRequest("News are not exist"));
    //         }

    //         res.json(newsData);
    //     } catch (error) {
    //         return next(ApiError.internal("Get news error: " + error.message));
    //     }

    // }
}

module.exports = new UserController();