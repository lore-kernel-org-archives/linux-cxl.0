Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793849320;
	b=bQkxFDrI1H5cGhlaL9a8mQT3cZ72Y9SwYqlZHdNrrE3L/79Jklq8pFOmYi3T+f3FFS0r
	 hCT34x7LjjHTjwd4YuXwwtxDwjgpJJv2Reej4gmO5HQoOTLcYs1eaTftgX7wDmPe1OoMX
	 vK68iJHPyRcJGnvta0glUS0Nx6pZub6zBWIII0y6rNeq4v1K8LibYj/OQ/40JhSbDH0R1
	 hRh27F5PvA00T+tULpINLqOUQriiDwcavYi0wYc07m9oMDwV9MvX7GwUs/R4aLVK86ymm
	 3rMuNr6/9T2ygLLhsgSl/L6qUbihH2s/sAIgcxf79/dhKGI5pW6radJo2wqcwCGWpEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793849320;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pHdbghMpAZen0RORLGdwSBDUnloGp8pFX4Fw+g1MVDo=;
	b=lnKIb3UDbtZm6X5kUqXJKPTiU6kpglQ3gXcc4So8ClaB2gl8bI5BIjVC4umBDZdxZvuO
	 GVBgDb/AYg//N5MmNn53/+bCqCBwawSDi/7Rwp9pn5G/RurNW4d5/EQ1zRChQX4JBGDWD
	 NUT0wO+PXk3ceQF9vIpLTl9gkjBQqRYp3+Go6rL+8Ej0D1ozde/CJph0V+7TFfwmYU9VX
	 HuHkIe0DkCaXjaPSKfRlJBCzinE5YS044Gz4widfPSaN45fCaJR861BZsbNWKVroimYOT
	 rQRnwMxGY0unWYoypNy5s3wKBKKwoMxKFE2rgCG/j3lhGCmMnGzkh1mOiRZ8iU/rp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9C5Ldxr;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DF606A31B
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 03:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C14DF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c9C5Ldxr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793849319; x=1825385319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=daCBdy1L0Y6Lvrxf/T2VxpoYisaG4tSHQd9eid7TW6o=;
  b=c9C5LdxrSi/JlKvcaibgsv95Scp4vUCLfLHW8sfbwmk0TVRDGZNm6Fcn
   S3dtOd7PzEC2ULxohCyB9Ae1FHuj0PINYs4NMcrMTErlxwflnTFuSYucx
   XyeN72p7dUA+3tMJWIcueMMzvXdw27rJxBxSQjC1RWe7Yr24EJMU/wZlf
   x7KdoAaH0RTiDkFqI54gIpxGVJOrxxoJOI1QDjHQ22ZvNkZfdk/9bBsMr
   A5Y27yLJR2+AJ2KOP89alzzXoaZ80O7POG34TBLmCDCHitqC05K5P3OLN
   LtfXSldaMnQG+8dSdBd9jzIOO0vdSqgaH4YjLv2xXthnklXaWtRYDgfAo
   w==;
X-CSE-ConnectionGUID: fye3WvKmQW+OwoC6u1J5wQ==
X-CSE-MsgGUID: ZCpTa8BPS/mZovCInmDe8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2511497"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2511497"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 19:28:39 -0800
X-CSE-ConnectionGUID: YcsTi7wcT6iEtXNl8amtHQ==
X-CSE-MsgGUID: VVvW8SjCTOqW92h8NIk87A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6913290"
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
Subject: [PATCH 3/4] cxl/region: Consolidate region performance completion
Date: Wed,  4 Nov 2026 19:28:30 -0800
Message-ID: <b8d1edde2129a7338ad6e9863a08ae2309a3d93b.1793847269.git.alison.schofield@intel.com>
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

Both user-created and autodiscovered regions perform the same three
operations when all targets are attached: calculate performance data,
account for shared upstream bandwidth, and update the visibility of the
region access attributes.

Consolidate these operations in cxl_region_perf_data_complete() to keep
the completion paths consistent and preserve their ordering.

No functional change.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 50cd483d710d..f9435e65c695 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -157,6 +157,13 @@ static void cxl_region_update_access_groups(struct cxl_region *cxlr)
 		dev_dbg(&cxlr->dev, "Failed to update access1 group\n");
 }
 
+static void cxl_region_perf_data_complete(struct cxl_region *cxlr)
+{
+	cxl_region_perf_data_update(cxlr);
+	cxl_region_shared_upstream_bandwidth_update(cxlr);
+	cxl_region_update_access_groups(cxlr);
+}
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -2182,9 +2189,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		 * then the region is already committed.
 		 */
 		p->state = CXL_CONFIG_COMMIT;
-		cxl_region_perf_data_update(cxlr);
-		cxl_region_shared_upstream_bandwidth_update(cxlr);
-		cxl_region_update_access_groups(cxlr);
+		cxl_region_perf_data_complete(cxlr);
 
 		return 0;
 	}
@@ -2206,9 +2211,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		if (rc)
 			return rc;
 		p->state = CXL_CONFIG_ACTIVE;
-		cxl_region_perf_data_update(cxlr);
-		cxl_region_shared_upstream_bandwidth_update(cxlr);
-		cxl_region_update_access_groups(cxlr);
+		cxl_region_perf_data_complete(cxlr);
 	}
 
 	cxled->cxld.interleave_ways = p->interleave_ways;
-- 
2.37.3

