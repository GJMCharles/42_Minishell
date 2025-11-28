/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   history.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bchanteu <bchanteu@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/11/28 15:34:08 by bchanteu          #+#    #+#             */
/*   Updated: 2025/11/28 16:18:23 by bchanteu         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minishell.h"

void print_history(t_history *list)
{
	// parcourir la liste chainee et afficher command avec printf
	while (list)
	{
		printf("%i : %s\n", list->nb_command, list->command);
		list = list->next;
	}
}

void clear_history(t_history **list)
{
	//vider la liste chainee et la free
	t_history *temp;
	
	if(!*list)
		return ;
	while (*list)
	{
		temp = (*list)->next;
		if (temp->command)	
			free(temp->command);
		free (*list);	
		(*list) = temp;
	}
}

int add_history(char *command, t_history **list)
{
	t_history	*node;
	t_history 	*temp;
	
	if(!command)
		return (-1);
	node = (t_history *)malloc(sizeof(t_history));
	if (!node)
		return (-1);
	node->command = (char *)malloc(sizeof(char) * ft_strlen(command) + 1);
	if (!node->command)	
	{
		free(node);
		return (-1);
	}
	(void) ft_strlcpy(node->command, command, ft_strlen(command));
	node->next = (struct s_history *) NULL;
	temp = *list;
	while (temp->next)
		temp = temp->next;
	temp->next = node;
	return (0);
}
