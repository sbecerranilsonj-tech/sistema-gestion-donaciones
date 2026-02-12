package com.donaciones.conf;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    
    // Instancia única (Singleton)
    private static DatabaseConnection instance;
    private Connection connection;
    
    // Parámetros de conexión
    private static final String URL ="jdbc:mysql://localhost:3306/sistema_gestion_donaciones?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Cambia si tienes contraseña
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Constructor privado para evitar instanciación externa
    private DatabaseConnection() {
        try {
            // Cargar el driver de MySQL
            Class.forName(DRIVER);
            // Establecer la conexión
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexión exitosa a la base de datos");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: Driver no encontrado");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error al conectar con la base de datos");
            e.printStackTrace();
        }
    }
    
    // Método para obtener la instancia única (Singleton)
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }
    
    // Método para obtener la conexión
    public Connection getConnection() {
        try {
            // Verificar si la conexión está cerrada o es nula
            if (connection == null || connection.isClosed()) {
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener la conexión");
            e.printStackTrace();
        }
        return connection;
    }
    
    // Método para cerrar la conexión
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Conexión cerrada");
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión");
            e.printStackTrace();
        }
    }
    
    // Método para probar la conexión
    public boolean testConnection() {
        try {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            return false;
        }
    }
}
