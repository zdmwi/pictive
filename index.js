const express = require('express');
const cors = require('cors');

const app = express();

app.use(express.json());
app.use(cors({ origin: '*' }));
app.use(express.static('public'));

app.get('/api/generate-report', (req, res) => {
  res.send({ yolo: 'swag' });
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`server running on port ${port}`));
