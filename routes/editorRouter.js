const Router = require("express");
const editorController = require("../controllers/editorController");
const router = new Router();
const { body } = require("express-validator");
const authMiddleware = require("../middleware/AuthMiddleware");
const roleMiddleware = require("../middleware/roleMiddleware");

router.post("/reg-editor", authMiddleware, roleMiddleware,  body("login").isLength({ min: 3 }), body("password").isLength({ min: 6 }), editorController.regEditor)
router.post("/add-service", authMiddleware, roleMiddleware, body("name").isLength({ min: 3 }), body("description").isLength({ min: 3 }), editorController.addService);
router.post("/edit-service", authMiddleware, roleMiddleware, editorController.editService);
router.post("/delete-service", authMiddleware, roleMiddleware, editorController.deleteService);
router.post("/add-doctor-service", authMiddleware, roleMiddleware, editorController.addDoctorService);
router.post("/remove-doctor-service", authMiddleware, roleMiddleware, editorController.removeDoctorService);
router.post("/add-doctor", authMiddleware, roleMiddleware, body("first_name").isLength({ min: 3 }), body("last_name").isLength({ min: 3 }), editorController.addDoctor);
router.post("/edit-doctor", authMiddleware, roleMiddleware, editorController.editDoctor);
router.post("/delete-doctor", authMiddleware, roleMiddleware, editorController.deleteDoctor);

module.exports = router;