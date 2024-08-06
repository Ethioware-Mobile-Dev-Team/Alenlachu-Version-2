const bcrypt = require('bcrypt');
const ClientModel = require('../models/client.model');
const Authentication = require('./auth.services');



class ClientService{
    static async registerClient(username, email,password, emergencyContact, fullName,phoneNumber, dateOfBirth, nationality, residency, isAnonymous){
        try{
            const newClient = new ClientModel({
                username,
                email,
                password,
                emergencyContact,
                fullName,
                phoneNumber,
                dateOfBirth,
                nationality,
                residency,
                isAnonymous,
            });
            return await newClient.save();
        }catch(e){
            throw new Error(`Failed to register Client ${e}`);
        }
    }

    static async loginClient(clinetUsername, clientPassword){
        const client = await ClientModel.findOne({username: clinetUsername});
        if (!client || !(await bcrypt.compare(clientPassword, client.password))) {
            return null;
        }

        const {
            _id,
            username,
            email,
            emergencyContact,
            fullName,
            phoneNumber,
            dateOfBirth,
            nationality,
            residency,
            isAnonymous,
        } = client;

        let tokenData = {
            _id: _id,
            username: username,
            email: email,
            emergencyContact: emergencyContact,
            fullName: fullName,
            phoneNumber: phoneNumber,
            dateOfBirth: dateOfBirth,
            nationality: nationality,
            residency: residency,
            isAnonymous: isAnonymous
        }

        const SECRET_KEY = process.env.SECRET_KEY || 'secret_key';
        const token = Authentication.generateToken(tokenData,SECRET_KEY,{expiresIn: '1h'});
        return token; 
    }

    static async addJournal(clientId, journalData) {
        try {
            const client = await ClientModel.findById(clientId);
            if (!client) throw new Error('Client not found');
            client.journals.push(journalData);
            await client.save();
            return client;
        } catch (e) {
            throw new Error(`Failed to add journal: ${e.message}`);
        }
    }

    static async getJournals(clientId) {
        try {
            const client = await ClientModel.findById(clientId).populate('journals');
            if (!client) throw new Error('Client not found');
            return client.journals;
        } catch (e) {
            throw new Error(`Failed to get journals: ${e.message}`);
        }
    }

    static async updateJournal(clientId, journalId, updatedData) {
        try {
            const client = await ClientModel.findById(clientId);
            if (!client) throw new Error('Client not found');

            const journal = client.journals.id(journalId);
            if (!journal) throw new Error('Journal not found');

            journal.set(updatedData);
            await client.save();
            return journal;
        } catch (e) {
            throw new Error(`Failed to update journal: ${e.message}`);
        }
    }

    static async deleteJournal(clientId, journalId) {
        try {
            const client = await ClientModel.findById(clientId);
            if (!client) throw new Error('Client not found');

            client.journals.id(journalId).remove();
            await client.save();
            return true;
        } catch (e) {
            throw new Error(`Failed to delete journal: ${e.message}`);
        }
    }

    
}

module.exports = ClientService;