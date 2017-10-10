const fs = require ('fs');
const qs = require ('querystring');
const http = require('http');
const https = require('https');

const githubServer = http.createServer((req, res)=>{
  if(req.method === 'POST') {
    let dataString = '';
    req.on('data', d => {
      dataString += d;
    });
    req.on('end', () => {
      const username = qs.parse(dataString).username;
      getGitRepos(username);
    });
  } else {
    res.end("Danger, not a POST request!");
  }
});

const options = {
  'User-Agent': "noahskang",
};

const getGitRepos = https.get('https://api.github.com', (res)=>{
  res.on('data', (d)=>{

  })
});

githubServer.listen(8080, ()=> console.log('Listening on 8080'));
