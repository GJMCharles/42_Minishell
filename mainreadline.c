/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mainreadline.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bchanteu <bchanteu@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/28 15:00:55 by bchanteu          #+#    #+#             */
/*   Updated: 2025/11/28 16:48:49 by bchanteu         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

#include <stdio.h>
#include <stdlib.h> 
#include <string.h>

#include <readline/readline.h>
#include <readline/history.h>


int main() {
    char *input; // readline renvoie un pointeur vers la chaîne lue

    // Définir le prompt
    const char *prompt = "$> ";

    printf("Bienvenue dans l'exemple Readline. Tapez 'exit' pour quitter.\n\n");

    // Boucle principale pour le prompt
    while (1) {
        // 1. Appeler la fonction readline() avec la chaîne de prompt
        input = readline(prompt);

        // readline() renvoie NULL si Ctrl+D (EOF) est pressé
        if (input == NULL) {
            printf("\nSortie.\n");
            break;
        }

        // 2. Traiter l'entrée si elle n'est pas vide
        if (input[0] != '\0') {
            add_history(input);

            // 3. Exemple : Vérifier si l'utilisateur veut quitter
            if (strcmp(input, "exit") == 0) {
                free(input); // Libérer la mémoire allouée par readline
                break;
            }
        }

        // 4. TRÈS IMPORTANT : Libérer la mémoire
        // readline() alloue dynamiquement de la mémoire pour stocker la chaîne lue.
        free(input);
    }

    return EXIT_SUCCESS;
}