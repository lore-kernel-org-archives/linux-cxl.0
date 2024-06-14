Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B69190068
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 08:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354894; cv=none; b=WjyjoIerxtntqv4zQf+vYT5PDfHIyrEJzNP1mYNa5qZOauYAZsFgKXfo5gUfVrx3SIcBSDH3XmjteZI+G16Y4ZzBnF9bRvqXd/IFobrJK4uzxcKkN/5kFFzEmj/+gR4NLjejpj3ptlNEHcijA/YBBZ3yGIvcVO8f2gVz6P8w/4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354894; c=relaxed/simple;
	bh=oil+j67d2TCyqZM5kBiWIu1f847Ge/R5OzIWxUm+crE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wmfe/iQDEFn1PdKuBIzzAab1dhl9n6B5DiEPZYGeis1FxhbLuLWDEkKKTZIt+vQuPmeFlfOSJ0CDM4MonVcD/s73Sp1yrRyLpzddeeaC717kjfit7JpCKmeROuLHgZ5NZDLgdb2v08ji62YiD8+ki37z0Y+6m2IBuAVYPZQHu/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aBKq0yTp; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aBKq0yTp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718354891; x=1749890891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oil+j67d2TCyqZM5kBiWIu1f847Ge/R5OzIWxUm+crE=;
  b=aBKq0yTpcpn/BXRCUWWSVL9Ik5pws3oX6WoWUFUSV87TvlNePEBrnZS6
   4/XPYk/zye3kbz5yBiXMrcak0CtBGGFQvh++ej1yL5ulWcZ/6p0Du1jIA
   fOHFp/GapBaMOB/d6KDQ36Zff6xEE2vssKlNYfnAc8WdLj8dFgtW/824U
   I65RiIC7XJsORTXqVih0yTomRY/R5fDgwhhwy2avoYDMiYVroHMgeFs8+
   OyySz0yqHBWGSFBUCTSnE5zti2gR24egafWIg+E3o6lT2x3j8LGdcYgpn
   zZiu/flt3J8YMbHt8rCasEojH11orT+BOI1hWJwLXlQP+8Cqz1727Bkpf
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="162427714"
X-IronPort-AV: E=Sophos;i="6.08,237,1712588400"; 
   d="scan'208";a="162427714"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 17:48:02 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 41BCAD7AD2
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:48:00 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7777CBDB69
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:47:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0720A2007CAB0
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 17:47:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0B5361A000B;
	Fri, 14 Jun 2024 16:47:57 +0800 (CST)
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
Subject: [PATCH v9 1/2] cxl/region: check interleave capability
Date: Fri, 14 Jun 2024 04:47:54 -0400
Message-Id: <20240614084755.59503-2-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
References: <20240614084755.59503-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28452.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28452.006
X-TMASE-Result: 10--15.003500-10.000000
X-TMASE-MatchedRID: P/hT4jlJcUSCKQp76hMfYYvefyp1glN04SkIdSwphgbAcOVi+ckjTQ/g
	N7zduuYXPwMNHlDj5arO6dmrTEheZQC06P0CvIY5KQxHYsCcxGlr2qJoNIuCjToUdFbHYUawvwU
	evDt+uW5/XjpbSJS7a2950PcJhKMdbHw3hiEs7YQZgmFGHqyx6wHSb9ju9dd8NAzT8I6i53AIpj
	Lek0l1pTPF0JllmKRWA3QiwhoZS/s8g1fEYZ38282CuVPkCNzu0NnUUVMlTKYUoJOBFYW8JuZOy
	8vmsc/pE6+MLRQ4FNEaAF0i3lwvcMYVE9z6Dlloo65WJt1k1O8WUg/hm489yBRfFsYbg/uso8WM
	kQWv6iXBcIE78YqRWo6HM5rqDwqtd8oQo9odB4xl0tH18iQhGrDP4JSU914CjtVBA6heZOAclzV
	T/DYP/g==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave capability is not verified, if the interleave
capability of a target does not match the region need, committing decoder
should have failed at the device end.

