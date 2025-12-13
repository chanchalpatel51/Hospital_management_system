package com.util;

import java.io.InputStream;
import java.util.Properties;

/**
 * Database configuration utility class.
 * Reads configuration from db.properties file with fallback to environment variables.
 * Priority: Environment Variables > db.properties file > Default values
 * This allows the application to work both locally and on cloud platforms like Render/TiDB.
 */
public class DBConnect {
    
    private static Properties properties = new Properties();
    
    // Static block to load properties file
    static {
        try (InputStream input = DBConnect.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input != null) {
                properties.load(input);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Database configuration
    public static final String DB_HOST = getProperty("DB_HOST", "localhost");
    public static final String DB_PORT = getProperty("DB_PORT", "3306");
    public static final String DB_NAME = getProperty("DB_NAME", "hospital_management_system");
    public static final String DB_USER = getProperty("DB_USER", "root");
    public static final String DB_PASSWORD = getProperty("DB_PASSWORD", "root");
    public static final String DB_DRIVER = getProperty("DB_DRIVER", "com.mysql.cj.jdbc.Driver");
    
    // SSL Configuration for TiDB Cloud
    public static final boolean DB_SSL = getPropertyAsBoolean("DB_SSL", false);
    public static final String DB_SSL_MODE = getProperty("DB_SSL_MODE", "DISABLED");
    
    // Connection pool settings
    public static final int DB_MAX_POOL_SIZE = getPropertyAsInt("DB_MAX_POOL_SIZE", 10);
    public static final int DB_CONNECTION_TIMEOUT = getPropertyAsInt("DB_CONNECTION_TIMEOUT", 30000);
    
    // Construct the full database URL with SSL support for TiDB
    public static final String DB_URL = buildDatabaseUrl();
    
    /**
     * Builds the database URL with appropriate SSL settings
     * For TiDB Cloud, SSL is required for secure connections
     * @return The complete JDBC URL
     */
    private static String buildDatabaseUrl() {
        StringBuilder url = new StringBuilder();
        url.append("jdbc:mysql://").append(DB_HOST).append(":").append(DB_PORT).append("/").append(DB_NAME);
        
        // Add SSL parameters if SSL is enabled (required for TiDB Cloud)
        if (DB_SSL) {
            url.append("?useSSL=true");
            url.append("&requireSSL=true");
            // Use verifyServerCertificate=false to avoid certificate issues with TiDB Cloud
            url.append("&verifyServerCertificate=false");
            url.append("&enabledTLSProtocols=TLSv1.2,TLSv1.3");
            url.append("&allowPublicKeyRetrieval=true");
        } else {
            url.append("?useSSL=false");
            url.append("&allowPublicKeyRetrieval=true");
        }
        
        // Common parameters for both local and production
        url.append("&serverTimezone=UTC");
        url.append("&useUnicode=true");
        url.append("&characterEncoding=UTF-8");
        url.append("&autoReconnect=true");
        url.append("&createDatabaseIfNotExist=true");
        
        return url.toString();
    }
    
    /**
     * Gets a property value with priority: Environment Variable > Properties File > Default Value
     * @param key The property name
     * @param defaultValue The default value if not found
     * @return The property value
     */
    public static String getProperty(String key, String defaultValue) {
        // First check environment variable
        String envValue = System.getenv(key);
        if (envValue != null && !envValue.isEmpty()) {
            return envValue;
        }
        // Then check properties file
        String propValue = properties.getProperty(key);
        if (propValue != null && !propValue.isEmpty()) {
            return propValue;
        }
        // Return default value
        return defaultValue;
    }
    
    /**
     * Gets a property value, returns null if not found
     * @param key The property name
     * @return The property value or null
     */
    public static String getProperty(String key) {
        String envValue = System.getenv(key);
        if (envValue != null && !envValue.isEmpty()) {
            return envValue;
        }
        return properties.getProperty(key);
    }
    
    /**
     * Gets an integer property with a fallback default.
     * @param key The property name
     * @param defaultValue The default value if not found or invalid
     * @return The property value as integer or the default value
     */
    public static int getPropertyAsInt(String key, int defaultValue) {
        String value = getProperty(key);
        if (value != null && !value.isEmpty()) {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                return defaultValue;
            }
        }
        return defaultValue;
    }
    
    /**
     * Gets a boolean property with a fallback default.
     * @param key The property name
     * @param defaultValue The default value if not found
     * @return The property value as boolean or the default value
     */
    public static boolean getPropertyAsBoolean(String key, boolean defaultValue) {
        String value = getProperty(key);
        if (value != null && !value.isEmpty()) {
            return Boolean.parseBoolean(value);
        }
        return defaultValue;
    }
}
