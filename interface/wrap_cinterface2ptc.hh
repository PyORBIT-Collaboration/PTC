#ifndef WRAP_PTC_H
#define WRAP_PTC_H

#include "Python.h"

#ifdef __cplusplus
extern "C"
{
#endif

namespace wrap_ptc
{
  void initptc(void);
  PyObject* getBasePTCType(char* name);
  void initPTC_Map(PyObject* module);
}

#ifdef __cplusplus
}
#endif

#endif // WRAP_PTC_H
