import connectDB from '../config/db.js';
import { Schema } from 'mongoose';
import bcrypt from 'bcryptjs';
const userSchema = new Schema({
    email: {
        type: String,
        lowercase: true,
        required: [true, "userName can't be empty"],
        match: [
            /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/,
            "userName format is not correct",
        ],
        unique: true,
    },
    password: {
        type: String,
        required: [true, "password is required"],
    },
}, { timestamps: true });
userSchema.pre('save', async function () {
    const user = this;
    if (!user.isModified('password'))
        return;
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);
});
userSchema.methods.comparePassword = async function (candidatePassword) {
    return bcrypt.compare(candidatePassword, this.password);
};
const connection = connectDB();
const UserModel = connection.model('User', userSchema);
export default UserModel;
