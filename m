Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCE4F5E6
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629750; cv=none; b=G/bogtrgcia1dn46RVdAegozVwnlEPhqn08FeEznbOnVoS5aiXgeONQ+9iJwY0b3UDrDXOEKH8LcaHKXf0/LEp366oYLa2JCFys9M+ze3UQkSED1KuyMwPIVr9FQ2RdVz5uaQlLvNrxCodrXq1ubJ5jfvzKIhoyLlVoIkTeyuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629750; c=relaxed/simple;
	bh=XAOFp0ujWMJqS70IYdIdDH1Zq0n7/QqhPArXtXIuu8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=juN7h0ZfV2DOXOS8d6wuO8J8uCYr/Z+4ssCUgyKKfNGDIKXYlUjziRat/geFoldNzrwhzvyJmYsMf86tkZ/coP4CyuqXSI9Xyjzxgtz5Lc37ctdyKASYwSyXWYwPdVnshISRAOkZD01sYCk/dqi6sdsKZ9VAyg/NY9G8ehObw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TVF9Wdme; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TVF9Wdme"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712629747; x=1744165747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XAOFp0ujWMJqS70IYdIdDH1Zq0n7/QqhPArXtXIuu8Y=;
  b=TVF9Wdme6Xw2qyZqP9O7ivsr5bf3LECX1pFFBOifCUTKpBrDuQPVni4e
   uyejWF8pCIt3bE2X5+S6qdqHk88MT092teVYZKKrmvrKOKAG2FNFwpF/4
   eSfBHEzdFhlZ66yJ4tOyJyAtrNS0CZAhE17a/YmUe8FTB8MsFMe7/Lv5h
   aamru1QYVyDRlYAIBCnqPjaV2+EA5b19fkyuOohJI2YUV5ksFwbpFWSFt
   RS1uILXyGFRNpyCvXwXnLHUA5oWlSdds/0zpVzzOAt6uQ8mUIKJ7MNxoe
   Xvf+CvnBT1DJBh32iS4L+bSu7jBSC3fWn+QISVZFgswMY+J4EIPRkhH1L
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="154439608"
X-IronPort-AV: E=Sophos;i="6.07,188,1708354800"; 
   d="scan'208";a="154439608"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 11:27:55 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A3B0B0022
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 11:27:52 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 91CE1D53E8
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 11:27:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 11FBF20097BC5
	for <linux-cxl@vger.kernel.org>; Tue,  9 Apr 2024 11:27:51 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1CA441A0002;
	Tue,  9 Apr 2024 10:27:50 +0800 (CST)
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
Subject: [PATCH v3] cxl/core/region: check interleave capability
Date: Mon,  8 Apr 2024 22:26:21 -0400
Message-Id: <20240409022621.29115-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28306.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28306.004
X-TMASE-Result: 10--4.242900-10.000000
X-TMASE-MatchedRID: 9KhQTl9YfS/1FjL5pOozBZjnsVPBNMvR+KgiyLtJrSBgPgeggVwCFugo
	SvaKsl/kIvrftAIhWmLy9zcRSkKatcbo+9KQi880b/oIJuUAIuEEa8g1x8eqF0rXDzW3VVVtZSg
	PkksZfMApzW7aDhkLmLhiviNSdTzijbcgpFl911p2jSf4k8Vwmn0tCKdnhB589yM15V5aWpj6C0
	ePs7A07Z5Vb9l0vnaPmUfYfOaLd0Dc08zUTVZG8RJ7YoiXc7foWFUL10VlrMm/Zcv9+vX2ljhDK
	0tEW0bMKGuw4CqsXuKFDa6FxY2i/7Iq4kqKvnq5hpPsVGqnTA8BxCsB8GHr28FEsV4fo4lIJMMP
	4MGO4TA=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave capability is not checked, a target can be attached to
region successfully even it does not support the interleave way or
interleave granularity.

When accessing the memory, unexpected behavior occurs due to converting
HPA to an error DPA:
$ numactl -m 2 ls
Segmentation fault (core dumped)

Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/hdm.c    |  5 ++++
 drivers/cxl/core/region.c | 51 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/cxlmem.h      |  1 +
 4 files changed, 59 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..5ac79d843a16 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -79,6 +79,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
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
index 5c186e0a39b9..abc14fe1717e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1210,6 +1210,41 @@ static int check_last_peer(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	unsigned int interleave_mask;
+	u8 eiw;
+	u16 eig;
+	int rc, start_pos, stop_pos;
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
+	if (eiw >= 8)
+		start_pos = eiw + eig - 1;
+	else
+		start_pos = eiw + eig + 7;
+	stop_pos = eig + 8;
+	if (stop_pos > start_pos)
+		return 0;
+
+	interleave_mask = GENMASK(start_pos, stop_pos);
+	if ((interleave_mask & cxlhdm->interleave_mask) != interleave_mask)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int cxl_port_setup_targets(struct cxl_port *port,
 				  struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled)
@@ -1360,6 +1395,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
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
@@ -1796,6 +1839,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
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
index 534e25e2f0a4..da8a487ededa 100644
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
index 20fb3b35e89e..1ec3e6285d41 100644
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

