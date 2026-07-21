Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C133FFAC3
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599189; cv=none; b=Atz75s593U+tgtYP0O13HztGhpkE+azKkKXUTRARYjKLoDb0HsPyhnwZhB6mUl+0Lj9fpwpSyoH67A5rsOpgD3B7tcR69mYI4Y7g0+AAioV+Wn1U1Vbjgd/TmZnhdKZKzfW+4agZEqqdEyJFVaf3ctSNpClvpYmipsXLqrOAe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599189; c=relaxed/simple;
	bh=oKCxacNlgmrGla6EGiItQS8JiDa/vJItNHYv89R9QTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWoL6aefyD7ghWFIl60aymxPIjwGdRqer0gtwaXYj0Uskmn+7QxS1z+pyzJqzk3FKoOVBYDm5EipjNIFhs9YWYe/KcrLMBbg1YsD1bIMBfmHLxv/88UMA8zIA8Lgj2Wovnagi7nViPevidUa/wUi1tKzTtRG5BN+rRt2HejvHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDh4QD2S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDh4QD2S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784599188; x=1816135188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oKCxacNlgmrGla6EGiItQS8JiDa/vJItNHYv89R9QTM=;
  b=JDh4QD2Stxxs5cL0LpPxLqYDr26dJep21BQgIjv4OCRZ1O4mzeDS7dqe
   kaLE1hUyd39SEgDdeZmaK7LeT7bD4K1wkbsGcyl1vtO33o2Putfv8Sr6k
   5jLM5FD4E57+aMUqwqPodWMn5qktK7SWv1al5RTnNCxEEA4DqeKgkWc1v
   lTOSpdXslMbsSZDbKrTEVUZ1riUKF6N9Tj/e2VYTIcjVmAe3ylNxbTx0Z
   /XAidhYwEjYSJ0QBNKbriCRHf3I41AM8Aj0qTM+xCiu4GeWvkgWnV4Wbb
   2IYhOfLVNRaDd+ju6dGMV03xL1tXNE0Vbe+JfiJI1E5Czmg/1tDL9LFb7
   Q==;
X-CSE-ConnectionGUID: c5eX+Z5LSAyQ0K3zojRHrQ==
X-CSE-MsgGUID: ZGkHvK5sTceUskbMylZK4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85209212"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85209212"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:47 -0700
X-CSE-ConnectionGUID: dMwMYL4FSHe0CrEftcXuKQ==
X-CSE-MsgGUID: i5jpDq7NRBCw9oxri3Okyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255837064"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v4 1/4] cxl/hdm: Reject switch decoder interleave ways that overflow targets
Date: Mon, 20 Jul 2026 18:59:37 -0700
Message-ID: <1e0e4d7b431a97efa0a8c83591b42b7a0622cea1.1784595445.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch decoder enumeration validates that the interleave ways encoding
is legal, but not that the resulting number of ways fits the available
targets. This can overrun the target arrays during enumeration.

Reject committed decoders whose interleave ways exceed either the
hardware target list capacity or the reported target count. Reject
switch decoders that report zero targets.

For uncommitted decoders, ignore the stale interleave ways value and
reset it to one until the decoder is committed.

Add a clarifying comment that target_count is a direct count, not
0-based like decoder_count.

Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..d81df45d8005 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 
 	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
 	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
+
+	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
@@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		if (cxlsd->nr_targets < 1) {
+			dev_err(&port->dev,
+				"decoder%d.%d: reports zero targets\n",
+				port->id, cxld->id);
+			return -ENXIO;
+		}
+
+		if (!committed) {
+			/* Ignore interleave ways until commit */
+			cxld->interleave_ways = 1;
+			return 0;
+		}
+
+		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {
+			dev_err(&port->dev,
+				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
+				port->id, cxld->id, cxld->interleave_ways,
+				CXL_HDM_DECODER0_TL_TARGETS);
+			return -ENXIO;
+		}
+		if (cxld->interleave_ways > cxlsd->nr_targets) {
+			dev_err(&port->dev,
+				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
+				port->id, cxld->id, cxld->interleave_ways,
+				cxlsd->nr_targets);
+			return -ENXIO;
+		}
+
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c0e5308e4d1b..291ada46b646 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+/* Two registers with one target ID per byte */
+#define CXL_HDM_DECODER0_TL_TARGETS 8
 #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
 #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
-- 
2.37.3

