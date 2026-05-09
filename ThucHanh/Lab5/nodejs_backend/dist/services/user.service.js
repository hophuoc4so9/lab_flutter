import UserModel from '../models/user.model.js';
import jwt from 'jsonwebtoken';
class UserService {
    static async registerUser(email, password) {
        try {
            const createUser = new UserModel({
                email,
                password
            });
            const savedUser = await createUser.save();
            return savedUser;
        }
        catch (error) {
            throw error;
        }
    }
    static async getUserByEmail(email) {
        try {
            const user = await UserModel.findOne({ email });
            return user;
        }
        catch (error) {
            throw error;
        }
    }
    static async checkUser(email) {
        try {
            return await UserModel.findOne({ email });
        }
        catch (error) {
            throw error;
        }
    }
    static async generateAccessToken(tokenData, JWTSecret, expiresIn) {
        return jwt.sign(tokenData, JWTSecret, { expiresIn: expiresIn });
    }
}
export default UserService;
