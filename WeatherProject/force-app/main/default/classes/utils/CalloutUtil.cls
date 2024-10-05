/**
 * @descripttion: Callout util class
 */
public with sharing class CalloutUtil {
   
    /**
     * @description: Method to make a callout to an external service
     * @param endpoint: The endpoint to make the callout to
     * @param method: The met hod to make the callout with
     * @param body: The body of the request
     * @return HttpResponse: The response from the callout
     */
    public static HttpResponse doCallout(String endpoint, String method, String body) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setBody(body);

        HttpResponse response = new Http().send(request);

        return response;
    }

    /**
     * @description: Method to check if a callout was successful
     * @param response: The response from the callout
     * @return Boolean: Returns true if the callout was successful
     */
    public static Boolean isSucces(HttpResponse response) {
        if (response != null && 
            (response.getStatusCode() == Constants.HTTP_SUCCESS_CODE || 
            response.getStatusCode() == Constants.HTTP_CREATED ||
            response.getStatusCode() == Constants.HTTP_ACCEPTED)) {
            return true;
        } else {
            return false;
        }
    }
}