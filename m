Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5722DFAF
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870073; cv=none; b=DIufhxPwBraKF5bBiOo79BUIDCQsuQed6gwt6I2gRusGtED3WeEbx5cG9ESnv29zTKYjC00ErVDkWRqwFkieGXSS72EeknXzvimYhwQ5l5r3427SmG6ezSEOQCeQdAoMIZNLjVYi69m7vS3Xc8MIkF0CYb4zvNJMi759MWpMfGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870073; c=relaxed/simple;
	bh=gjbE9p+SpbBly1zNXbli2cZypadHG8RbIh7E6c9ox+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=kCoHC0l1EH1Od9aoH9NYyEo3wHDyOX8EkJ0SQtTm2R+0ILC3NwRGJD0gih1kuv7XlpHn41Qj7P1PGepPFBCykZyI7CuokRuy94GCqs0asYOwuCXRG9TYYDeSswgXIovwV56Kjo+DSkgfOefSk6eucKmMsyTtQmXu2AjlCz9HoMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bEAWePt/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bEAWePt/"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250218091427epoutp03a5e4381dd5f6a35417bcea904e204b0e~lQpvHbg0A0065500655epoutp03S
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 09:14:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250218091427epoutp03a5e4381dd5f6a35417bcea904e204b0e~lQpvHbg0A0065500655epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739870067;
	bh=s8YhuUluRgNIJWlfbH0fQz1EsKw8ZflNWmxB30V49Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bEAWePt/RTm9KmEPOEV1UPGyFCopjewpARAgqpcWUw9KL17WsVRvlOGYpc4frYJZr
	 gpDSeQdyHorK2054AJfnUdajtJbSYfPnixHpQXDX5Ad3ePjt3N/wCis9jE2KUy5qvD
	 phCN4lns0ghLuhhCNvXvW38mHb8p0oRclSmiH0jk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250218091427epcas5p41de951f23f8ce9fcc5400f8d36014cd4~lQpu4CtgA0646206462epcas5p4E;
	Tue, 18 Feb 2025 09:14:27 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yxv3h3npxz4x9Pv; Tue, 18 Feb
	2025 09:14:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FE.6E.19710.07F44B76; Tue, 18 Feb 2025 18:14:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250218085810epcas5p42b0e96fff3fff297a1e7334cc7feae9f~lQbhF0u-e0753707537epcas5p4t;
	Tue, 18 Feb 2025 08:58:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250218085810epsmtrp24ab3b9a61c7b6517f6c12273dab424d0~lQbhFEPSM2184521845epsmtrp2K;
	Tue, 18 Feb 2025 08:58:10 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-34-67b44f70620d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.DC.33707.2AB44B76; Tue, 18 Feb 2025 17:58:10 +0900 (KST)
Received: from test-PowerEdge-R740xd.samsungds.net (unknown [107.99.41.79])
	by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250218085809epsmtip13f77c85799bfe0e8c6ad7c859181449d~lQbfqHevn1080210802epsmtip1e;
	Tue, 18 Feb 2025 08:58:09 +0000 (GMT)
From: Arpit Kumar <arpit1.kumar@samsung.com>
To: qemu-devel@nongnu.org
Cc: gost.dev@samsung.com, linux-cxl@vger.kernel.org, nifan.cxl@gmail.com,
	dave@stgolabs.net, vishak.g@samsung.com, krish.reddy@samsung.com,
	a.manzanares@samsung.com, alok.rathore@samsung.com, Arpit Kumar
	<arpit1.kumar@samsung.com>
Subject: [PATCH v2 1/3] hw/cxl/cxl-mailbox-utils.c: Added support for Get
 Log Capabilities (Opcode 0402h)
