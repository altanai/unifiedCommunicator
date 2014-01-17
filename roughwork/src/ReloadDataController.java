 // Spring MVC Controller

 public class ReloadDataController {

   // Request Mapping
   @RequestMapping(value = '/reload-data-url', method = RequestMethod.POST)
   @ResponseBody
   public ResponseEntity<String> processReloadData(@RequestBody String body) {

     // Get your request
     JSONObject request = new JSONObject(body);
     String id = request.getString("id"); // Here the value is 'some id'

     // Get the new data in a JSONObject
     JSONObject response = new JSONObject();
     // build the response...

     // Send the response back to your client
     HttpHeaders headers = new HttpHeaders();
     headers.add("Content-Type", "application/json; charset=utf-8");
     return new ResponseEntity<String>(response.toString(),
                headers, HttpStatus.OK);
   }

 }