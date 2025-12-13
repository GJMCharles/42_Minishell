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

.DEFAULT_GOAL := all

MAKEFLAGS += --no-print-directory

CC := cc
CFLAGS := \
	-Wall -Wextra -Werror -Wpedantic -Wformat -Wformat-security \
	-Wstack-protector -Wconversion -Wstrict-overflow=5 \
	-D_FORTIFY_SOURCE=2 -fstack-protector-strong \
	-fno-omit-frame-pointer \
	-fPIE -fPIC -O2 -g

RM := rm -f -v
RM_DIR := rmdir -v

LIBRARY := includes/

LIBFT := $(addprefix $(LIBRARY), libft)

CPPFLAGS := \
	-I $(LIBRARY) \
	-I $(LIBFT)

LDFLAGS := \
	-L $(LIBFT)

LDLIBS := \
	-lft \
	-lreadline

NAME := minishell

DIR_MANDATORY := srcs/

OBJECTS_DIR := .objects/

SOURCES_MANDATORY := \
	main.c

OBJECTS_MANDATORY := \
$(patsubst $(DIR_MANDATORY)%.c, \
	$(OBJECTS_DIR)%.o,\
	$(addprefix $(DIR_MANDATORY), $(SOURCES_MANDATORY))\
)

DEPS_MANDATORY := $(OBJECTS_MANDATORY:.o=.d)

-include $(DEPS_MANDATORY)

$(OBJECTS_DIR):
	mkdir -p $@

$(OBJECTS_DIR)%.o: $(DIR_MANDATORY)%.c | $(OBJECTS_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

LIBS:
	$(MAKE) -C $(LIBFT)

$(NAME): $(OBJECTS_MANDATORY) | LIBS
	$(CC) $(CFLAGS) $^ $(LDFLAGS) $(LDLIBS) -o $@
	@echo -e "Generated executable: $@"

all: $(NAME)

clean:
	@$(MAKE) -C $(LIBFT) clean
	@$(RM) $(OBJECTS_MANDATORY)
	@$(RM) $(DEPS_MANDATORY)
	@if [ -d  $(OBJECTS_DIR) ]; then \
		$(RM_DIR) -p $(OBJECTS_DIR); \
	fi

fclean: clean
	@$(MAKE) -C $(LIBFT) fclean
	@$(RM) $(NAME)

re: fclean all

debug: re
	+valgrind \
	--leak-check=full \
	--show-leak-kinds=all \
	--track-origins=yes \
	-s $(NAME)

norm:
	-norminette -R $(shell find includes -type f -name "*.h")
	-norminette -R $(shell find srcs -type f -name "*.c")

.SECONDARY: $(OBJECTS_MANDATORY)

.PRECIOUS: $(OBJECTS_DIR)

# .SILENT:

.PHONY: all clean fclean re LIBS debug norm
