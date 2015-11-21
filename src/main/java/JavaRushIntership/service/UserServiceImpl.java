package JavaRushIntership.service;


import JavaRushIntership.dao.UserDAO;
import JavaRushIntership.entity.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    private UserDAO userDAO;

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    @Transactional
    public void addUser(User user) {
        this.userDAO.addUser(user);
    }

    @Transactional
    public void removeUser(Integer id) {
        this.userDAO.removeUser(id);
    }

    @Transactional
    public void updateUser(User user) {
        this.userDAO.updateUser(user);
    }

    @Transactional
    public User getUserById(Integer id) {
        return this.userDAO.getUserById(id);
    }

    @Transactional
    public List<User> search(String searchText){
        return this.userDAO.search(searchText);
    }
}
