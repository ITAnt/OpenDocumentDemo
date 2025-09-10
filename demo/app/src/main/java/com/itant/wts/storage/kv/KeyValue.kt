package com.itant.wts.storage.kv

/**
 * SharedPreference配置清单
 */
object KeyValue {
    var token by MM("token", "")
    var theme = 0

    //var testObjList by MM("testObjList", ArrayList<TestObj>())
    //var testObjList by MM("testObjList", ArrayList<TestObj>(), object : TypeToken<ArrayList<TestObj>>() {}.type)

    //var testObj by MM("testObj", TestObj())
}