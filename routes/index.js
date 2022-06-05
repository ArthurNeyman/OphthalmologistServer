const Router = require("express");
const router = new Router();

const userRouter = require("./userRouter");
const patientRouter = require("./patientRouter");
const editorRouter = require("./editorRouter");

router.use("/user", userRouter);
router.use("/patient", patientRouter);
router.use("/editor", editorRouter);

module.exports = router;