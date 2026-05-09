import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();
const connectDB = () => {
    return mongoose.createConnection(process.env.MONGO_URI || '')
        .on('open', () => {
        console.log('Connected to MongoDB');
    })
        .on('error', (err) => {
        console.error('Error connecting to MongoDB:', err);
    });
};
export default connectDB;
