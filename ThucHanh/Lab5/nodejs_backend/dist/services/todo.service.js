import ToDoModel from '../models/todo.model.js';
class ToDoService {
    static async createToDo(userId, title, description) {
        const createToDo = new ToDoModel({
            userId,
            title,
            description
        });
        return await createToDo.save();
    }
    static async getUserToDos(userId) {
        return await ToDoModel.find({ userId });
    }
    static async updateToDo(toDoId, title, description) {
        return await ToDoModel.findByIdAndUpdate(toDoId, { title, description }, { new: true });
    }
    static async deleteToDo(toDoId) {
        return await ToDoModel.findByIdAndDelete(toDoId);
    }
}
export default ToDoService;
