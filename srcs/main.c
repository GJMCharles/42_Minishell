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

int	process_command_line(char **command_line)
{
	char	*line;

	line = *command_line;
	if (ft_memcmp(line, "exit", 4) == 0)
	{
		free(line);
		return (-1);
	}
	return (0);
}

void	error_found(const char *message)
{
	const char	*error;

	error = "ERROR: ";
	ft_putstr_fd((char *) error, 2);
	ft_putendl_fd((char *) message, 2);
}

int	main(void)
{
	char		*input;
	const char	*prompt;

	prompt = "$> ";
	while (1)
	{
		input = readline(prompt);
		if (!input)
			return (free(input), error_found("Forced EXIT"), EXIT_FAILURE);
		add_history(input);
		if (process_command_line(&input) == -1)
			break ;
		free(input);
	}
	return (EXIT_SUCCESS);
}
