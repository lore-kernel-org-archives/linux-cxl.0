Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F8204697
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649589; cv=none; b=LTMlrda57bmO4Yhoeddyy0I9nON2CU1wFtKb1uhL1o1c7bKtM5A6YVeO7vHZ+rNT/ENNjJeOIk89WthPZvYrh1R/4JjA1vGmy/qAFri52G21VP5k4pHmxMTPSFjzja36SzU/owdLtGuDFbgCXokx2m35s1CS7kXXtmPyB79AyMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649589; c=relaxed/simple;
	bh=6FnAeLXiKfLOB+yIc+WpoLUpXh/d4xRzxWYF52cVcho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=jskPx4tUcbm5AkTuTtoJURY/l+buzo/T1pql072pFwli9wLRKTxSvooDQqaAcOyDo+2v7O1dusmnlCb3nIFCOMjmD/UHgpYhpqyBg/jUdmjJAcaOxfSPjksPUlD7+a8/03yfWZN5Xdg0rqNj/+i1knZKzJizd9C4fgHZV+RxQao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=S8e3+24R; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="S8e3+24R"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250204061304epoutp01bea3fbca3c5bf838a3146482a6daf1b7~g7JXEhC2o2230722307epoutp01_
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 06:13:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250204061304epoutp01bea3fbca3c5bf838a3146482a6daf1b7~g7JXEhC2o2230722307epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738649584;
	bh=7eYVIhQTCURr+8LboGawPPUEnkFdSlOJyIkhWcu6ITw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8e3+24RyJkZ7SiY8hLHhDofgGAHjA0pq+AoIATrDcChRjdZ+OnYzH0mIhXRdJrT6
	 +trs0MjhL02Yq1hjURTvRNNJ32kyT561264z0T1IGiZnwVoJehEqWcaEHLTqgC+fAQ
	 OLLc4oH7NAGbAyl/glICp5bf7CI7ljGdwXXgCOCE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250204061303epcas5p3840ec0f71d38af2ce71803577354bb7a~g7JWsAmYj1750617506epcas5p3O;
	Tue,  4 Feb 2025 06:13:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YnCht2BdKz4x9Q7; Tue,  4 Feb
	2025 06:13:02 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.0E.19956.AEFA1A76; Tue,  4 Feb 2025 15:12:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121~gnVan4Oz53204032040epcas5p3H;
	Mon,  3 Feb 2025 06:00:51 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203060051epsmtrp1bfca7cc2e321ba22f951ef352dbf8259~gnVanBq-U2496624966epsmtrp1a;
	Mon,  3 Feb 2025 06:00:51 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-63-67a1afea1792
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.EE.23488.39B50A76; Mon,  3 Feb 2025 15:00:51 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250203060050epsmtip2bb19ad36dfd182998c65f041ba376d93~gnVZMqGT42702127021epsmtip21;
	Mon,  3 Feb 2025 06:00:50 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get Log
 Capabilities (Opcode 0402h)
