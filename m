Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997F2EACEF
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151962; cv=none; b=GELIFBSM8BMboGINkYTafCJ6RJ1U0q4Rd32DIdZj5TRNFYZJI1KahbDV4s/cWBZ8NOLU0rDOUO7Le7M3fmHZPpsagYXXi3gShXl3HBrIRM7wurCcOF5Ptrzei8HB5vEpPdYjw2QUU7bzxokwXZLBONmJmqWdHndPdXNdISJClf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151962; c=relaxed/simple;
	bh=MDfBShH6c6W0fjfhPC5+HhR+wQFAGiCLxAwXGp4/NRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6i0iNPwhJeR1Vjir3NWkc14WY+LvcI6MwgMXr52IIfCCzGoJqh6qlzuEh+FQmLY41Lcqfee/Mlh3HiYW4v7NXbX6BKSTbWEnfseVXLN6W3Zs1S5/MHNO+RIaEQ137NVdIakewOibX0AuIAQB3png+7xY2Vm4JjrAJWgL8BusVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbY40OY+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbY40OY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784151961; x=1815687961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MDfBShH6c6W0fjfhPC5+HhR+wQFAGiCLxAwXGp4/NRY=;
  b=hbY40OY+52Wkt+mnb1pP11+m7fYqc6knNX8hBkL9fcg95x10ewA4i0+E
   +YsT7AsSHO+Q9Y2P3+9S5LBlWqd9f1lCa1oxNZBB87rVJc7cRlLKHg5N9
   qFv/szLvtAJLXobTEyjbidJjAikPlsTjzIQ3AoJQQTUjv0W0hIOZXFQ0R
   zys924SIPJTpSd71gsaPR69tQXH/hhm2tu6GHY9xBY+pIgemgktouJeA6
   BxhnosdSPFqLZMYHTuD2j8+1Ql0LqdnpAOvijqLGpkvaS0a3AmhuH1FRU
   JL4oHuc1gTD+wRRbyAcz7pv+qN1NYR8Wqm0rqrTQFC2mXgYpioeDs6I/T
   A==;
X-CSE-ConnectionGUID: Q489shs3SteCjYxo3MI2qA==
X-CSE-MsgGUID: bl8CrOHYR+G/Ljk0AKo1TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88632840"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88632840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:46:00 -0700
X-CSE-ConnectionGUID: ffG7rlNKRhuArEpMNgQiAg==
X-CSE-MsgGUID: dCImnPq+TpWFebO2DR6k/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="254549524"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.156])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:46:00 -0700
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
Subject: [PATCH v2 1/3] cxl/hdm: Reject switch decoder interleave ways that overflow targets
Date: Wed, 15 Jul 2026 14:45:47 -0700
Message-ID: <0d7618c36e20bfda585699f8641d62928b23f6d5.1784150131.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784150131.git.alison.schofield@intel.com>
References: <cover.1784150131.git.alison.schofield@intel.com>
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
 drivers/cxl/core/hdm.c  | 26 ++++++++++++++++++++++++++
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..9f005f3193e2 100644
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
@@ -1084,6 +1086,30 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		cxld->interleave_ways, cxld->interleave_granularity);
 
 	if (!cxled) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1215ee4f4035..28eccfdd75b8 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1979,7 +1979,7 @@ static int cxl_switch_decoder_init(struct cxl_port *port,
 				   struct cxl_switch_decoder *cxlsd,
 				   int nr_targets)
 {
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
+	if (nr_targets < 1 || nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return -EINVAL;
 
 	cxlsd->nr_targets = nr_targets;
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

