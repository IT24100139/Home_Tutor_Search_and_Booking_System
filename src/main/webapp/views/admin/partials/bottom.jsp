<%--
  Created by IntelliJ IDEA.
  User: isu23
  Date: 5/11/2025
  Time: 6:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

         </div>
        </main>
    </div>
    <!-- Footer
    <footer class="mt-8 border-t bg-white">
    <div class="container mx-auto px-6 py-4 text-center text-gray-600">
    <p>© 2025 Zentutor.lk. All rights reserved.</p>
    </div>
    </footer> -->
    <script>
        // Navigation handling
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('href').substring(1);
                document.querySelectorAll('.content-section').forEach(section => {
                    section.classList.add('hidden');
                });
                document.getElementById(targetId).classList.remove('hidden');
            });
        });

        // Show dashboard by default
        document.getElementById('dashboard').classList.remove('hidden');
    </script>
    </body>
</html>