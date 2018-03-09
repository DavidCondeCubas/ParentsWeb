package controladores;

import Montessori.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SessionCheck {
    public boolean checkSession(HttpServletRequest hsr){
               
       HttpSession sesion = hsr.getSession();
       return sesion.getAttribute("user")==null;
    } 
}
