const express = require('express');
const cors = require('cors');

const app = express();

app.use(express.json());
app.use(cors({ origin: '*' }));
app.use(express.static('public'));

app.get('/test', (req, res) => {
  res.json({ relatable: 'isOnline' });
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`server running on port ${port}`));
