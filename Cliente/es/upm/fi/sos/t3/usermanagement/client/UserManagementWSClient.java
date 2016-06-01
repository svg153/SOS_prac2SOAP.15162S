package es.upm.fi.sos.t3.usermanagement.client;

import java.rmi.RemoteException;
import es.upm.fi.sos.t3.usermanagement.client.UserManagementWSStub.*;

public class UserManagementWSClient {
	
	static Response response;
	static UserManagementWSStub stub; 
	
	
	
	
	public static void main(String[] args) throws RemoteException {
		
		
		boolean res;
		
		
		// creamos el stub
		stub = new UserManagementWSStub();
		
		// hacemos que el stub mantega la conexion
        stub._getServiceClient().engageModule("addressing");
        stub._getServiceClient().getOptions().setManageSession(true);

        
        
        //
        // VARS
        //
        
        User admin = new User();
        admin.setName("admin");
        admin.setPwd("admin");
        Username adminUsername = new Username();
        adminUsername.setUsername("admin");
        
        User paco = new User();
        paco.setName("paco");
        paco.setPwd("paco");
        Username pacoUsername = new Username();
        pacoUsername.setUsername("paco");
        
        //
        // PRUEBAS
        //
        
		System.out.print("login with admin... TRUE =?=... ");
		response = stub.login(admin);
		res = response.getResponse();
		System.out.print(res);
		System.out.println("\n");
		
		System.out.println("Un vez echo el login, intentamos cambiar la contraseña... TRUE =?=... ");
		PasswordPair passwordPair5 = new PasswordPair();
		passwordPair5.setOldpwd("admin");
		passwordPair5.setNewpwd("admin2");	
		response = stub.changePassword(passwordPair5);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		System.out.print("logout with admin...  ");
		stub.logout();
		System.out.println("\n");
		
		System.out.print("login con admin Old...  FALSE =?=...");
		response = stub.login(admin);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		System.out.print("logout, intentamos cambiar la contraseña... FALSE =?=... ");
		response = stub.changePassword(passwordPair5);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("logout con admin...  ");
		stub.logout();
		System.out.println("\n");
		
		
		System.out.print("login con admin con su nueva contrasena...  TRUE =?=.. ");
		User admin2 = new User();
		admin2.setName(admin.getName());
		admin2.setPwd("admin2");
		response = stub.login(admin2);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:Admin. Crea un nuevo usuario PEPE... TRUE =?=... ");
		User pepe = new User();
		pepe.setName("pepe");
		pepe.setPwd("pepe");
		response = stub.addUser(pepe);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:Admin. Crea un nuevo usuario JOSE... TRUE =?=... ");
		User jose = new User();
		jose.setName("jose");
		jose.setPwd("jose");
		response = stub.addUser(jose);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:Admin. Crea un nuevo usuario PEPE existente... FALSE =?=... ");
		response = stub.addUser(pepe);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:Admin. Borra usuario JOSE... TRUE =?=... ");
		Username username2 = new Username();
		username2.setUsername("jose");
		response = stub.removeUser(username2);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("logout con admin...  ");
		stub.logout();
		System.out.println("\n");
		
		
		System.out.print("User:JOSE. login JOSE... TRUE =?=... ");
		response = stub.login(pepe);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		System.out.print("User:JOSE. addUser PACO... FALSE =?=... ");
		response = stub.addUser(pepe);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		System.out.print("User:JOSE. addUser ADMIN... FALSE =?=... ");
		response = stub.addUser(admin);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		System.out.print("User:JOSE. removeUser ADMINUSERNAME... FALSE =?=... ");
		response = stub.removeUser(adminUsername);
		res = response.getResponse();
		System.out.println(res+"\n");
		
		
		
		
	}
	
	
	
	//
	// FUNCs
	//
	
	/**
	 * 
	 */
	
	
	
	
	
	
}
