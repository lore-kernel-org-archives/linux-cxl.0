Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A132572E;
	Tue, 25 Nov 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081461; cv=none; b=Uf5/zeaNON5+bVN8/FpMbtsfnBAuZQCWmvceL2Th4hrTjssYWYh3q7CeztXw+owjdlzh36fzEnuFbmBxuhKDaiNHpqlIjZF1I2kDVNlSv2Svb5l0kbB2+urKpre3k42XsRp9zn2a/3OlqMcMtkjLRlT1i01tGK363do3fOg0qKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081461; c=relaxed/simple;
	bh=G0/MBVaVUSJEMjwaIVqzxBwjG+MMLP0g5258UR/9qY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBinZi19sDuc+scVxr5MreW68HRRlN/fypIVgj0A1rRuDcL6EGDpxjSpRz34yfE5zVuNm0OqNBDUKj3VMJ0m0p71qSRgnf+gFTOs/tuwrucZKGSwmWqOn+Ul1+xbATG7TV9KF9K5y5XFBaJ6jAQTwcrkaA3pmAQq+qo7EzckDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=mJlcGQmn; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="mJlcGQmn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1764081460; x=1795617460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G0/MBVaVUSJEMjwaIVqzxBwjG+MMLP0g5258UR/9qY8=;
  b=mJlcGQmn5oKsMtlx6QU9r+Mzf5DzspEWybuyBK3IJw2ZoCyq3RUCA0sy
   BFk4ax6uEq9LrfnYx9rgr3uCap49sASPe4AZIfIC4JMHpDNemG5b71Stm
   zMMNwLX7cF7uVBu0a03Qa+FIc/TRXuLGxTvoPixoKUrHMaitsCFPLiR/5
   U+gSwUC7Jh5B6/44oHGwtPuqE0n4JpUnruaTps5L8hIIz0QdlyBxdaYUA
   y5XpsybfZqLEL6TQQIUmC8LfoPVljYOsLpSkK+562VHzmb7ERXnrqUqPU
   WBAZWXdNLQ93l5NynK1OVSE1UovBo9FsIyhueAQcl0wlX7t1xtRD+rRLw
   Q==;
X-CSE-ConnectionGUID: uWuqJbmmQvCBtxv3v7sEJw==
X-CSE-MsgGUID: L66ne24SQVy9CQU4z60pIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="220337716"
X-IronPort-AV: E=Sophos;i="6.20,225,1758553200"; 
   d="scan'208";a="220337716"
Received: from unknown (HELO az2uksmgr1.o.css.fujitsu.com) ([52.151.125.19])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 23:36:29 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id 04A421C1C711;
	Tue, 25 Nov 2025 14:36:29 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTP id 7FD621400383;
	Tue, 25 Nov 2025 14:36:28 +0000 (UTC)
Received: from nezuko.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id DD2D22005371;
	Tue, 25 Nov 2025 23:36:26 +0900 (JST)
From: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
To: dan.j.williams@intel.com,
	alison.schofield@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
Subject: [RFC PATCH v1 2/2] cxl/cli: enforce HPA-descending teardown order for destroy-region
Date: Tue, 25 Nov 2025 23:38:24 +0900
Message-ID: <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement destroy_multiple_regions() and bypass the generic
do_region_xable() path for ACTION_DESTROY. Regions are collected and
sorted by HPA, then destroyed from highest to lowest, stopping at the
first "matching after skipped" to provide user with better error log.
This prevents attempts on non-last regions and aligns destroy-region
with required decoder programming order.

Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
---
 cxl/region.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/cxl/region.c b/cxl/region.c
index 58765b3d..1bf1901a 100644
--- a/cxl/region.c
+++ b/cxl/region.c
@@ -950,6 +950,57 @@ static int destroy_region(struct cxl_region *region)
 	return cxl_region_delete(region);
 }
 
+static int destroy_multiple_regions(struct parsed_params *p,
+				 struct cxl_decoder *decoder,
+				 int *count)
+{
+	struct cxl_region **list;
+	int nr, rc, i;
+	bool skipped = false;
+
+	rc = collect_regions_sorted(decoder, NULL, &list, &nr);
+	if (rc) {
+		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
+		return rc;
+	}
+
+	for (i = nr - 1; i >= 0; --i) {
+		struct cxl_region *region = NULL;
+
+		for (int j = 0; j < p->argc; j++) {
+			region = util_cxl_region_filter(list[i], p->argv[j]);
+			if (region)
+				break;
+		}
+
+		if (!region) {
+			skipped = true;
+			continue;
+		}
+
+		/* if current region matches filter, but previous didn't, destroying would
+		 * result in breaking HPA continuity
+		 */
+		if (skipped) {
+			log_err(&rl, "failed to destroy %s: not a valid HPA suffix under %s\n",
+				cxl_region_get_devname(region),
+				cxl_decoder_get_devname(decoder));
+			rc = -EINVAL;
+			break;
+		}
+
+		rc = destroy_region(region);
+		if (rc) {
+			log_err(&rl, "%s: failed: %s\n",
+				cxl_region_get_devname(region), strerror(-rc));
+			break;
+		}
+		++(*count);
+	}
+	free(list);
+	return rc;
+}
+
 static int do_region_xable(struct cxl_region *region, enum region_actions action)
 {
 	switch (action) {
@@ -957,8 +1008,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
 		return cxl_region_enable(region);
 	case ACTION_DISABLE:
 		return disable_region(region);
-	case ACTION_DESTROY:
-		return destroy_region(region);
 	default:
 		return -EINVAL;
 	}
@@ -1026,7 +1075,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
 			if (!util_cxl_decoder_filter(decoder,
 						     param.root_decoder))
 				continue;
-			rc = decoder_region_action(p, decoder, action, count);
+
+			if (action == ACTION_DESTROY)
+				rc = destroy_multiple_regions(p, decoder, count);
+			else
+				rc = decoder_region_action(p, decoder, action, count);
+
 			if (rc)
 				err_rc = rc;
 		}
-- 
2.45.1.windows.1

