package JavaRushIntership.dao;

import JavaRushIntership.entity.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public class UserDAOImpl implements UserDAO {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sf) {
        this.sessionFactory = sf;
    }

    public void addUser(User user) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(user);
    }

    public void removeUser(Integer id) {
        User user =  sessionFactory.getCurrentSession().load(User.class, id);
        if (null != user) {
            sessionFactory.getCurrentSession().delete(user);
        }
    }

    public void updateUser(User user) {
        sessionFactory.getCurrentSession().update(user);
    }

    public User getUserById(Integer id) {
        return this.sessionFactory.getCurrentSession().load(User.class, id);
    }

    @SuppressWarnings("unchecked")
    public List<User> search(String searchText) {
        Session session = sessionFactory.getCurrentSession();
        if (searchText == null || searchText.isEmpty()) {
            return session.createQuery("from User").list();
        }
        String query = "select * from user where name like '%"+searchText+"%'";
        return sessionFactory.getCurrentSession().createSQLQuery(query).addEntity(User.class).list();
    }

}

