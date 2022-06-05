const ApiError = require("../error/apiError");
const tokenService = require("../services/token-service");

module.exports = (req, res, next) => {
    try {
        // const { accessToken } = req.cookies;
        const accessToken = req.get('Authorization').replace('Bearer ', '');

        if (!accessToken) {
            return next(ApiError.unAuth("Not auth"));
        }

        const userData = tokenService.validateAccessToken(accessToken);

        if (!userData) {
            return next(ApiError.unAuth("Not auth"));
        }

        req.user = userData;
        next();
    } catch (error) {
        return next(ApiError.unAuth("Not auth"));
    }
}