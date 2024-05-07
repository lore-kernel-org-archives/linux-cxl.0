Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E944C9D;
	Tue,  7 May 2024 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060084; cv=none; b=QGDzAqCMU8UY06mu8T0WHe6UIv4uiCdQO38Cb+5avpHqCdG5Vpp3lWxBEJlRa+LmJ04nVdTPHMfhlTXbjtWAk3c7TQywr8fC/VwnNgdcoAf4t6HRE6HOiCQtNUgnyIcaP+5UCn/wAcPk5mnW/CUewb3vSUQi+e59/i+trwJWNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060084; c=relaxed/simple;
	bh=kWsx9r+IsZebycMvtu2kA8q1XeItoXHgG6C79L0hDcA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BGo0cajDxZHCMreIkAQTbN7hyXRJhm197Mil0JHAdKaJhMDGxm3Q8Abc/Yud6AqSzfX7Tiy/BR2vWt+fMy7auCANr0pWksLeYDUV4nScq1FlMF9xGrS1nu3owCp0c9kGZhMVkmQ6HUqBhrDX2lY9KB4aqkMGV/GUjVUoF6z6MSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dg+J8jDO; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dg+J8jDO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1715060082; x=1746596082;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWsx9r+IsZebycMvtu2kA8q1XeItoXHgG6C79L0hDcA=;
  b=dg+J8jDOZbrrye0q/2PbNnFuY7gnNR7gEKWrxfdoMjmf89BRB6K+hPqe
   F3v4w5fEZ75ZoxXj9nsYljVL0uW9kqlqj459F1OVi+u9bzu1hqRAgMVmq
   TcrkYNRws+L4ElFnJBycmkJZRXZ/GhroDycgVpEoDtLpidZbHIP3mRIWF
   BVrEmw2xSzpj4UEQIKWhgApN4UgHWT1zazS/I7X+iHJjuI2IjJxqOCkB2
   L/CiAKjoEa+ToQI/cOd1pCVSeA1q2tnIGETchwkVN/4F8JlYewbBiulXl
   tZb86drjSlk79Lse/0cDlpDJL1FLUkufQPdRBrgquXKIPzuCWEUfh1vpK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="136791182"
X-IronPort-AV: E=Sophos;i="6.07,260,1708354800"; 
   d="scan'208";a="136791182"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 14:34:32 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CB5BD6EFE;
	Tue,  7 May 2024 14:34:30 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id A7313D9732;
	Tue,  7 May 2024 14:34:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4557220071A34;
	Tue,  7 May 2024 14:34:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 643281A0002;
	Tue,  7 May 2024 13:34:28 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] cxl/region: Fix memregion leaks in devm_cxl_add_region()
Date: Tue,  7 May 2024 13:34:21 +0800
Message-Id: <20240507053421.456439-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28366.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28366.005
X-TMASE-Result: 10--5.654200-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cP/rbll2ZPJSIL5ja7E+OhynpdnAKvzbsEBLwIiWDU8a78F
	Hrw7frluf146W0iUu2tDc4lSgrowpc2IoAvAG8CyBe3KRVyu+k3DCscXmnDN78fASe7knCttQIs
	gZTZgm0Ggx1wnIrEXsoAy6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHu60fgqs6GC2l5dg
	k0gqkmKXunP19LriDGzAxqArotu/kfwV6sBPR0lg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Move the mode verification to __create_region() before allocating the
memregion to avoid the memregion leaks.

Fixes: 6e099264185d ("cxl/region: Add volatile region creation support")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Move the mode verification to __create_region() # Dan
---
 drivers/cxl/core/region.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 812b2948b6c6..18b95149640b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2352,15 +2352,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	struct device *dev;
 	int rc;
 
-	switch (mode) {
-	case CXL_DECODER_RAM:
-	case CXL_DECODER_PMEM:
-		break;
-	default:
-		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
-		return ERR_PTR(-EINVAL);
-	}
-
 	cxlr = cxl_region_alloc(cxlrd, id);
 	if (IS_ERR(cxlr))
 		return cxlr;
@@ -2415,6 +2406,15 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 {
 	int rc;
 
+	switch (mode) {
+	case CXL_DECODER_RAM:
+	case CXL_DECODER_PMEM:
+		break;
+	default:
+		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
+		return ERR_PTR(-EINVAL);
+	}
+
 	rc = memregion_alloc(GFP_KERNEL);
 	if (rc < 0)
 		return ERR_PTR(rc);
-- 
2.29.2

