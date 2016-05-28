package es.upm.fi.sos.t3.usermanagement.client;

import java.rmi.RemoteException;
import es.upm.fi.sos.t3.usermanagement.client.UserManagementWSStub.*;

public class UserManagementWSClient {
	public static void main(String[] args) throws RemoteException {
		
		Response response;
        boolean res;
		
		// creamos el stub
		UserManagementWSStub stub = new UserManagementWSStub();
		
		// hacemos que el stub mantega la conexion
        stub._getServiceClient().engageModule("addressing");
        stub._getServiceClient().getOptions().setManageSession(true);

        
        //
        // PRUEBAS
        //
        
		System.out.print("login with admin...  ");
		User admin = new User();
		admin.setName("admin");
		admin.setPwd("admin");
		response = stub.login(admin);
		res = response.getResponse();
		System.out.print(res);
		System.out.println("\n");
		
		
		System.out.print("logout with admin...  ");
		stub.logout();
		System.out.println("\n");
		
		
		System.out.print("Un vez echo el logout, intentamos cambiar la contraseña... FALSE =?=... ");
		PasswordPair passwordPair5 = new PasswordPair();
		passwordPair5.setOldpwd("admin");
		passwordPair5.setNewpwd("admin2");		
		response = stub.changePassword(passwordPair5);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("logout con admin...  ");
		stub.logout();
		System.out.println("\n");

		
		System.out.print("login con admin...  ");
		response = stub.login(admin);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.println("Un vez echo el login, intentamos cambiar la contraseña...  ");
		System.out.print("deberia salir TRUE... ");
		response = stub.changePassword(passwordPair5);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("logout de admin...  ");
		stub.logout();
		System.out.println("");
		
		
		System.out.print("login con admin con su nueva contrasena...  ");
		User admin2 = new User();
		admin2.setName(admin.getName());
		admin2.setPwd("admin2");
		response = stub.login(admin2);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		System.out.print("User:Admin. Crea un nuevo usuario PEPE...  ");
		User pepe = new User();
		pepe.setName("pepe");
		pepe.setPwd("pepe");
		response = stub.addUser(pepe);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:Admin. Crea un nuevo usuario JOSE...  ");
		User jose = new User();
		jose.setName("jose");
		jose.setPwd("jose");
		response = stub.addUser(jose);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:Admin. Borra usuario JOSE...  ");
		Username username2 = new Username();
		username2.setUsername("jose");
		response = stub.removeUser(username2);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		
	}
}
