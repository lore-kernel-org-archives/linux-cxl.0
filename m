Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EAA94C
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072399; cv=none; b=WFdzCWUqvtizg2ZCz7P2ZSMvGgfSt5OawLq0MIxfMwJ6yUjQt+BL8TOqO8ScwruvupBeB/S0qV5UHnrvUjIjcUgYYdPU5P/8BU2USrbJFZ9ps/VTwwKKk4a9OOT+8GJzcWDQk1bmPEFbctlaSI4rnLQR96eZ+CFmLsHENfDsuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072399; c=relaxed/simple;
	bh=AoArj7WCbebGnNpnNVC4nTtSuA/gB40JMNi1M8b95Lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h1093v3YW5uZJEiwGTCB44MDP6j3GwBVTUskvcJ+/x33I1ftATvhvayeyGmZ1tq9Kq1fkiP2W5nrTBHY1LhRJtDznw9eM5uRHsfHk3k5KwcVlEYBSieszZGb95lqm5ASW/5VsThUmCkYb/OM5+/SuoLYghlm7SwpIN827Wl1bic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mfBioeDN; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mfBioeDN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718072395; x=1749608395;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AoArj7WCbebGnNpnNVC4nTtSuA/gB40JMNi1M8b95Lg=;
  b=mfBioeDNvNiIDfOiv4MO/AHiGf4bUO1a7JT1fKHwqtuXqyZn4RVnshKY
   SARoV1o2naPjexP7uaCgp++oyEOJtX1GHRSO+Sm5KoY0twNa6RlDAeisi
   JesnnmGQGmIqigbpCuAiK4bwbP9kLkLgFOIbAVDnGeL8p5RSUMAEw22F0
   ydKBFtVTZZz2SJeX50zvIf8+HSw0GPNC4jHP9pKijcpM5tru9RuUSTxSp
   wQmFbRL/wRS98i2lSsXHkzdihgGtCTRS21TXDxfrg9B6YfzdTvBbYBEaP
   P6wzsqccHprjoU1NJdGlyh8r3xKo0CNAY2MUctPDbM4V6vJqL2Z1qnY2k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="142060456"
X-IronPort-AV: E=Sophos;i="6.08,228,1712588400"; 
   d="scan'208";a="142060456"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 11:19:52 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 017ECD8016
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 11:19:51 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 486D6BDC83
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 11:19:50 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id BC6CB41183
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 11:19:49 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BC4BF1A0002;
	Tue, 11 Jun 2024 10:19:48 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v6] cxl/region: check interleave capability
Date: Mon, 10 Jun 2024 22:15:11 -0400
Message-Id: <20240611021511.35315-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28446.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28446.004
X-TMASE-Result: 10--11.178900-10.000000
X-TMASE-MatchedRID: 5xPUiUcii1KCKQp76hMfYYvefyp1glN04SkIdSwphgZNEl8XeFvcyOaL
	XqTzHpREkPI1/ZdqoS2kfiUvzNMZPM9LhMkLoGtYHWRJEfGP5nndKRNjzo2IOKvWBS71/UX/unq
	BIQj+1Jkw1PYcQ48wS+bbJpwkpbmp0UwGeYlGH8mgcOgSnZOzMZcE9F6aLBE1Qzq2udhlYuP3mu
	Lh+GPYb+1uuxu6ZpzQaZBSvh3L/JfvXvInwhwK26zGfgakLdjaCZa9cSpBObnAuQ0xDMaXkH4qt
	YI9sRE/lssl7DXxD4/Fj3CvTDWpFQkClU3H8XT/b/oIJuUAIuGp/958oU3WcNkIN4ouKvbzUexg
	NDoxdJYxO2whu+/SKHtGbZhW7m3iKA89P2l9zZ6eAiCmPx4NwJuJ+Pb8n/Vx3jNPYpPa42wqtq5
	d3cxkNZTGHb2pter3MO1rOHd967mAvGO7k/r5Vm9/qixCBdCuigAxFp8n/og=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave capability is not verified, if the interleave
capability of a target does not match the region need, committing decoder
should have failed at the device end.

In order to checkout this error as quickly as possible, driver needs
to check the interleave capability of target during attaching it to
region.

According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
Capability Register' indicate the capability to establish interleaving
in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
be attached to a region utilizing such interleave ways.

Additionally, bits 8 and 9 in the same register represent the capability
of the bits used for interleaving in the address, Linux tracks this in the
cxl_port interleave_mask.

Regarding 'Decoder Protection':
If IW is less than 8 (for interleave ways of 2, 4, 8, 16), the
interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.

If the IW is greater than or equal to 8 (for interleave ways of 6, 12),
the interleave bits start at bit position IG + 8 and end at IG + IW - 1.

When the interleave ways is 1 or 3, all the bits of HPA are used, the
interleave bits are none, the following check is ignored.

If the interleave mask is insufficient to cover the required interleave
bits, the target cannot be attached to the region.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

---

V5[5] -> V6:
-- fix some typo.
-- update comment.
-- set rc when check faild in cxl_port_attach_region().

V4[4] -> V5:
-- update comment.
-- add nr_targets check while attaching a port to switch.
-- delete passthrough flag and allow all the capabilities for passthrough
   decoders.

