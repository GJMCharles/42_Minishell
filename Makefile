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

# Set default rule when 'make all'
.DEFAULT_GOAL := all

# Hide message 'Entering directory' & 'Leaving directory'
MAKEFLAGS += --no-print-directory

CC := cc
CFLAGS := \
	-Wall -Wextra -Werror -Wpedantic -Wformat -Wformat-security \
	-Wstack-protector -Wconversion -Wstrict-overflow=5 \
	-D_FORTIFY_SOURCE=2 -fstack-protector-strong \
	-fno-omit-frame-pointer \
	-fPIE -fPIC -O2 -g

# Delete files & empty directories
RM := rm -f -v
RM_DIR := rmdir -v

LIBRARY := ./includes

# Project Libft (+GetNextLine/+FtPrintF)
LIBFT := $(addprefix $(LIBRARY)/, libft)

CPPFLAGS := \
	-I $(LIBRARY) \
	-I $(LIBFT)

# Specifies options for the linker:
# example: -L/usr/local/lib
LDFLAGS := \
	-L $(LIBFT)

# Lists libraries to link with:
# example: -lm -lpthread
LDLIBS := \
	-lft \
	-lreadline

NAME := minishell

DIR_MANDATORY := srcs

OBJECTS_DIR := .objects

SOURCES_MANDATORY := \
	main.c

OBJECTS_MANDATORY := \
$(patsubst \
	$(DIR_MANDATORY)/%.c,\
	$(OBJECTS_DIR)/%.o,\
	$(addprefix $(DIR_MANDATORY)/, $(SOURCES_MANDATORY))\
)

DEPS_MANDATORY := $(OBJECTS_MANDATORY:.o=.d)

-include $(DEPS_MANDATORY)

$(OBJECTS_DIR):
	mkdir -p $@

$(OBJECTS_DIR)/%.o: $(DIR_MANDATORY)/%.c | $(OBJECTS_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): LIBS $(OBJECTS_MANDATORY)

LIBS:
	$(MAKE) -C $(LIBFT)

all: $(NAME)
	$(CC) $(CFLAGS) $(OBJECTS_MANDATORY) $(LDFLAGS) $(LDLIBS) -o $^
	@echo -e "Generated executable: $^"

clean:
	@$(MAKE) -C $(LIBFT) clean
	@$(RM) $(OBJECTS_MANDATORY)
	@$(RM) $(DEPS_MANDATORY)
	@if [ -d  $(OBJECTS_DIR) ]; then \
		$(RM_DIR) -p $(OBJECTS_DIR); \
	fi

fclean: clean
	@$(MAKE) -C $(LIBFT) fclean
	@$(RM) ./$(NAME)/$(NAME)

re: fclean all

debug: re
	-valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes -s ./$(NAME)

norm:
	-norminette -R $(shell find ./includes -type f -name "*.h")
	-norminette -R $(shell find ./srcs -type f -name "*.c")

.SECONDARY: $(OBJECTS_MANDATORY)

.PRECIOUS: $(OBJECTS_DIR)

.SILENT:

.PHONY: all clean fclean re debug norm
