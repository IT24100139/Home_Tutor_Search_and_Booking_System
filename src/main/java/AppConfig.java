import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import service.FileService;
import service.TutorService;

@WebListener
public class AppConfig implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Initialize data files if they don't exist
        FileService.loadTutors();
        FileService.loadUsers();

        // Initialize BST with tutors
        new TutorService();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}
