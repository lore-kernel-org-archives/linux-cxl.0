Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2962494834
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992590; cv=none; b=Mqh5sLAERIVO1WCgGh1DOqkyI5Kon1GuedEIj9w1DiuJAF9xaAACtlbNpOWG1dpou5/G7gJthQ7W0B6RPL1mlBPhAvKLoWel4a0l67aerbv6CwPeI/5IG09gbBuwQaty2PPQFbZiWSbHWOm4mCzx6eJHVzfluOuaehBbBxWlTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992590; c=relaxed/simple;
	bh=G6uUBq69Kt06wMi/vS+tnp74CZ3mxYTFsPV+dsMiJJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2dn8xdS5l+jazDYQjX+WLt1XRSvYjQ8MR9oWrfSFVSp8DGcaeL1NcU+Vv27s5ILwwwrZZj18QB8h6WA7lcc977EwpNEKrleAp/eN8HAvvvD9EaSNbQ5xTDUpHftBR69m2jaKUPzeytV9qzuyD7YZGp/Di2l8SDJTpcb8Uyoyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hRgYJYJj; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hRgYJYJj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789992578; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GGV59z+uCKopVc7wQqPW1D3pPXb13x+aOqIFryIn42U=;
	b=hRgYJYJju9yNu4ilTGxA+dKPt107ZEv9me1S7wBDfglCiZb0A+jHuhMM8MpEuiIcuKcjm8JNPU2/jWJZjebAF15fE1ekg0fhXBYcXGG8bsZRvODQFRp6n1WDhtOqS01/5jxXIibAjr9mWn7OYDeipGx6Rq7mSQtPW5OvNF1O/+s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBO3mY-_1789992577;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBO3mY-_1789992577 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Sep 2026 20:09:37 +0800
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
Subject: [PATCH] cxl/events: Fix event type check for CME counter expiration
Date: Mon, 21 Sep 2026 20:09:32 +0800
Message-ID: <20260921120932.1769566-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Memory Event Type field of the General Media and DRAM event
records is an enumeration; 05h designates the advanced programmable
CME counter expiration event. The validity checks for that event
test the field with a bitwise AND against
CXL_GMER_MEM_EVT_TYPE_AP_CME_COUNTER_EXPIRE instead of comparing it
for equality, so benign event types that share a bit with 05h, such
as 01h (Invalid Address), 03h (TE State Violation), 04h (Scrub
Media ECC Error) or 06h (CKID Violation), match too.

A device reporting any of those types with an otherwise valid record
therefore trips WARN_ON_ONCE, once the general media or DRAM
tracepoint is enabled, which is the case for any deployment
collecting CXL events with rasdaemon. The warning panics the kernel
under panic_on_warn=1.

Compare the type field for equality instead.

Found by code inspection during review of a downstream backport of
these two patches. Reproduced in a QEMU CXL topology by injecting a
General Media event with type 01h through the
cxl-inject-general-media-event QMP command, which warns in
cxl_event_trace_record(); with the fix the same injection is traced
without a warning. Events that do violate the spec conditions, type
05h without the threshold event descriptor bit and type 05h with the
bit set but a zero CME count, still warn.

Fixes: cd3b36cfc659 ("cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record")
Fixes: d8145bb8af5c ("cxl/events: Add extra validity checks for CVME count in DRAM Event Record")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
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

