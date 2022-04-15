import express from 'express';
const app = express();

app.get("/", (req, res) => {
    res.send("API is 🎉ready");
})

app.listen(8085, () => { console.log("Server is 🏃‍♂️ running"); })