const fs = require('fs');

// fs.readFile('./animals.txt', 'utf-8', (err, data)=>{
//   if(err){
//     throw(err);
//   } else {
//     const ary = data.split("\n");
//     const newary = [];
//     // console.log(process.argv[2]);
//     ary.forEach((ele)=>{
//       if(ele[0]===process.argv[2].toUpperCase()) newary.push(ele);
//     });
//     // console.log(newary);
//     writeWordsToNewFile(newary, process.argv[2]);
//   }
// });

const http = require('http');
const querystring = require('querystring');
const port = 8000;

const server = http.createServer((req, res) => {

  if(req.url === '/favicon.ico'){
    res.writeHead(200, {'Content-Type': 'image/x-icon'});
    res.end();
    return;
  }

  let query = querystring.parse(req.url.split("/?")[1]);

  if(Object.keys(animalList).length===0) {
    getAnimalList((animalObject)=>{
      filterAnimals(query["letter"], animalObject, (list)=>{
        res.write(list);
        res.end();
      });
    });
  } else {
    filterAnimals(query["letter"], animalList, (list)=>{
      res.write(list);
      res.end();
    });
  }

});


const animalList = {};

const filterAnimals = (letter, animalObject, cb) => {
  let newary = animalObject["list"].filter((ele)=>{
    return ele[0]===letter.toUpperCase();
  });
  cb(newary.join("\n"));
};

const getAnimalList = (cb) => {
  fs.readFile('./animals.txt', 'utf-8', (err, data)=>{
    if(err){
      throw(err);
    } else {
      cb({list: data.split("\n")});
    }
  });
};

server.listen(port, (err)=> {
  if(err){
    return console.log('something bad happened', err);
  }
  console.log(`I'm listening on port ${port}`);
});
