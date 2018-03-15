#ifndef __LOG_H__
#define __LOG_H__

#define LOG_ALWAYS_FATAL(fmt, ...) printf(fmt"\n", ##__VA_ARGS__)
#define ALOGE(fmt, ...) printf(fmt"\n", ##__VA_ARGS__)
#define ALOGD(fmt, ...) printf(fmt"\n", ##__VA_ARGS__)
#define ALOGV(fmt, ...) printf(fmt"\n", ##__VA_ARGS__)

#endif /* __LOG_H__ */