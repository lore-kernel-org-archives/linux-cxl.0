Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6B325498
	for <linux-cxl@vger.kernel.org>; Wed, 10 Dec 2025 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372438; cv=none; b=OWdy3VLVCoW3/tHxAQRQpCv+O7OrfdrqRYevvsHv6DJTF+CSvaLkfwsFADrO3mpHQxz+UTr4riWFsDoZavPym4tBcqKB7kq2WZmp+Zj2CbMxwfgO/Q6hjCGlbWjOq4dbXERpKHDQkqwphavFwb8k47v2L7UvYjkPVgxwtjeHeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372438; c=relaxed/simple;
	bh=fQPtlNbTEBr8bXCbf8nFNj3s8URe4WGUuFZseDFk/3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a4/WDi1e7YnvPhjV1KhTQZ6OCjb1LzkIZBjyNdcbPJVrubYfIFaYkVWnbBF4swPcLKGcCHWyZE178Y7L6Yhl9N3ufdGpcL6kbCWdLOPcUhfTgmMRHoAqgZKlV5SCIu7UwBotlHkNVcKtZyxRiVgj/cUyRlHFmEUJ9aPa5bxJmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dRGPV6KVQzJ4680;
	Wed, 10 Dec 2025 21:13:34 +0800 (CST)
Received: from dubpeml100008.china.huawei.com (unknown [7.214.145.227])
	by mail.maildlp.com (Postfix) with ESMTPS id D858040570;
	Wed, 10 Dec 2025 21:13:52 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.168.56) by
 dubpeml100008.china.huawei.com (7.214.145.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 10 Dec 2025 13:13:51 +0000
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH] cxl/events: Update memory event type for patrol scrub cycle end event
Date: Wed, 10 Dec 2025 13:12:34 +0000
Message-ID: <20251210131235.1731-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100008.china.huawei.com (7.214.145.227)

From: Shiju Jose <shiju.jose@huawei.com>

According to the CXL Specification Revision 4.0, Advanced CVME (Corrected
Volatile Memory Error) enhancements added additional granularity control
and event generation for Patrol Scrub cycle end.

Update Memory Event Type field in the trace events for section
8.2.10.2.1.1, Table 8-224 (General Media Event Record), and section
8.2.10.2.1.2, Table 8-225 (DRAM Event Record), to include the event type
'Patrol Scrub cycle end'.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
Open Question,
Option to enable event generation for 'Patrol Scrub cycle end' is given in
the Memory Error Threshold feature, Section 8.2.10.9.11.3 Advanced
Programmable Corrected  Volatile Memory Error Threshold Feature Discovery
and Configuration. Does support of this Memory Error Threshold feature is
required in the kernel or via fwctl?
---
 drivers/cxl/core/trace.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a972e4ef1936..e79c2bd415af 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -367,6 +367,7 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x04
 #define CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
 #define CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
+#define CXL_GMER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END	0x07
 #define show_gmer_mem_event_type(type)	__print_symbolic(type,				\
 	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
 	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
@@ -374,7 +375,8 @@ TRACE_EVENT(cxl_generic_event,
 	{ CXL_GMER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },		\
 	{ CXL_GMER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
 	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
-	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }		\
+	{ CXL_GMER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" },		\
+	{ CXL_GMER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END,	"Adv Prog CME Patrol Scrub Cycle End" }	\
 )
 
 #define CXL_GMER_TRANS_UNKNOWN				0x00
@@ -554,6 +556,7 @@ TRACE_EVENT(cxl_general_media,
 #define CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION	0x04
 #define CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE	0x05
 #define CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION		0x06
+#define CXL_DER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END	0x07
 #define show_dram_mem_event_type(type)	__print_symbolic(type,					\
 	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },				\
 	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },		\
@@ -561,7 +564,8 @@ TRACE_EVENT(cxl_general_media,
 	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" },			\
 	{ CXL_DER_MEM_EVT_TYPE_TE_STATE_VIOLATION,	"TE State Violation" },			\
 	{ CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE,	"Adv Prog CME Counter Expiration" },	\
-	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" }			\
+	{ CXL_DER_MEM_EVT_TYPE_CKID_VIOLATION,		"CKID Violation" },			\
+	{ CXL_DER_MEM_EVT_TYPE_AP_CME_PS_CYCLE_END,	"Adv Prog CME Patrol Scrub Cycle End" }	\
 )
 
 #define CXL_DER_VALID_CHANNEL				BIT(0)
-- 
2.43.0

