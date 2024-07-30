const bcrypt = require('bcrypt');
const AdminModel = require('../models/admin.model');
const Authentication = require('./auth.services');

class AdminService {
    static async registerAdmin(email, password) {
        try{
            const newAdmin = new AdminModel({
                email,
                password
            });

            return await newAdmin.save();
        }catch(e){
            throw new Error(`Failed to register admin ${e}`);
        }
    }

    static async loginAdmin(adminEmail, adminPassword) {
        const admin = await AdminModel.findOne({adminEmail});

        if(!admin || !(await bcrypt.compare(adminPassword, admin.password))){
            return null;
        }

        const{_id, email, password} = admin;

        let tokenData = {
            _id : _id,
            email : email,
        }

        const SECRET_KEY = process.env.SECRET_KEY || 'secret_key';
        const token = Authentication.generateToken(tokenData,SECRET_KEY,{expiresIn: '1h'});
        return token;
    }
}

module.exports = AdminService;