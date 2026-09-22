Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC54141A4E2
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065354; cv=none; b=DhNBIWRCpdnOHNDmxiaspQ1vCKqtvrxGz7OWmx76a31kGaMqFZiBn3xLSnBPjbiqlJlfOSPII5DMj3P1YrStdGw85SWixn98UFFpElPH3+Ijh3MMLpNCM9xMq9BWeZi/QZrepXhwMAyHu8gDNS73sT0fI8VVa1dM6oLJ+IReQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065354; c=relaxed/simple;
	bh=EPqwyilWhpOD5tFZROFJnkleyX6cIx/NtiLGOw3ejdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3shp/mrlJJeyBRzOHdljZUO0YADsUkNYEjjqO3T1YmCJ8saGzZTmwrSbR8t3D2hFB3QwHi88ioxBB0h4vgi8SoywshOjHluDeeDl/8fTQdqt3KIrE1RbQJN583n4S3cSNfed1kzWLugoOkEQuzPxaSTbZA8qMwE0UefYPCQQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hvCspqyF; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hvCspqyF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790065340; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XyM1loYO9/H03Z51j5yHCOlMEkMqUDVCmLJ62Ikh6PA=;
	b=hvCspqyFV98ugRDfVeO+bVuqivr9UlTvul08RW69EfP0dAh1p7UhnJKDeaAwZkqMF/Bl1Fx0fmQLRWW2VnGgg65hbeMTpPzJQ8eKRWVVXWsCy17TbRob465hBSIeXyjWCxv0PlOBy4t1yuSnQqL8VGNmh8veMfu5tX3zE7wt8Ag=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBT6joJ_1790065339;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBT6joJ_1790065339 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 16:22:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/events: Test CME counter expiry with equality, not bitwise AND
Date: Tue, 22 Sep 2026 16:22:14 +0800
Message-ID: <20260922082214.3526355-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Memory Event Type field in the General Media and DRAM event records
is an enumeration, not a bitmask. The validity checks for the advanced
programmable CME counter expiration event (05h) test the field with a
bitwise AND, so types 01h, 03h, 04h and 06h match it as well.

A device reporting one of those types trips WARN_ON_ONCE once the
general media or DRAM tracepoint is enabled, which is the case anywhere
rasdaemon collects CXL events. Under panic_on_warn=1 that kills the
machine.

Compare the type field for equality instead. Type 05h records that do
violate the spec conditions still warn.

Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Found by code inspection during review of a downstream backport of
these two patches. Reproduced in a QEMU CXL topology by injecting
General Media events through the cxl-inject-general-media-event QMP
command: a type 01h event warns in cxl_event_trace_record() without
the fix and is traced without a warning with it; type 05h events that
violate the spec conditions still warn.

Changes since v1 [1]:
- Collect the commit log suggested by Dave Jiang and the subject
  suggested by Alison Schofield.
- Move the reproducer explanation below '---' (Dave Jiang).
- Add the 'Assisted-by: LLM' tag (Dave Jiang).

[1]: https://lore.kernel.org/all/20260921120932.1769566-1-kanie@linux.alibaba.com/

 drivers/cxl/core/mbox.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 55828a836c01..01341f524a93 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -942,11 +942,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 
 			if (evt->gen_media.media_hdr.descriptor &
 			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
-				WARN_ON_ONCE((evt->gen_media.media_hdr.type &
+				WARN_ON_ONCE((evt->gen_media.media_hdr.type ==
 					      CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
 					     !get_unaligned_le24(evt->gen_media.cme_count));
 			else
-				WARN_ON_ONCE(evt->gen_media.media_hdr.type &
+				WARN_ON_ONCE(evt->gen_media.media_hdr.type ==
 					     CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
 
 			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
@@ -957,11 +957,11 @@ void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 
 			if (evt->dram.media_hdr.descriptor &
 			    CXL_GMER_EVT_DESC_THRESHOLD_EVENT)
-				WARN_ON_ONCE((evt->dram.media_hdr.type &
+				WARN_ON_ONCE((evt->dram.media_hdr.type ==
 					      CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE) &&
 					     !get_unaligned_le24(evt->dram.cvme_count));
 			else
-				WARN_ON_ONCE(evt->dram.media_hdr.type &
+				WARN_ON_ONCE(evt->dram.media_hdr.type ==
 					     CXL_DER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE);
 
 			trace_cxl_dram(cxlmd, type, cxlr, hpa, hpa_alias,
-- 
2.43.7

