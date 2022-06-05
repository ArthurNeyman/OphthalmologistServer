const sequelize = require("../db");
const { DataTypes } = require("sequelize");
const { model } = require("../db");

const User = sequelize.define("user", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    login: { type: DataTypes.STRING, unique: true },
    password: { type: DataTypes.STRING, allowNull: false }
});

const Role = sequelize.define("role", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    user_role: { type: DataTypes.STRING, allowNull: false }
});

const Patient = sequelize.define("patient", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    first_name: { type: DataTypes.STRING, allowNull: false },
    last_name: { type: DataTypes.STRING, allowNull: false },
    surname: { type: DataTypes.STRING }
});

const Doctor = sequelize.define("doctor", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    first_name: { type: DataTypes.STRING, allowNull: false },
    last_name: { type: DataTypes.STRING, allowNull: false },
    surname: { type: DataTypes.STRING },
    position: { type: DataTypes.STRING },
    category: { type: DataTypes.STRING },
    scientific_title: { type: DataTypes.STRING },
    description: { type: DataTypes.STRING(3000) },
    phoneNumber: { type: DataTypes.STRING },
    imgLink: { type: DataTypes.STRING(1000) }
});

const Token = sequelize.define("token", {
    token_id: { type: DataTypes.STRING, primaryKey: true }
});

const News = sequelize.define("news", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING, allowNull: false },
    description: { type: DataTypes.STRING(5000), allowNull: false },
    date: { type: DataTypes.DATE, allowNull: false },
    imgLink: { type: DataTypes.STRING(1000) }
});

const Service = sequelize.define("service", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING, allowNull: false },
    description: { type: DataTypes.STRING(5000), allowNull: false },
    price: { type: DataTypes.FLOAT },
    parentId: { type: DataTypes.INTEGER },
    imgLink: { type: DataTypes.STRING(1000) },
    sort: { type: DataTypes.INTEGER }
});

const ServiceDoctors = sequelize.define("service_doctor", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    serviceId: { type: DataTypes.INTEGER, allowNull: false },
    doctorId: { type: DataTypes.INTEGER, allowNull: false },
});

const ServiceOptions = sequelize.define("service_option", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING(1000), allowNull: false },
    description: { type: DataTypes.STRING(1000) },
    imgLink: { type: DataTypes.STRING(1000) },
    serviceId: { type: DataTypes.INTEGER },
});

const Clinic = sequelize.define("clinic", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING(1000), allowNull: false },
    shortDescription: { type: DataTypes.STRING(1000) },
});

const ClinicContacts = sequelize.define("clinic_contact", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    name: { type: DataTypes.STRING(1000), allowNull: false },
    contact: { type: DataTypes.STRING(1000), allowNull: false },
    isMain: { type: DataTypes.BOOLEAN, defaultValue: 0 }
});

const ClinicAddress = sequelize.define("clinic_address", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    postIndex: { type: DataTypes.STRING(1000) },
    address: { type: DataTypes.STRING(1000), allowNull: false },
    comments: { type: DataTypes.STRING(1000) }
});

const Faq = sequelize.define("faq", {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    question: { type: DataTypes.STRING(1000), allowNull: false },
    answer: { type: DataTypes.STRING(1000), allowNull: false },
});

// const ServiceCategory = sequelize.define("service_category", {
//     id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
//     name: {type: DataTypes.STRING, allowNull: false},
//     description: {type: DataTypes.STRING(5000)},
//     parentId: {type: DataTypes.INTEGER},
//     sort: {type: DataTypes.INTEGER}
// });

// const Polyclinic 

Role.hasMany(User);
User.belongsTo(Role);

User.hasMany(Patient);
Patient.belongsTo(User);

User.hasMany(Doctor);
Doctor.belongsTo(User);

User.hasMany(Token);
Token.belongsTo(User);

User.hasMany(News);
News.belongsTo(User);

Service.hasMany(ServiceOptions, { as: 'options' });

Doctor.belongsToMany(Service, {
    as: "services",
    through: ServiceDoctors,
    foreignKey: "doctorId",
});

Service.belongsToMany(Doctor, {
    as: "doctors",
    through: ServiceDoctors,
    foreignKey: "serviceId",
});

ServiceDoctors.belongsTo(Service, { foreignKey: "serviceId" });
ServiceDoctors.belongsTo(Doctor, { foreignKey: "doctorId" });

Clinic.hasMany(ClinicContacts, { as: "contacts" });
ClinicContacts.belongsTo(Clinic, { foreignKey: "id" });

Clinic.hasMany(ClinicAddress, { as: "address" });
ClinicAddress.belongsTo(Clinic, { foreignKey: "id" });

// ServiceCategory.hasMany(Service);
// Service.belongsTo(ServiceCategory);

module.exports = {
    sequelize,
    User,
    Role,
    Patient,
    Token,
    News,
    Service,
    /*ServiceCategory,*/
    Doctor,
    ServiceDoctors,
    ServiceOptions,
    Clinic,
    ClinicContacts,
    ClinicAddress,
    Faq
}