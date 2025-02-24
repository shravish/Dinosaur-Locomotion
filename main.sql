// SQL shell: Create table dinosaurs and insert into values //

> CREATE TABLE dinosaurs (species text, height float, length float, legs int);

// Insert into values //

> INSERT INTO dinosaurs (species, height, length, legs) VALUES
 ('Ceratosaurus', 4.0, 6.1, 2),
 ('Deinonychus', 1.5, 2.7, 2),
 ('Microvenator', 0.8, 1.2, 2),
 ('Plateosaurus', 2.1, 7.9, 2),
 ('Spinosaurus', 2.4, 12.2, 2),
 ('Tyrannosaurus', 7.0, 15.2, 2),
 ('Velociraptor', 0.6, 1.8, 2),
 ('Apatosaurus', 2.2, 22.9, 4),
 ('Brachiosaurus', 7.6, 30.5, 4),
 ('Diplodocus', 3.6, 27.1, 4),
 ('Supersaurus', 10.0, 30.5, 4),
 ('Albertosaurus', 4.6, 9.1, NULL),
 ('Argentinosaurus', 10.7, 36.6, NULL),
 ('Compsognathus', 0.6, 0.9, NULL),
 ('Gallimimus', 2.4, 5.5, NULL),
 ('Mamenchisaurus', 5.3, 21.0, NULL),
 ('Oviraptor', 0.9, 1.5, NULL),
 ('Ultrasaurus', 8.1, 30.5, NULL);

// Display dinosaurs table //

> SELECT * FROM dinosaurs

// Output: //
  
|     species     | height | length | legs |


| Ceratosaurus    |      4 |    6.1 |    2 |

| Deinonychus     |    1.5 |    2.7 |    2 |

| Microvenator    |    0.8 |    1.2 |    2 |

| Plateosaurus    |    2.1 |    7.9 |    2 |

| Spinosaurus     |    2.4 |   12.2 |    2 |

| Tyrannosaurus   |      7 |   15.2 |    2 |

| Velociraptor    |    0.6 |    1.8 |    2 |

| Apatosaurus     |    2.2 |   22.9 |    4 |

| Brachiosaurus   |    7.6 |   30.5 |    4 |

| Diplodocus      |    3.6 |   27.1 |    4 |

| Supersaurus     |     10 |   30.5 |    4 |

| Albertosaurus   |    4.6 |    9.1 |  NULL|

| Argentinosaurus |   10.7 |   36.6 |  NULL| 

| Compsognathus   |    0.6 |    0.9 |  NULL|

| Gallimimus      |    2.4 |    5.5 |  NULL|

| Mamenchisaurus  |    5.3 |     21 |  NULL|

| Oviraptor       |    0.9 |    1.5 |  NULL|

| Ultrasaurus     |    8.1 |   30.5 |  NULL|
 
 
 (18 rows)

// Determine characteristic height/length (=body shape) ratio separately for bipedal and quadropedal dinosaurs: //

> WITH bodies(legs, shape) AS 
(SELECT d.legs, avg(d.height / d.length) AS shape) 
FROM dinosaurs AS d 
WHERE d.legs IS NOT NULL GROUP BY d.legs) 
TABLE bodies;

// Output: //

| legs ||        shape        |
 
 
|    4 || 0.20149009443419652 |

|    2 ||  0.4477662389355141 |
  

> WITH bodies(legs, shape) AS 
(SELECT d.legs, avg(d.height / d.length) AS shape) 
FROM dinosaurs AS d 
WHERE d.legs IS NOT NULL GROUP BY d.legs) 
SELECT d.species, d.height, d.length,
(SELECT b.legs FROM bodies AS b 
ORDER BY abs(b.shape - d.height / d.length) 
LIMIT 1) AS legs
FROM dinosaurs AS d 
WHERE d.legs IS NULL

-- the above query -- Locomotion of dinosaur d is unknown

UNION ALL

-- the below query -- Locomotion of dinosaur d is known

SELECT d.* FROM dinosaurs AS d 
WHERE d.legs IS NOT NULL;

// Output: //

|     species     | height | length | legs |

| Albertosaurus   |    4.6 |    9.1 |    2 |

| Argentinosaurus |   10.7 |   36.6 |    4 |

| Compsognathus   |    0.6 |    0.9 |    2 |

| Gallimimus      |    2.4 |    5.5 |    2 |

| Mamenchisaurus  |    5.3 |     21 |    4 |

| Oviraptor       |    0.9 |    1.5 |    2 |

| Ultrasaurus     |    8.1 |   30.5 |    4 |

| Ceratosaurus    |      4 |    6.1 |    2 |

| Deinonychus     |    1.5 |    2.7 |    2 |

| Microvenator    |    0.8 |    1.2 |    2 |

| Plateosaurus    |    2.1 |    7.9 |    2 |

| Spinosaurus     |    2.4 |   12.2 |    2 |

| Tyrannosaurus   |      7 |   15.2 |    2 |

| Velociraptor    |    0.6 |    1.8 |    2 |

| Apatosaurus     |    2.2 |   22.9 |    4 |

| Brachiosaurus   |    7.6 |   30.5 |    4 |

| Diplodocus      |    3.6 |   27.1 |    4 |

| Supersaurus     |     10 |   30.5 |    4 |

(18 rows)
