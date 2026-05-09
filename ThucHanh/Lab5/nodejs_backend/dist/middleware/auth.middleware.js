import jwt from 'jsonwebtoken';
export const authenticateToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    // Token format: "Bearer <token>"
    const token = authHeader && authHeader.split(' ')[1];
    if (!token) {
        return res.status(401).json({ status: false, message: "Unauthorized: Access token is missing" });
    }
    try {
        const secret = process.env.JWT_SECRET || 'secret';
        const decoded = jwt.verify(token, secret);
        req.user = decoded;
        next();
    }
    catch (err) {
        return res.status(403).json({ status: false, message: "Forbidden: Invalid or expired token" });
    }
};
