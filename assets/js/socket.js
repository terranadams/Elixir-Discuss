import { Socket } from "phoenix" /* we import the socket library */

let socket = new Socket("/socket", {params: {token: window.userToken}})/* we create a new instance of the socket library... 
and then connect it to our backend server  */

socket.connect()/* ...and then connect it to our backend server   */

let channel = socket.channel("comments:1", {})/* then once we've connected, we create a reference to a very specific channel */
channel.join()/* once the channel has been joined, we can register these two separate events to get feedback on the connection */
    .receive("ok", resp => { console.log("Joined successfully", resp)})
    .receive("error", resp => { console.log("Unable to join", resp)})

export default socket