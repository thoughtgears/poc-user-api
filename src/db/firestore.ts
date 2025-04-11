import { Firestore, DocumentReference, type DocumentData } from '@google-cloud/firestore';
import { type UserModel, userSchema } from '../models/userModel.ts'; // Corrected import

const firestore = new Firestore();
const collectionName = 'users';

export const userRepository = {
    createUser: async (userData: UserModel): Promise<{ id: string } & UserModel> => {
        const parsedData = userSchema.parse(userData);
        const docRef: DocumentReference<DocumentData> = await firestore.collection(collectionName).add(parsedData);
        return { id: docRef.id, ...parsedData };
    },

    getUser: async (id: string): Promise<({ id: string } & UserModel) | null> => {
        const docSnap = await firestore.collection(collectionName).doc(id).get();

        if (!docSnap.exists) {
            return null;
        }

        return { id, ...(docSnap.data() as UserModel) };
    },

    updateUser: async (id: string, userData: UserModel): Promise<{ id: string } & UserModel> => {
        const parsedData = userSchema.parse(userData);
        await firestore.collection(collectionName).doc(id).update(parsedData);
        return { id, ...parsedData };
    },

    deleteUser: async (id: string): Promise<void> => {
        await firestore.collection(collectionName).doc(id).delete();
    },
};
