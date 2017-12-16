function metaValue(name) {
  return document.querySelector(`meta[name="${name}"]`).getAttribute("content");
}
var action = `${metaValue('controller_name')}/${metaValue('action_name')}`;

// if("welcomes/show" == action) {
//   require('./welcomes/show/index.js')
// }
// else if("welcomes/index" == action) {
//   require('./welcomes/index/index.js')
// }