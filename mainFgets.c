/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bchanteu <bchanteu@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/28 15:00:55 by bchanteu          #+#    #+#             */
/*   Updated: 2025/11/28 16:30:18 by bchanteu         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

#include <stdio.h>
#include <stdlib.h> // Non strictement nécessaire ici, mais bonne pratique

#define MAX_SIZE 100 // Définir une taille maximale pour le buffer

int main() {
    // 1. Déclarer un tableau de caractères (buffer) pour stocker l'entrée
    char buffer[MAX_SIZE];

    // 2. Afficher le prompt (le message demandant l'entrée)
    // printf("Veuillez entrer votre nom (max %d caractères) : ", MAX_SIZE - 1);

    // 3. Utiliser fgets pour lire l'entrée de l'utilisateur
    // Paramètres : (buffer, taille_max, source)
	while(1)
	{
		if (fgets(buffer, MAX_SIZE, stdin) != NULL) {
			// La lecture a réussi.

			// Note Importante : fgets inclut le caractère de nouvelle ligne ('\n')
			// s'il y a de la place dans le buffer. Il est souvent nécessaire de le supprimer.

			// 4. (Optionnel mais Recommandé) Supprimer le '\n' si présent
			// Chercher le caractère '\n'
			int i = 0;
			while (buffer[i] != '\0') {
				if (buffer[i] == '\n') {
					buffer[i] = '\0'; // Le remplacer par le terminateur de chaîne
					// break;
				}
				i++;
			}

			// printf("Bonjour, %s!\n", buffer);

		} else {
			// La lecture a échoué (ex: fin de fichier inattendue, erreur)
			fprintf(stderr, "Erreur de lecture de l'entrée.\n");
			return 1;
				}
	}
    return 0;
}