Date: Tue, 18 Feb 2025 14:27:29 +0530
Message-Id: <20250218085731.550029-2-arpit1.kumar@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218085731.550029-1-arpit1.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmpm6B/5Z0g96HkhbTDytafDm9h82i
	d/ESVovVN9cwWtw8sJPJYuHGZUwW52edYrH4u20vo8Xx3h0sQO4cdgcuj52z7rJ7PLm2mcmj
	b8sqRo+ps+s9Pm+SC2CNyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xN
	tVVy8QnQdcvMAbpJSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqX
	rpeXWmJlaGBgZApUmJCdsez3NpaCZ5oV35qXszcwTpLvYuTkkBAwkZjQc4a9i5GLQ0hgN6PE
	t8df2SCcT4wSh/e/ZYdz9r/vYIJpWf9zAStEYiejxLoft5ggnAYmiVl3jjODVLEJ6Eicvz2X
	DcQWEZCU+N11mhmkiFngDaPEg6sLwIqEBbIlmtu72EFsFgFViVe/j4DZvAJ2EqunPGaEWCcv
	sf/gWbB6TgF7idvvv0PVCEqcnPmEBcRmBqpp3jobbIGEwE92iWub17BDNLtIbHm9ghXCFpZ4
	dXwLVFxK4vO7vWwQdrbEn/ntUHaBxKKfM6Fq7CVaT/UDDeUAWqApsX6XPkRYVmLqqXVMEHv5
	JHp/P4EGC6/EjnkwtppE+475UGNkJN78Wgw13kPi2MmvYH8JCUwChvasnAmMCrOQvDMLyTuz
	EDYvYGRexSiZWlCcm56abFpgmJdaDo/m5PzcTYzghKrlsoPxxvx/eocYmTgYDzFKcDArifAe
	6tqQLsSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgSk9ryTe0MTSwMTMzMzE0tjMUEmct3ln
	S7qQQHpiSWp2ampBahFMHxMHp1QDk/NnNq9dna+7hLKPFD3psGCc//GQl9Eqhgemr+PDZ243
	2lm1PPmTcF/k/fxvgbl2bIf0f9hxPkho29rnZpb24GThtQ9mD5MVTuZEpTPmuD319Mu8MO/k
	AaVUrv4pwgkbT9fV3T60oOGuyDSllHDleqXmwz9KHpw3LOs7H9l370B8K++kg1pbZ5iUHAhS
	qViTpiD1Z6/vvFr1C8sEOY7V9dkkLbOSrOebujCG+4b1/oQ0m+zf3zfc2dj8m3+eIr+YTvDz
	dDZR/zsMczXEDlVNWpF2zvvQ84vFYXf87J4edNaebfGwWK6dSe2W645TNZP9FxXXXjQzf9In
	f/Fo0fQ57HzVzQv4vsdy/omtfNqlxFKckWioxVxUnAgA1ibEtzEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO4i7y3pBqf2aVhMP6xo8eX0HjaL
	3sVLWC1W31zDaHHzwE4mi4UblzFZnJ91isXi77a9jBbHe3ewALlz2B24PHbOusvu8eTaZiaP
	vi2rGD2mzq73+LxJLoA1issmJTUnsyy1SN8ugStj2e9tLAXPNCu+NS9nb2CcJN/FyMkhIWAi
	sf7nAtYuRi4OIYHtjBIf/85ihEjISFyc+ZgFwhaWWPnvOTtE0T9GibWzr4Il2AR0JM7fnssG
	YosISEr87jrNDFLELPCNUWLOrResIAlhgUyJi2sngNksAqoSr34fYQexeQXsJFZPeQy1TV5i
	/8GzzCA2p4C9xO3338FqhIBqNnT9ZYSoF5Q4OfMJ2GJmoPrmrbOZJzAKzEKSmoUktYCRaRWj
	aGpBcW56bnKBoV5xYm5xaV66XnJ+7iZGcKhrBe1gXLb+r94hRiYOxkOMEhzMSiK8h7o2pAvx
	piRWVqUW5ccXleakFh9ilOZgURLnVc7pTBESSE8sSc1OTS1ILYLJMnFwSjUwbTv/TyT8/t1v
	nR/FxbgkF+i+evico78lU+24iFW31ZmmVaXizrd4WOOErkRtnXrA3DQzIexkcspBq7O7ltYx
	uE5vsD25Pn8a06zvPx6bamkf/b3p2dfrQSkdu5Y5LWCcuPTJa1WNdTr1rCeTFi848He3ItPu
	nzlX9/08tULeU/1/klhAQjFnWMdCK8eHJZvuJTrFVr1QEpoxZcqSGe8+tew6saqy7d1epWsb
	XZkOpKxPWeAlcTTL7pbfr8w5H0QLNn07a2o+pSTBMmy7bO7i7pYz8V+nSu21/2VzdcnckljB
	m8tqX01kfHdvikP82aUev+d/lGSR13frac/wvVN1NVfo9umQnvCNtiL3BARmr1FiKc5INNRi
	LipOBACtoqY/5AIAAA==
X-CMS-MailID: 20250218085810epcas5p42b0e96fff3fff297a1e7334cc7feae9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218085810epcas5p42b0e96fff3fff297a1e7334cc7feae9f
References: <20250218085731.550029-1-arpit1.kumar@samsung.com>
	<CGME20250218085810epcas5p42b0e96fff3fff297a1e7334cc7feae9f@epcas5p4.samsung.com>

