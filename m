Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D9C04A94
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGXQXd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjGXQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:30 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7B71B8
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162325usoutp013ad86b8cd639e139b63fba3e5b716e4b~02lHQlxW12613826138usoutp01R;
        Mon, 24 Jul 2023 16:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230724162325usoutp013ad86b8cd639e139b63fba3e5b716e4b~02lHQlxW12613826138usoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215805;
        bh=qdfqQW1bn/vhvlMZzfNI8DuF/HeSyUHBbOTbODKacy0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WKMsY7dGmEoiCrf4jlSMxBlWEzABotz5xV+OTumwEFPXsbW2K26/4EXSSn10C/+qr
         2ZUzM6NZsLLi8f4ILyOg7crugTMAxtwObf1ny8QobynMDi7kHn3uoPOLNFtowqgYVt
         3scNf5rYAtCpEeqOXd0nBWJ0IuGXjn8otzR9+L9E=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p239e624b31ea5e3239f836cb6acc57b1b~02lHFjh5S0635306353uscas1p2T;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 50.15.51475.C75AEB46; Mon,
        24 Jul 2023 12:23:24 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p25916a52440d357dcec1675c8a62aa6fa~02lGuq8pB0599105991uscas1p2N;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
X-AuditID: cbfec36d-635ff7000001c913-9a-64bea57cf34c
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 33.D1.64580.C75AEB46; Mon,
        24 Jul 2023 12:23:24 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 09:23:23 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 09:23:23 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [Qemu PATCH RESEND 8/9] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Thread-Topic: [Qemu PATCH RESEND 8/9] hw/cxl/events: Add qmp interfaces to
        add/release dynamic capacity extents
Thread-Index: AQHZvksqg57PbbEm3UyZPz+aianBiA==
Date:   Mon, 24 Jul 2023 16:23:23 +0000
Message-ID: <20230724162313.34196-9-fan.ni@samsung.com>
In-Reply-To: <20230724162313.34196-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djXc7o1S/elGEzdaWTRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8a7r71MBX/cK1ZOb2RsYHxq2sXIwSEhYCLRccGri5GLQ0hgJaPEstk3WCCcViaJ
        1ptL2LoYOcGKrv84zQ6RWMso8evhabCEkMAnRomHZzIgEssYJR7seMwMkmATUJTY17UdrEhE
        wFji2OElzCBFzAJvWSQ+rnnDApIQFsiROLR+IytEUaHExhuTmCBsPYnfsxaygdzHIqAqcXRR
        HEiYV8Bc4sjC+2CtnAIWEhsunQBrZRQQk/h+ag1YK7OAuMStJ/OZIK4WlFg0ew8zhC0m8W/X
        Q6hv5CUm/5gBZStK3P/+kh2iV0/ixtQpbBC2tsSyha+ZIfYKSpyc+YQFol5S4uAKSBBJCEzm
        lGh6A3GEhICLRMvVNihbWmL6mssskPBNllj1kQsinCMxf8kWqDnWEgv/rGeawKgyC8nZs5Cc
        MQvJGbOQnLGAkWUVo3hpcXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYGo7/e9w7g7GHbc+6h1i
        ZOJgPMQowcGsJMJrGLMvRYg3JbGyKrUoP76oNCe1+BCjNAeLkjivoe3JZCGB9MSS1OzU1ILU
        IpgsEwenVAPTxj2ndaWCTu2UvZscvXhK2ydN0eRXFhY8GyxeVu2JkBc/YXjgy/NVR4I1BM++
        0bW7uuXPPn6phCUxJ+5sN6gpPMvM+3zO1f7U50YvnVafyFPe1FbIIvH6IEtw9j9e8YwVQXvl
        ApZlLfKUYRJJfellWiuqL8hzs/z919qA2Vv1UucFvjc6N3uybtLjI0471FQ7dtzYcnmC51/R
        qCvve9h/9L3Zw7soeuJ/nfa9X+e+OCC7UVv22bzOd0lekcUBDyZW2bUuf7FASUfm27Z401cn
        a+dq7vguHspwSU9R9GTJoYMOxy9v3P2Bqb9gsor5suXrH5be2meyYX/Aj4RPvTJ9i87vv9Sc
        /yY6129PouAWYyWW4oxEQy3mouJEAHFq1ZfcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWS2cA0Sbdm6b4Ug/sNUhbd5zcwWkyfeoHR
        YvXNNYwWDU2PWCxadr9nstj/9DmLxaqF19gszs86xWLxfOJzJoulSx4xWxzv3cHiwO1xYfIE
        Vo/FDa4eO2fdZfdoOfIWyNvzkslj48f/7B5Prm1m8tj8+gWzx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZbz72stU8Me9YuX0RsYGxqemXYycHBICJhLXf5xm72Lk4hASWM0o8eTXFRYI5xOj
        RPftucwQzjJGib5TW9hBWtgEFCX2dW1nA7FFBIwljh1ewgxiMwu8ZpH4dpEbxBYWyJE4tH4j
        K0RNocTxppXMELaexO9ZC4F6OThYBFQlji6KAwnzCphLHFl4nwXEFgKyz2zaD7aKU8BCYsOl
        E2BjGAXEJL6fWsMEsUpc4taT+UwQHwhILNlznhnCFpV4+fgfK4QtLzH5xww2CFtR4v73l+wQ
        vXoSN6ZOYYOwtSWWLXzNDHGDoMTJmU9YIOolJQ6uuMEygVFiFpJ1s5C0z0LSPgtJ+wJGllWM
        4qXFxbnpFcXGeanlesWJucWleel6yfm5mxiBieH0v8MxOxjv3fqod4iRiYPxEKMEB7OSCK9h
        zL4UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwesRPjhQTSE0tSs1NTC1KLYLJMHJxSDUwXe2+k
        O+UzXf9sE8WgIc2oO+uxx6J3a213ut4Nsr/4cb9/i33EQ+W/Tsdv66breEzq4Nib2M5fcd/x
        X3XM9WcnNTbnW6xc1xNgIBSQVyIpadH6YJFm7K9T3KHLLVqPzXQtmvhXekd3ctI/b9alxmv3
        Phd/ek7z2rtXDF7mkSs3dJ14feTjr0yZx7tOhLquvl00IW++qZr+5dTUSuEqTpUNL9pldm1f
        +Vbg/+PnSxoZ7NSmsB+eGXRL14KjWHNdRPt07qrVQpvci3+mzn3IN/+EEM+BQxbaKbcijqz7
        rr99RdtsFV1bgYnLxRLNP5XG/PjRrB7IrbjrpOIUoePLJTNus1Q9r2cTecTybs6O3D4lluKM
        REMt5qLiRADBVgvPewMAAA==
