# Rainmeter skin configurator

## Preview
![preview](preview/preview.png)

## Installing
* Download [last release](https://github.com/Findoss/Rainmeter-skin-configurator/releases)

## Using
Create file config.json ([demo](https://github.com/Findoss/Rainmeter-skin-configurator/blob/master/demo/configurator/config.json))

### INI file configurate
```
"pathConfigFile": String,  // path config file
"name": String,            // [optional] name config file
```

### Section
```
"section": [            // sections
  {
    "name": String,     // name section
    "inputs": [Objects] // inputs
  }
]
```

### Inputs

#### Input text
```
  "type": "input", 
  "key": String,         // key
  "discriotion": String, // [optional] discriotion
  "default": String      // [optional] default value
```

#### Password
```
  "type": "password", 
  "key": String,         // key
  "discriotion": String, // [optional] discriotion
  "default": String      // [optional] default value
```

#### Combo box
```
  "type": "combo", 
  "key": String,         // key
  "options": String,     // elements should split |
  "discriotion": String, // [optional] discriotion
  "default": String      // [optional] default element
```

#### Number
```
  "type": "number", 
  "key": String,         // key
  "discriotion": String, // [optional] discriotion
  "default": Number,     // [optional] default value
  "limit": {             // [optional] limit
    "min": Number,       // min value
    "max": Number        // max value
  }
```

#### Slider
```
  "type": "slider", 
  "key": String,         // key
  "discriotion": String, // [optional] discriotion
  "default": Number,     // [optional] default value
  "limit": {             // [optional] limit
    "min": Number,       // min value
    "max": Number        // max value
  }
```

#### Checkbox
```
  "type": "checkbox", 
  "key": String,         // key
  "discriotion": String, // [optional] discriotion
  "default": Number      // [optional] only 1 (TRUE) or 0 (FALSE)
```

### ! Limits
Configuration files = no limits  
Sections = 15 in file  
Inputs = 25 in section  
Discriotion lines = 2

## Plans
* Update combo box
* More type input (color, date)  
* Syfix and prefix  
[Read more](https://github.com/Findoss/Rainmeter-skin-configurator/projects)

## License
[MIT](https://github.com/Findoss/Rainmeter-skin-configurator/blob/master/LICENSE.txt). Copyright (c) [Findoss](https://github.com/Findoss).