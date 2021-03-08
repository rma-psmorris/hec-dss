#include <jni.h>
#include <string.h>
#include "heclib.h"


JNIEXPORT void JNICALL Java_hec_heclib_util_Heclib_Hec_1zgintl
    (JNIEnv *env, jobject obj, jintArray j_interval, jobject j_ePart,
     jintArray j_nvals, jintArray j_status)
{
    int *interval;
    const char *ePart;
    int *nvals;
    int *status;
    char cEpart[65];

    interval = (*env)->GetIntArrayElements (env, j_interval, 0);
    ePart    = (*env)->GetStringUTFChars (env, j_ePart, 0);
    nvals    = (*env)->GetIntArrayElements (env, j_nvals, 0);
    status   = (*env)->GetIntArrayElements (env, j_status, 0);


	stringCopy(cEpart, 65, ePart, strlen(ePart));
    upcase_ (cEpart, strlen(ePart));

    zgintl_ (interval, cEpart, nvals, status,
             sizeof(cEpart)-1);

    (*env)->ReleaseIntArrayElements (env, j_interval, interval, 0);
    (*env)->ReleaseStringUTFChars (env, j_ePart, ePart);
    (*env)->ReleaseIntArrayElements (env, j_nvals, nvals, 0);
    (*env)->ReleaseIntArrayElements (env, j_status, status, 0);
}
