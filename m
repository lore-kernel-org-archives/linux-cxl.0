Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A119DC433FE
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 23:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiKVXIC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 18:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbiKVXH7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 18:07:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5888F56550
        for <linux-cxl@vger.kernel.org>; Tue, 22 Nov 2022 15:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669158477; x=1700694477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ugHtw7v/MUFjVH4cArhP6P1uBuVdGpg+DXNAfUl99mA=;
  b=Roe74bWhhYAiykiSpZtcwzkI79TLh1KgEXTHMb9OuhRoweqk1elKI9wi
   YIDVxApZ1AaHLjY9c7bYZf/XP7p9EGDBjRwlOiGkm4JafCtBm53cZV6Ky
   g+B9oDHqGL8WbhWfVpoFFIx/g5tFa52iulnOgoMziC8Kk5lDrnLY3yaFw
   bP/5PR4+ivATwrxM6SGXrfFrOI6Bd+9bz886h8+94qBBuxXf6V9zxbOZi
   8gYcX1FUXhPQjPiYEisqIrqrOkEYLL6xb8BBoFtZ8IfNp8bEz+z5LAmZs
   uj2dgS/wFvF+E95vPjJw+fY8+GeBUs5ugBJZPSs+NL9o2J6Sgm5Jc/DBG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376079336"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376079336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="747542493"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="747542493"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.144.204])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 15:07:54 -0800
From:   alison.schofield@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/4] cxl/region: Add a DPA to HPA translation helper
Date:   Tue, 22 Nov 2022 15:07:48 -0800
Message-Id: <31c38d6711cc3a000a5307b8ebf3b6e88675e17f.1669153711.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1669153711.git.alison.schofield@intel.com>
References: <cover.1669153711.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

CXL devices may report errors and events using their DPA (device
physical address). When a CXL device contributes capacity to a
CXL region, the device's physical addresses are mapped to HPA's.
(host physical addresses)

Provide a helper to calculate the HPA when given a DPA, a region,
and the devices position in the region interleave.

Verify that the HPA is within the expected ranges that this device
contributes to the region interleave set.

The initial use case is translating the DPAs that CXL devices
report in media error records.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/core.h   |  3 ++
 drivers/cxl/core/region.c | 80 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d8f87be283f..72b58e53c394 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -67,6 +67,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
 }
 
+u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
+		   struct cxl_endpoint_decoder *cxled);
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index f9ae5ad284ff..c847517e766c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1865,6 +1865,86 @@ static void cxlr_pmem_unregister(void *dev)
 	device_unregister(dev);
 }
 
+static bool cxl_is_hpa_in_range(u64 hpa, struct cxl_region *cxlr, int pos)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int gran = p->interleave_granularity;
+	int ways = p->interleave_ways;
+	u64 stride;
+
+	/* Is the hpa within this region at all */
+	if (hpa < p->res->start || hpa > p->res->end) {
+		dev_dbg(&cxlr->dev,
+			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
+		return false;
+	}
+	/* Is the hpa in an expected stride for its pos(-ition) */
+	stride = p->res->start + pos * gran;
+	do {
+		if (hpa >= stride && hpa <= stride + gran - 1)
+			return true;
+
+		stride = stride + ways * gran;
+	} while (stride < p->res->end);
+
+	dev_dbg(&cxlr->dev,
+		"Addr trans fail: hpa 0x%llx not in any stride\n", hpa);
+
+	return false;
+}
+
+u64 cxl_dpa_to_hpa(u64 dpa, struct cxl_region *cxlr,
+		   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	u64 dpa_offset, hpa_offset, hpa;
+	int rc, pos = cxled->pos;
+	u16 eig;
+	u8 eiw;
+
+	rc = ways_to_cxl(p->interleave_ways, &eiw);
+	if (rc)
+		return rc;
+	rc = granularity_to_cxl(p->interleave_granularity, &eig);
+	if (rc)
+		return rc;
+
+	/*
+	 * Reverse the HPA->DPA decode logic defined
+	 * in the CXL Spec 3.0 Section 8.2.4.19.13
+	 * Implementation Note: Device Decode Logic
+	 *
+	 * The device position in the region interleave
+	 * set was removed in the HPA->DPA translation.
+	 * Put it back to reconstruct the HPA.
+	 */
+
+	/* Remove the dpa base */
+	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
+
+	/* Restore the position */
+	if (eiw <= 8) {
+		hpa_offset = (dpa_offset & GENMASK_ULL(51, eig + 8)) << eiw;
+		hpa_offset |= GENMASK_ULL(eig + 8 + eiw, eig + 8)
+			      & (pos << (eig + 8));
+	}
+	if (eiw == 9)
+		hpa_offset |= BIT(eig + eiw) & (pos & 0x01);
+	if (eiw == 10)
+		hpa_offset |= GENMASK_ULL(eig + eiw, eig + 8) & (pos & 0x03);
+
+	/* The lower bits remain unchanged */
+	hpa_offset |= dpa_offset & GENMASK_ULL(eig + 7, 0);
+
+	/* Apply the hpa_offset to region base address */
+	hpa = hpa_offset + p->res->start;
+
+	if (!cxl_is_hpa_in_range(hpa, cxlr, cxled->pos))
+		return 0;
+
+	return hpa;
+}
+
 /**
  * devm_cxl_add_pmem_region() - add a cxl_region-to-nd_region bridge
  * @cxlr: parent CXL region for this pmem region bridge device
-- 
2.37.3