In order to checkout this error as quickly as possible, driver needs
to check the interleave capability of target during attaching it to
region.

Per CXL specification r3.1(8.2.4.20.1 CXL HDM Decoder Capability Register),
bits 11 and 12 indicate the capability to establish interleaving in 3, 6,
12 and 16 ways. If these bits are not set, the target cannot be attached to
a region utilizing such interleave ways.

Additionally, bits 8 and 9 represent the capability of the bits used for
interleaving in the address, Linux tracks this in the cxl_port
interleave_mask.

Per CXL specification r3.1(8.2.4.20.13 Decoder Protection):
  eIW means encoded Interleave Ways.
  eIG means encoded Interleave Granularity.

  in HPA:
  if eIW is 0 or 8 (interleave ways: 1, 3), all the bits of HPA are used,
  the interleave bits are none, the following check is ignored.

  if eIW is less than 8 (interleave ways: 2, 4, 8, 16), the interleave bits
  start at bit position eIG + 8 and end at eIG + eIW + 8 - 1.

  if eIW is greater than 8 (interleave ways: 6, 12), the interleave bits
  start at bit position eIG + 8 and end at eIG + eIW - 1.

  if the interleave mask is insufficient to cover the required interleave
  bits, the target cannot be attached to the region.

Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c       | 13 ++++++
 drivers/cxl/core/region.c    | 82 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h            |  2 +
 drivers/cxl/cxlmem.h         | 10 +++++
 tools/testing/cxl/test/cxl.c |  4 ++
 5 files changed, 111 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 784843fa2a22..3df10517a327 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -52,6 +52,14 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 	struct cxl_dport *dport = NULL;
 	int single_port_map[1];
 	unsigned long index;
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+
+	/*
+	 * Capability checks are moot for passthrough decoders, support
+	 * any and all possibilities.
+	 */
+	cxlhdm->interleave_mask = ~0U;
+	cxlhdm->iw_cap_mask = ~0UL;
 
 	cxlsd = cxl_switch_decoder_alloc(port, 1);
 	if (IS_ERR(cxlsd))
@@ -79,6 +87,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
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
index 3c2b6144be23..034cc0a90e8f 100644
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
@@ -1210,6 +1230,50 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int interleave_mask;
+	u8 eiw;
+	u16 eig;
+	int high_pos, low_pos;
+
+	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
+		return -ENXIO;
+	/*
+	 * Per CXL specification r3.1(8.2.4.20.13 Decoder Protection),
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
+	ways_to_eiw(iw, &eiw);
+	if (eiw == 0 || eiw == 8)
+		return 0;
+
+	granularity_to_eig(ig, &eig);
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
@@ -1360,6 +1424,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
@@ -1796,6 +1869,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
index 603c0120cff8..d770a00f95e4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -47,6 +47,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
 #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
+#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
 #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
 #define   CXL_HDM_DECODER_ENABLE BIT(1)
 #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 19aba81cdf13..7806194d2de1 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -851,11 +851,21 @@ static inline void cxl_mem_active_dec(void)
 
 int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
 
+/**
+ * struct cxl_hdm - HDM Decoder registers and cached / decoded capabilities
+ * @regs: mapped registers, see devm_cxl_setup_hdm()
+ * @decoder_count: number of decoders for this port
+ * @target_count: for switch decoders, max downstream port targets
+ * @interleave_mask: interleave granularity capability, see check_interleave_cap()
+ * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
+ * @port: mapped cxl_port, see devm_cxl_setup_hdm()
+ */
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int interleave_mask;
+	unsigned long iw_cap_mask;
 	struct cxl_port *port;
 };
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 3482248aa344..90d5afd52dd0 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -630,11 +630,15 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
 					  struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
+	struct device *dev = &port->dev;
 
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
+	cxlhdm->interleave_mask = ~0U;
+	cxlhdm->iw_cap_mask = ~0UL;
+	dev_set_drvdata(dev, cxlhdm);
 	return cxlhdm;
 }
 
-- 
2.37.3