V3[3] -> V4:
-- update comment.
-- optimize the code.
-- add a passthrough flag to mark the passthrough decoder.

V2[2] -> V3:
-- revert ig_cap_mask to interleave_mask.
-- fix the interleave bits check logical.

V1[1] -> V2:
-- rename interleave_mask to ig_cap_mask.
-- add a check for interleave granularity.
-- update commit.
-- move hdm caps init to parse_hdm_decoder_caps().

[1]
https://lore.kernel.org/linux-cxl/20240401075635.9333-1-yaoxt.fnst@fujitsu.com

[2]
https://lore.kernel.org/linux-cxl/20240403021747.17260-1-yaoxt.fnst@fujitsu.com

[3]
https://lore.kernel.org/linux-cxl/20240409022621.29115-1-yaoxt.fnst@fujitsu.com

[4]
https://lore.kernel.org/linux-cxl/20240422091350.4701-1-yaoxt.fnst@fujitsu.com

[5]
https://lore.kernel.org/linux-cxl/20240524092740.4260-1-yaoxt.fnst@fujitsu.com
---
 drivers/cxl/core/hdm.c    | 10 +++++
 drivers/cxl/core/region.c | 89 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 +
 drivers/cxl/cxlmem.h      |  1 +
 4 files changed, 102 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..5b7dff19bbfa 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	struct cxl_dport *dport = NULL;
 	int single_port_map[1];
 	unsigned long index;
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	/* allow all the interleave capabilities for passthrough decoder */
+	cxlhdm->interleave_mask = GENMASK(14, 8);
+	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
 
 	cxlsd = cxl_switch_decoder_alloc(port, 1);
 	if (IS_ERR(cxlsd))
@@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
+	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..2716678df5db 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1101,6 +1101,26 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	}
 	cxld = cxl_rr->decoder;
 
+	/*
+	 * the number of targets should not exceed the target_count
+	 * of the decoder
+	 */
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd;
+
+		cxlsd = to_cxl_switch_decoder(&cxld->dev);
+		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s %s add: %s:%s @ %d overflows targets: %d\n",
+				dev_name(port->uport_dev), dev_name(&port->dev),
+				dev_name(&cxld->dev), dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev), pos,
+				cxlsd->nr_targets);
+			rc = -ENXIO;
+			goto out_erase;
+		}
+	}
+
 	rc = cxl_rr_ep_add(cxl_rr, cxled);
 	if (rc) {
 		dev_dbg(&cxlr->dev,
@@ -1210,6 +1230,57 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int interleave_mask;
+	u8 eiw;
+	u16 eig;
+	int rc, high_pos, low_pos;
+
+	rc = ways_to_eiw(iw, &eiw);
+	if (rc)
+		return rc;
+
+	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
+		return -ENXIO;
+
+	rc = granularity_to_eig(ig, &eig);
+	if (rc)
+		return rc;
+
+	/*
+	 * Per CXL specification (8.2.4.20.13 Decoder Protection in r3.1),
+	 * if eiw < 8:
+	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + 8 + eiw]
+	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
+	 *
+	 *   when the eiw is 0, all the bits of HPAOFFSET[51: 0] are used, the
+	 *   interleave bits are none.
+	 *
+	 * if eiw >= 8:
+	 *   DPAOFFSET[51: eig + 8] = HPAOFFSET[51: eig + eiw] / 3
+	 *   DPAOFFSET[eig + 7: 0]  = HPAOFFSET[eig + 7: 0]
+	 *
+	 *   when the eiw is 8, all the bits of HPAOFFSET[51: 0] are used, the
+	 *   interleave bits are none.
+	 */
+	if (eiw == 0 || eiw == 8)
+		return 0;
+
+	if (eiw > 8)
+		high_pos = eiw + eig - 1;
+	else
+		high_pos = eiw + eig + 7;
+	low_pos = eig + 8;
+	interleave_mask = GENMASK(high_pos, low_pos);
+	if (interleave_mask & ~cxlhdm->interleave_mask)
+		return -ENXIO;
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1360,6 +1431,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			return -ENXIO;
 		}
 	} else {
+		rc = check_interleave_cap(cxld, iw, ig);
+		if (rc) {
+			dev_dbg(&cxlr->dev,
+				"%s:%s iw: %d ig: %d is not supported\n",
+				dev_name(port->uport_dev),
+				dev_name(&port->dev), iw, ig);
+			return rc;
+		}
+
 		cxld->interleave_ways = iw;
 		cxld->interleave_granularity = ig;
 		cxld->hpa_range = (struct range) {
@@ -1796,6 +1876,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
+				  p->interleave_granularity);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
+			dev_name(&cxled->cxld.dev), p->interleave_ways,
+			p->interleave_granularity);
+		return rc;
+	}
+
 	if (cxled->mode != cxlr->mode) {
 		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
 			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 036d17db68e0..dc8e46a1fe82 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -45,6 +45,8 @@
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 36cee9c30ceb..6b8cf20ff375 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -853,6 +853,7 @@ struct cxl_hdm {
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	unsigned long iw_cap_mask;
 	struct cxl_port *port;
 };
 
-- 
2.37.3

