const ApiError = require("../error/apiError");
const jwt = require("jsonwebtoken");
const { Token } = require("../models/models");
const moment = require("moment");

class TokenService {
    generateTokens(payload) {
        const accessToken = jwt.sign(payload, process.env.JWT_ACCESS_SECRET_KEY, { expiresIn: '60d' });
        const refreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET_KEY, { expiresIn: '65d' });
        return {
            accessToken,
            refreshToken
        }
    }

    validateAccessToken(token) {
        try {
            const userData = jwt.verify(token, process.env.JWT_ACCESS_SECRET_KEY);
            return userData;
        } catch (error) {
            throw ApiError.notAuth("401 " + error);
        }
    }

    validateRefreshToken(token) {
        try {
            const userData = jwt.verify(token, process.env.JWT_REFRESH_SECRET_KEY);
            return userData;
        } catch (error) {
            throw ApiError.fobirden("403 " + error);
        }
    }

    async saveToken(userId, refreshToken) {
        const tokenData = await Token.findOne({ where: { userId } });

        if (tokenData) {
            const updateToken = await Token.update({ token_id: refreshToken }, { where: { userId } });
            return updateToken;
        }

        const dateAdd = moment().format("YYYY-MM-DD HH:mm:ss");
        const token = await Token.create({ token_id: refreshToken, createdAt: dateAdd, updatedAt: dateAdd, userId })

        return token;
    }

    async removeToken(refreshToken) {
        try {
            const tokenData = await Token.destroy({ where: { token_id: refreshToken } });
            return tokenData;
        } catch (error) {
            throw ApiError.badRequest("You are not authorized!");
        }

    }

    async findToken(refreshToken) {
        try {
            const tokenData = await await Token.findOne({ where: { token_id: refreshToken } });
            return tokenData;
        } catch (error) {
            throw ApiError.badRequest("You are not authorized!");
        }

    }
}

module.exports = new TokenService();