Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EC2C18E1A
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E240960F50
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Oct 2021 18:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhJVSjm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Oct 2021 14:39:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:5590 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233988AbhJVSjj (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 22 Oct 2021 14:39:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216528984"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216528984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:20 -0700
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="445854749"
Received: from aagregor-mobl3.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.134.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 11:37:20 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [RFC PATCH v2 28/28] cxl: Program decoders for regions
Date:   Fri, 22 Oct 2021 11:37:09 -0700
Message-Id: <20211022183709.1199701-29-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022183709.1199701-1-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Do the HDM decoder programming for all endpoints and host bridges in a
region. Switches are currently unimplemented.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h    |   3 +
 drivers/cxl/port.c   | 196 +++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/region.c |  33 +++++++-
 3 files changed, 231 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 79d22992fddf..f2ee26ac2398 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -52,6 +52,7 @@
 #define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
@@ -337,6 +338,8 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 					struct device *dev);
 struct cxl_decoder *cxl_pop_decoder(struct cxl_port *port);
 void cxl_push_decoder(struct cxl_decoder *cxld);
+int cxl_commit_decoder(struct cxl_decoder *cxld);
+void cxl_disable_decoder(struct cxl_decoder *cxld);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 5d35ccf2407f..67143c7f59bb 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -99,6 +99,202 @@ struct cxl_port_data {
 	} caps;
 };
 
