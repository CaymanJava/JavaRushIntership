package JavaRushIntership;


import JavaRushIntership.entity.User;
import JavaRushIntership.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import java.sql.Date;
import java.util.List;

@Controller
public class UserController {

    private UserService userService;
    private Paging paging;

    @Autowired(required = true)
    @Qualifier(value = "userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    @Autowired(required = true)
    @Qualifier(value = "pager")
    public void setUserService(Paging paging) {
        this.paging = paging;
    }


    @ModelAttribute("pageProperty")
    public Paging createModel() {
        return this.paging;
    }

    @RequestMapping(value = "/users")
    public String listUsers(@ModelAttribute("pageProperty") Paging paging, Model model) {
        User user = new User();
        user.setName(null);
        user.setAge(null);
        user.setIsAdmin(false);
        user.setCreatedDate(new Date(System.currentTimeMillis()));
        model.addAttribute("user", user);

        List<User> ul = userService.search(paging.getNameFilter());
        Integer pageNumber = paging.getPageNumber();
        PagedListHolder<User> pagedListHolder = new PagedListHolder<User>(ul);

        pagedListHolder.setPageSize(paging.getPageSize());

        if (pageNumber == null || (pageNumber - 1) < 1 || pageNumber > pagedListHolder.getPageCount()) {
            paging.setPageNumber(1);
            pagedListHolder.setPage(0);
            model.addAttribute("listUsers", pagedListHolder.getPageList());
        } else if (pageNumber <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(pageNumber - 1);
            model.addAttribute("listUsers", pagedListHolder.getPageList());
        }
        paging.setSize(pagedListHolder.getPageCount());

        model.addAttribute("pageProperty", paging);
        return "allUsers";
    }


    @RequestMapping("/")
    public String homePage(@ModelAttribute("pageProperty") Paging paging) {
        paging.setPageNumber(1);
        paging.setNameFilter("");
        return "redirect:/users";
    }

    @RequestMapping(value = "/user/add", method = RequestMethod.POST)
    public String addUser(@ModelAttribute("user") User user) {
        if (user.getId() == 0) {
            this.userService.addUser(user);
        } else {
            this.userService.updateUser(user);
        }
        return "redirect:/users";
    }

    @RequestMapping("/remove/{id}")
    public String deleteUser(@PathVariable("id") Integer id) {
        this.userService.removeUser(id);
        return "redirect:/users";
    }

    @RequestMapping("/edit/{id}")
    public String updateUser(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("user", userService.getUserById(id));
        model.addAttribute("listUsers", this.userService.search(""));
        return "allUsers";
    }
}
