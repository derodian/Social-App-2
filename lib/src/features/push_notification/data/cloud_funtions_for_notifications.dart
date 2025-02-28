// TODO: this is index.js file for cloud functions for notifications


// const functions = require('firebase-functions');
// const admin = require('firebase-admin');
// admin.initializeApp();

// /**
//  * Send notification for new community event
//  */
// exports.notifyNewEvent = functions.firestore
//   .document('events/{eventId}')
//   .onCreate(async (snapshot, context) => {
//     const eventData = snapshot.data();
//     const eventId = context.params.eventId;
    
//     if (!eventData) {
//       console.log('No event data found');
//       return null;
//     }
    
//     try {
//       // Prepare notification message
//       const message = {
//         notification: {
//           title: 'New Community Event',
//           body: eventData.title || 'Check out this new event!',
//         },
//         data: {
//           type: 'event',
//           id: eventId,
//           category: 'events',
//           timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//         },
//         topic: 'events', // Send to all devices subscribed to events topic
//       };
      
//       // Send the notification
//       const response = await admin.messaging().send(message);
//       console.log('Successfully sent event notification:', response);
//       return response;
//     } catch (error) {
//       console.error('Error sending event notification:', error);
//       return null;
//     }
//   });

// /**
//  * Send notification for new album
//  */
// exports.notifyNewAlbum = functions.firestore
//   .document('albums/{albumId}')
//   .onCreate(async (snapshot, context) => {
//     const albumData = snapshot.data();
//     const albumId = context.params.albumId;
    
//     if (!albumData) {
//       console.log('No album data found');
//       return null;
//     }
    
//     try {
//       // Get photo count
//       const photoCount = albumData.photoCount || 0;
      
//       // Prepare notification message
//       const message = {
//         notification: {
//           title: 'New Photo Album',
//           body: `${albumData.title || 'New album'} - ${photoCount} photos`,
//         },
//         data: {
//           type: 'album',
//           id: albumId,
//           category: 'albums',
//           timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//         },
//         topic: 'albums', // Send to all devices subscribed to albums topic
//       };
      
//       // Send the notification
//       const response = await admin.messaging().send(message);
//       console.log('Successfully sent album notification:', response);
//       return response;
//     } catch (error) {
//       console.error('Error sending album notification:', error);
//       return null;
//     }
//   });

// /**
//  * Send notification for new community news
//  */
// exports.notifyNewNews = functions.firestore
//   .document('news/{newsId}')
//   .onCreate(async (snapshot, context) => {
//     const newsData = snapshot.data();
//     const newsId = context.params.newsId;
    
//     if (!newsData) {
//       console.log('No news data found');
//       return null;
//     }
    
//     try {
//       // Prepare notification message
//       const message = {
//         notification: {
//           title: 'Community News',
//           body: newsData.title || 'New announcement from your community',
//         },
//         data: {
//           type: 'news',
//           id: newsId,
//           category: 'communityNews',
//           timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//         },
//         topic: 'communitynews', // Send to all devices subscribed to this topic
//       };
      
//       // Send the notification
//       const response = await admin.messaging().send(message);
//       console.log('Successfully sent news notification:', response);
//       return response;
//     } catch (error) {
//       console.error('Error sending news notification:', error);
//       return null;
//     }
//   });

// /**
//  * Send notification when a user is mentioned in a comment
//  */
// exports.notifyUserMention = functions.firestore
//   .document('comments/{commentId}')
//   .onCreate(async (snapshot, context) => {
//     const commentData = snapshot.data();
//     const commentId = context.params.commentId;
    
//     if (!commentData || !commentData.mentions || !commentData.mentions.length) {
//       console.log('No mentions found in comment');
//       return null;
//     }
    
//     try {
//       // For each mentioned user, send a notification
//       const mentionedUsers = commentData.mentions;
//       const commenterName = commentData.authorName || 'Someone';
//       const parentType = commentData.parentType || 'post';
//       const parentId = commentData.parentId;
      
//       // Batch notification promises
//       const notificationPromises = mentionedUsers.map(async (userId) => {
//         // Get user's tokens
//         const userTokens = await admin.firestore()
//           .collection('device_tokens')
//           .where('userId', '==', userId)
//           .where('notificationsEnabled', '==', true)
//           .get();
          
//         if (userTokens.empty) {
//           console.log(`No active tokens found for user ${userId}`);
//           return null;
//         }
        
//         // Get all token strings
//         const tokens = [];
//         userTokens.forEach(doc => {
//           tokens.push(doc.data().token);
//         });
        
//         // Skip if no tokens
//         if (tokens.length === 0) return null;
        
