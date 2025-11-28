# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bchanteu <bchanteu@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/11/28 15:01:10 by bchanteu          #+#    #+#              #
#    Updated: 2025/11/28 15:05:41 by bchanteu         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Force default rule as : 'all'
.DEFAULT_GOAL := all

# Hide message 'Entering directory' & 'Leaving directory'
MAKEFLAGS += --no-print-directory

CC := cc
CFLAGS := -Wall -Wextra -Werror -pedantic

# Delete files & empty directories
RM := rm -f -v
RM_DIR := rmdir -v

# Project Libft (+GetNextLine/+FtPrintF)
LIBFT := libft

CPPFLAGS := \
-I ./ \
-I ./includes/ \
-I ./includes/$(LIBFT)

# Specifies options for the linker:
# example: -L/usr/local/lib
LDFLAGS := \
-L./includes/$(LIBFT)

# Lists libraries to link with:
# example: -lm -lpthread
LDLIBS := \
-lft \
-lpthread

NAME := minishell

DIR_MANDATORY := $(NAME)

OBJECTS_DIR := .objects

SOURCES_MANDATORY := \
main.c

OBJECTS_MANDATORY := \
$(patsubst \
	$(DIR_MANDATORY)/%.c,\
	$(OBJECTS_DIR)/.$(DIR_MANDATORY)/%.o,\
	$(addprefix $(DIR_MANDATORY)/, $(SOURCES_MANDATORY))\
)

DEPS_MANDATORY := $(OBJECTS_MANDATORY:.o=.d)

-include $(DEPS_MANDATORY)

$(OBJECTS_DIR):
	mkdir -p $@/.$(DIR_MANDATORY)

$(OBJECTS_DIR)/.$(DIR_MANDATORY)/%.o: $(DIR_MANDATORY)/%.c | $(OBJECTS_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): LIBS $(OBJECTS_MANDATORY)

LIBS:
	$(MAKE) -C ./includes/$(LIBFT)

all: $(NAME)
	$(CC) $(CFLAGS) $(OBJECTS_MANDATORY) -o ./$^/$^ $(LDFLAGS) $(LDLIBS)
	echo -e "Generated executable: ./$^/$^"

clean:
	@$(MAKE) -C ./includes/$(LIBFT) clean
	@$(RM) $(OBJECTS_MANDATORY)
	@$(RM) $(DEPS_MANDATORY)
	@if [ -d  $(OBJECTS_DIR)/.$(DIR_MANDATORY) ]; then \
		$(RM_DIR) -p $(OBJECTS_DIR)/.$(DIR_MANDATORY); \
	fi

fclean: clean
	@$(MAKE) -C ./includes/$(LIBFT) fclean
	@$(RM) ./$(NAME)/$(NAME)

re: fclean all

norm:
	norminette -R $(DIR_MANDATORY)

.SECONDARY: $(OBJECTS_MANDATORY)

.PRECIOUS: $(OBJECTS_DIR)

.SILENT:

.PHONY: all clean fclean re
