const ApiError = require("../error/apiError");

module.exports = (req, res, next) => {
    try {
        const userRole = req.user.role;

        if (userRole.toLowerCase() !== "admin" && userRole.toLowerCase() !== "doctor") {
            return next(ApiError.forbidden("Access denided!"));
        }

        next();
    } catch (error) {
        return next(ApiError.unAuth("Not auth"));
    }
}