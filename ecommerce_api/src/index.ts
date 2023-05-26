import app from './app';
/* eslint-disable no-console */
/* eslint-enable no-console */
const port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log(`Listenin: http://localhost:${port}`);
});
