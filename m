Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9F22611
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777298; cv=none; b=FRkFZzY9xnLQoEK9I7AgeSyLKJ0kfp233PurdlqyWXrNGIsO97q/rOrPEhRdbUK7ZyuhBiiO0w0B6RQsXS9GzItO9GG0VLLNnfc/4tQWIYi4o5+X95iNjoySWHjC4+J2w1HLNHYNStkkAR8fXyhPITg4R8NcufY9BIA3tZjjGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777298; c=relaxed/simple;
	bh=NSb7AoSMwh4nDhcOFnuxE9e9BwHp7u6RU1iu0GG0D/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTZXBB0cPYgFSd3/AhvHyA+ks75PehKVLvGHtJeyeXvaeERjDQSzoHwLvIkVkd1kVN7+eTvhxXlK5S+qhUXyN2SabyB1FKycfVlAQpzrHvK7ncWlB2tnCSEUHbRt902a/9sL/MI1UlnQzOTcogkNbh2GtWvGBDsj6VwWNqy/NwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=KLemNpgS; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="KLemNpgS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1713777296; x=1745313296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSb7AoSMwh4nDhcOFnuxE9e9BwHp7u6RU1iu0GG0D/s=;
  b=KLemNpgSCfPVItNwxD2Sw8R8k8szDCdI80bDelcHYP03lLLemKCrjSPx
   SUfA0sfILgxjsLQoHgpeVoSMrW7h1+AErXLGkQspmJGckuKcJopCnl6Y5
   UQRVnproMZ5CStKopOV/ZgUjvEDqpANKEkHb9CZJ344x3mLMwU9YvBBMb
   2wXG0LN381o6aByIUZ9rXf2nJfA8BkTP1EqCc3sNUguKqRUuSlBmrOK15
   xtlT2k4y+2wiLfgkliz1iTISImCmemqej1MHlCZAc8LIbNuaFxLb5KFIQ
   Iizd6PRSTst/q+lq/NrWjvssdDpFNvURuhzsl9BJ3RstThvwxGc45dM+u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11051"; a="156297920"
X-IronPort-AV: E=Sophos;i="6.07,220,1708354800"; 
   d="scan'208";a="156297920"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 18:14:47 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 199F8D9DC1
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:45 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 157FED4BF8
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 958F920093277
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 18:14:43 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id EADE71A000C;
	Mon, 22 Apr 2024 17:14:42 +0800 (CST)
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
Subject: [PATCH v4 2/2] cxl/region: check interleave capability
Date: Mon, 22 Apr 2024 05:13:50 -0400
Message-Id: <20240422091350.4701-3-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
References: <20240422091350.4701-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28336.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28336.006
X-TMASE-Result: 10--6.591300-10.000000
X-TMASE-MatchedRID: 2reTTf+FGgP1FjL5pOozBXeM7/EGB9RSW+HVwTKSJIYYzaT/lQGltqXU
	yW1SOqVgF0zr/L2WUfRQcrAG3UvfE3585nKQczq7RHSgjCgw/JUCGAqMIYu/os5vuB8AqBMQOrT
	V1pt7yWLwPofUv1eohI9EQu4ZqaSbW/S32WUN1/5FThfcy7XcjAmWvXEqQTm5wLkNMQzGl5B+Kr
	WCPbERP+CvRZnq77Kl2qrzycqlC6/3LKKZvqYslKBw6BKdk7MxP8UQejhp29qqA3rusLu26mS0G
	F7aVfVO4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vtv2M8uBi2ubp8bcsXQUfTefY+mwAxft1t/Bd
	OrguYTc5wFM94z7+fw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave capability is not verified, a target can successfully
attach to a region even if it lacks support for the specified interleave
ways or granularity.

When attempting to access memory, unexpected behavior occurs due to the
incorrect conversion of HPA to a faulty DPA, leading to a segmentation
fault, as observed when executing the command:
$ numactl -m 2 ls

According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
Capability Register' indicate the capability to establish interleaving
in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
be attached to a region utilizing such interleave ways.

Additionally, bits 8 and 9 in the same register represent the capability
of the bits used for interleaving in the address, commonly referred to as
the interleave mask.

Regarding 'Decoder Protection':
If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.

If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
the interleave bits start at bit position IG + 8 and end at IG + IW - 1.

If the interleave mask is insufficient to cover the required interleave
bits, the target cannot be attached to the region.

The above check does not apply to the host-bridges with single port and
switches with single dport, because there does not have a instance of
CXL HDM Decoder Capability Structure for them.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/hdm.c    |  5 +++
 drivers/cxl/core/region.c | 70 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/cxlmem.h      |  1 +
 4 files changed, 78 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 27fb4f9d489e..b201be4b8d76 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -80,6 +80,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
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
index 5c186e0a39b9..5c09652136c9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1210,6 +1210,60 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	struct cxl_switch_decoder *cxlsd;
+	unsigned int interleave_mask;
+	u8 eiw;
+	u16 eig;
+	int rc, high_pos, low_pos;
+
+	if (is_switch_decoder(&cxld->dev)) {
+		cxlsd = to_cxl_switch_decoder(&cxld->dev);
+		if (cxlsd->passthrough)
+			return 0;
+	}
+
+	rc = ways_to_eiw(iw, &eiw);
+	if (rc)
+		return rc;
+
+	if (!(cxlhdm->iw_cap_mask & BIT(iw)))
+		return -EOPNOTSUPP;
+
+	rc = granularity_to_eig(ig, &eig);
+	if (rc)
+		return rc;
+
+	/*
+	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
+	 * if IW < 8, the interleave bits start at bit position IG + 8, and
+	 * end at IG + IW + 8 - 1.
+	 * if IW >= 8, the interleave bits start at bit position IG + 8, and
+	 * end at IG + IW - 1.
+	 */
+	if (eiw >= 8)
+		high_pos = eiw + eig - 1;
+	else
+		high_pos = eiw + eig + 7;
+	low_pos = eig + 8;
+	/*
+	 * when the IW is 0 or 8 (interlave way is 1 or 3), the low_pos is
+	 * larger than high_pos, since the target is in the target list of a
+	 * passthrough decoder, the following check is ignored.
+	 */
+	if (low_pos > high_pos)
+		return 0;
+
+	interleave_mask = GENMASK(high_pos, low_pos);
+	if (interleave_mask & ~cxlhdm->interleave_mask)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1360,6 +1414,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
 		cxld->interleave_ways = iw;
 		cxld->interleave_granularity = ig;
 		cxld->hpa_range = (struct range) {
@@ -1796,6 +1858,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
 	if (cxled->mode != cxlr->mode) {
 		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
 			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6f562baa164f..b7afb936c854 100644
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
index 36cee9c30ceb..a044234f5993 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -853,6 +853,7 @@ struct cxl_hdm {
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	unsigned int iw_cap_mask;
 	struct cxl_port *port;
 };
 
-- 
2.37.3

