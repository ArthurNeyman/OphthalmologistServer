const { User, Role } = require("./models/models");
const ApiError = require("./error/apiError");
const bcrypt = require("bcrypt");
const moment = require("moment");

const initApp = async() => {
    try {
        const login = process.env.ADMIN_LOGIN;
        const existAdm = await User.findOne({ where: { login } });
        if (!existAdm) {
            const role = await Role.findOne({ where: { user_role: "admin" } });
            const dateReg = moment().format("YYYY-MM-DD HH:mm:ss");
            const hashPassword = await bcrypt.hash(String(process.env.ADMIN_PASS), 5);
            const user = await User.create({ login, password: hashPassword, createdAt: dateReg, updatedAt: dateReg, roleId: role.id });
        }
    } catch (error) {
        throw ApiError.internal("Init error: " + error.message);
    }
}

module.exports = initApp;