X-CMS-MailID: 20230724162324uscas1p25916a52440d357dcec1675c8a62aa6fa
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162324uscas1p25916a52440d357dcec1675c8a62aa6fa
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162324uscas1p25916a52440d357dcec1675c8a62aa6fa@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Since fabric manager emulation is not supported yet, the change implements
the functions to add/release dynamic capacity extents as QMP interfaces.

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each is 128MB long)
to region 0 (starting at dpa offset 0 and 128MB) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity-event",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "extents": [
      {
          "region-id": 0,
          "dpa": 0,
          "len": 128
      },
      {
          "region-id": 0,
          "dpa": 128,
          "len": 128
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MB from region 0
(starting at dpa offset 128MB) look like below:

{ "execute": "cxl-release-dynamic-capacity-event",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "extents": [
      {
          "region-id": 0,
          "dpa": 128,
          "len": 128
      }
      ]
  }
}

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c          | 145 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |   6 ++
 include/hw/cxl/cxl_events.h |  16 ++++
 qapi/cxl.json               |  49 ++++++++++++
 4 files changed, 216 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 608063ac52..cb1f9182e6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1811,6 +1811,151 @@ void qmp_cxl_inject_memory_module_event(const char =
*path, CxlEventLog log,
     }
 }
=20
+static const QemuUUID dynamic_capacity_uuid =3D {
+    .data =3D UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+            0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+/*
+ * cxl r3.0: Table 8-47
+ * 00h: add capacity
+ * 01h: release capacity
+ * 02h: forced capacity release
+ * 03h: region configuration updated
+ * 04h: Add capacity response
+ * 05h: capacity released
+ */
+enum DC_Event_Type {
+    DC_EVENT_ADD_CAPACITY,
+    DC_EVENT_RELEASE_CAPACITY,
+    DC_EVENT_FORCED_RELEASE_CAPACITY,
+    DC_EVENT_REGION_CONFIG_UPDATED,
+    DC_EVENT_ADD_CAPACITY_RSP,
+    DC_EVENT_CAPACITY_RELEASED,
+    DC_EVENT_NUM
+};
+
+#define MEM_BLK_SIZE_MB 128
+static void qmp_cxl_process_dynamic_capacity_event(const char *path,
+        CxlEventLog log, enum DC_Event_Type type,
+        uint16_t hid, CXLDCExtentRecordList *records, Error **errp)
+{
+    Object *obj =3D object_resolve_path(path, NULL);
+    CXLEventDynamicCapacity dCap;
+    CXLEventRecordHdr *hdr =3D &dCap.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *dcd;
+    uint8_t flags =3D 1 << CXL_EVENT_TYPE_INFO;
+    uint32_t num_extents =3D 0;
+    CXLDCExtentRecordList *list =3D records;
+    CXLDCExtent_raw *extents;
+    uint64_t dpa, len;
+    uint8_t rid;
+    int i;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+    dcd =3D CXL_TYPE3(obj);
+    cxlds =3D &dcd->cxl_dstate;
+    memset(&dCap, 0, sizeof(dCap));
+
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    while (list) {
+        dpa =3D list->value->dpa * 1024 * 1024;
+        len =3D list->value->len * 1024 * 1024;
+        rid =3D list->value->region_id;
+
+        if (rid >=3D dcd->dc.num_regions) {
+            error_setg(errp, "region id is too large");
+            return;
+        }
+
+        if (dpa % dcd->dc.regions[rid].block_size
+                || len % dcd->dc.regions[rid].block_size) {
+            error_setg(errp, "dpa or len is not aligned to region block si=
ze");
+            return;
+        }
+
+        if (dpa + len > dcd->dc.regions[rid].decode_len * 256 * 1024 * 102=
4) {
+            error_setg(errp, "extent range is beyond the region end");
+            return;
+        }
+
+        num_extents++;
+        list =3D list->next;
+    }
+
+    i =3D 0;
+    list =3D records;
+    extents =3D g_new0(CXLDCExtent_raw, num_extents);
+    while (list) {
+        dpa =3D list->value->dpa * 1024 * 1024;
+        len =3D list->value->len * 1024 * 1024;
+        rid =3D list->value->region_id;
+
+        extents[i].start_dpa =3D dpa + dcd->dc.regions[rid].base;
+        extents[i].len =3D len;
+        memset(extents[i].tag, 0, 0x10);
+        extents[i].shared_seq =3D 0;
+
+        list =3D list->next;
+        i++;
+    }
+
+    /*
+     * 8.2.9.1.5
+     * All Dynamic Capacity event records shall set the Event Record
+     * Severity field in the Common Event Record Format to Informational
+     * Event. All Dynamic Capacity related events shall be logged in the
+     * Dynamic Capacity Event Log.
+     */
+    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCa=
p),
+            cxl_device_get_timestamp(&dcd->cxl_dstate));
+
+    dCap.type =3D type;
+    stw_le_p(&dCap.host_id, hid);
+    /* only valid for DC_REGION_CONFIG_UPDATED event */
+    dCap.updated_region_id =3D rid;
+    for (i =3D 0; i < num_extents; i++) {
+        memcpy(&dCap.dynamic_capacity_extent, &extents[i]
+                , sizeof(CXLDCExtent_raw));
+
+        if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
+                    (CXLEventRecordRaw *)&dCap)) {
+            cxl_event_irq_assert(dcd);
+        }
+    }
+
+    g_free(extents);
+}
+
+void qmp_cxl_add_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records,
+        Error **errp)
+{
+   qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONA=
L,
+           DC_EVENT_ADD_CAPACITY, 0, records, errp);
+}
+
+void qmp_cxl_release_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records,
+        Error **errp)
+{
+    qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATION=
AL,
+            DC_EVENT_RELEASE_CAPACITY, 0, records, errp);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index f3e4a9fa72..482229f3bd 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -56,3 +56,9 @@ void qmp_cxl_inject_correctable_error(const char *path, C=
xlCorErrorType type,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_add_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records, Error **errp) {}
+
+void qmp_cxl_release_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records, Error **errp) {}
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 089ba2091f..3baf745f8d 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -165,4 +165,20 @@ typedef struct CXLEventMemoryModule {
     uint8_t reserved[0x3d];
 } QEMU_PACKED CXLEventMemoryModule;
