# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: grcharle <grcharle@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/04/29 11:55:25 by grcharle          #+#    #+#              #
#    Updated: 2025/08/28 06:53:08 by grcharle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.DEFAULT_GOAL := all

CC := cc
CFLAGS := -Wall -Wextra -Werror -pedantic
CPPFLAGS := -I.

# Specifies options for the linker:
# example: -L/usr/local/lib
LDFLAGS :=

# Lists libraries to link with:
# example: -lm -lpthread
LDLIBS :=

NAME := libft.a
NAME_BONUS := libft_bonus.a

OBJECTS_DIR := .objects/

RM := rm -f

SOURCES_MANDATORY := \
ft_atoi.c \
ft_bzero.c \
ft_calloc.c \
ft_isalnum.c \
ft_isalpha.c \
ft_isascii.c \
ft_isdigit.c \
ft_isprint.c \
ft_itoa.c \
ft_memchr.c \
ft_memcmp.c \
ft_memcpy.c \
ft_memmove.c \
ft_memset.c \
ft_putchar_fd.c \
ft_putendl_fd.c \
ft_putnbr_fd.c \
ft_putstr_fd.c \
ft_split.c \
ft_strchr.c \
ft_strdup.c \
ft_striteri.c \
ft_strjoin.c \
ft_strlcat.c \
ft_strlcpy.c \
ft_strlen.c \
ft_strmapi.c \
ft_strncmp.c \
ft_strnstr.c \
ft_strrchr.c \
ft_strtrim.c \
ft_substr.c \
ft_tolower.c \
ft_toupper.c

SOURCES_BONUS := \
ft_lstnew_bonus.c \
ft_lstadd_front_bonus.c \
ft_lstsize_bonus.c \
ft_lstlast_bonus.c \
ft_lstadd_back_bonus.c \
ft_lstdelone_bonus.c \
ft_lstclear_bonus.c \
ft_lstiter_bonus.c \
ft_lstmap_bonus.c

SOURCES_EXTRA := 

OBJECTS_MANDATORY := \
	$(patsubst %.c, \
		$(OBJECTS_DIR)%.o, \
		$(SOURCES_MANDATORY) $(SOURCES_EXTRA)\
	)
OBJECTS_BONUS := \
	$(patsubst %.c, \
		$(OBJECTS_DIR)%.o, \
		$(SOURCES_BONUS)\
	)

DEPS_MANDATORY := $(OBJECTS_MANDATORY:.o=.d)
DEPS_BONUS := $(OBJECTS_BONUS:.o=.d)

-include $(DEPS_MANDATORY) $(DEPS_BONUS)

$(OBJECTS_DIR):
	mkdir -p $@

$(OBJECTS_DIR)%.o: %.c | $(OBJECTS_DIR)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(NAME): $(OBJECTS_MANDATORY)
	$(AR) rs $@ $^

$(NAME_BONUS): $(OBJECTS_BONUS)
	$(AR) rs $@ $^

all: $(NAME)

bonus: $(NAME_BONUS)

clean:
	$(RM) $(OBJECTS_MANDATORY) $(OBJECTS_BONUS)
	$(RM) $(DEPS_MANDATORY) $(DEPS_BONUS)
	$(RM) -r $(OBJECTS_DIR)

fclean: clean
	$(RM) -v $(NAME)
	$(RM) -v $(NAME_BONUS)

re: fclean all

info:
	echo -e "Mandatory objects: $(OBJECTS_MANDATORY)"
	echo -e "Bonus objects: $(OBJECTS_BONUS)"
	echo -e "Mandatory dependencies: $(DEPS_MANDATORY)"
	echo -e "Bonus dependencies: $(DEPS_BONUS)"
	echo -e "CFLAGS: $(CFLAGS)"
	echo -e "CPPFLAGS: $(CPPFLAGS)"

norm:
	norminette -R .

.SECONDARY: $(OBJECTS_MANDATORY) $(OBJECTS_BONUS)

.PRECIOUS: $(OBJECTS_DIR)

.SILENT:

.PHONY: all clean fclean re bonus