//         // Create message
//         const message = {
//           notification: {
//             title: 'You were mentioned',
//             body: `${commenterName} mentioned you in a comment`,
//           },
//           data: {
//             type: parentType,
//             id: parentId,
//             commentId: commentId,
//             category: 'comments',
//             timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//           },
//           tokens: tokens,
//         };
        
//         // Send to all user's devices
//         return admin.messaging().sendMulticast(message);
//       });
      
//       // Execute all notifications
//       await Promise.all(notificationPromises);
//       console.log('Successfully sent mention notifications');
//       return null;
//     } catch (error) {
//       console.error('Error sending mention notifications:', error);
//       return null;
//     }
//   });

// /**
//  * Send notification for direct message
//  */
// exports.notifyDirectMessage = functions.firestore
//   .document('messages/{messageId}')
//   .onCreate(async (snapshot, context) => {
//     const messageData = snapshot.data();
    
//     if (!messageData || !messageData.recipientId) {
//       console.log('No valid message data found');
//       return null;
//     }
    
//     try {
//       const recipientId = messageData.recipientId;
//       const senderId = messageData.senderId;
//       const conversationId = messageData.conversationId;
      
//       // Don't send notification for system messages
//       if (senderId === 'system') return null;
      
//       // Get sender info
//       const senderDoc = await admin.firestore()
//         .collection('users')
//         .doc(senderId)
//         .get();
      
//       if (!senderDoc.exists) {
//         console.log('Sender not found');
//         return null;
//       }
      
//       const senderName = senderDoc.data().displayName || 'Someone';
      
//       // Get recipient tokens
//       const recipientTokens = await admin.firestore()
//         .collection('device_tokens')
//         .where('userId', '==', recipientId)
//         .where('notificationsEnabled', '==', true)
//         .get();
        
//       if (recipientTokens.empty) {
//         console.log(`No active tokens found for recipient ${recipientId}`);
//         return null;
//       }
      
//       // Get all token strings
//       const tokens = [];
//       recipientTokens.forEach(doc => {
//         tokens.push(doc.data().token);
//       });
      
//       // Create message content - truncate if too long
//       let messageContent = messageData.text || '';
//       if (messageContent.length > 100) {
//         messageContent = messageContent.substring(0, 97) + '...';
//       }
      
//       // Create message
//       const notificationMessage = {
//         notification: {
//           title: `Message from ${senderName}`,
//           body: messageContent,
//         },
//         data: {
//           type: 'message',
//           id: conversationId,
//           senderId: senderId,
//           category: 'directMessages',
//           timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//         },
//         tokens: tokens,
//       };
      
//       // Send to all recipient's devices
//       const response = await admin.messaging().sendMulticast(notificationMessage);
//       console.log('Successfully sent message notification:', response);
//       return response;
//     } catch (error) {
//       console.error('Error sending message notification:', error);
//       return null;
//     }
//   });

// /**
//  * Send notification for comment on user's content
//  */
// exports.notifyContentComment = functions.firestore
//   .document('comments/{commentId}')
//   .onCreate(async (snapshot, context) => {
//     const commentData = snapshot.data();
    
//     if (!commentData || !commentData.parentId || !commentData.parentAuthorId) {
//       console.log('No valid comment data found');
//       return null;
//     }
    
//     try {
//       // Skip if commenter is the same as content author
//       if (commentData.authorId === commentData.parentAuthorId) {
//         console.log('Author commenting on own content - skipping notification');
//         return null;
//       }
      
//       const parentId = commentData.parentId;
//       const parentType = commentData.parentType || 'post';
//       const parentAuthorId = commentData.parentAuthorId;
//       const commenterName = commentData.authorName || 'Someone';
      
//       // Get recipient tokens
//       const recipientTokens = await admin.firestore()
//         .collection('device_tokens')
//         .where('userId', '==', parentAuthorId)
//         .where('notificationsEnabled', '==', true)
//         .get();
        
//       if (recipientTokens.empty) {
//         console.log(`No active tokens found for recipient ${parentAuthorId}`);
//         return null;
//       }
      
//       // Get all token strings
//       const tokens = [];
//       recipientTokens.forEach(doc => {
//         tokens.push(doc.data().token);
//       });
      
//       // Determine type-specific content
//       let title = 'New Comment';
//       let body = `${commenterName} commented on your post`;
      
//       if (parentType === 'photo') {
//         title = 'New Photo Comment';
//         body = `${commenterName} commented on your photo`;
//       } else if (parentType === 'album') {
//         title = 'New Album Comment';
//         body = `${commenterName} commented on your album`;
//       }
      