Date: Mon,  3 Feb 2025 11:29:48 +0530
Message-Id: <20250203055950.2126627-2-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmlu6r9QvTDXoPqltMP6xo8eX0HjaL
	3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
	vi2rGD2mzq73+LxJLoA1KtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
	1VbJxSdA1y0zB+gmJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWle
	ul5eaomVoYGBkSlQYUJ2xuP9O5gKpulUzFi2k6mBcZVCFyMnh4SAicSq/x1sILaQwG5GiUtr
	dbsYuYDsT4wSFw6vZ4FwvjFK/PlzjamLkQOs48RHqPheRokz3RdYIZwGJolthyeBjWIT0JE4
	f3sumC0iICnxu+s0M0gRs8AbRokHVxcwgySEBTIkOu+3MoLYLAKqEquPHmIBsXkF7CUmvbzJ
	BnGfvMT+g2fB6jkFHCR+bL7JClEjKHFy5hOwemagmuats5kh6v+ySzz7Lw5hu0hc/9MOFReW
	eHV8CzuELSXxsr8Nys6W+DO/HWpXgcSinzOh4vYSraf6mUE+ZhbQlFi/Sx8iLCsx9dQ6Joi1
	fBK9v58wQcR5JXbMg7HVJNp3zIcaIyPx5tdiqPEeEvfmzGWGBNZkRomFL4+wTmBUmIXknVlI
	3pmFsHoBI/MqRsnUguLc9NRi0wLjvNRyeCQn5+duYgQnUy3vHYyPHnzQO8TIxMF4iFGCg1lJ
	hPf09gXpQrwpiZVVqUX58UWlOanFhxhNgeE9kVlKNDkfmM7zSuINTSwNTMzMzEwsjc0MlcR5
	m3e2pAsJpCeWpGanphakFsH0MXFwSjUw2aw/6LflyIobSxlcTt/atsaof83Ls5kWU3tWnrA8
	MEPlzXLe/ZlPrHX53AqVkt+0OwdHhO77rqs4beK78uKe7r+ncjcZfTHx1JdxfCudcdNc0eCj
	8wMnUb64sHibqAcam5aY/J13pnpq+uZVkVYvnv+2f8hRc+lVQfrFi8zv+Rawh247M6emLDTM
	Rn+rf8Lvu1kLmS7LVbgsfHHndWjU9Pj0/9zHk25lpCdOcZS/drL/wzWFz0Fy6kJz82bZnl58
	KX1JX/MH88Ntk0wmHxTLFbxvec3V+FGyuNur3Sx5ugJTd27Yr1C/8GHih7Md611UK0W31Hot
	+sD6IivrVSfHVr5fW9UUl77aEfe4PN9fR4mlOCPRUIu5qDgRAJ/DqJovBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSvO7k6AXpBlO/q1hMP6xo8eX0HjaL
	3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
	vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugSvj8f4dTAXTdCpmLNvJ1MC4SqGLkYNDQsBE
	4sRHli5GLg4hgd2MErs2bWTsYuQEistIXJz5mAXCFpZY+e85O0TRP0aJf5v+s4Ek2AR0JM7f
	ngtmiwhISvzuOs0MUsQs8I1RYs6tF6wgCWGBNInOGRfZQWwWAVWJ1UcPgU3lFbCXmPTyJhvE
	BnmJ/QfPMoPYnAIOEj823wTrFQKqOd9+hAmiXlDi5MwnYL3MQPXNW2czT2AUmIUkNQtJagEj
	0ypGydSC4tz03GTDAsO81HK94sTc4tK8dL3k/NxNjOCA19LYwfjuW5P+IUYmDsZDjBIczEoi
	vByH56QL8aYkVlalFuXHF5XmpBYfYpTmYFES511pGJEuJJCeWJKanZpakFoEk2Xi4JRqYAp3
	YdZpcF0yqe3VdN+/h1XVjl75e/F5iF7shBVzvBgyk75t+D+7nnOthlDQYt/Q0w47j/XfW9qy
	xGDFu6D9kco3YkTiLWU+mRXoKIhM405aej7r3KbbIp8+cp1ue1dSrZP9vULPsFVKr+5ofkG0
	n9vZdQ0bF2XPfqXIuWSVxfz/Aol3pn0Pb2dnMpzQM8+C8ZeFWfiP35dYRKPOiW9ufh9q6rno
	085z5w+6V3mzXr7w29b3vuuSE77skdJT4l/EabToW0hHz3t1KZSj79FDw1txwulinjYnHCI+
	XPWYaLXwNmuUjm+HYzmTsf/93KoKD36WWefXOy59y3ExX1BFOGl/wL3mG9Xas9pTBS79UmIp
	zkg01GIuKk4EAK65lk/nAgAA