+#define COMMIT_TIMEOUT_MS 10
+static int wait_for_commit(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	const unsigned long start = jiffies;
+	struct cxl_port_data *cpd;
+	void __iomem *hdm_decoder;
+	unsigned long end = start;
+	u32 ctrl;
+
+	cpd = dev_get_drvdata(&port->dev);
+	hdm_decoder = cpd->regs.hdm_decoder;
+
+	do {
+		end = jiffies;
+		ctrl = readl(hdm_decoder +
+			     CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			break;
+
+		if (time_after(end, start + COMMIT_TIMEOUT_MS)) {
+			dev_err(&cxld->dev, "HDM decoder commit timeout %x\n", ctrl);
+			return -ETIMEDOUT;
+		}
+		if ((ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) != 0) {
+			dev_err(&cxld->dev, "HDM decoder commit error %x\n", ctrl);
+			return -ENXIO;
+		}
+	} while (!!FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl));
+
+	return 0;
+}
+
+/**
+ * cxl_commit_decoder() - Program a configured cxl_decoder
+ * @cxld: The preconfigured cxl decoder.
+ *
+ * A cxl decoder that is to be committed should have been earmarked as enabled.
+ * This mechanism acts as a soft reservation on the decoder.
+ *
+ * Returns 0 if commit was successful, negative error code otherwise.
+ */
+int cxl_commit_decoder(struct cxl_decoder *cxld)
+{
+	u32 ctrl, tl_lo, tl_hi, base_lo, base_hi, size_lo, size_hi;
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port_data *cpd;
+	void __iomem *hdm_decoder;
+	int rc;
+
+	/*
+	 * Decoder flags are entirely software controlled and therefore this
+	 * case is purely a driver bug.
+	 */
+	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_EN) == 0,
+			  "Invalid %s enable state\n", dev_name(&cxld->dev)))
+		return -ENXIO;
+
+	cpd = dev_get_drvdata(&port->dev);
+	hdm_decoder = cpd->regs.hdm_decoder;
+	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	/*
+	 * A decoder that's currently active cannot be changed without the
+	 * system being quiesced. While the driver should prevent against this,
+	 * for a variety of reasons the hardware might not be in sync with the
+	 * hardware and so, do not splat on error.
+	 */
+	size_hi = readl(hdm_decoder +
+			CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
+	size_lo =
+		readl(hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl) &&
+	    (size_lo + size_hi)) {
+		dev_err(&port->dev, "Tried to change an active decoder (%s)\n",
+			dev_name(&cxld->dev));
+		return -EBUSY;
+	}
+
+	u32p_replace_bits(&ctrl, 8 - ilog2(cxld->interleave_granularity),
+			  CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(&ctrl, ilog2(cxld->interleave_ways),
+			  CXL_HDM_DECODER0_CTRL_IW_MASK);
+	u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_COMMIT);
+
+	/* TODO: set based on type */
+	u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_TYPE);
+
+	base_lo = FIELD_PREP(GENMASK(31, 28),
+			     (u32)(cxld->res.start & 0xffffffff));
+	base_hi = FIELD_PREP(~0, (u32)(cxld->res.start >> 32));
+
+	size_lo = (u32)(resource_size(&cxld->res)) & GENMASK(31, 28);
+	size_hi = (u32)((resource_size(&cxld->res) >> 32));
+
+	if (cxld->nr_targets > 0) {
+		tl_lo |= FIELD_PREP(GENMASK(7, 0), cxld->target[0]->port_id);
+		if (cxld->interleave_ways > 1)
+			tl_lo |= FIELD_PREP(GENMASK(15, 8),
+					    cxld->target[1]->port_id);
+		if (cxld->interleave_ways > 2)
+			tl_lo |= FIELD_PREP(GENMASK(23, 16),
+					    cxld->target[2]->port_id);
+		if (cxld->interleave_ways > 3)
+			tl_lo |= FIELD_PREP(GENMASK(31, 24),
+					    cxld->target[3]->port_id);
+		if (cxld->interleave_ways > 4)
+			tl_hi |= FIELD_PREP(GENMASK(7, 0),
+					    cxld->target[4]->port_id);
+		if (cxld->interleave_ways > 5)
+			tl_hi |= FIELD_PREP(GENMASK(15, 8),
+					    cxld->target[5]->port_id);
+		if (cxld->interleave_ways > 6)
+			tl_hi |= FIELD_PREP(GENMASK(23, 16),
+					    cxld->target[6]->port_id);
+		if (cxld->interleave_ways > 7)
+			tl_hi |= FIELD_PREP(GENMASK(31, 24),
+					    cxld->target[7]->port_id);
+
+		writel(tl_hi, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
+		writel(tl_lo, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
+	}
+
+	writel(size_hi,
+	       hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
+	writel(size_lo,
+	       hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
+	writel(base_hi,
+	       hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
+	writel(base_lo,
+	       hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
+	writel(ctrl, hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	rc = wait_for_commit(cxld);
+	if (rc)
+		return rc;
+
+#define DPORT_TL_STR "%d %d %d %d %d %d %d %d"
+#define DPORT(i)                                                               \
+	(cxld->nr_targets && cxld->interleave_ways > (i)) ?                    \
+		      cxld->target[(i)]->port_id :                                   \
+		      -1
+#define DPORT_TL                                                               \
+	DPORT(0), DPORT(1), DPORT(2), DPORT(3), DPORT(4), DPORT(5), DPORT(6),  \
+		DPORT(7)
+
+	dev_dbg(&port->dev,
+		"%s\n\tBase %pa\n\tSize %llu\n\tIG %u\n\tIW %u\n\tTargetList: " DPORT_TL_STR,
+		dev_name(&cxld->dev), &cxld->res.start,
+		resource_size(&cxld->res), cxld->interleave_granularity,
+		cxld->interleave_ways, DPORT_TL);
+#undef DPORT_TL
+#undef DPORT
+#undef DPORT_TL_STR
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_commit_decoder);
+
+/**
+ * cxl_disable_decoder() - Disables a decoder
+ * @cxld: The active cxl decoder.
+ *
+ * CXL decoders (as of 2.0 spec) have no way to deactivate them other than to
+ * set the size of the HDM to 0. This function will clear all registers, and if
+ * the decoder is active, commit the 0'd out registers.
+ */
+void cxl_disable_decoder(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port_data *cpd;
+	void __iomem *hdm_decoder;
+	u32 ctrl;
+
+	cpd = dev_get_drvdata(&port->dev);
+	hdm_decoder = cpd->regs.hdm_decoder;
+	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_EN) == 0,
+			  "Invalid decoder enable state\n"))
+		return;
+
+	/* There's no way to "uncommit" a committed decoder, only 0 size it */
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
+
+	/* If the device isn't actually active, just zero out all the fields */
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+		writel(CXL_HDM_DECODER0_CTRL_COMMIT,
+		       hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+}
+EXPORT_SYMBOL_GPL(cxl_disable_decoder);
+
 static inline int cxl_hdm_decoder_ig(u32 ctrl)
 {
 	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index f4d190ede3ee..05e7ca3d0900 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -526,7 +526,38 @@ static int gather_hdm_decoders(const struct cxl_region *region, struct decoder_p
 
 static int bind_region(const struct cxl_region *region)
 {
-	/* TODO: */
+	const struct decoder_programming *p = &region->state;
+	int i, rc;
+
+	for (i = 0; i < p->hb_count; i++) {
+		struct cxl_decoder *cxld = p->hbs[i].cxld;
+		int j;
+
+		cxld->res = (struct resource)DEFINE_RES_MEM(region->res->start,
+							    region->size);
+		cxld->interleave_granularity = region->ig;
+		cxld->interleave_ways = p->hbs[i].rp_count;
+		for (j = 0; j < p->hbs[i].rp_count; j++)
+			cxld->target[j] = p->hbs[i].rp_target_list[j];
+
+		rc = cxl_commit_decoder(cxld);
+		if (rc)
+			return rc;
+	}
+
+	for (i = 0; i < region_ways(region); i++) {
+		struct cxl_decoder *cxld = p->ep_cxld[i];
+
+		cxld->res = (struct resource)DEFINE_RES_MEM(region->res->start,
+							    region->size);
+		cxld->interleave_granularity = region->ig;
+		cxld->interleave_ways = region_ways(region);
+
+		rc = cxl_commit_decoder(cxld);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
-- 
2.33.1

