import '../../chat/repository/conversation_repository.dart';

import '../models/models.dart';

class ChatListBloc {
  Stream<List<ConversationModel>> getConversations({
    required String userId,
  }) {
    return ConversationsRepository.getInstance()
        .getConversations(userId: userId);
  }

  Stream<List<UserChatModel>> getUsers() {
    return ConversationsRepository.getInstance().getUsers();
  }

  Future<String> acceptRequest({required ConversationModel conversation}) {
    return ConversationsRepository.getInstance()
        .acceptRequest(conversation: conversation);
  }
}
