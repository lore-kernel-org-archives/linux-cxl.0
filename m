Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E2FEB64DD
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjGYSkQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjGYSkI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:08 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD7D199A
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:59 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183958usoutp01ca4219ae688b3d67582e7d7dfbddb25f~1MFoViZvN1010010100usoutp01b;
        Tue, 25 Jul 2023 18:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230725183958usoutp01ca4219ae688b3d67582e7d7dfbddb25f~1MFoViZvN1010010100usoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310398;
        bh=oq8OuyNlcK46NtOYiH/dkrYZOBLYrhi5/Gt4g5ls/rw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aYqCab9nFQZddCJW7mBY795lZJXuB0laTYmuIoIvCnHmBi+LpoEQTk6+vGrbXYblS
         re5zCazI6uz+S0On4ZFONpdMxwnFzNTuAA1tL0ySvf++B+xjvdBBvRwDvlMJnyhNoh
         v8kaNx3GmeSi0N1IS0w+/3CMCm1grKwqyInRcqtI=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183958uscas1p13a01ccdf75fc954ec0c4d28f21e96544~1MFn-v4Eo1453314533uscas1p1_;
        Tue, 25 Jul 2023 18:39:58 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 24.11.42611.EF610C46; Tue,
        25 Jul 2023 14:39:58 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p1ebf676c30d21896d1fd7f9b652250449~1MFnpsX0j0317903179uscas1p1x;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-47-64c016fec26d
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id D4.54.38326.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 25 Jul 2023 11:39:56 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        25 Jul 2023 11:39:56 -0700
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
Subject: [Qemu PATCH v2 8/9] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Thread-Topic: [Qemu PATCH v2 8/9] hw/cxl/events: Add qmp interfaces to
        add/release dynamic capacity extents
Thread-Index: AQHZvydoteAcJguFu0q3LwS06vqHoA==
Date:   Tue, 25 Jul 2023 18:39:56 +0000
Message-ID: <20230725183939.2741025-9-fan.ni@samsung.com>
In-Reply-To: <20230725183939.2741025-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djX87r/xA6kGNzaw2HRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8bbxjlMBU0eFZfOvWRpYHxp2sXIySEhYCJx6+Aaxi5GLg4hgZWMEj8bjjFDOK1M
        Ev/eLGeHqzq1E6pqLaPEyveX2CCcT4wS95a+hHKWMUq8af/FDNLCJqAosa9rOxuILSJgLHHs
        8BKwucwCb1kkPq55wwKSEBbIkDg16xMLRFGuxMr99xkhbD2J/gtLmEBsFgFViRtHjoDFeQUs
        JQ7O/swKYnMKWEk8+zIbzGYUEJP4fmoNWD2zgLjErSfzmSDuFpRYNHsPM4QtJvFv10M2CFte
        YvKPGVC2osT97y/ZIXr1JG5MncIGYWtLLFv4mhlir6DEyZlPWCDqJSUOrrjBAvKMhMBkTomu
        D5ehlrlIfJrzDKpIWuLq9alAzRxAdrLEqo9cEOEciflLtkCVWEss/LOeaQKjyiwkZ89CcsYs
        JGfMQnLGAkaWVYzipcXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEJ7vS/w/k7GK/f+qh3iJGJ
        g/EQowQHs5IIr2HMvhQh3pTEyqrUovz4otKc1OJDjNIcLErivIa2J5OFBNITS1KzU1MLUotg
        skwcnFINTI2SG+p2nrv9aXJy07Z6E32j6Wv5S6/0CZxlejk9JvafVgDbqn/nPi5oLdyw0+GT
        hdDrhTvSoxVORMTFKOlXrr0deLvLa+rVAs43vbsSsuMF566MWHJlLn/Qi9uKh3799s5wrCjJ
        PcBYMGPRM+aA569vCMxnfcgnN2dH9oE6W3fPVw5zFRPZs6XbP/vNu/+W9XgDk6ic5GfJP5xc
        K08pvn/02PD//OALWmuW6FxNl9ureLY6LGL6211OnQxz72xYflx1T1+O/Nd9ztdDpMKW//oQ
        3yVjb7q/ztTIb23P50avlmeX+ZaGmpSLCD5z8lw7/ZuxiU70h4m7X6d9OPvkW0ab4/d1ndwt
        FRcfbLS5YajEUpyRaKjFXFScCACL3ZRu3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0gTYRjHee9u2zkbXMv01ULTstBotiw6V1SUxlX/jCDKsmy1wy23ZTst
        S6glq0Cz3FTSWz9xpalEaVmSVOqy1GibyJhDK5Y1x4ooy/WDrK0j8L/P93m+3/d5HnhxVOzD
        4nC1rpDW6xSaJL4QUxsQ05Lf0U+US++a0shy+21AXqhxALJ5uAWQhlIvRhoffkLIx+98GNl0
        zcUn7Ww/RvpMPoS8bvWi5LOKB9i6SMpRVcmj6g1ZVAc7KqCMto8h1elHqDuf/wioMVcbQrUF
        xlGqxnKCmmiNlwt3ClcraY36MK1PW7NXqPp48iJSUEoVD770YwbgX1EGInBILIee/g5QBoS4
        mGgG0D5qRDjxBcA+6ycBJ24AeKW+GYQjfCIRPiq7zw9zFJEOe3usaJhRIoDBSWdkmGcRKhio
        bgrV8ZBHCxt75ZxdAs87rEiYMSIZum22f0+KiAzYZZnghe3iEN8z7QmXIwgZfP/VwgszIKJh
        sL8F4SbFQM/YFYQ7gIDWTjvK8WzofzvF4zgBVn2v5XOcCF8H/QIuK4Hummo+x4vhjWsBlFth
        JuyrG8M4fyzsanRjlQCy08ax0+LstDg7LX4VYE0gpohhtHnFjFRHH5EwCi1TpMuT7D+obQWh
        vzAw1ZP9ADz1fJZ0AwQH3QDiaFKUSJrzSCkWKRVHj9H6g7n6Ig3NdIM5OJYUIxJnmXLFRJ6i
        kM6n6QJa/7+L4BFxBqR8pHzr5Rf+b9K8eT9Hbjr7XzWIfiwcv7R6frbl1njdyj+42yqjzHxT
        aoW48tAydIXcdrwhRebadDM5Mz2dYBuPREm63p7+1TmYWMfOT840Lw6smTn0zGXR9KROVp0o
        N3qlwoSJA6c3xFtaneeYd7t6sWKHswRkD9h41wMt7rQU+Y7j+84Y5wTb1fkF8rNTNbe2bR/b
        uHn9h82ZZscHMzA/yUXa9BVbGmqDA+3VmqgO8pXdiZ0zSLLMZV3m3dHKRWlvVgli8zPavHOD
        rZdK1m4smWVeamv3LCkYqWf75hl86ycWeJc3xsq0z+sT+NF1qpOnZoiGzgzvSFR5InMkSRij
        UkhTUT2j+AviSwS6egMAAA==
X-CMS-MailID: 20230725183957uscas1p1ebf676c30d21896d1fd7f9b652250449
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183957uscas1p1ebf676c30d21896d1fd7f9b652250449
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p1ebf676c30d21896d1fd7f9b652250449@uscas1p1.samsung.com>
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
index f1170b8047..41a828598a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1817,6 +1817,151 @@ void qmp_cxl_inject_memory_module_event(const char =
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
+    uint8_t rid =3D 0;
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
