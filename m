Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB8C7EE22
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjEKSYJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjEKSYI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:24:08 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55FC10C6
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:24:06 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175642usoutp02df6b7caf1db5c7964604db29db295e38~eKHcYI77O2377423774usoutp02n;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230511175642usoutp02df6b7caf1db5c7964604db29db295e38~eKHcYI77O2377423774usoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827802;
        bh=drqPJBiApwcNYY9N2OmW3kEYbqgOgaqjVzvL7Zi3zKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bLnzLE+ie0b1gvn2aMpYzD+vyyu4oTTJ06mXAi8CJ2oAyyl9Kak8RfusphTXK3Wsp
         3sheNz22Z6G5/jZOeZaqjOgVMC7Z38kGBuM1U3fplbm99ONMFGJlssik4sikAlxGvU
         f09zSlLfH989oxtuZgjYGi8M/cyrHxbfBJjvd3V8=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p2db67b9bfa163413fd907aea261b78ad8~eKHcQB_pb2037920379uscas1p2S;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 9A.93.20392.A5C2D546; Thu,
        11 May 2023 13:56:42 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p27cf2915c8184225bfd581fb6f6dfb2d9~eKHb7Hxc32038420384uscas1p2G;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
X-AuditID: cbfec370-81ffe70000024fa8-f9-645d2c5a62d2
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 59.7F.38326.95C2D546; Thu,
        11 May 2023 13:56:42 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 10:56:41 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 10:56:41 -0700
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
Subject: [RFC 6/7] Add qmp interfaces to add/release dynamic capacity
 extents
Thread-Topic: [RFC 6/7] Add qmp interfaces to add/release dynamic capacity
        extents
Thread-Index: AQHZhDHweOj1egr3rka/i5lzMWKESQ==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-7-fan.ni@samsung.com>
In-Reply-To: <20230511175609.2091136-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djXc7pROrEpBu+vSFp0n9/AaDF96gVG
        i9U31zBaNDQ9YrFo2f2eyWL/0+csFqsWXmOzOD/rFIvF84nPmSyWLnnEbHG8dweLA7fHhckT
        WD0WN7h67Jx1l92j5chbIG/PSyaPjR//s3s8ubaZyWPz6xfMHlNn13t83iQXwBXFZZOSmpNZ
        llqkb5fAlfFr0Tm2gu1WFQt+tzE3MP7T62Lk5JAQMJG43XaQrYuRi0NIYCWjxJltT9khnFYm
        iXdzZ7LBVN1Y8B0qsZZR4v+9FcwQzidGiabTL1khnGWMEu+/72EGaWETUJTY17UdrF1EwFji
        2OElYB3MAm9ZJD6uecMCkhAW8JeY3nuaHaIoROLP78OsELaeRNeEv2A1LAKqEudu7GAEsXkF
        LCX6DnxlArE5BawkNjSfALMZBcQkvp9aA2YzC4hL3HoynwnibkGJRbMhDpIAqvm36yHUP/IS
        k3/MgLIVJe5/f8kO0asncWPqFDYIW1ti2cLXzBB7BSVOznzCAlEvKXFwxQ0WkGckBPo5JebM
        OgE1yEWip7uFHcKWlrh6fSpQMweQnSyx6iMXRDhHYv6SLVBzrCUW/lnPNIFRZRaSs2chOWMW
        kjNmITljASPLKkbx0uLi3PTUYuO81HK94sTc4tK8dL3k/NxNjMAEd/rf4YIdjLdufdQ7xMjE
        wXiIUYKDWUmE9+2S6BQh3pTEyqrUovz4otKc1OJDjNIcLErivIa2J5OFBNITS1KzU1MLUotg
        skwcnFINTJGSdY3TFNOzL9n1L9TYuMuW62/TsdsbAllsNhYmBrEVh1+8dP9Yv5JOUYDQYs0Z
        /lsNZJ07s3nf7/H2dQrdKsFxTnYl332ucp8f0/eJSTVtXTmTK+6oxBL5OY/OXJNl6L86S1k2
        3tuAYYt+4wr7Fdxf3jImLk/+f7xT97apzuTabftadtv0n+n8OY0p8vdh+UCXFyr+VgccNHZ7
        3Vi53Of8ZrOKTaLhcXs574mtTVHp1Juzy6Hydcg7KauEu4/mcyzpnrZFeeWf1A/vOm9m3ink
        rLfh/sun8YnVIO9ozhH+bVzHQqafKngUWT/nwT6ODvWQf26vZm9gXy7XJNcRExm+rqNatKpS
        ZnPTNh5hJZbijERDLeai4kQAxEcGL98DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0STdKJzbF4P5EFovu8xsYLaZPvcBo
        sfrmGkaLhqZHLBYtu98zWex/+pzFYtXCa2wW52edYrF4PvE5k8XSJY+YLY737mBx4Pa4MHkC
        q8fiBlePnbPusnu0HHkL5O15yeSx8eN/do8n1zYzeWx+/YLZY+rseo/Pm+QCuKK4bFJSczLL
        Uov07RK4Mn4tOsdWsN2qYsHvNuYGxn96XYycHBICJhI3Fnxn72Lk4hASWM0osXVnMyuE84lR
        4t7SgywQzjJGicat61hBWtgEFCX2dW1nA7FFBIwljh1ewgxiMwu8ZpH4dpEbxBYW8JXo3b2G
        BaImROLWlqPMELaeRNeEv2BxFgFViXM3djCC2LwClhJ9B74ygdhCQPbHnzvZQWxOASuJDc0n
        wOKMAmIS30+tYYLYJS5x68l8JogXBCSW7DnPDGGLSrx8/I8VwpaXmPxjBhuErShx//tLdohe
        PYkbU6ewQdjaEssWvmaGuEFQ4uTMJywQ9ZISB1fcYJnAKDELybpZSNpnIWmfhaR9ASPLKkbx
        0uLi3PSKYsO81HK94sTc4tK8dL3k/NxNjMDUcPrf4cgdjEdvfdQ7xMjEwXiIUYKDWUmE9+2S
        6BQh3pTEyqrUovz4otKc1OJDjNIcLErivEKuE+OFBNITS1KzU1MLUotgskwcnFINTPJfu1Qs
        cjmjYovv9ZWWLQ0L2sPrsuFGZPGZUxmLo/Xy51s12WjFfpR682qlxdRfZZlJz9vPHG82PaSp
        LO175VVraZVOsaOVWXSJiv93J6EwqZKZ4mdDJl7eeuTqEZdvQfNvvfNmb9ug3LZT5n/5dklt
        s+r7c+ys+PZYtX56UOydejLD2qQ8Ra6Pz9ZOW26WUExrvqOM2+J+/7X5sSnrVx0wyo1jljgp
        8mXH9EupysYfnabzB/bPsJZXY1yw9IpZmfSPfTJ3LY3ucM01cU3Yq/Jqzm/VmMzEihoeo23v
        3M09RCq4++MTNzgxC5Vs+LzwdfLOyqNzmiP2fZSU1737rWXCQfvKU4ddJB099iuxFGckGmox
        FxUnAgD6twOCfAMAAA==
