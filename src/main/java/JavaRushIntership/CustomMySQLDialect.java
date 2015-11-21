package JavaRushIntership;

import org.hibernate.dialect.MySQL5InnoDBDialect;

public class CustomMySQLDialect extends MySQL5InnoDBDialect {


    public String getTableTypeString(){
        return " ENGINE=InnoDB DEFAULT CHARSET=utf8";
    }
}