//       // Create message
//       const notificationMessage = {
//         notification: {
//           title: title,
//           body: body,
//         },
//         data: {
//           type: parentType,
//           id: parentId,
//           commentId: context.params.commentId,
//           category: 'comments',
//           timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//         },
//         tokens: tokens,
//       };
      
//       // Send to all recipient's devices
//       const response = await admin.messaging().sendMulticast(notificationMessage);
//       console.log('Successfully sent comment notification:', response);
//       return response;
//     } catch (error) {
//       console.error('Error sending comment notification:', error);
//       return null;
//     }
//   });

// /**
//  * Clean up old device tokens (inactive for more than 60 days)
//  * Run daily at midnight
//  */
// exports.cleanupOldDeviceTokens = functions.pubsub
//   .schedule('every 24 hours')
//   .onRun(async (context) => {
//     try {
//       const cutoffTime = admin.firestore.Timestamp.fromMillis(
//         Date.now() - (60 * 24 * 60 * 60 * 1000) // 60 days ago
//       );
      
//       const oldTokensSnapshot = await admin.firestore()
//         .collection('device_tokens')
//         .where('lastActiveAt', '<', cutoffTime)
//         .get();
      
//       if (oldTokensSnapshot.empty) {
//         console.log('No old tokens to clean up');
//         return null;
//       }
      
//       console.log(`Found ${oldTokensSnapshot.size} old tokens to clean up`);
      
//       // Delete in batches of 500 (maximum batch size)
//       const batches = [];
//       let batch = admin.firestore().batch();
//       let operationCount = 0;
      
//       oldTokensSnapshot.forEach(doc => {
//         batch.delete(doc.ref);
//         operationCount++;
        
//         if (operationCount === 500) {
//           batches.push(batch);
//           batch = admin.firestore().batch();
//           operationCount = 0;
//         }
//       });
      
//       // Push final batch if it has operations
//       if (operationCount > 0) {
//         batches.push(batch);
//       }
      
//       // Commit all batches
//       await Promise.all(batches.map(batch => batch.commit()));
      
//       console.log(`Successfully removed ${oldTokensSnapshot.size} old device tokens`);
//       return null;
//     } catch (error) {
//       console.error('Error cleaning up old device tokens:', error);
//       return null;
//     }
//   });

// /**
//  * HTTP endpoint for sending targeted notifications to specific users
//  * Requires authentication with admin privileges
//  */
// exports.sendUserNotification = functions.https.onCall(async (data, context) => {
//   // Check if the user has admin permissions
//   if (!context.auth) {
//     throw new functions.https.HttpsError(
//       'unauthenticated',
//       'You must be logged in to send notifications'
//     );
//   }
  
//   // Verify admin status
//   const adminDoc = await admin.firestore()
//     .collection('users')
//     .doc(context.auth.uid)
//     .get();
    
//   if (!adminDoc.exists || !adminDoc.data().isAdmin) {
//     throw new functions.https.HttpsError(
//       'permission-denied',
//       'Only administrators can send manual notifications'
//     );
//   }
  
//   // Validate input
//   const { userId, title, body, data: notificationData } = data;
  
//   if (!userId) {
//     throw new functions.https.HttpsError(
//       'invalid-argument',
//       'User ID is required'
//     );
//   }
  
//   if (!title || !body) {
//     throw new functions.https.HttpsError(
//       'invalid-argument',
//       'Notification title and body are required'
//     );
//   }
  
//   try {
//     // Get user's tokens
//     const userTokens = await admin.firestore()
//       .collection('device_tokens')
//       .where('userId', '==', userId)
//       .where('notificationsEnabled', '==', true)
//       .get();
      
//     if (userTokens.empty) {
//       return {
//         success: false,
//         message: 'No active devices found for this user'
//       };
//     }
    
//     // Get all token strings
//     const tokens = [];
//     userTokens.forEach(doc => {
//       tokens.push(doc.data().token);
//     });
    
//     // Prepare data payload
//     const dataPayload = {
//       ...notificationData,
//       timestamp: admin.firestore.Timestamp.now().toMillis().toString(),
//     };
    
//     // Create message
//     const message = {
//       notification: {
//         title: title,
//         body: body,
//       },
//       data: dataPayload,
//       tokens: tokens,
//     };
    
//     // Send the notification
//     const response = await admin.messaging().sendMulticast(message);
    
//     // Log success
//     console.log(`Admin ${context.auth.uid} sent notification to user ${userId}`);
    
//     // Return success details
//     return {
//       success: true,
//       successCount: response.successCount,
//       failureCount: response.failureCount,
//     };
//   } catch (error) {
//     console.error('Error sending manual notification:', error);
//     throw new functions.https.HttpsError(
//       'internal',
//       'Failed to send notification: ' + error.message
//     );
//   }
// });