X-CMS-MailID: 20230511175642uscas1p27cf2915c8184225bfd581fb6f6dfb2d9
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175642uscas1p27cf2915c8184225bfd581fb6f6dfb2d9
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p27cf2915c8184225bfd581fb6f6dfb2d9@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Since fabric manager emulation is not supported yet, the change implements
the functions to add/release dynamic capacity extents as QMP interfaces.

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each is 128MB
long) to region 0 (starting at dpa offset 0) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity-event",
    "arguments": {
	"path": "/machine/peripheral/cxl-pmem0",
	"region-id" : 0,
	"num-extent": 2,
	"dpa":0,
	"extent-len": 128
	}
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MB from region
0 (starting at dpa offset 0) look like below:

{ "execute": "cxl-release-dynamic-capacity-event",
	"arguments": {
		 "path": "/machine/peripheral/cxl-pmem0",
		"region-id" : 0,
		 "num-extent": 1 ,
		"dpa":0,
		"extent-len": 128
	}
}

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c          | 127 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_events.h |  16 +++++
 qapi/cxl.json               |  44 +++++++++++++
 3 files changed, 187 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 23954711b5..70d47d43b9 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1651,6 +1651,133 @@ void qmp_cxl_inject_memory_module_event(const char =
*path, CxlEventLog log,
     }
 }
