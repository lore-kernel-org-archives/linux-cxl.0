Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6541BDCE
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110755; cv=none; b=V24S02o1xaeNUtnimqJellOGyfqvb2dYTHCq+lAt6WVpsSraoa55bwuVhZEjSFQPORJhrmCzo84WT8WzU+kXUZDeP1hnlINNEr08h3Ky5h60S6q+JN3devcRnfQeGm9Hsl7qRCukZHLoS639tXqyVAVY3f3CWUvz0rP4XvgwVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110755; c=relaxed/simple;
	bh=72K2oszAxwkeTyoELNXGaRH6TVEOGULbt4Arjq4l6VU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r45A9m3zEw03zn5IHIxTnDJpX8r6b+rJs/Z1ruLTQOzWeCMhNimczudOjtkE8VMQIPZ+1WeK7zFVpap5+ZWAkRaI0zOiD5SfOIwKy5eKNSI6Cr9VoTQBQvmo2rLIYEJ9u17Nx8irtVqtJGdp2Eelvyo54wj+1yMmz+i520TEcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Gg/PT5EN; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Gg/PT5EN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712110753; x=1743646753;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=72K2oszAxwkeTyoELNXGaRH6TVEOGULbt4Arjq4l6VU=;
  b=Gg/PT5ENpmPVG3KcGNFLa5IJy/B/gKo54YdkcAgB8V1KweDzTROU+XDs
   APB+9tQ5moJl5zLyyFLpLP9k0JJKMuJk9EnY25OlbFWlNlJNcGPp+Hf5w
   XY3AXoe0uyndxz0VCz2kz8lvwVpTSkfcB22M1oizvgl2REm53PtSDbyb6
   Az6ZikD2/zY1UpEaGFhoD5SbPwfBvu76emi4YNU5Ah3kG9UOVTP5S1Y/S
   h06ZxFp7wtIgCDPD0TsmtPFlWQBZd3kER13z0+6rz2BstQ7mPl2g91kJW
   /VI5R/OWC+/eiBlhmq2ltherJaUTiB8JmE75ZRTSemf3/BluXKi8EPT34
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="154423299"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="154423299"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:19:08 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 72B64D4804
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:19:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E8D9D620C
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:19:05 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 37A43220E68
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:19:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 9BB8E1A0002;
	Wed,  3 Apr 2024 10:19:04 +0800 (CST)
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
Subject: [PATCH v2 2/2] cxl/core/region: check interleave capability
Date: Tue,  2 Apr 2024 22:17:47 -0400
Message-Id: <20240403021747.17260-3-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28294.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28294.004
X-TMASE-Result: 10--6.874500-10.000000
X-TMASE-MatchedRID: QhZNiSEZdB31FjL5pOozBZjnsVPBNMvR+KgiyLtJrSBgPgeggVwCFugo
	SvaKsl/kIvrftAIhWmLy9zcRSkKatcbo+9KQi880b/oIJuUAIuF8m8RQoY1fdN9zZd3pUn7K09D
	6Rw2zIrMxO2whu+/SKHtGbZhW7m3iKA89P2l9zZ6eAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8h+IC
	quNi0WJKLJphnVzLv5TjyhSbBa1CM/Bsa7BcD2mjtcNi4T0L3oftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave capability is not checked, a target can be attached to
region successfully even it does not support the interleave ways or
interleave granularity.

When accessing the memory, unexpected behavior occurs due to converting
HPA to an error DPA:
$ numactl -m 2 ls
Segmentation fault (core dumped)

Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/hdm.c    |  4 ++++
 drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/cxlmem.h      |  1 +
 4 files changed, 48 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 9bb6a256cc6f..1a99b138dbec 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -79,6 +79,10 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->ig_cap_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
 		cxlhdm->ig_cap_mask |= GENMASK(14, 12);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
+		cxlhdm->iw_cap_mask |= BIT(16);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..25d178e14ed1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1786,6 +1786,36 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+static int
+check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	u8 eiw;
+	u16 eig;
+	int rc;
+
+	rc = ways_to_eiw(iw, &eiw);
+	if (rc)
+		return rc;
+
+	if (eiw > 3 && !(cxlhdm->iw_cap_mask & BIT(iw))) {
+		dev_dbg(&cxld->dev, "iw: %d is not supported\n", iw);
+		return -EOPNOTSUPP;
+	}
+
+	rc = granularity_to_eig(ig, &eig);
+	if (rc)
+		return rc;
+
+	if (!(BIT(eig + 8) & cxlhdm->ig_cap_mask)) {
+		dev_dbg(&cxld->dev, "ig: %d is not supported\n", ig);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -1796,6 +1826,17 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
+				  p->interleave_granularity);
+	if (rc) {
+		dev_dbg(&cxlr->dev,
+			"%s with region iw: %d, ig: %d is not supported\n",
+			dev_name(&cxled->cxld.dev),
+			p->interleave_ways,
+			p->interleave_granularity);
+		return rc;
+	}
+
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
index b53f7ae0fdd6..979c22955246 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -853,6 +853,7 @@ struct cxl_hdm {
 	unsigned int decoder_count;
 	unsigned int target_count;
 	unsigned int ig_cap_mask;
+	unsigned int iw_cap_mask;
 	struct cxl_port *port;
 };
 
-- 
2.37.3

