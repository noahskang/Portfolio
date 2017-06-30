const readline = require('readline');

const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

function addNumbers(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) { return completionCallback(sum); }
  if (numsLeft > 0) {
    reader.question('Give a number: ', (res) => {
      let num = parseInt(res);
      sum += num;
      addNumbers(sum, numsLeft - 1, completionCallback);
    });
  }
}

addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`));
