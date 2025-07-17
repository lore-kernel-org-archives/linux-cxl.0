Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3928CF73
	for <linux-cxl@vger.kernel.org>; Thu, 17 Jul 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747519; cv=none; b=jZRo4mbNBLdMvaUY9AoTCXKNTEWHGH836KeX5/IYHP9SyewWDmQmL7RKvikioM5erlWSUB4Fbd8lGqB+ZCCKGykIIGiqQAL7PZ0ulvbnX0+/OIKwjFIlKGsjARTQ56xA1xcKMpVp62stPDw0uvTwKJqVCq5PEc+Xo7MzCUVLPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747519; c=relaxed/simple;
	bh=HAQ1PjWpW9zJnhBql6FkdN/3QmWObLmW5vkzT3Tk3Xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyP1E+hZpN04oeksOgU30ej/qtTiSq2oXbFmmrhntzAOrz0wZ4HhrryqasVdbeFRGUWtN3ICHaQ4OwJYr/8BltB3Em40ptEx3HVZusjDf1gEh9e8zNdcyMkL72ekd8nqsYHRHCJolkOr5Xew+I7LG4re1SVZ9WmLuBkJqZDsh3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bjTLq1MNlz6JB0Y;
	Thu, 17 Jul 2025 18:14:59 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 60B0B14027A;
	Thu, 17 Jul 2025 18:18:34 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.216) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Jul 2025 12:18:33 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 3/4] cxl/events: Add extra validity checks for CVME count in DRAM Event Record
Date: Thu, 17 Jul 2025 11:18:16 +0100
Message-ID: <20250717101817.2104-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250717101817.2104-1-shiju.jose@huawei.com>
References: <20250717101817.2104-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.2,
Table 8-58 (DRAM Event Record), the CVME (Corrected Volatile Memory Error)
Count field is valid under the following conditions:
1. The Threshold Event bit is set in the Memory Event Descriptor field,
and
2. The CVME Count must be greater than 0 for events where the Advanced
Programmable Threshold Counter has expired.

Additionally, if the Advanced Programmable Corrected Memory Error Counter
Expire bit in the Memory Event Type field is set, then the Threshold Event
bit in the Memory Event Descriptor field shall also be set.

Add validity checks for the above conditions while reporting the event to
the userspace.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c  | 9 +++++++++
 drivers/cxl/core/trace.h | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index ba4a29afd3aa..445889b128cd 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -941,6 +941,15 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			if (cxl_store_rec_dram((struct cxl_memdev *)cxlmd, evt))
 				dev_dbg(&cxlmd->dev, "CXL store rec_dram failed\n");
 
+			if (evt->dram.media_hdr.descriptor &
+			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
+				WARN_ON_ONCE((evt->dram.media_hdr.type &
+					      CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
+					     !get_unaligned_le24(evt->dram.cvme_count));
+			else
+				WARN_ON_ONCE(evt->dram.media_hdr.type &
+					     CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
+
 			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
 				       &evt->dram);
 		}
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index c38f94ca0ca1..462c2e892ba2 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -661,7 +661,10 @@ TRACE_EVENT(cxl_dram,
 		       CXL_EVENT_GEN_MED_COMP_ID_SIZE);
 		__entry->sub_channel = rec->sub_channel;
 		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
-		__entry->cvme_count = get_unaligned_le24(rec->cvme_count);
+		if (rec->media_hdr.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
+			__entry->cvme_count = get_unaligned_le24(rec->cvme_count);
+		else
+			__entry->cvme_count = 0;
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' sub_type='%s' " \
-- 
2.43.0