=20
+static const QemuUUID dynamic_capacity_uuid =3D {
+	.data =3D UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+			0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+static void qmp_cxl_process_dynamic_capacity_event(const char *path, CxlEv=
entLog log,
+		uint8_t flags, uint8_t type, uint16_t hid, uint8_t rid, uint32_t extent_=
cnt,
+		CXLDCExtent_raw *extents, Error **errp)
+{
+	Object *obj =3D object_resolve_path(path, NULL);
+	CXLEventDynamicCapacity dCap;
+	CXLEventRecordHdr *hdr =3D &dCap.hdr;
+	CXLDeviceState *cxlds;
+	CXLType3Dev *dcd;
+	int i;
+
+	if (!obj) {
+		error_setg(errp, "Unable to resolve path");
+		return;
+	}
+	if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+		error_setg(errp, "Path not point to a valid CXL type3 device");
+		return;
+	}
+
+	dcd =3D CXL_TYPE3(obj);
+	cxlds =3D &dcd->cxl_dstate;
+	memset(&dCap, 0, sizeof(dCap));
+
+	if (!dcd->dc.num_regions) {
+		error_setg(errp, "No dynamic capacity support from the device");
+		return;
+	}
+
+	/*
+	 * 8.2.9.1.5
+	 * All Dynamic Capacity event records shall set the Event Record
+	 * Severity field in the Common Event Record Format to Informational
+	 * Event. All Dynamic Capacity related events shall be logged in the
+	 * Dynamic Capacity Event Log.
+	 */
+	assert(flags & (1<<CXL_EVENT_TYPE_INFO));
+	cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap))=
;
+
+	/*
+	 * 00h: add capacity
+	 * 01h: release capacity
+	 * 02h: forced capacity release
+	 * 03h: region configuration updated
+	 * 04h: Add capacity response
+	 * 05h: capacity released
+	 **/
+	dCap.type =3D type;
+	stw_le_p(&dCap.host_id, hid);
+	dCap.updated_region_id =3D rid;
+	for (i =3D 0; i < extent_cnt; i++) {
+		extents[i].start_dpa +=3D dcd->dc.regions[rid].base;
+		memcpy(&dCap.dynamic_capacity_extent, &extents[i]
+				, sizeof(CXLDCExtent_raw));
+
+		if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
+					(CXLEventRecordRaw *)&dCap)) {
+			;
+		}
+		cxl_event_irq_assert(dcd);
+	}
+}
+
+#define MEM_BLK_SIZE_MB 128
+void qmp_cxl_add_dynamic_capacity_event(const char *path, uint8_t region_i=
d,
+		uint32_t num_exent, uint64_t dpa, uint64_t extent_len_MB, Error **errp)
+{
+	uint8_t flags =3D 1 << CXL_EVENT_TYPE_INFO;
+	CXLDCExtent_raw *extents;
+	int i;
+
+	if (extent_len_MB < MEM_BLK_SIZE_MB) {
+		error_setg(errp,
+			"extent size cannot be smaller than memory block size (%dMB)",
+			MEM_BLK_SIZE_MB);
+		return;
+	}
+
+	extents =3D g_new0(CXLDCExtent_raw, num_exent);
+	for (i =3D 0; i < num_exent; i++) {
+		extents[i].start_dpa =3D dpa;
+		extents[i].len =3D extent_len_MB*1024*1024;
+		memset(extents[i].tag, 0, 0x10);
+		extents[i].shared_seq =3D 0;
+		dpa +=3D extents[i].len;
+	}
+
+	qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
+			flags, 0x0, 0, region_id, num_exent, extents, errp);
+
+	g_free(extents);
+}
+
+void qmp_cxl_release_dynamic_capacity_event(const char *path, uint8_t regi=
on_id,
+		uint32_t num_exent, uint64_t dpa, uint64_t extent_len_MB, Error **errp)
+{
+	uint8_t flags =3D 1 << CXL_EVENT_TYPE_INFO;
+	CXLDCExtent_raw *extents;
+	int i;
+
+	if (extent_len_MB < MEM_BLK_SIZE_MB) {
+		error_setg(errp,
+			"extent size cannot be smaller than memory block size (%dMB)",
+			MEM_BLK_SIZE_MB);
+		return;
+	}
+
+	extents =3D g_new0(CXLDCExtent_raw, num_exent);
+	for (i =3D 0; i < num_exent; i++) {
+		extents[i].start_dpa =3D dpa;
+		extents[i].len =3D extent_len_MB*1024*1024;
+		memset(extents[i].tag, 0, 0x10);
+		extents[i].shared_seq =3D 0;
+		dpa +=3D extents[i].len;
+	}
+
+	qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
+			flags, 0x1, 0, region_id, num_exent, extents, errp);
+
+	g_free(extents);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 089ba2091f..dd00458d1d 100644
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
+	CXLEventRecordHdr hdr;
+	uint8_t type;
+	uint8_t reserved1;
+	uint16_t host_id;
+	uint8_t updated_region_id;
+	uint8_t reserved2[3];
+	uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
+	uint8_t reserved[0x20];
+} QEMU_PACKED CXLEventDynamicCapacity;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 8b3d30cd71..c9a9a45ce4 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -264,3 +264,47 @@
             'type': 'CxlCorErrorType'
   }
 }
+
+##
+# @cxl-add-dynamic-capacity-event:
+#
+# Command to add dynamic capacity extent event
+#
+# @path: CXL DCD canonical QOM path
+# @region-id: region id
+# @num-extent: number of extents to add, test only
+# @dpa: start dpa for the operation
+# @extent-len: extent size in MB
+#
+# Since: 8.0
+##
+{ 'command': 'cxl-add-dynamic-capacity-event',
+  'data': { 'path': 'str',
+           'region-id': 'uint8',
+           'num-extent': 'uint32',
+           'dpa':'uint64',
+           'extent-len': 'uint64'
+  }
+}
+
+##
+# @cxl-release-dynamic-capacity-event:
+#
+# Command to add dynamic capacity extent event
+#
+# @path: CXL DCD canonical QOM path
+# @region-id: region id
+# @num-extent: number of extents to add, test only
+# @dpa: start dpa for the operation
+# @extent-len: extent size in MB
+#
+# Since: 8.0
+##
+{ 'command': 'cxl-release-dynamic-capacity-event',
+  'data': { 'path': 'str',
+           'region-id': 'uint8',
+           'num-extent': 'uint32',
+           'dpa':'uint64',
+           'extent-len': 'uint64'
+  }
+}
--=20
2.25.1
