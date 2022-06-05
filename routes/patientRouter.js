const Router = require("express");
const router = new Router();
const patientController = require("../controllers/patientController");

router.post("/add", patientController.add);
router.post("/edit-info", patientController.editInfo);
router.get("/info:user_id", patientController.getInfoOne);

module.exports = router;