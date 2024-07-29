const InstitutionService = require('../services/institution.services');

exports.registerInstitution = async (req, res) => {
    try {
        const { 
            name,
            email,
            password,
            phoneNumber,
            address,
            establishmentDate,
            languageToProvideService,
            pricePerHour
        } = req.body;

        if (!/^\S+@\S+\.\S+$/.test(email)) {
            return res.status(400).json({ error: 'Invalid email format.' });
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

        const result = await InstitutionService.registerInstitution(
            name.trim(),
            email.trim().toLowerCase(),
            password.trim(),
            phoneNumber.trim(),
            address.trim(),
            new Date(establishmentDate),
            languageToProvideService.trim(),
            Number(pricePerHour)
        );

        res.status(201).json(result);
    } catch (e) {
        res.status(400).json({ error: e.message });
    }
};

exports.loginInstitution = async (req, res) => {
    try{
        const {email, password} = req.body;
        const token = InstitutionService.loginInstitution(email, password);

        if(!token){
            return res.status(401).send('Invalid credential');
        }

        res.status(200).json({status: true, token: token});
    }catch(e){
        res.status(500).send('Internal server error');
    }
}