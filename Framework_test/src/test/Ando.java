package test;

import annotation.Controller;
import annotation.Route;
// import view.ModelView;

@Controller
public class Ando {
    @Route(url = "/ando")
    public String ando() {
        return "ando";
    }

    // @Route(url = "testView")
    // public ModelView testView() {
    //     ModelView mv = new ModelView("a.jsp");
    //     mv.addData("Nom", "Miaritsoa");
    //     return mv;
    // }
}
