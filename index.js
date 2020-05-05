const express = require("express");
const cors = require("cors");

const app = express();

app.use(express.json());
app.use(cors({ origin: "*" }));

app.get("/", (req, res) => {
  res.json({ relatable: "isOnline" });
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`server running on port ${port}`));
