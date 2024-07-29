
const ClientService = require('../services/client.services');

exports.registerClient = async (req, res) => {
    try {
        const { username, email,password, emergencyContact, fullName, phoneNumber, dateOfBirth, nationality, residency, isAnonymous } = req.body;
        if (!username || username.trim() === '') {
            return res.status(400).json({ error: 'Username is required.' });
        }
        if (!email || email.trim() === '') {
            return res.status(400).json({ error: 'Email is required.' });
        }

        if (!/^\S+@\S+\.\S+$/.test(email)) {
            return res.status(400).json({ error: 'Invalid email format.' });
        }
        
        if (!emergencyContact || emergencyContact.trim() === '') {
            return res.status(400).json({ error: 'Emergency contact is required.' });
        }

        if (!password || password.trim() === '') {
            return res.status(400).json({ error: 'Password is required.' });
        }

        if (password.length < 8) {
            return res.status(400).json({ error: 'Password must be at least 8 characters long.' });
            
        }
        if (!/[a-z]/.test(password)) {
            return res.status(400).json({ error: 'Password must include at least one lowercase letter.' });
        }
        if (!/[A-Z]/.test(password)) {
            return res.status(400).json({ error: 'Password must include at least one uppercase letter.' });
        }
        if (!/\d/.test(password)) {
            return res.status(400).json({ error: 'Password must include at least one number.' });
        }
        if (!/[@$!%*?&]/.test(password)) {
            return res.status(400).json({ error: 'Password must include at least one special character.' });
        }
        
        const result = await ClientService.registerClient(
            username.trim(),
            email.trim().toLowerCase(),
            password.trim(),
            emergencyContact.trim(),
            fullName ? fullName.trim() : null,
            phoneNumber ? phoneNumber.trim() : null,
            dateOfBirth ? new Date(dateOfBirth) : null,
            nationality ? nationality.trim() : null,
            residency ? residency.trim() : null,
            isAnonymous
        );

        res.status(201).json(result);
    } catch (err) {
        res.status(400).json({ error: err.message });
    }
};

exports.loginClient = async (req,res) => {
    try {
        const {username, password} = req.body;
        const token = await ClientService.loginClient(username, password);

        if(!token){
            return res.status(401).send('Invalid credential');
        }

        res.status(200).json({status: true, token: token});
    } catch (e) {
        res.status(500).send('Internal server error');
    }
 
}