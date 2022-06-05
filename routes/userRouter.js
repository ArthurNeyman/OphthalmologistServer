const Router = require("express");
const userController = require("../controllers/userController");
const router = new Router();
const {body} = require("express-validator");

router.post("/registration", body("code").isLength({min: 6, max: 32}), userController.registration);
router.post("/login", userController.login);
router.post("/logout", userController.logout);
router.post("/refresh", userController.refresh);
router.get("/news", userController.getNews);
router.get("/services", userController.getServices);
router.get("/doctors", userController.getDoctors);
router.get("/service-categories", userController.getServiceCategories);
router.get("/info-clinic", userController.getInfoClinic);
router.get("/faq", userController.getFaq);
// router.post("/send-code", userController.sendCode);
// router.get("/auth", userController.checkAuth);

module.exports = router;