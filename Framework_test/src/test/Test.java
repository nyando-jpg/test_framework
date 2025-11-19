package test;

import annotation.Controller;
import annotation.Route;
// import view.ModelView;

@Controller
public class Test {
    @Route(url = "/test")
    public String test() {
        return "test";
    }

    // @Route(url = "testView")
    // public ModelView testView() {
    //     ModelView mv = new ModelView("a.jsp");
    //     mv.addData("Nom", "Miaritsoa");
    //     return mv;
    // }
}
