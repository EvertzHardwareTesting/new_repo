# class will trigger a Fatalerror in robotframework when it is called
class FatalError(RuntimeError):
    ROBOT_EXIT_ON_FAILURE = True
