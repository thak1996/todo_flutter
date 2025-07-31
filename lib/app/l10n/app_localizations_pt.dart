// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get titleApp => ' Aplicativo de Tarefas';

  @override
  String get welcomeBack => 'Bem vindo de volta!';

  @override
  String get email => 'Email';

  @override
  String get password => 'Senha';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get login => 'Entrar';

  @override
  String get dontHaveAccount => 'Não tem conta?';

  @override
  String get signUp => 'Registrar';

  @override
  String get requiredField => 'Campo obrigatório';

  @override
  String get invalidEmail => 'E-mail Inválido';

  @override
  String get passwordMinLength => 'Senha deve ter no mínimo 8 caracteres';

  @override
  String get switchToDarkMode => 'Modo Escuro';

  @override
  String get switchToLightMode => 'Modo Claro';

  @override
  String get createAccount => 'Criar Conta';

  @override
  String get name => 'Nome';

  @override
  String get alreadyHaveAccount => 'Já tem uma conta?';

  @override
  String get passwordsDoNotMatch => 'As senhas não conferem';

  @override
  String get confirmPassword => 'Confirmação de Senha';

  @override
  String get register => 'Registrar';

  @override
  String get nameMinLength => 'Nome precisa ter pelo menos 3 caracteres';

  @override
  String get errorNotFound => 'Recurso não encontrado';

  @override
  String get errorUnauthorized => 'Acesso não autorizado';

  @override
  String get errorNetwork => 'Erro de conexão';

  @override
  String get errorValidation => 'Dados inválidos';

  @override
  String get errorUnknown => 'Erro desconhecido';

  @override
  String get errorUserNotFound => 'Usuário não encontrado';

  @override
  String get addTask => 'Adicionar Tarefa';

  @override
  String get title => 'Título';

  @override
  String get titleRequired => 'Título Obrigatório';

  @override
  String get description => 'Descrição';

  @override
  String get group => 'Grupo';

  @override
  String get priorityLow => 'Baixa Prioridade';

  @override
  String get priorityMedium => 'Média Prioridade';

  @override
  String get priorityHigh => 'Alta Prioridade';

  @override
  String get priority => 'Prioridade';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Adicionar';

  @override
  String get todo => 'Tarefas';

  @override
  String get noTasksFound => 'Nenhuma tarefa encontrada.';

  @override
  String get newTask => 'Nova Tarefa';

  @override
  String get user => 'Usuário';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Configurações';

  @override
  String get logout => 'Sair';

  @override
  String get deleteTask => 'Excluir Tarefa';

  @override
  String get confirmDeleteTask => 'Tem certeza que deseja excluir esta tarefa?';

  @override
  String get delete => 'Excluir';

  @override
  String get editTask => 'Editar Tarefa';

  @override
  String get taskDeleted => 'Tarefa excluída!';

  @override
  String get taskEdited => 'Tarefa editada!';

  @override
  String get errorGoogleUserNotFound => 'Usuário do google não encontrado';

  @override
  String get loginWithGoogle => 'Login com o Google';

  @override
  String get groups => 'Grupos';

  @override
  String get createGroup => 'Criar Grupo';

  @override
  String get newGroup => 'Novo Grupo';

  @override
  String get groupName => 'Nome do grupo';

  @override
  String get create => 'Criar';

  @override
  String get logoutConfirmation => 'Tem certeza que deseja sair?';

  @override
  String get todoOptions => 'Opções da tarefa';

  @override
  String get chooseAction => 'Escolha uma ação';

  @override
  String get edit => 'Editar';

  @override
  String get noGroupsFound => 'Nenhum grupo encontrado.';

  @override
  String get authUserNotFound => 'Usuário não encontrado';

  @override
  String get authWrongPassword => 'Senha incorreta';

  @override
  String get authEmailAlreadyInUse => 'Este email já está sendo usado';

  @override
  String get authWeakPassword => 'A senha é muito fraca';

  @override
  String get authInvalidEmail => 'Email inválido';

  @override
  String get authTooManyRequests =>
      'Muitas tentativas. Tente novamente mais tarde';

  @override
  String get authUserDisabled => 'Esta conta foi desabilitada';

  @override
  String get authOperationNotAllowed => 'Operação não permitida';

  @override
  String get authInvalidCredential => 'Credenciais inválidas';

  @override
  String get authNetworkRequestFailed =>
      'Erro de conexão. Verifique sua internet';

  @override
  String get authRequiresRecentLogin => 'Esta operação requer login recente';

  @override
  String authUnknown(Object message) {
    return 'Erro de autenticação: $message';
  }
}
