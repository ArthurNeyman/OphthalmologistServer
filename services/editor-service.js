const ApiError = require("../error/apiError");
const models = require("../models/models");
const { Op } = require("sequelize");
const UserServices = require("./user-service");
const moment = require("moment");
const bcrypt = require("bcrypt");

class EditorService {
    async regEditor(regData){
        const existUser = await models.User.findOne({where: {login: regData.login}});

        if (existUser){
            return {error: "Такой пользователь уже зарегистрирован"};
        }

        const role = await models.Role.findOne({where: {user_role: regData.role}});
        
        if (role === null) {
            return {error: "Роли '" + regData.role + "' не существует"};
        }

        const dateReg = moment().format("YYYY-MM-DD HH:mm:ss");
        const hashPassword = await bcrypt.hash(String(regData.password), 5);
        const user = await models.User.create({login: regData.login, password: hashPassword, createdAt: dateReg, updatedAt: dateReg, roleId: role.id});
        
        return { message: "Администратор добавлен" };
    }

    async addService(insertData) {
        if (!insertData.sort) {
            const sort = await models.Service.findOne({
                attributes: [
                    [models.sequelize.fn('max', models.sequelize.col('sort')), 'maxSort']
                ],
                raw: true
            });
            insertData.sort = sort.maxSort + 1;
        }

        const serviceData = await models.Service.create(insertData);

        if (!serviceData) {
            return null;
        }

        const doctors = insertData.doctors;

        if (doctors) {
            if(!Array.isArray(doctors) || !doctors.length) {
                const deleteRecord = await models.Service.destroy({ where: { id: serviceData.id } });
                return {error: "Incorret doctors object"};
            } else {
                let doctorsServiceId = doctors.map((obj) => {
                    return { serviceId: serviceData.id, doctorId: obj.doctorId };
                });
        
                const serviceDoctors = await models.ServiceDoctors.bulkCreate(doctorsServiceId);

                if (!serviceDoctors) {
                    const deleteRecord = await models.Service.destroy({ where: { id: serviceData.id } });
                    return {error: "Error add doctors to service"};
                }
            }
        }
        
        // return { message: "Услуга добавлена" };
        return UserServices.getServices();
    }

    async editService(editData) {
        if (editData.id == null || editData.id == "" || isNaN(Number(editData.id))) {
            return {error: "Incorrect service id"};
        }

        if ("name" in editData && editData.name.length < 3) {
            return { error: "Название услуги должно содержать больше трёх символов" };
        }   
        
        if ("description" in editData && editData.description.length < 3) {
            return { error: "Описание услуги должно содержать больше трёх символов" };
        }

        // if (editData.description && editData.description.length < 3) {
        //     return { error: "Описание услуги должно содержать больше трёх символов" };
        // }

        const serviceData = await models.Service.update({
            name: editData.name,
            description: editData.description,
            price: editData.price,
            parentId: editData.parentId,
            imgLink: editData.imgLink,
            sort: editData.sort
        }, { where: { id: editData.id } });

        console.log("service data ", serviceData);

        if (!serviceData) {
            return {error: "Error edit service"};
        }

        return { message: "Услуга отредактирована" };
    }

    async deleteService(deleteData) {
        if (deleteData.serviceId == null || deleteData.serviceId == "" || isNaN(Number(deleteData.serviceId))) {
            return {error: "Incorrect service id"};
        }

        const serviceData = await models.Service.destroy({ where: { id: deleteData.serviceId } });

        if (!serviceData) {
            return {error: "Error delete service"};
        }

        // return { message: "Услуга удалена" };
        return UserServices.getServices();
    }

    async addDoctorService(doctorService) {
        if (doctorService.serviceId == null || doctorService.serviceId == "" || isNaN(Number(doctorService.serviceId)) || !doctorService.doctors.length) {
           return {error: "Incorrect service or doctors id"};
        }

        const existDoctor = await models.ServiceDoctors.findAll({
            where: {
                [Op.or]: doctorService.doctors,
                [Op.and]: [{ serviceId: doctorService.serviceId }]
            }
        });


        if (existDoctor.length) {
            return {error: "Врач уже привязан к услуге"};
        }

        let doctorsServiceId = doctorService.doctors.map((obj) => {
            return { serviceId: doctorService.serviceId, doctorId: obj.doctorId };
        });

        const serviceData = await models.ServiceDoctors.bulkCreate(doctorsServiceId);

        if (!serviceData) {
            return {error: "Error add service doctors"};
        }

        return UserServices.getServices(doctorService.serviceId);
        // return { message: "Врач привязан к услуге" };
    }

    async removeDoctorService(doctorService) {
        if (doctorService.serviceId == null || doctorService.serviceId == "" || isNaN(Number(doctorService.serviceId)) || !doctorService.doctors.length) {
            throw ApiError.badRequest("Incorrect id");
        }

        const existDoctor = await models.ServiceDoctors.findAll({
            where: {
                [Op.or]: doctorService.doctors,
                [Op.and]: [{ serviceId: doctorService.serviceId }]
            }
        });

        if (!existDoctor.length) {
            throw ApiError.badRequest("Врач не привязан к услуге");
        }

        let doctorsId = [];
        doctorService.doctors.map((obj) => {
            doctorsId.push(obj.doctorId);
        });
        
        const serviceData = await models.ServiceDoctors.destroy({
            where: {
                doctorId: doctorsId,
                [Op.and]: [{ serviceId: doctorService.serviceId }]
            }
        });

        if (!serviceData) {
            return null;
        }

        return { message: "Врач(и) больше не привязан(ы) к услуге" };
    }

    async addDoctor(doctor) {
        // if (doctorService.serviceId == null || doctorService.serviceId == "" || isNaN(Number(doctorService.serviceId)) || !doctorService.doctors.length) {
        //     throw ApiError.badRequest("Incorrect id");
        // }

        const doctorData = await models.Doctor.create(doctor);

        if (!doctorData) {
            return null;
        }

        return { message: "Врач добавлен" };
    }

    async editDoctor(editData) {
        
        if ("firstName" in editData && editData.firstName.length < 3) {
            return { error: "Имя должно содержать больше трёх символов" };
        }
        // console.log("edit data ", editData.lastName);
        if ("lastName" in editData && editData.lastName.length < 3) {
            return { error: "Фамилия должна содержать больше трёх символов" };
        }

        const doctorData = await models.Doctor.update({
            first_name: editData.firstName,
            last_name: editData.lastName,
            surname: editData.surname,
            position: editData.position,
            category: editData.category,
            scientific_title: editData.scientificTitle,
            description: editData.description,
            phoneNumber: editData.phoneNumber,
            imgLink: editData.imgLink
        }, { where: { id: editData.id } });

        if (!doctorData) {
            return null;
        }

        return { message: "Изменения выполнены успешно!" };
    }

    async deleteDoctor(deleteData) {
        if (deleteData.doctorId == null || deleteData.doctorId == "" || isNaN(Number(deleteData.doctorId))) {
            return {error: "Incorrect doctor id"};
        }

        const doctorData = await models.Doctor.destroy({ where: { id: deleteData.doctorId } });

        if (!doctorData) {
            return {error: "Error delete service"};
        }

        return UserServices.getDoctors();
    }
}

module.exports = new EditorService();