=20
+/*
+ * Dynamic Capacity Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.5: Table 8-47
+ * All fields little endian.
+ */
+typedef struct CXLEventDynamicCapacity {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t reserved1;
+    uint16_t host_id;
+    uint8_t updated_region_id;
+    uint8_t reserved2[3];
+    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
+    uint8_t reserved[0x20];
+} QEMU_PACKED CXLEventDynamicCapacity;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 05c560cfe5..fb04ec4c41 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -369,3 +369,52 @@
 ##
 {'command': 'cxl-inject-correctable-error',
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
+
+##
+# @CXLDCExtentRecord:
+#
+# Record of a single extent to add/release
+#
+# @region-id: id of the region where the extent to add/release
+# @dpa: start dpa (in MiB) of the extent, related to region base address
+# @len: extent size (in MiB)
+#
+# Since: 8.0
+##
+{ 'struct': 'CXLDCExtentRecord',
+  'data': {
+      'region-id': 'uint8',
+      'dpa':'uint64',
+      'len': 'uint64'
+  }
+}
+
+##
+# @cxl-add-dynamic-capacity-event:
+#
+# Command to add dynamic capacity extent event
+#
+# @path: CXL DCD canonical QOM path
+# @extents: Extents to add
+#
+##
+{ 'command': 'cxl-add-dynamic-capacity-event',
+  'data': { 'path': 'str',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
+
+##
+# @cxl-release-dynamic-capacity-event:
+#
+# Command to release dynamic capacity extent event
+#
+# @path: CXL DCD canonical QOM path
+# @extents: Extents to release
+#
+##
+{ 'command': 'cxl-release-dynamic-capacity-event',
+  'data': { 'path': 'str',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
--=20
2.25.1
