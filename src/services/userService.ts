import { userRepository } from '../db/firestore';
import type { UserModel } from '../models/userModel';

export const userService = {
    createUser: async (userData: UserModel): Promise<{ id: string } & UserModel> => {
        return userRepository.createUser(userData);
    },

    getUser: async (id: string): Promise<({ id: string } & UserModel) | null> => {
        return userRepository.getUser(id);
    },

    updateUser: async (id: string, userData: UserModel): Promise<({ id: string } & UserModel) | null> => {
        return userRepository.updateUser(id, userData);
    },

    deleteUser: async (id: string): Promise<void> => {
        await userRepository.deleteUser(id);
    },
};
