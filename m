Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183522E62A
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 11:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707479736; cv=none; b=DbasGcQHc0TgilKF54c5W7UNs4b0xszvJcwe/2Djc25YBVzKgY2VHnfVuQIZ6UbqoT2LKOGpFPEt3RLaEWnMwqbR44IbP2MuAbIJRzRcaCsXNl6X6Eiq35u1rvls6CxIrG9L3awNjtjC2PtBCQ/+V6mkUFLWC1+CfJznYfRNIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707479736; c=relaxed/simple;
	bh=DqknUnBjZ5fwkO5WCjpRr3I7mOyqFTJUsVXnrEI3Vh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDh2WYcxVLQDs4itCthNlWNqbORtQTTWqe2tF7WKA8i2uGn+7aDvDoFpVyFVU3P8fsRmy0jgptP0oBgTS75c5MvlsTRrpeZFb5sKlzL+RBKzZwlUAGrxM80siZZftoDkDHqcpes4tXeO8H1qubX3+SPrONhZpbc7ubVS4NUpm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ntA9oDrP; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ntA9oDrP"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1707479733; x=1739015733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqknUnBjZ5fwkO5WCjpRr3I7mOyqFTJUsVXnrEI3Vh4=;
  b=ntA9oDrPiZ7XpIoS0FhPcNhs5h+0VQMwQbZ6JeWW0292lG3IoIS53XTP
   RwdbjN0+8HtmuHxlsQTqOXVe9fLfpiquH6V0AIyfjn1s/zI7khjyToxNK
   En8yPB5ev3AH28zz4GwdVX7mdLHsAg+wmtKGTS6SXBMqxOCqJDKE/h3nY
   F9pQ96MIS1Yyt4dpodIMWs36rRg/GreZHylgs3J/V2YzBcUwSkcSOzRDg
   SppE+U4n2H4Wt+9cK3Af1wqKSVq65Y15qPwNkQZDiKWMQ8OnOXNpPrulq
   ekSHs4uVJ7YRVLpVxeJN+6CvXZadOPMaZrdzBbRiLSvj/mI9BxFVvhaXT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="136939364"
X-IronPort-AV: E=Sophos;i="6.05,256,1701097200"; 
   d="scan'208";a="136939364"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 20:54:22 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A6B1AD687F
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:20 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id DB23BD5006
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 726A5E3685
	for <linux-cxl@vger.kernel.org>; Fri,  9 Feb 2024 20:54:19 +0900 (JST)
Received: from irides.g08.fujitsu.local (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1AF471A009A;
	Fri,  9 Feb 2024 19:54:19 +0800 (CST)
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
To: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Cc: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com
Subject: [RFC PATCH 2/5] cxl/core: introduce cxl_memdev_dpa_to_hpa()
Date: Fri,  9 Feb 2024 19:54:14 +0800
Message-Id: <20240209115417.724638-5-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28180.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28180.007
X-TMASE-Result: 10--0.230400-10.000000
X-TMASE-MatchedRID: E/JbUmZTmPmNrFmNgJn2XRFbgtHjUWLyBPY4SegK3jyCFz9ikiaZRugo
	SvaKsl/kIvrftAIhWmLy9zcRSkKatWk5Fql3Faa7GYJhRh6ssevxKR2kbb+f18jKFxQAxz7go8W
	MkQWv6iXBcIE78YqRWo6HM5rqDwqtDOrGF7ZOho2UDWJ+gGA8HODB/FnLVeD/eq3AljACGEWBY1
	kgr1igAyCXLsbqmC2GIHzy4kLR1fJvckC7hSyyXDMdHQ58xd4CFcG3+ZRETICP9kUX1Z+buE3Lu
	mkbQiNwVCqTSPu8tVR7AxIEOt4h2Q==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When a memdev is assigned to a region, its Device Physical Address will be
mapped to Host Physical Address.  Introduce this helper function to
translate HPA from a given memdev and its DPA.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/cxl/core/memdev.c | 12 ++++++++++++
 drivers/cxl/cxlmem.h      |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dae8802ecdb0..c304e709ef0e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -319,6 +319,18 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
 	return 0;
 }
 
+phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa)
+{
+	struct cxl_region *cxlr = cxl_dpa_to_region(cxlmd, dpa);
+
+	if (cxlr)
+		return cxlr->params.res->start + dpa;
+	else {
+		dev_dbg(&cxlmd->dev, "device belongs to no region.\n");
+		return 0;
+	}
+}
+
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 {
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..97ddab421e63 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -833,6 +833,7 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		       struct cxl_region *cxlr);
 int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
+phys_addr_t cxl_memdev_dpa_to_hpa(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
-- 
2.34.1

