const ApiError = require("../error/apiError");
const bcrypt = require("bcrypt");
const tokenService = require("./token-service");
const moment = require("moment");
// const {User, Role, News, Service, Doctor, Clinic, ClinicContacts, ClinicAddress} = require("../models/models");
const models = require("../models/models");

class UserService {
    async registration(phoneNumber, code, roleId){
        if(!phoneNumber || !code){
            throw ApiError.badRequest("Incorrect phone number or code");
            // return next(ApiError.badRequest("Incorrect phone number or code"));
        }

        const login = phoneNumber;
        const existUser = await models.User.findOne({where: {login}});

        if(existUser){
            // return next(ApiError.badRequest("User already exist"));
            throw ApiError.badRequest("User already exist");
        }

        const role = await models.Role.findOne({where: {id: roleId}});
        const dateReg = moment().format("YYYY-MM-DD HH:mm:ss");
        const hashPassword = await bcrypt.hash(String(code), 5);
        const user = await models.User.create({login, password: hashPassword, createdAt: dateReg, updatedAt: dateReg, roleId});
        const tokens = tokenService.generateTokens({id: user.id, login: user.login, role: role.user_role});
        await tokenService.saveToken(user.id, tokens.refreshToken);

        return {...tokens}
    }

    async login(login, password) {
        const existUser = await models.User.findOne({where: {login}});

         if(!existUser) {
            throw ApiError.badRequest("Incorrect login or password");
        }
        
        let comparePassword = bcrypt.compareSync(password, existUser.password);
        
        if(!comparePassword) {
            throw ApiError.badRequest("Incorrect login or password");
        }

        const role = await models.Role.findOne({where: {id: existUser.roleId}});
        const tokens = tokenService.generateTokens({id: existUser.id, login: existUser.login, role: role.user_role});
        await tokenService.saveToken(existUser.id, tokens.refreshToken);

        return {...tokens}
    }

    async logout(refreshToken) {
        const token = await tokenService.removeToken(refreshToken);
        return token;
    }

    async refresh(refreshToken) {
        if(!refreshToken) {
            throw ApiError.fobirden("Invalid token!");
        }

        const userData = tokenService.validateRefreshToken(refreshToken);
        const tokenFromDb = tokenService.findToken(refreshToken);

        if(!userData || !tokenFromDb){
            throw ApiError.fobirden("Invalid token!");
        }

        const user = await models.User.findOne({where: {id: userData.id}});
        const role = await models.Role.findOne({where: {id: user.roleId}});
        const tokens = tokenService.generateTokens({id: user.id, login: user.login, role: role.user_role});
        await tokenService.saveToken(user.id, tokens.refreshToken);

        return {...tokens}
    }

    async getNews(newsId = "") {
        let news = [];
        newsId = Number(newsId);
        
        if(newsId > 0){
            news = await models.News.findOne({where: {id: newsId}, raw: true});
        } else {
            news = await models.News.findAll({attributes: ['id', 'name', 'date', 'imgLink'], raw: true});
        }
        
        return news;
    }

    async getServices(serviceId = "") {
        let services = [];
        serviceId = Number(serviceId);
        
        if(serviceId > 0){
            let service = await models.Service.findAll({where: {id: serviceId}, include: [{association: 'options' }, {model: models.Doctor, attributes: ["id", "first_name", "last_name", "surname", "position", "phoneNumber"], as: "doctors", through: {attributes: []}}]}); //, raw: true
            services = service[0];
        } else {
            services = await models.Service.findAll({order: [['sort', 'ASC']], attributes: ['id', 'name', 'price', 'imgLink'], raw: true});
        }
        
        return services;
    }

    async getDoctors(doctorId = "") {
        let doctors = [];
        doctorId = Number(doctorId);
        
        if(doctorId > 0){
            let doctor = await models.Doctor.findAll({where: {id: doctorId}, include: [{model: models.Service, attributes: ["id", "name", "price"], as: "services", through: {attributes: []}}]}); //, raw: true
            doctors = doctor[0];
        } else {
            doctors = await models.Doctor.findAll({attributes: ['id', 'first_name', 'last_name', 'surname', 'position', 'phoneNumber', 'imgLink'], raw: true});
        }
        
        return doctors;
    }

    async getServiceCategories() {
        const servicesCategory = await models.ServiceCategory.findAll({attributes: ['id', 'name', 'description'], raw: true});
        return servicesCategory;
    }

    async getInfoClinic(clinicId = "") {
        let clinics = {};
        let mainContacts = [];
        let contacts = [];

        clinicId = Number(clinicId);
        
        if(clinicId > 0){
            let clinicsData = await models.Clinic.findAll({where: {id: clinicId}, attributes: ["id", "name", "shortDescription"], include: [{model: models.ClinicContacts, as: "contacts", attributes: ["id", "name", "contact", "isMain"]}, {model: models.ClinicAddress, as: "address", attributes: ["id", "postIndex", "address", "comments"]}]});
            clinicsData = clinicsData[0];
            clinicsData.contacts.map((obj, index) => {
                if(obj.isMain) {
                    mainContacts.push(obj);
                } else {
                    contacts.push(obj);
                }               
            });
            clinics = {
                id: clinicsData.id,
                name: clinicsData.name,
                shortDescription: clinicsData.shortDescription,
                contacts: {
                    mainContacts,
                    contacts 
                },
                address: clinicsData.address[0]
            }
        } else {
            clinics = await models.Clinic.findAll({attributes: ['id', 'name', 'shortDescription'], raw: true});
        }
        return clinics;
    }

    async getFaq() {
        const faq = await models.Faq.findAll({attributes: ['id', 'question', 'answer'], raw: true});
        return faq;
    }

    // async getNewsById(id) {
    //     const news = await News.findOne({where: {id}, raw: true});
    //     return news;
    // }

}

module.exports = new UserService();