#include <stdlib.h>
#include <string.h>

const uint8_t eval_binary[] =
{
  #embed "resources/eval.egev2"
};
const uint8_t eval_move_ordering_end_binary[] =
{
  #embed "resources/eval_move_ordering_end.egev"
};

const uint8_t book_binary[] =
{
  #embed "resources/book.egbk3"
};

const uint8_t hash25_binary[] =
{
  #embed "resources/hash/hash25.eghs"
};
const uint8_t hash26_binary[] =
{
  #embed "resources/hash/hash26.eghs"
};
const uint8_t hash27_binary[] =
{
  #embed "resources/hash/hash27.eghs"
};

int get_resource_bytes(const char* resource_name, int start, int size, uint8_t* resource) {
    int ret = 1;
    if (0 == strcmp(resource_name, "eval")) {
       memcpy(resource, eval_binary + start, size);
       ret = 0;
    }else if (0 == strcmp(resource_name, "evalend")) {
       memcpy(resource, eval_move_ordering_end_binary + start, size);
       ret = 0;
    }else if (0 == strcmp(resource_name, "book")) {
       memcpy(resource, book_binary + start, size);
       ret = 0;
    }else if (0 == strcmp(resource_name, "hash25")) {
       memcpy(resource, hash25_binary + start, size);
       ret = 0;
    }else if (0 == strcmp(resource_name, "hash26")) {
       memcpy(resource, hash26_binary + start, size);
       ret = 0;
    }else if (0 == strcmp(resource_name, "hash27")) {
       memcpy(resource, hash27_binary + start, size);
       ret = 0;
    }
    return ret;
}


int get_resource_size(const char* resource_name) {
    if (0 == strcmp(resource_name, "eval"))
        return sizeof(eval_binary);
    if (0 == strcmp(resource_name, "evalend"))
        return sizeof(eval_move_ordering_end_binary);
    if (0 == strcmp(resource_name, "book"))
        return sizeof(book_binary);
    if (0 == strcmp(resource_name, "hash25"))
        return sizeof(hash25_binary);
    if (0 == strcmp(resource_name, "hash26"))
        return sizeof(hash26_binary);
    if (0 == strcmp(resource_name, "hash27"))
        return sizeof(hash27_binary);
    return 0;
}

