const sort = (a, b) => b.val-a.val;

function convertBase(value, from_base, to_base) {
  const range = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+/'.split('')
  , from_range = range.slice(0, from_base)
  , to_range = range.slice(0, to_base)
  
  let dec_value = value
    .split('')
    .reverse()
    .reduce((carry, digit, index) => {
      return carry += 
        from_range.indexOf(digit) * 
        (Math.pow(from_base, index));
    }, 0),
    new_value = '';
  
  while (dec_value > 0) {
    new_value = to_range[dec_value % to_base] + new_value;
    dec_value = (dec_value - (dec_value % to_base)) / to_base;
  }
  
  return new_value || '0';
}

const main = (num) => {
  if (num < 5) throw new Error('input must be larger than 4');
  check = [];
  x = 3;
  while (x < num) {
    check.push({
      val: convertBase(num.toString(), 10, x).split('4').length,
      base: x
    });
    x++
  }
  return check.sort(sort)[0].base;
}

//tests
console.log('Running tests...');
console.time("2k difforent bases took");
for (var i = 5; i < 2000; i++) {
  main(i)
}
console.timeEnd("2k difforent bases took");

console.time('10e5 base took');
main(1000000);
console.timeEnd('10e5 base took');


