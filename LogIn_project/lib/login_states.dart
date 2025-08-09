abstract class BaseClass {}

class InitialState extends BaseClass {}

class LoadState extends BaseClass {}

class SuccessState extends BaseClass {
  String successMessage;
  SuccessState(this.successMessage);
}

class FailureState extends BaseClass {
  String faliureMessage;
  FailureState(this.faliureMessage);
}
