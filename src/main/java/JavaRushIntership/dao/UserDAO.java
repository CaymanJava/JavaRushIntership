package JavaRushIntership.dao;

import JavaRushIntership.entity.User;
import java.util.List;

public interface UserDAO {

    void addUser(User user);

    void removeUser(Integer id);

    void updateUser(User user);

    User getUserById(Integer id);

    List<User> search(String searchText);
}
