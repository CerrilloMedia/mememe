// This corresponds to the post#new form which displays a preview
// of the uplaoded image

var loadFile = function(event) {
  var output = document.getElementById('image-preview');
  output.src = URL.createObjectURL(event.target.files[0]);

  console.log(event.target.files[0]);
  var fileField = document.getElementById("upload-filename");
  if (fileField) {
    fileField.value = "file: " + event.target.files[0].name;
  }
}
