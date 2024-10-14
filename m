Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7AF39FCE
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916226; cv=none; b=KZngorXnT4rMiQbjT9ONcaspYamFYORGHNwTaCfy6h6fIQ4ogjYGy6aeKEkODK9nIbyEAFk0c/JhDZqBopKZ0XtjbGiCSldSGYsvP67oPNcJS1pTEUZwJq7RnJHC/JOzF+ywTUXWTr1v0UeLw2h2bElv1VGyVCpRWHagiTa1mzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916226; c=relaxed/simple;
	bh=sHXb0A2rz2Q0pap06AsBCI5FpEJMOHD0sCY3CLZKQJk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dyvCzw6U34vjO7tPMP6BJTu+5Kl8Aes5jf0c+WREyjn55gUVXDoAthiEkR8AbxagrQMMKJ7PMHH3vlZPi3U3M71IS9QAkVzFJo0Pkz0jold7C9mEb25C814JFzUZk3ANbBj9djdd6HJTy2QIyqQQbxv9EvaWqd1lLeT/5UwBsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRzzj2kfbz6LC0x;
	Mon, 14 Oct 2024 22:25:53 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D721140AB8;
	Mon, 14 Oct 2024 22:30:20 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.169.100) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 16:30:19 +0200
From: <shiju.jose@huawei.com>
To: <dave.jiang@intel.com>, <dan.j.williams@intel.com>,
	<jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>, <dave@stgolabs.net>,
	<linux-cxl@vger.kernel.org>
CC: <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/1] cxl/events: Fix Trace DRAM Event Record
Date: Mon, 14 Oct 2024 15:30:03 +0100
Message-ID: <20241014143003.1170-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Fix decode memory event type field of DRAM Event Record.
For e.g. if value is 0x1 it will be reported as an Invalid Address
(General Media Event Record - Memory Event Type) instead of Scrub Media
ECC Error (DRAM Event Record - Memory Event Type) and so on.

Fixes: 2d6c1e6d60ba ("cxl/mem: Trace DRAM Event Record")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
Updates for event records in CXL spec r3.1 will follow shortly.

 drivers/cxl/core/trace.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 9167cfba7f59..cdffebcf20a4 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -279,7 +279,7 @@ TRACE_EVENT(cxl_generic_event,
 #define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
 #define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
 #define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
-#define show_mem_event_type(type)	__print_symbolic(type,			\
+#define show_gmer_mem_event_type(type)	__print_symbolic(type,			\
 	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
 	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
 	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
@@ -373,7 +373,7 @@ TRACE_EVENT(cxl_general_media,
 		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
-		show_mem_event_type(__entry->type),
+		show_gmer_mem_event_type(__entry->type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->device,
 		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
@@ -391,6 +391,17 @@ TRACE_EVENT(cxl_general_media,
  * DRAM Event Record defines many fields the same as the General Media Event
  * Record.  Reuse those definitions as appropriate.
  */
+#define CXL_DER_MEM_EVT_TYPE_ECC_ERROR			0x00
+#define CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR	0x01
+#define CXL_DER_MEM_EVT_TYPE_INV_ADDR			0x02
+#define CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x03
+#define show_dram_mem_event_type(type)  __print_symbolic(type,				\
+	{ CXL_DER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },			\
+	{ CXL_DER_MEM_EVT_TYPE_SCRUB_MEDIA_ECC_ERROR,	"Scrub Media ECC Error" },	\
+	{ CXL_DER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },		\
+	{ CXL_DER_MEM_EVT_TYPE_DATA_PATH_ERROR,		"Data Path Error" }		\
+)
+
 #define CXL_DER_VALID_CHANNEL				BIT(0)
 #define CXL_DER_VALID_RANK				BIT(1)
 #define CXL_DER_VALID_NIBBLE				BIT(2)
@@ -477,7 +488,7 @@ TRACE_EVENT(cxl_dram,
 		"hpa=%llx region=%s region_uuid=%pUb",
 		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
 		show_event_desc_flags(__entry->descriptor),
-		show_mem_event_type(__entry->type),
+		show_dram_mem_event_type(__entry->type),
 		show_trans_type(__entry->transaction_type),
 		__entry->channel, __entry->rank, __entry->nibble_mask,
 		__entry->bank_group, __entry->bank,
-- 
2.34.1

