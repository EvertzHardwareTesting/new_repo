import configparser


def get_variables(fileLocation):
    config = configparser.ConfigParser(delimiters='=')
    config.read(fileLocation)
    variables = {}
    for section in config.sections():
        for key, value in config.items(section):
            key = key.title()
            #print(value)
            variables[key] = value
    #print(variables)
    return variables

#get_variables()
