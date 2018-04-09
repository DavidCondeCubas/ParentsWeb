package controladores;

import ParentWeb.DBConect;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CerrarLogin {
    
    @RequestMapping(value="/cerrarLogin")
    public ModelAndView cerrarLogin(HttpServletRequest hsr, HttpServletResponse hsr1) throws Exception {
            ModelAndView mv =  new ModelAndView("redirect:/userform.htm?opcion=inicio");
            DBConect.close();
            HttpSession sesion = hsr.getSession(false);
            sesion.invalidate();
            return mv;
    }

}
