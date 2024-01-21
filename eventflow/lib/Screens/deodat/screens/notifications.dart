import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eventflow/widgets/deodat/widgets/notification_provider.dart';
import 'package:eventflow/widgets/deodat/widgets/welcome_notification.dart';

class PageNotification extends StatelessWidget {
  const PageNotification({Key? key});

  @override
  Widget build(BuildContext context) {
    // Liste de notifications simulées
    final List<WelcomeNotification> welcomeNotifications = [
      WelcomeNotification(
        titre: 'Bienvenue à EventFlow',
        message: 'Merci d\'avoir accepté nos conditions.',
      ),
      // Ajoutez d'autres notifications ici si nécessaire
    ];


    // Ajouter les notifications à la liste dans le fournisseur seulement si elles n'existent pas déjà
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: false);
    for (final notification in welcomeNotifications) {
      if (!notificationProvider.notifications.contains(notification)) {
        notificationProvider.ajouterNotification(notification);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Consumer<NotificationProvider>(
          builder: (context, notificationProvider, child) {
            return ListView.builder(
              itemCount: notificationProvider.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationProvider.notifications[index];

                // Utiliser la classe WelcomeNotification pour extraire les détails
                if (notification is WelcomeNotification) {
                  return ListTile(
                    title: Text(
                      notification.titre,
                      style: TextStyle(
                        fontWeight: notification.isRead
                            ? FontWeight.normal
                            : FontWeight.bold, // Gras si non lu
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.message,
                          style: TextStyle(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold, // Gras si non lu
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Marquer la notification comme lue
                      notificationProvider.marquerNotificationCommeLue(notification);

                      // Afficher les détails dans un AlertDialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(notification.titre),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(notification.message),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Fermer le dialogue
                                },
                                child: Text('Fermer'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                } else {
                  // Gérer d'autres types de notifications si nécessaire
                  return SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:event_flow/widgets/notification_provider.dart';
// import 'package:event_flow/widgets/welcome_notification.dart';

// class PageNotification extends StatelessWidget {
//   const PageNotification({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notifications'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Consumer<NotificationProvider>(
//               builder: (context, notificationProvider, child) {
//                 return Text(
//                   'Nombre de notifications non lues : ${notificationProvider.nombreNotificationsNonLues}',
//                   style: const TextStyle(fontSize: 18),
//                 );
//               },
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Ajoutez une nouvelle notification de bienvenue
//                 Provider.of<NotificationProvider>(context, listen: false)
//                     .ajouterNotification(
//                   WelcomeNotification(
//                     titre: 'Welcome to EventFlow',
//                     message:
//                         "Bienvenue chez EventFlow, merci d'avoir accepté nos conditions.",
//                   ),
//                 );
//               },
//               child: const Text('Ajouter une notification de bienvenue'),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Marquer toutes les notifications comme lues
//                 Provider.of<NotificationProvider>(context, listen: false)
//                     .marquerToutesCommeLues();
//               },
//               child: const Text('Marquer toutes comme lues'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
