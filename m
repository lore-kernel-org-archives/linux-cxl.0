Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABDF2F3C22
	for <linux-cxl@vger.kernel.org>; Wed, 16 Jul 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664871; cv=none; b=K/Dc23MIJ8qWu64k+r64lJlGzMyCZKQRWlAwpro9ayqGFuZjTcbHKKLNNu04jDWsPjVQGo++btnoJUQHfFOr4O2Od0dafWKuaeUfDLw9sc+tjZBYy2hPInkvJirVR+VqmZBaRXsApEs2BvNyEwv+K4qGu7CUF81Xn6VEVsBglZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664871; c=relaxed/simple;
	bh=DqcHA32ZfuLQRqDUjK+7+lJOysiL09FLjqctJ/itWmY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXIYK5wjUJeQly6zCZFwfDh4t3J8VODnr02TD4EqW6CGPsoRFG9QAQMyH+y07ZN6OlLKBR6Kwv+TM04+KIN5xIqgrX6HVx1/LdEEbnUgpaiy/1K/Xmkat4wQJcRGh6Cqdga55UsYVs0GB2J0t0+0n5ImhPrl7sFe52ul5uyRqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhtnV1yshz6L4vw;
	Wed, 16 Jul 2025 19:17:34 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B72611402FB;
	Wed, 16 Jul 2025 19:21:06 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.168) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Jul 2025 13:21:05 +0200
From: <shiju.jose@huawei.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH 2/4] cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record
Date: Wed, 16 Jul 2025 11:49:43 +0100
Message-ID: <20250716104945.2002-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250716104945.2002-1-shiju.jose@huawei.com>
References: <20250716104945.2002-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

According to the CXL Specification Revision 3.2, Section 8.2.10.2.1.1,
Table 8-57 (General Media Event Record), the Corrected Memory Error Count
field is valid under the following conditions:
1. The Threshold Event bit is set in the Memory Event Descriptor field, and
2. The Corrected Memory Error Count must be greater than 0 for events where
   the Advanced Programmable Threshold Counter has expired.

Additionally, if the Advanced Programmable Corrected Memory Error Counter
Expire bit in the Memory Event Type field is set, then the Threshold Event
bit in the Memory Event Descriptor field shall also be set.

Add validity checks for the above conditions while reporting the event to
the userspace.

Note: CXL spec rev3.2 Table 8-57. General Media Event Record
Field: Corrected Memory Error Count at Event) "For events in which the
advanced programmable threshold counter has expired, this field value
shall be a value greater than 0. Counter expiration events in which
the corrected memory error count is 0 shall not generate a media event
record".
Q: Should kernel drop the event record in this case or user space
to handle?

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/cxl/core/mbox.c  | 9 +++++++++
 drivers/cxl/core/trace.h | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2689e6453c5a..5a30d3891b17 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -926,6 +926,15 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
 			if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
 				dev_dbg(&cxlmd->dev, "CXL store rec_gen_media failed\n");
 
+			if (evt->gen_media.media_hdr.descriptor &
+			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
+				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
+					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
+					     !evt->gen_media.cme_count);
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

