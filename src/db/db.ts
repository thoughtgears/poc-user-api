import * as fs from 'fs/promises';
import type { User } from '../types';
import { v4 as uuid } from 'uuid';
import path from 'path';

const dataFilePath = path.join(__dirname, 'data.json');

const loadData = async (): Promise<User[]> => {
    try {
        const fileData = await fs.readFile(dataFilePath, 'utf-8');
        return JSON.parse(fileData) as User[];
    } catch (error) {
        console.error('Error loading data:', error);
        return [] as User[];
    }
};

export const db = {
    getAll: async (): Promise<User[]> => {
        return await loadData();
    },

    getById: async (id: string): Promise<User | null> => {
        const users = await loadData();
        const user = users.find((user) => user.id === id);
        return user || null;
    },

    create: async (userData: Omit<User, 'id'>): Promise<User> => {
        const users = await loadData();
        const newUser: User = {
            ...userData,
            id: uuid.toString(),
        };

        users.push(newUser);
        return newUser;
    },

    update: async (id: string, userData: Partial<Omit<User, 'id'>>): Promise<User | null> => {
        const users = await loadData();
        const index = users.findIndex((user) => user.id === id);

        if (index === -1) {
            return null;
        }

        const currentUser = users[index]!;

        users[index] = {
            firstName: userData.firstName ?? currentUser.firstName,
            lastName: userData.lastName ?? currentUser.lastName,
            email: userData.email ?? currentUser.email,
            address: userData.address ?? currentUser.address,
            id: currentUser.id,
            // Optional fields
            middleName: userData.middleName ?? currentUser.middleName,
            phone: userData.phone ?? currentUser.phone,
        };

        return users[index];
    },

    delete: async (id: string): Promise<boolean> => {
        const users = await loadData();
        const filteredUsers = users.filter((user) => user.id !== id);

        return filteredUsers.length !== users.length;
    },
};