CXL spec 3.2 section 8.2.10.5.3 describes Get Log Capabilities.
It provides log capabilities supported by specified log.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c   | 45 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h  | 20 ++++++++++++++++
 include/hw/cxl/cxl_mailbox.h |  5 ++++
 3 files changed, 70 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9c7ea5bc35..5b0f793ac5 100644
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
@@ -1075,6 +1076,43 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static const struct CXLLogCapabilities *find_log_index(QemuUUID *uuid, CXLCCI *cci)
+{
+    for (int i = CXL_LOG_COMMAND_EFFECT; i < MAX_LOG_TYPE; i++) {
+        if (qemu_uuid_is_equal(uuid,
+            &cci->supported_log_cap[i].uuid)) {
+                return &cci->supported_log_cap[i];
+        }
+    }
+    return NULL;
+}
+
+/* CXL r3.2 Section 8.2.10.5.3: Get Log Capabilities (Opcode 0402h) */
+static CXLRetCode cmd_logs_get_log_capabilities(const struct cxl_cmd *cmd,
+                                                uint8_t *payload_in,
+                                                size_t len_in,
+                                                uint8_t *payload_out,
+                                                size_t *len_out,
+                                                CXLCCI *cci)
+{
+    const CXLLogCapabilities *cap;
+    struct {
+        QemuUUID uuid;
+    } QEMU_PACKED QEMU_ALIGNED(8) * get_log_capabilities_in = (void *)payload_in;
+
+    uint32_t *get_log_capabilities_out = (uint32_t *)payload_out;
+
+    cap = find_log_index(&get_log_capabilities_in->uuid, cci);
+    if (!cap) {
+        return CXL_MBOX_INVALID_LOG;
+    }
+
+    memcpy(get_log_capabilities_out, &cap->param_flags,
+           sizeof(cap->param_flags));
+    *len_out = sizeof(*get_log_capabilities_out);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 section 8.2.9.6: Features */
 /*
  * Get Supported Features output payload
@@ -2840,6 +2878,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [LOGS][GET_LOG_CAPABILITIES] = { "LOGS_GET_LOG_CAPABILITIES",
+                                     cmd_logs_get_log_capabilities, 0x10, 0 },
     [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
                                   cmd_features_get_supported, 0x8, 0 },
     [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
@@ -3084,10 +3124,15 @@ static void cxl_rebuild_cel(CXLCCI *cci)
     }
 }
 
+static const struct CXLLogCapabilities cxl_get_log_cap[MAX_LOG_TYPE] = {
+    [CXL_LOG_COMMAND_EFFECT] = {.param_flags = 0, .uuid = cel_uuid},
+};
+
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
     cci->payload_max = payload_max;
     cxl_rebuild_cel(cci);
+    cci->supported_log_cap = cxl_get_log_cap;
 
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a64739be25..23f6f4ed17 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -164,6 +164,18 @@ typedef enum {
     CXL_MBOX_MAX = 0x20
 } CXLRetCode;
 
+/* types of logs */
+typedef enum {
+    CXL_LOG_COMMAND_EFFECT,
+    CXL_LOG_VENDOR_DEBUG,
+    CXL_LOG_COMPONENT_STATE_DUMP,
+    CXL_LOG_ERROR_CHECK_SCRUB,
+    CXL_LOG_MEDIA_TEST_CAPABILITY,
+    CXL_LOG_MEDIA_TEST_RESULTS_SHORT,
+    CXL_LOG_MEDIA_TEST_RESULTS_LONG,
+    MAX_LOG_TYPE
+} CXLLogType;
+
 typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
@@ -194,6 +206,11 @@ typedef struct CXLEventLog {
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
 
+typedef struct CXLLogCapabilities {
+    uint32_t param_flags;
+    QemuUUID uuid;
+} CXLLogCapabilities;
+
 typedef struct CXLCCI {
     struct cxl_cmd cxl_cmd_set[256][256];
     struct cel_log {
@@ -202,6 +219,9 @@ typedef struct CXLCCI {
     } cel_log[1 << 16];
     size_t cel_size;
 
+    /* get log capabilities */
+    const CXLLogCapabilities *supported_log_cap;
+
     /* background command handling (times in ms) */
     struct {
         uint16_t opcode;
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index 9008402d1c..8e1c7c5f15 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -16,4 +16,9 @@
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
 #define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
 
+#define CXL_LOG_CAP_CLEAR_SUPPORTED (1 << 0)
+#define CXL_LOG_CAP_POPULATE_SUPPORTED (1 << 1)
+#define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
+#define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
+
 #endif
-- 
2.34.1

