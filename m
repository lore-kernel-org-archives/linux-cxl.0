Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBA7395D98
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450071; cv=none; b=irP8qEcQISwDR7b57V3MFHccK9SfxFLk4vwRSQIcTxLsa21oIIJ8Xd8jRhZLDkvkJg15//1m2xfECThSitnTGHykMiCRyUK7hydWk6dTrck4Kykv3oMP7wl2TNhFOWBtPfCrGdbdcKShTQ+ETQwlTAP5tcIkj2mpupr/VS/GoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450071; c=relaxed/simple;
	bh=V1pHeEuPBesymqPrJLh02pa0u8t9fb2Fk6tg6X5v/KI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLzytIZDpp4euWNY4A8jM6bkPsppG7TH2j0SyWnut1lHTykxgh8QTdJBod61PX8VUud67UczWEYy0pIyht0i+h6l0M01dyBw2moCMgKyZlB9QK+9io2ADLsoePYXOP4dRoRMHMqEkieku0F+YqNQ888Y7seWrZNJo+Tu7IWiW6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFWHKmpP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFWHKmpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450069; x=1816986069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V1pHeEuPBesymqPrJLh02pa0u8t9fb2Fk6tg6X5v/KI=;
  b=dFWHKmpPvpagr9Bu0YoZgjrzlaMrPXLgcRvH82HUznALiaF0M6AW3HID
   oYbEEEUfyf15jDpQ5PuFVyv41GkWFtoJ5g9chtSoyWZcUisVg1X5z32JR
   wEnFG/QOGB6KLslUxxobnc35EmqIOgqO1kI2XIaJ3ieaT6wL7HetZvKsS
   2C/0fruBIa63QwA/yh/muVPXxO9AmnkR4bj9jm+afkfbZegX9ZR0bgM7l
   W32TT4of5nY+tKDWwBfWt+09WVBxt3raglTWxvOhiCvtG/KA8sWhzlHXT
   WrFHQ3NFO+e2/GLbSxpb+RpOIlWCxwZUPvwK12xKz63S6QZpxyrlqMErY
   g==;
X-CSE-ConnectionGUID: 3uFwbFmdRtSBujQK9YTtfg==
X-CSE-MsgGUID: Mj0sar0TQEKGhrhtMNmUrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96665401"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96665401"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:50 -0700
X-CSE-ConnectionGUID: SUF4czzxT56CIZeNsRdiVA==
X-CSE-MsgGUID: ITnUngj5TyOAyhOFuo3QBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265482266"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:47 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 7/9] cxl/region: Fail region creation on position check mismatch
Date: Thu, 30 Jul 2026 15:20:27 -0700
Message-ID: <73e263e243583a26d0ab302a4f39aabc4a47b105.1785444498.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1785444498.git.alison.schofield@intel.com>
References: <cover.1785444498.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The position check in cxl_region_attach() only logged a mismatch
between the attach-order position and the auto-discovery calculator.
A mismatch means the same configuration would decode wrong when
presented as CXL_REGION_F_AUTO, yet region creation still succeeded.

Fail region creation on a mismatch, before the region reaches
CXL_CONFIG_ACTIVE, so a configuration that cannot round-trip through
auto-discovery cannot be committed.

Since cxl_region_setup_targets() has already programmed the topology
at this point, tear it down before returning so a later detach can
cleanly replace the endpoint.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b4e8ebe158f7..62179d987e4b 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2492,6 +2492,29 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		rc = cxl_region_setup_targets(cxlr);
 		if (rc)
 			return rc;
+
+		/*
+		 * Verify that auto-discovery reconstructs the endpoint
+		 * positions assigned while creating the region.
+		 */
+		root_pos_per_target = root_positions_per_target(cxlr);
+		for (int i = 0; i < p->nr_targets; i++) {
+			struct cxl_endpoint_decoder *target = p->targets[i];
+			int test_pos;
+
+			test_pos = cxl_calc_interleave_pos(target,
+							   &cxlr->hpa_range,
+							   root_pos_per_target,
+							   p->interleave_granularity);
+			if (test_pos != target->pos) {
+				dev_err(&target->cxld.dev,
+					"cxl_calc_interleave_pos() mismatch: test_pos:%d target->pos:%d\n",
+					test_pos, target->pos);
+				cxl_region_teardown_targets(cxlr);
+				return -ENXIO;
+			}
+		}
+
 		p->state = CXL_CONFIG_ACTIVE;
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
 	}
@@ -2503,29 +2526,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		.end = p->res->end,
 	};
 
-	if (p->nr_targets != p->interleave_ways)
-		return 0;
-
-	/*
-	 * Test the auto-discovery position calculator function
-	 * against this successfully created user-defined region.
-	 * A fail message here means that this interleave config
-	 * will fail when presented as CXL_REGION_F_AUTO.
-	 */
-	root_pos_per_target = root_positions_per_target(cxlr);
-	for (int i = 0; i < p->nr_targets; i++) {
-		struct cxl_endpoint_decoder *target = p->targets[i];
-		int test_pos;
-
-		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range,
-						   root_pos_per_target,
-						   p->interleave_granularity);
-		dev_dbg(&target->cxld.dev,
-			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
-			(test_pos == target->pos) ? "success" : "fail",
-			test_pos, target->pos);
-	}
-
 	return 0;
 }
 
-- 
2.37.3

