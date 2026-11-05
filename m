Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849319;
	b=lm8Ez0vaYMXCEr/HXdyKV7TCZZBM48YEfYjEYIsBrZQsRBdrOfpPLEEJq4/4aoH/W+ii
	 Bd8fX//3auG2rEC2SWQTBYGiTh9gyFviA1kcrdJDmEL0WKi6Ge9N2mZaIo9SZU213S2w+
	 +QZYVCBaUf6LvFZH/HPvTAaGfBRXvGdhZwcah4TzHFhlRFETiPa3Z5l4z4WH/DJgA+onO
	 +3hWSHwVljIcmY6D77nwsm+JF/PgxitcoVlDndIZ9xH2h8ex3fZGQ93ka0rnhoret6Kb1
	 D80ngCU19XK6fyADAEBit7LrfpcBILp3GS2IvUO7j7rdvK1XUM0Nmu1jPs8J/9EcXmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ikuFwyb8D2ZZkL30HJ6fEwBj+8zCYyHQEm67qF+KZiE=;
	b=Js4EWnoY5k01qwJZdKRiOqUYWVCQ7qYEwPfGgb7SMNo85e03yIvVGXVtxMZl+FZlOUxX
	 DjUEyqzYO5jUaivIJX8gI0CVmFws3BNDG/TZGkxD5wdL/VdMoUs0BT34PZF8BdUZwD/ke
	 xTdcr8FyyW3e8IxHIovYZ7d3bAJmK0h+QJZi0sdueDTDUd8YoMeOu/yMATue6K7oaeA+B
	 TX6GyyZC+DbJ2t0fpgx64NHInmcuISpb/H/v/jsKh8CAR9LB9dk+cjrhUBotTjnWft0VR
	 RIxMiyAiV6wx5X5Mqr9r4IhPss8LVd0WnMkMxrvhgHZzJE6E58RTKHOPgBhgcwaCwoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UjnPdfK1;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64BD606A32D
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D64BD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UjnPdfK1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793849319; x=1825385319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m7W0OuTBdBG14wnfjrWBJ1mNvO/+orb/8F3kA3fEx3E=;
  b=UjnPdfK1XX5Y5rZdvDwS4wMFYDakQ4BM6ynUagf2UDozqD7ur7KC+89Z
   OtIHn4EalIBG594+uGGX62UhPo4fz3hl95bwiKThxU9TD1fe3mTYZ/6w/
   il3HLAy0sMbilsnzbBpIsUcW9o27KwOCGU8PQJ+BRv/gu5BTUNGPXPOfW
   N6QFE8X9hphLZWWYpWkgTMxGzJ9WKUzRqZLuwOMQ3Wnt0OFc82KwOt/Rm
   QyGEdSQZA02c6kyODqcigOFTrpDbWp5T6ARPKfKSqu8W+fzMRjs3xe2I4
   KieaDuZj2R+MiYB17m7q1bgJtGlCuWLUILbqvLvAygT9k/Q+SLd+CiQhS
   w==;
X-CSE-ConnectionGUID: R5GEFxZ/ScutllJNxivv9g==
X-CSE-MsgGUID: VCnePxcrRGGHBbAVzOjmXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2511492"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2511492"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:38 -0800
X-CSE-ConnectionGUID: mbe8AA35R+C/w8qsoMO0jg==
X-CSE-MsgGUID: RI7XGVH8R0OuAKBf3KnnCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6913287"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:38 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/4] cxl/region: Show access attributes once performance data is calculated
Date: Wed,  4 Nov 2026 19:28:29 -0800
Message-ID: <eb2b648a7b0446f65d6ac2db6eb4f247ee72cea6.1793847269.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793847269.git.alison.schofield@intel.com>
References: <cover.1793847269.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Region access attributes expose calculated latency and bandwidth to
userspace, allowing the performance of individual CXL regions to be
inspected independently of their use as system RAM.

Currently, attribute visibility is refreshed only when performance data is
propagated to a NUMA node. Regions whose memory is not onlined as system
RAM, such as pmem and devdax regions, can have valid performance data that
userspace cannot inspect.

Refresh attribute visibility when the region completes and its performance
data has been calculated. The existing visibility checks continue to hide
attributes without valid values, and NUMA node performance updates remain
unchanged.

Fixes: c20eaf44113e ("cxl/region: Add sysfs attribute for locality attributes of CXL regions")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 34d42559e33e..50cd483d710d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -144,6 +144,19 @@ static const struct attribute_group *get_cxl_region_access1_group(void)
 	return &cxl_region_access1_coordinate_group;
 }
 
+/*
+ * Region access attributes depend on calculated performance data, not
+ * NUMA node onlining. Re-evaluate visibility after region completion.
+ */
+static void cxl_region_update_access_groups(struct cxl_region *cxlr)
+{
+	if (sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access0_group()))
+		dev_dbg(&cxlr->dev, "Failed to update access0 group\n");
+
+	if (sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access1_group()))
+		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
+}
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -2171,6 +2184,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		p->state = CXL_CONFIG_COMMIT;
 		cxl_region_perf_data_update(cxlr);
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
+		cxl_region_update_access_groups(cxlr);
 
 		return 0;
 	}
@@ -2194,6 +2208,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		p->state = CXL_CONFIG_ACTIVE;
 		cxl_region_perf_data_update(cxlr);
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
+		cxl_region_update_access_groups(cxlr);
 	}
 
 	cxled->cxld.interleave_ways = p->interleave_ways;
@@ -2629,7 +2644,6 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
 static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 {
 	int cset = 0;
-	int rc;
 
 	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
 		if (cxlr->coord[i].read_bandwidth) {
@@ -2650,18 +2664,7 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
 		}
 	}
 
-	if (!cset)
-		return false;
-
-	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access0_group());
-	if (rc)
-		dev_dbg(&cxlr->dev, "Failed to update access0 group\n");
-
-	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_access1_group());
-	if (rc)
-		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
-
-	return true;
+	return cset > 0;
 }
 
 static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
-- 
2.37.3

