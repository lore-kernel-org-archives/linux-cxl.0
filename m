Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5143DA4C
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448186; cv=none; b=YidTEga0nkBranjVJMnrhbHjHwUdmiuAgluVqJaTMTlIk2ER36U7P96xEIZ9hx3bMajqO72wXFSZi/z93He/ojpo1+sgSpTGfZZuQwS46coNS8thJ0ZSQwsplO8trMOih4WjilR1kd38SkhAMKRoVzM6mVfkIXjfr+vvWSEKKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448186; c=relaxed/simple;
	bh=T514opcNUktHO6ym0TE9ODQB4xSSpD6pkA2JY+enOwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RblKie57NZvoJTLu0NdMditAF0YTtlnJG+eKhHVBeejBc4TfHNJ/BRYlsSFzzPLV7NnaXVhu/dCd4EOeGZaxtUYD14ACIK6QZpIeZsVkoSC9ylMg9jmyoaRw5O4tn26B7cd4WlRqOjWbQbEBpjG8EGcVnGMF/gAXxKOe8M0KVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x30FZXU9; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x30FZXU9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786448181; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UHW7AjeqsC9YcCpvFz3nhYxVbrQasEro0ZQeLxSLr0c=;
	b=x30FZXU9uosTtxJbT92yyt20yzeL8vC24lN29f1blD2CLOJHglpN6Q81vptN9OkoPzPW+LVWcqZDiIwEDZYk3L4+r/ohoZuw8BRppEbKrokJTk3AWlJ/KIg1ft5unyD4trMBSXSmBqBPnPkyxasrhAfGY1rDsYAOfV7t5ALlJ8M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R251e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X8oO0gO_1786448179;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8oO0gO_1786448179 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 19:36:20 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH 5/8] cxl/hdm: Fix out of bounds read of the decoder target list
Date: Tue, 11 Aug 2026 19:36:05 +0800
Message-ID: <20260811113608.2815625-6-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260811113608.2815625-1-kanie@linux.alibaba.com>
References: <20260811113608.2815625-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_hdm_decoder() copies the HDM Decoder Target List register into
cxld->target_map using the decoder's interleave ways as the element count:

	union {
		u64 value;
		unsigned char target_id[8];
	} target_list;
	...
	target_list.value = (hi << 32) + lo;
	for (i = 0; i < cxld->interleave_ways; i++)
		cxld->target_map[i] = target_list.target_id[i];

The Target List register is 8 bytes wide, i.e. 8 target ports, but
interleave ways comes from the 4-bit Interleave Ways field of the decoder
control register, and eiw_to_ways() maps the valid encodings to 1, 2, 4, 8,
16 (eiw 0-4) and 3, 6, 12 (eiw 8-10). A switch or host bridge decoder found
programmed with 12 or 16 ways therefore reads up to 8 bytes past the
on-stack union.

The region programming path already rejects that configuration in
cxl_port_setup_targets(), 'if (iw > 8 || iw > cxlsd->nr_targets)', but the
enumeration path of a BIOS programmed decoder has no such check.

Reject the decoder instead, consistent with how the neighbouring
eiw_to_ways() and eig_to_granularity() failures are handled: a target list
that cannot describe the interleave is not a configuration the driver can
attach a region to.

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/cxl/core/hdm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..9d49b48a4456 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1084,6 +1084,18 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		/*
+		 * The Target List register only holds
+		 * ARRAY_SIZE(target_list.target_id) entries, so a switch
+		 * decoder cannot interleave across more ports than that.
+		 */
+		if (cxld->interleave_ways > ARRAY_SIZE(target_list.target_id)) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Interleave ways: %d exceeds target list size\n",
+				 port->id, cxld->id, cxld->interleave_ways);
+			return -ENXIO;
+		}
+
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
-- 
2.43.7