X-CMS-MailID: 20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121
References: <20250203055950.2126627-1-arpit1.kumar@samsung.com>
	<CGME20250203060051epcas5p350b7b24d3b5fcff25bc30e1acccd8121@epcas5p3.samsung.com>

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Reviewed-by: Alok Rathore <alok.rathore@samsung.com>
Reviewed-by: Krishna Kanth Reddy <krish.reddy@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 55 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h  | 31 ++++++++++++++++++++
 include/hw/cxl/cxl_mailbox.h |  5 ++++
 3 files changed, 91 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..3d66a425a9 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -76,6 +76,7 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+        #define GET_LOG_CAPABILITIES   0x2
     FEATURES    = 0x05,
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
@@ -1075,6 +1076,45 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static int32_t valid_log_check(QemuUUID *uuid, CXLCCI *cci)
+{
+    int32_t id = -1;
+    for (int i = CEL; i < MAX_LOG_TYPE; i++) {
+        if (qemu_uuid_is_equal(uuid,
+            &cci->supported_log_cap[i].uuid)) {
+            id = i;
+            break;
+        }
+    }
+    return id;
+}
+
+/* CXL r3.1 Section 8.2.9.5.3: Get Log Capabilities (Opcode 0402h) */
+static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    int32_t cap_id;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * get_log_capabilities_in = (void *)payload_in;
+
+    CXLParamFlags *get_log_capabilities_out = (void *)payload_out;
+
+    cap_id = valid_log_check(&get_log_capabilities_in->uuid, cci);
+    if (cap_id == -1) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    memcpy(get_log_capabilities_out, &cci->supported_log_cap[cap_id].param_flags.pflags,
+           sizeof(CXLParamFlags));
+    *len_out = sizeof(*get_log_capabilities_out);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2840,6 +2880,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
+                                     cmd_logs_get_log_capabilities, 0x10, 0 },
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
@@ -3084,10 +3126,23 @@ static void cxl_rebuild_cel(CXLCCI *cci)
     }
 }
 
+static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
+    [CEL] = {.param_flags.pflags = CXL_LOG_CAP_CLEAR | CXL_LOG_CAP_POPULATE,
+             .uuid = cel_uuid},
+};
+
+static void cxl_init_get_log(CXLCCI *cci)
+{
+    for (int set = CEL; set < MAX_LOG_TYPE; set++) {
+        cci->supported_log_cap[set] = cxl_get_log_cap[set];
+    }
+}
+
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
     cci->payload_max = payload_max;
     cxl_rebuild_cel(cci);
+    cxl_init_get_log(cci);
 
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..e7cb99a1d2 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -164,6 +164,18 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* types of logs */
+enum Logs {
+    CEL,
+    VDL,
+    CSDL,
+    ECSL,
+    MTCL,
+    MTRSL,
+    MTRLL,
+    MAX_LOG_TYPE
+};
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -194,6 +206,22 @@ typedef struct CXLEventLog {
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
 
+typedef struct CXLParamFlags {
+    union {
+        uint32_t clear_log_supported:1;
+        uint32_t populate_log_supported:1;
+        uint32_t auto_populate_supported:1;
+        uint32_t persistent_across_cold_reset:1;
+        uint32_t reserved:28;
+        uint32_t pflags;
+    };
+} CXLParamFlags;
+
+typedef struct CXLLogCapabilities {
+    CXLParamFlags param_flags;
+    QemuUUID uuid;
+} CXLLogCapabilities;
+
 typedef struct CXLCCI {
     struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
@@ -202,6 +230,9 @@ typedef struct CXLCCI {
     } cel_log[1 << 16];
     size_t cel_size;
 
+    /* get log capabilities */
+    CXLLogCapabilities supported_log_cap[MAX_LOG_TYPE];
+
     /* background command handling (times in ms) */
     struct {
         uint16_t opcode;
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..f3502c3f68 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -16,4 +16,9 @@
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
 
+#define CXL_LOG_CAP_CLEAR 1
+#define CXL_LOG_CAP_POPULATE (1 << 1)
+#define CXL_LOG_CAP_AUTO_POPULATE (1 << 2)
+#define CXL_LOG_CAP_PERSISTENT_COLD_RESET (1 << 3)
+
 #endif
-- 
2.34.1

