const { createProxyMiddleware } = require("http-proxy-middleware");

// the package.json fix did not work for me on windows...
// "proxy": "http://localhost:8080/mainappfile/",
// It turns out per default windows relys on the DNS to resolve localhost to 127.0.0.1
// and does this not in the hosts file...
module.exports = function (app) {
  app.use(
    "/api",
    createProxyMiddleware({
      target: "http://127.0.0.1:8080/mainappfile",
      changeOrigin: true,
    })
  );
};
