import 'package:tecnonautas_app/core/models/trivia.dart';
// 
  // final String id;  
  // final String name;
  // final String category;
  // final String description;
  // final int points;
  // final int qtyPreg;
  // final bool fav;
  // final bool isActive;
// 
  // final Map<String, int> qtyResp;
  // final Map<String, int> questionTime;
  // final List<String> questions;
  // final Map<String, String> respCorrect;
  // final Map<String, Map<String, String>> responses;

List<Trivia> localTrivias = [
  Trivia(
    id: "1",
    name: "Redes",
    category: "Informática y Tecnología",
    description: "Conceptos básicos de redes y redes de computadoras",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
    },
    questions: [
      "Viendo una red entera, los puntos transmisor y receptor, ¿a qué corresponderían?",
      "Los cables que unen varias computadoras en un Café Internet, para tener acceso a Internet, ¿Qué elemento son?",
      "¿Cuál es el tamaño máximo que puede tener una red?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Nodos",
        "resp01": "Conexiones",
        "resp02": "Cables",
        "resp03": "Conectores"
      },
      "question1": {
        "resp10": "Receptor",
        "resp11": "Mensaje",
        "resp12": "Medio",
        "resp13": "Transmisor"
      },
      "question2": {
        "resp20": "De alrededor de 1 Km",
        "resp21": "Solamente en un edificio",
        "resp22": "No tiene límite",
        "resp23": "Solamente dentro de un pais"
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp12",
      "question2": "resp22",
    }
  ),
  Trivia(
    id: "2",
    name: "Tipos de Redes",
    category: "Informática y Tecnología",
    description: "Tipos de redes de Telecomunicaciones - clasificación",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
    },
    questions: [
      "¿Qué tipo de red sería una red que abarca la ciudad de La Paz?",
      "¿Cuál es el elemento que nos ayuda a comunicar una red con otra diferente, y dirige el tráfico de información?",
      "¿Qué crees que utilizan Youtube y Facebook para poder guardar todos los videos, fotos e información de sus usuarios?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "LAN",
        "resp01": "PAN",
        "resp02": "WAN",
        "resp03": "MAN"
      },
      "question1": {
        "resp10": "Cable",
        "resp11": "Conector",
        "resp12": "Router",
        "resp13": "Computadora"
      },
      "question2": {
        "resp20": "Cables",
        "resp21": "Servidores",
        "resp22": "Clientes",
        "resp23": "Medios"
      }
    },
    respCorrect: {
      "question0": "resp04",
      "question1": "resp13",
      "question2": "resp21",
    }
  ),
  Trivia(
    id: "3",
    name: "Sist. Op de Red",
    category: "Informática y Tecnología",
    description: "Toplologías de una red, y características de sistema operativo de red",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
    },
    questions: [
      "¿Cual crees que será la topología más resistente a un corte en alguna conexión de la red?",
      "¿Cuál red crees que es la más fácil de implementar? (La que no requiera programación para conseguir la conectividad entre todos)",
      "¿El sistema operativo de un enrutador, que función principal tendrá?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Malla",
        "resp01": "Anillo",
        "resp02": "Estrella",
        "resp03": "Árbol"
      },
      "question1": {
        "resp10": "Malla",
        "resp11": "Anillo",
        "resp12": "Estrella",
        "resp13": "Árbol"
      },
      "question2": {
        "resp20": "Permitir que podamos acceder a los programas como Word",
        "resp21": "Permitir que instalemos la red",
        "resp22": "Configurar los equipos transmisores y receptores",
        "resp23": "Ejecutar los algoritmos para definir las mejores rutas para cada caso"
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp12",
      "question2": "resp23",
    }
  ),
  Trivia(
    id: "4",
    name: "Cableado estructurado - Intro",
    category: "Informática y Tecnología",
    description: "Cableado estructurado, utilidad y velocidad de transmisión",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
    },
    questions: [
      "¿Cual tipo de cable permitirá una transmisión de mayor cantidad de datos?",
      "¿Cuánta información puedo transmitir cada minuto, si dispongo de una conexión con velocidad de 10 Mbps?",
      "¿Cuánto tiempo tardaré en transmitir un archivo de video de 75000000 bits, si tengo una conexión de 2 Mbps?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 60
    },
    responses: {
      "question0": {
        "resp00": "UTP Cat 6",
        "resp01": "Fibra Óptica",
        "resp02": "Cable Coaxial",
        "resp03": "UTP Cat 5"
      },
      "question1": {
        "resp10": "600 Megabits",
        "resp11": "600 Kilobits",
        "resp12": "60 Megabits",
        "resp13": "600 Bits"
      },
      "question2": {
        "resp20": "37.5 segundos",
        "resp21": "75 segundos",
        "resp22": "150 segundos",
        "resp23": "7.5 segundos"
      }
    },
    respCorrect: {
      "question0": "resp01",
      "question1": "resp10",
      "question2": "resp20",
    }
  ),
  Trivia(
    id: "5",
    name: "Relacion entre angulos",
    category: "Matemáticas",
    description: "Clasificación de angulos, depende de su sumatoria o el grado que tiene",
    points: 10,
    qtyPreg: 4,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
      "question3": 4,
    },
    questions: [
      "¿Que numero es 316 en radianes ?",
      "¿cual es el tipo de angulo que al sumar dos angulos nos da 90 grados?",
      "¿cual es el tipo de angulo que al sumar dos angulos nos da 360 grados?",
      "¿cual es el tipo de angulo que al sumar dos angulos nos da 180 grados?"
    ],
    questionTime: {
      "question0": 90,
      "question1": 30,
      "question2": 30,
      "question3": 30,
    },
    responses: {
      "question0": {
        "resp00": "115 rad",
        "resp01": "72 rad",
        "resp02": "79/45 rad",
        "resp03": "54 rad"
      },
      "question1": {
        "resp10": "Suplementario",
        "resp11": "Complementario",
        "resp12": "Conjugado",
        "resp13": "Consecutivos"
      },
      "question2": {
        "resp20": "Conjugado",
        "resp21": "Suplementario",
        "resp22": "Consecutivo",
        "resp23": "Complementario"
      },
      "question3": {
        "resp30": "Consecutivos",
        "resp31": "Complementario",
        "resp32": "Conjugado",
        "resp33": "Suplementario",
      }
    },
    respCorrect: {
      "question0": "resp02",
      "question1": "resp11",
      "question2": "resp20",
      "question3": "resp33",
    }
  ),
  Trivia(
    id: "6",
    name: "Numeros reales",
    category: "Matemáticas",
    description: "Operaciones mixtas de numero reales",
    points: 10,
    qtyPreg: 4,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
      "question3": 4,
    },
    questions: [
      "¿Cual es el resultado de 4(-7+9)+8?",
      "¿Cual es el resultado de(3+1/4)-(2+1/6)?",
      "¿Cual es el resultado de 3+5x2?",
      "¿Cual es el resultado de (4+5)/9?"
    ],
    questionTime: {
      "question0": 90,
      "question1": 90,
      "question2": 90,
      "question3": 90
    },
    responses: {
      "question0": {
        "resp00": "10",
        "resp01": "0",
        "resp02": "13",
        "resp03": "11"
      },
      "question1": {
        "resp10": "15/26",
        "resp11": "13/12",
        "resp12": "-2",
        "resp13": "44"
      },
      "question2": {
        "resp20": "34.72",
        "resp21": "24.6",
        "resp22": "13",
        "resp23": "54"
      },
      "question3": {
        "resp30": "2.5",
        "resp31": "1",
        "resp32": "3",
        "resp33": "4.5"
      }
    },
    respCorrect: {
      "question0": "resp01",
      "question1": "resp11",
      "question2": "resp22",
      "question3": "resp33",
    }
  ),
  Trivia(
    id: "7",
    name: "Racionales e Irracionales",
    category: "Matemáticas",
    description: "Operaciones combinadas de numeros racionales e irracionales",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
    },
    questions: [
      "¿El numero pi es ?",
      "¿Cual es el resultado de (3/4+1/2)/(5/3+1/6)?",
      "¿Un numero racional es un?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 90,
      "question2": 90
    },
    responses: {
      "question0": {
        "resp00": "Irracional",
        "resp01": "Racional",
        "resp02": "Entero",
        "resp03": "Decimal"
      },
      "question1": {
        "resp10": "0",
        "resp11": "1",
        "resp12": "7",
        "resp13": "15/22"
      },
      "question2": {
        "resp20": "Cociente",
        "resp21": "Raiz",
        "resp22": "Real",
        "resp23": "Decimal"
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp13",
      "question2": "resp20",
    }
  ),
  Trivia(
    id: "8",
    name: "Notacion cientifica",
    category: "Matemáticas",
    description: "Operaciones de suma, resta, multiplicación y division de numeros en notacion cientifica",
    points: 10,
    qtyPreg: 4,
    qtyResp: {
      "question0": 4,
      "question1": 4,
      "question2": 4,
      "question3": 4,
    },
    questions: [
      "¿Cuando la coma recorre a la derecha el exponente es?"
      "¿Cual es el resultado en numero de 12,345x10^2?",
      "¿Cuatas posiciones debe recorrer la coma si el exponente es 10^-2?",
      "¿El numero 0,0005 es, en notacion cientifica?",
    ],
    questionTime: {
      "question0": 30,
      "question1": 60,
      "question2": 60,
      "question3": 90,
    },
    responses: {
      "question0": {
        "resp00": "-1",
        "resp01": "Cero",
        "resp02": "Negativo",
        "resp03": "Positivo"
      },
      "question1": {
        "resp10": "1234,5",
        "resp11": "123,5",
        "resp12": "1,234",
        "resp13": "12345"
      },
      "question2": {
        "resp20": "1",
        "resp21": "4",
        "resp22": "2",
        "resp23": "3"
      },
      "question3": {
        "resp30": "5x10^-3",
        "resp31": "5x10^-4",
        "resp32": "5x10^4",
        "resp33": "5x10^3",
      }
    },
    respCorrect: {
      "question0": "resp03",
      "question1": "resp10",
      "question2": "resp22",
      "question3": "resp31",
    }
  ),
  Trivia(
    id: "9",
    name: "Algoritmo: Analisis y resolución de problemas",
    category: "Informática y Tecnología",
    description: "Analizar un problema y crear el algoritmo",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 3,
      "question2": 2,
    },
    questions: [
      "¿En qué momento nació el algoritmo?",
      "¿Que son los datos de entrada de un algoritmo?",
      "Imagina que realizas un algoritmo donde hay una toma de decisión ¿el algoritmo tiene dos finales?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Existe desde las culturas ancestrales",
        "resp01": "Ada Lovelace invento el algoritmo",
        "resp02": "Microsoft creo el algoritmo",
      },
      "question1": {
        "resp10": "Los datos que se conocen",
        "resp11": "Los datos que resultan del algoritmo",
        "resp12": "Los datos que desconocemos",
      },
      "question2": {
        "resp20": "Si",
        "resp21": "No",
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp10",
      "question2": "resp21",
    }
  ),
  Trivia(
    id: "10",
    name: "Diagrama de flujo y prueba de escritorio",
    category: "Informática y Tecnología",
    description: "Realizar una prueba para verificar si el diagrama de flujo es correcto",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 2,
      "question2": 3,
    },
    questions: [
      "Los símbolos del diagrama de flujo:",
      "¿El pseudocodigo puede ejecutarse en una computadora?",
      "¿Cuando se debe realizar una prueba de escritorio?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Varian de acuerdo al gusto del programador",
        "resp01": "Cambian en función del lenguaje de programación",
        "resp02": "No cambian",
      },
      "question1": {
        "resp10": "Si, es lenguaje que la maquina puede interpretar",
        "resp11": "No, no es lenguaje de programación",
      },
      "question2": {
        "resp20": "Siempre",
        "resp21": "Solo cuando se realiza el programa en la computadora",
        "resp22": "Solo para pseudocodigo",
      }
    },
    respCorrect: {
      "question0": "resp02",
      "question1": "resp11",
      "question2": "resp20",
    }
  ),
  Trivia(
    id: "11",
    name: "Algoritmo: Introduccion a la resolución de problemas",
    category: "Informática y Tecnología",
    description: "Introducción a la resolución de problemas",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 2,
      "question2": 3,
    },
    questions: [
      "¿Cual es un algoritmo?",
      "¿Los algoritmos son solo para la informatica?",
      "¿Cual es una caracteristica del algoritmo?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Tu conversacion por WhatsApp",
        "resp01": "Una receta de cocina",
        "resp02": "Las materias que llevas en el colegio",
      },
      "question1": {
        "resp10": "No",
        "resp11": "Si",
      },
      "question2": {
        "resp20": "Los pasos se anotan en orden",
        "resp21": "Solo sirve para realizar calculos",
        "resp22": "Es solo para realizar programas en la computadora",
      }
    },
    respCorrect: {
      "question0": "resp01",
      "question1": "resp10",
      "question2": "resp20",
    }
  ),
  Trivia(
    id: "12",
    name: "Algoritmo: diagrama de flujo y pseudocodigo",
    category: "Informática y Tecnología",
    description: "Formas de expresar los algoritmos",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 3,
      "question2": 2,
    },
    questions: [
      "¿Cuantos finales puede tener un algoritmo?",
      "¿Como se llama la representacion grafica de un algoritmo?",
      "¿El diagrama de flujo solo se utiliza en informatica?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Maximo 10",
        "resp01": "Los que sean necesarios",
        "resp02": "1",
      },
      "question1": {
        "resp10": "Diagrama de Flujo",
        "resp11": "Pseudocodigo",
        "resp12": "Programa",
      },
      "question2": {
        "resp20": "Si",
        "resp21": "No",
      }
    },
    respCorrect: {
      "question0": "resp02",
      "question1": "resp10",
      "question2": "resp21",
    }
  ),
  Trivia(
    id: "13",
    name: "Herramientas y normas para ensamblado de equipos",
    category: "Informática y Tecnología",
    description: "Realizar el ensamblado de una computadora",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 3,
      "question2": 3,
    },
    questions: [
      "¿Como se divide una computadora?",
      "¿Porque la superficie donde vamos a realizar el ensamblado debe ser aislante (de madera)?",
      "¿Porque es necesario que la computadora tenga un sistema de refrigeracion (ventilador)?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "CPU y monitor",
        "resp01": "Hardware y Software",
        "resp02": "Perifericos de entrada y de salida",
      },
      "question1": {
        "resp10": "Para evitar estatica",
        "resp11": "Porque es mas dura y resistente",
        "resp12": "No debe ser aislante",
      },
      "question2": {
        "resp20": "Para evitar la acumulacion de polvo",
        "resp21": "Porque el computador esta en un lugar calido",
        "resp22": "Porque el procesador se puede quemar",
      }
    },
    respCorrect: {
      "question0": "resp01",
      "question1": "resp10",
      "question2": "resp22",
    }
  ),
  Trivia(
    id: "14",
    name: "Instalacion de sistema operativo y drivers",
    category: "Informática y Tecnología",
    description: "Conocer que es y como se instala el sistema operativo, y tambien conocer que son los drivers",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 3,
      "question2": 3,
    },
    questions: [
      "El software principal de la computadora es el sistema operativo y administra:",
      "El sistema operativo más difundido es:",
      "¿Qué pasa si mi computadora no tiene sistema operativo?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Hardware",
        "resp01": "Software",
        "resp02": "Hardware y Software",
      },
      "question1": {
        "resp10": "OS X (apple)",
        "resp11": "Windows",
        "resp12": "Linux",
      },
      "question2": {
        "resp20": "No funciona",
        "resp21": "No tiene memoria para almacenar archivos",
        "resp22": "No controlaria los puertos de entrada y de salida",
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp12",
      "question2": "resp22",
    }
  ),
  Trivia(
    id: "15",
    name: "Instalacion de aplicaciones",
    category: "Informática y Tecnología",
    description: "Conocer la correcta instalacion de una aplicación en la computadora",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 3,
      "question1": 3,
      "question2": 3,
    },
    questions: [
      "Las aplicaciones funcionan en el hardware a través de:",
      "Es el sistema operativo más difundido y por tanto tiene más aplicaciones disponibles:",
      "¿Por qué es necesario verificar la integridad de la aplicación antes de la instalación?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "El Sistema Operativo",
        "resp01": "El usuario",
        "resp02": "Los drivers",
      },
      "question1": {
        "resp10": "OS X (apple)",
        "resp11": "Windows",
        "resp12": "Linux",
      },
      "question2": {
        "resp20": "Para comprobar la versión de la aplicación",
        "resp21": "Para corroborar que si es la aplicación y no un virus",
        "resp22": "Para conocer los requisitos de instalación",
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp11",
      "question2": "resp21",
    }
  ),
  Trivia(
    id: "16",
    name: "Mantenimiento preventivo físico y lógico",
    category: "Informática y Tecnología",
    description: "Conocer los tipos de mantenimiento preventivo y cuando realizarlos",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 2,
      "question1": 2,
      "question2": 3,
    },
    questions: [
      "En qué situación es necesario que la computadora esté funcionando:",
      "Mantenimiento preventivo lógico se refiere a:",
      "Es el mantenimiento que se realiza aprovechando que no se usara el equipo en un determinado momento:"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Para realizar el mantenimiento preventivo",
        "resp01": "Para realizar el mantenimiento correctivo",
      },
      "question1": {
        "resp10": "Mantenimiento de hardware",
        "resp11": "Mantenimiento de software",
      },
      "question2": {
        "resp20": "Mantenimiento programado",
        "resp21": "Mantenimiento predictivo",
        "resp22": "Mantenimiento de oportunidad",
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp11",
      "question2": "resp22",
    }
  ),
  Trivia(
    id: "17",
    name: "Diseño de una base de datos",
    category: "Informática y Tecnología",
    description: "Conocer los pasos para el diseño de una base de datos",
    points: 10,
    qtyPreg: 3,
    qtyResp: {
      "question0": 2,
      "question1": 3,
      "question2": 3,
    },
    questions: [
      "¿Una biblioteca es comparable con una base de datos?",
      "Cuando armamos una tabla, si en una tabla se repiten atributos, ¿cuál es la norma que no se estaría cumpliendo?",
      "¿Cuándo tenemos entidades con relación muchos a muchos ¿Qué debemos hacer?"
    ],
    questionTime: {
      "question0": 30,
      "question1": 30,
      "question2": 30
    },
    responses: {
      "question0": {
        "resp00": "Si",
        "resp01": "No",
      },
      "question1": {
        "resp10": "Primera forma normal",
        "resp11": "Segunda forma normal",
        "resp12": "Tercera forma normal",
      },
      "question2": {
        "resp20": "Nada",
        "resp21": "Agregar una clave primaria",
        "resp22": "Crear una tabla de enlace para evitar la relación M:M",
      }
    },
    respCorrect: {
      "question0": "resp00",
      "question1": "resp10",
      "question2": "resp22",
    }
  ),
];