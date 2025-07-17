Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ACE1E1DE9
	for <linux-cxl@vger.kernel.org>; Thu, 17 Jul 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752747519; cv=none; b=i/Xy6EOCPkO47hmCbU8v1+LmgSPcQ0dPwWDIlbwz23bZp393XcwQ8RUuG6n3mKb63NRLjDo8xwZTWwEaLp2n3URl6q4CZFWuSpuv9wepM8czyzfZef9uX3C1B3lg+uQsVigjcUHemwKbwnvgjlyAkFppxlHILph6eOQjkrR8Gs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752747519; c=relaxed/simple;
	bh=htaT4wke8YD3gtHrjAwSatFcex4m5DVUF8s9Z9KcEtI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2ULdYCEOyA1OG4Xi5coSToB7HmkD6roviCqJBv18aQMW0qH+8rlnl7SREmJ4Y0PJR2+aJyHG/ppp20ub9VQsHOzBe/c/gBd3wuA8HsezZxcyXuA37rwWIfaxETzpRT5URcj/sZVta/mmycb4+dVkER6qJxOWbcb8twawYj+Y6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bjTPW4bt5z6L5H3;
	Thu, 17 Jul 2025 18:17:19 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 659EA1400F4;
	Thu, 17 Jul 2025 18:18:33 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.245.216) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Jul 2025 12:18:32 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 2/4] cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record
Date: Thu, 17 Jul 2025 11:18:15 +0100
Message-ID: <20250717101817.2104-3-shiju.jose@huawei.com>
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

According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.1,
Table 8-57 (General Media Event Record), the Corrected Memory Error Count
field is valid under the following conditions:
1. The Threshold Event bit is set in the Memory Event Descriptor field,
and
2. The Corrected Memory Error Count must be greater than 0 for events
where the Advanced Programmable Threshold Counter has expired.

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
index 2689e6453c5a..ba4a29afd3aa 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -926,6 +926,15 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
 				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
 
+			if (evt->gen_media.media_hdr.descriptor &
+			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
+				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
+					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
+					     !get_unaligned_le24(evt->gen_media.cme_count));
+			else
+				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
+					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
+
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
 						hpa_alias, &evt->gen_media);
 		} else if (event_type == CXL_CPER_EVENT_DRAM) {
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index a77487a257b3..c38f94ca0ca1 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -506,7 +506,10 @@ TRACE_EVENT(cxl_general_media,
 			uuid_copy(&__entry->region_uuid, &uuid_null);
 		}
 		__entry->cme_threshold_ev_flags = rec->cme_threshold_ev_flags;
-		__entry->cme_count = get_unaligned_le24(rec->cme_count);
+		if (rec->media_hdr.descriptor & CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
+			__entry->cme_count = get_unaligned_le24(rec->cme_count);
+		else
+			__entry->cme_count = 0;
 	),
 
 	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
-- 
2.43.0

