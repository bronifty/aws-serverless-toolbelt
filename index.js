const serverless = require("serverless-http");
const express = require("express");
const app = express();

// creating routes
app.get("/api", (req, res) => {
  res.send("Hello world!");
});

// to run and test locally
if (process.env.DEVELOPMENT) {
  const PORT = 8080;

  app.listen(PORT, () => {
    console.log(`Server is running on PORT: ${PORT}`);
  });
}

module.exports.handler = serverless(app);
