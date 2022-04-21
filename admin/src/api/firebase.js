import firebase from 'firebase/app'
import 'firebase/storage'

import { initializeApp } from "firebase/app";
import { getStorage, getDownloadURL, uploadBytesResumable, ref } from "firebase/storage";

const firebaseConfig = {
    apiKey: "AIzaSyB5o8SJzvcIbvxxr4ZXx6Qm4hgejMfujes",
    authDomain: "studyboard-ff4d3.firebaseapp.com",
    projectId: "studyboard-ff4d3",
    storageBucket: "studyboard-ff4d3.appspot.com",
    messagingSenderId: "679123909914",
    appId: "1:679123909914:web:287a5b67b0d337177480a3",
    measurementId: "G-1VK8N9R0NP",
};

const firebaseApp = initializeApp(firebaseConfig);
const storage = getStorage(firebaseApp);

const uploadImageFirbase = (file) => {
    return new Promise(async (resolve, reject) => {
        const now = new Date()
        const storageRef = ref(storage, `/quill/${file.name}-pplcakrawalabosquhh-${now.toString()}`);
        const uploadTask = uploadBytesResumable(storageRef, file);
        uploadTask.on(
            "state_changed",
            (snapshot) => {

            },
            (err) => {
                console.log(err)
            },
            () => {
                getDownloadURL(uploadTask.snapshot.ref).then((url) => {
                    return resolve(url);
                })
            }
        )
    })
}

export {storage, uploadImageFirbase};