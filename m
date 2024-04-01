Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1423F15A4
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958268; cv=none; b=HV2yLKDucVH9FWuEEJO+LJ5jfuXTb5P9aP2WbBJOczqltkFX/IFhsS6AflGTcZYu/SxuRofpnPQaJ4wQ1+jRusQDi/8aep/2LTGKlctuEE02HN7Ij4bcFyyF2Ue4nB2o1vircn/cAkzlsIF71GC6HBiPschyvzbvLBReCthB9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958268; c=relaxed/simple;
	bh=ojwE3zF/YVoCzRXlQzzGsmLpZOtfseLJFkxVsvr5DSU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XtscDkdXO5pyfI9V4rc+M1PC5iRrEqDR66xoZX8njK9Sd6lXqhJBgpMjRdx8/Pa7O+dDnyLcN7BBu/hLku7xtG/cZDybB5wx7+8eRgLdnY3LbDJPmi+/N/y8npzncJj1/EFich6WdOXcCT7euj3DgmYFAJnQ/GCdCBZ0mReDBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Hj7s6/Dc; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Hj7s6/Dc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1711958267; x=1743494267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ojwE3zF/YVoCzRXlQzzGsmLpZOtfseLJFkxVsvr5DSU=;
  b=Hj7s6/DcL2mMFkOhoWcA3S7Wkt5hs8d3QQ4GZk25EQrWEmGsnDRvwWa9
   j943aEgeYWt7q2vnZ+VlaJuUB+5yLetp1W7rWMuCGkkG/rMeZ9OjuX5nm
   ADH/NcLS5dhLALYQxLApY2wc2PRxxBFwg2pjhQ97k58hjgVdeDsbPZChc
   bX2f4ASUmOGicheCMRMtNDN+uKLE3oPaZL8UoKqO0/smWiq0Nhal/j0K5
   kpGMfPiTBn5IF1jeq1dPKBbUKXPbwtkyLTcdTi3Z5YQk+0+D05fqvhXqw
   FTEG7nyfwWpA+Y7Em6YcMlDaI/kCQiyhoBMiOcIgMqCVzItBDpIThT+od
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="133600173"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; 
   d="scan'208";a="133600173"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 16:57:38 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8A10E118A0A
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 16:57:35 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id BE528C520A
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 16:57:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 40CA140FFA
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 16:57:34 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 4F6741A000A;
	Mon,  1 Apr 2024 15:57:33 +0800 (CST)
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
Subject: [PATCH] cxl/core/region: check interleave way capability
Date: Mon,  1 Apr 2024 03:56:35 -0400
Message-Id: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28290.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28290.005
X-TMASE-Result: 10--5.550900-10.000000
X-TMASE-MatchedRID: V4ysb0UgFCFkvkWE6RxJkTzHAJTgtKqw8boZEVitthhbgyw/wjxjozd7
	cdHHAIr1u6vrlKbSNb7UZIH18EF0kd/K1ikJIsLOuce7gFxhKa3BOVz0Jwcxl6vCrG0TnfVUaUX
	s6FguVy38yScp0aIv09wPraq/iXb+Sry0z8DqbhLNgrlT5Ajc7ibH0QLHlTYFBlnw3dG9MzGjxY
	yRBa/qJcFwgTvxipFajoczmuoPCq0FiKps0+S/mpmYQxqXPUppgnr8TL+3zzGJBOE6Xm0+Oz0LQ
	I3Cd3y6
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

I used qemu to emulaute the cxl.mem and attmpted to create a 6-way
region, the region was created successfully, but I could not access the
memory properly:
$ numactl -m 2 ls
Segmentation fault (core dumped)

I found the root cause is that the logic of converting HPA to DPA for
3-way, 6-way and 12-way were not implimented on qemu side.

But qemu has already disable the capability, so we should not create
region in such ways.

So I think we should check whether the interleave way is supported by
the target while attaching it to region.

Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com/T/#r
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/region.c | 25 +++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..dde66b7c9e3f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1786,6 +1786,24 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 	return rc;
 }
 
+static bool check_iw_capability(struct cxl_endpoint_decoder *cxled, u8 iw)
+{
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	u32 cap;
+
+	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
+	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, cap) &&
+	    (iw == 3 || iw == 6 || iw == 12))
+		return false;
+
+	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, cap) && iw == 16)
+		return false;
+
+	return true;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -1796,6 +1814,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	struct cxl_dport *dport;
 	int rc = -ENXIO;
 
+	if (!check_iw_capability(cxled, p->interleave_ways)) {
+		dev_dbg(&cxlr->dev,
+			"%s with region interleave ways: %d is not supported\n",
+			dev_name(&cxled->cxld.dev), p->interleave_ways);
+		return -EOPNOTSUPP;
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
-- 
2.37.3

