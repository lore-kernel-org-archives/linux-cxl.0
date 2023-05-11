Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB28C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 17:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbjEKR6I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 13:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjEKR5s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 13:57:48 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89446A246
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 10:57:17 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175642usoutp010075b2527e4d5104a13b51c5ae9fba33~eKHcDRZ4c3198731987usoutp01q;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230511175642usoutp010075b2527e4d5104a13b51c5ae9fba33~eKHcDRZ4c3198731987usoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827802;
        bh=b20nz0VaweLqQdC3LPv3vj8OGNqr5dkkVxALkb0s/r4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pZA80jD7ZJIoWrXZEdiANl2azivZvR0fK2kCQVYZh62OKWXFGXQ1yzeLdEtGjvyKU
         dvPZAHxKnOSM52SoBcGGso8RTINdZcBdeVxoOrcr5TD23+WuUWUVBiD+i//w+TDgi6
         DcRCvJwozLw+CN6mwSSlulkfEqrbZrlqHM9rhcUk=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p2cc2d90d8793af33c913386e689233b33~eKHb5YJeV2440824408uscas1p2D;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id DE.8A.19925.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511175641uscas1p165a19a1416facf6603bf1a417121f0dc~eKHbZe8Y_2473124731uscas1p1n;
        Thu, 11 May 2023 17:56:41 +0000 (GMT)
X-AuditID: cbfec36d-975ff70000004dd5-84-645d2c591473
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 98.7F.38326.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 10:56:40 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 10:56:40 -0700
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
Subject: [RFC 2/7] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region
 representative and mailbox command support
Thread-Topic: [RFC 2/7] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
        region representative and mailbox command support
Thread-Index: AQHZhDHwZg5veepn5EaQyLC3G3XrlA==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-3-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djX87pROrEpBnf1LLrPb2C0mD71AqPF
        6ptrGC0amh6xWLTsfs9ksf/pcxaLVQuvsVmcn3WKxeL5xOdMFkuXPGK2ON67g8WB2+PC5Ams
        HosbXD12zrrL7tFy5C2Qt+clk8fGj//ZPZ5c28zksfn1C2aPqbPrPT5vkgvgiuKySUnNySxL
        LdK3S+DK2HttL2vBbZWKRce3sTYwzpDrYuTkkBAwkZi1YTZbFyMXh5DASkaJaQ8msEM4rUwS
        058+ZYGpurdzIxNEYi2jxOmWVcwQzidGicOL/kI5yxgl/i68ywbSwiagKLGvazuYLSJgLHHs
        8BKwImaBtywSH9e8AZsrLFAqsanxKhNEUZXEzY0HoGw9iTMfT4PVsAioSpy7sYMRxOYVsJQ4
        f6wFLM4pYCWxofkEWD2jgJjE91NrwGxmAXGJW0/mM0HcLSixaPYeZghbTOLfrodsELa8xOQf
        M6BsRYn731+yQ/TqSdyYOoUNwtaWWLbwNTPEXkGJkzOfQMNCUuLgihssIM9ICPRzShy+0sMI
        kXCRONQ6G8qWlrh6fSpQMweQnSyx6iMXRDhHYv6SLVBzrCUW/lnPNIFRZRaSs2chOWMWkjNm
        ITljASPLKkbx0uLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMD0dvrf4dwdjDtufdQ7xMjEwXiI
        UYKDWUmE9+2S6BQh3pTEyqrUovz4otKc1OJDjNIcLErivIa2J5OFBNITS1KzU1MLUotgskwc
        nFINTGu99HqKg1ROf7cOeXt35wv+JN2t1QIHsu6wK+rq9u9/6Bo+cUpIt722e5l++JMj8axd
        LU+7+bgz284ZlreZF/SEK2/Y4x/RkLO9zGnV1UNvLNYe2Z9TcVew4PWT/Qd+r5xnPndFbZL4
        pIqPFa1PvZrtAw9b2m2vL5wnVTdtb3RY5WwxtwVvqsqdnk7N8nutuV5gk8cswzO3jyw7/eH3
        2XDrJjP2FoZH/hYuKyyXyITbHu417xTW/y389uPe6ns3WFZ2f9H1LDhTLyFjF39080uNNYmq
        CUe3B1RzHQjd9+Jg4cJfx33/xy9N2M12+MNmhkMdd5sKdiydpvVd/WxY1eqJO/3X3n/M9Svf
        bdIDByWW4oxEQy3mouJEAJiYx0TeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWS2cA0STdSJzbFoKdF1qL7/AZGi+lTLzBa
        rL65htGioekRi0XL7vdMFvufPmexWLXwGpvF+VmnWCyeT3zOZLF0ySNmi+O9O1gcuD0uTJ7A
        6rG4wdVj56y77B4tR94CeXteMnls/Pif3ePJtc1MHptfv2D2mDq73uPzJrkArigum5TUnMyy
        1CJ9uwSujL3X9rIW3FapWHR8G2sD4wy5LkZODgkBE4l7OzcygdhCAqsZJZY0WHQxcgHZnxgl
        ut8dZYZwljFKbJ7cxQhSxSagKLGvazsbiC0iYCxx7PASZhCbWeA1i8S3i9wgtrBAqcSmxqtM
        EDVVEoc7JrNA2HoSZz6eBrNZBFQlzt3YATaTV8BS4vyxFhaIKywlPv7cyQ5icwpYSWxoPgE2
        h1FATOL7qTVMELvEJW49mc8E8YGAxJI955khbFGJl4//sULY8hKTf8xgg7AVJe5/f8kO0asn
        cWPqFDYIW1ti2cLXzBA3CEqcnPmEBaJeUuLgihssExglZiFZNwtJ+ywk7bOQtC9gZFnFKF5a
        XJybXlFsmJdarlecmFtcmpeul5yfu4kRmBhO/zscuYPx6K2PeocYmTgYDzFKcDArifC+XRKd
        IsSbklhZlVqUH19UmpNafIhRmoNFSZxXyHVivJBAemJJanZqakFqEUyWiYNTqoEprXjJ2qpb
        QndW/51yItzw+XHe97YG+SeWG/7Zd/7F7PV9QUEVuq+Me69qCy8OKHOfJHK70XhD8KP338vf
        x9kZXdr2dK7tPraVlQkVoft+fji5ruUX5zr5Dx2fGd6V1p92PscbKvL9P0dzQeg2bYEHXgWR
        byu0nJTmf/kj9MykSCmvYnE0V0912t2vMu2G7Jo37i94X+HYYsccuKCZXeBSvcY5z/kXQy26
        1lTNbA46seaau52UxedLaQmvE17Pt7d8v8av/3+sivTFjzddeiOMxSSbXvJPc/i+wGmfKre2
        TIlj22uNCqs1VQf8OkRLvlVKK3q4/PX7JRTElvpA4nRperelwcaPlzubpjEGtiuxFGckGmox
        FxUnAgCLUE87ewMAAA==
X-CMS-MailID: 20230511175641uscas1p165a19a1416facf6603bf1a417121f0dc
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p165a19a1416facf6603bf1a417121f0dc
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175641uscas1p165a19a1416facf6603bf1a417121f0dc@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Per cxl spec 3.0, add dynamic capacity region representative based on
Table 8-126 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 68 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 +++++++++
 2 files changed, 84 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7ff4fbdf22..61c77e52d8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -81,6 +81,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+	DCD_CONFIG =3D 0x48, /*8.2.9.8.9*/
+		#define GET_DC_REGION_CONFIG   0x0
     PHYSICAL_SWITCH =3D 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -935,6 +937,70 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cm=
d *cmd,
     return CXL_MBOX_SUCCESS;
 }
=20
+/*
+ * cxl spec 3.0: 8.2.9.8.9.2
+ * Get Dynamic Capacity Configuration
+ **/
+static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
+		CXLDeviceState *cxl_dstate,
+		uint16_t *len)
+{
+	struct get_dyn_cap_config_in_pl {
+		uint8_t region_cnt;
+		uint8_t start_region_id;
+	} QEMU_PACKED;
+
+    struct get_dyn_cap_config_out_pl {
+		uint8_t num_regions;
+		uint8_t rsvd1[7];
+		struct {
+			uint64_t base;
+			uint64_t decode_len;
+			uint64_t region_len;
+			uint64_t block_size;
+			uint32_t dsmadhandle;
+			uint8_t flags;
+			uint8_t rsvd2[3];
+		} QEMU_PACKED records[];
+	} QEMU_PACKED;
+
+	struct get_dyn_cap_config_in_pl *in =3D (void *)cmd->payload;
+	struct get_dyn_cap_config_out_pl *out =3D (void *)cmd->payload;
+	struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_ds=
tate);
+	uint16_t record_count =3D 0, i =3D 0;
+	uint16_t out_pl_len;
+
+	if (in->start_region_id >=3D ct3d->dc.num_regions)
+		record_count =3D 0;
+	else if (ct3d->dc.num_regions - in->start_region_id < in->region_cnt)
+		record_count =3D ct3d->dc.num_regions - in->start_region_id;
+	else
+		record_count =3D in->region_cnt;
+
+	out_pl_len =3D sizeof(*out) + record_count * sizeof(out->records[0]);
+	assert(out_pl_len <=3D CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+	memset(out, 0, out_pl_len);
+	out->num_regions =3D record_count;
+	for (; i < record_count; i++) {
+		stq_le_p(&out->records[i].base,
+			ct3d->dc.regions[in->start_region_id+i].base);
+		stq_le_p(&out->records[i].decode_len,
+			ct3d->dc.regions[in->start_region_id+i].decode_len);
+		stq_le_p(&out->records[i].region_len,
+			ct3d->dc.regions[in->start_region_id+i].len);
+		stq_le_p(&out->records[i].block_size,
+			ct3d->dc.regions[in->start_region_id+i].block_size);
+		stl_le_p(&out->records[i].dsmadhandle,
+			ct3d->dc.regions[in->start_region_id+i].dsmadhandle);
+		out->records[i].flags
+			=3D ct3d->dc.regions[in->start_region_id+i].flags;
+	}
+
+	*len =3D out_pl_len;
+	return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -973,6 +1039,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] =3D { "MEDIA_AND_POISON_CLEAR_POISON"=
,
         cmd_media_clear_poison, 72, 0 },
+	[DCD_CONFIG][GET_DC_REGION_CONFIG] =3D { "DCD_GET_DC_REGION_CONFIG",
+		cmd_dcd_get_dyn_cap_config, 2, 0 },
 };
=20
 static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e285369693..8a04e53e90 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -383,6 +383,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
=20
+#define DCD_MAX_REGION_NUM 8
+
+typedef struct CXLDCD_Region {
+	uint64_t base;
+	uint64_t decode_len; /* in multiples of 256MB */
+	uint64_t len;
+	uint64_t block_size;
+	uint32_t dsmadhandle;
+	uint8_t flags;
+} CXLDCD_Region;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -414,6 +425,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+	struct dynamic_capacity {
+		uint8_t num_regions; // 1-8
+		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
+	} dc;
 };
=20
 #define TYPE_CXL_TYPE3 "cxl-type3"
--=20
2.25.1
