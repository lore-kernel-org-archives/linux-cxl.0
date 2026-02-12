Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9AA1EB9FA
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 06:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770877375; cv=none; b=V1sjPk+xIcmclzTMhXrgnbIO3zngpG52g0GUMFiXhjVk2Xhkgkk8zCIgpgHl7If2QTcO9n8V1fKZDuddNgeapyyqStVdTgmPWTVw0pW+JWverIlJM7y43GdNRGRwwZukYdXctmWnLksmD3uqELJxgKZcB75TYbMrzQTwpPJkuiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770877375; c=relaxed/simple;
	bh=7BP4RJ23hXCtHpF5GFbMTruoxa4JF7SgJp6mj02rNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DBBU7mOe7w82HQwLfvAMfWBL2GiFdYLESSHseeocipfuiccnve+zomX7TwdTjedFoDU+84y9C8zJYs3t6J3sErHYGGCNJvmvAB+5Wwfgh7XTJ6YHPtSI+sTkBrYZy7iSPfz9DWmP4ZekhMCMAgxWgbnmnXzsloe4e5WHSVxFG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/SKS8HS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/SKS8HS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770877374; x=1802413374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7BP4RJ23hXCtHpF5GFbMTruoxa4JF7SgJp6mj02rNxk=;
  b=I/SKS8HSJSlEIwIEMFd5FXuCQhDO0ni25H+sK1h2ib6S247VGb2FQUZn
   dEIei1BA/Hji9yLegc1u3pvUriFJlhvsL55EaO4mcPBbakC/qoFfDHwS1
   +Rm5r61jP6yGq/VOzLe63+6qw5TGox+yDTQdq5tRqNi0KMM5DJ3QXD31Y
   dZnJbu3KhLqmoZFYWW1m3/mfrwAlEUVgpX5tOF0aeo+nLB5atJkEu4ozd
   SlPGlk3Stj1faQAuBo7yQ4fspjZtWYn1jHvKiwK3gs4qmvPQCZcv6Jq28
   zMGiyQKnYcjrHpX8dozGcmHL3YoQFk/Q2cON4Xia7sU9HxyhBMzeVLUiZ
   g==;
X-CSE-ConnectionGUID: f26bG5x/TuOReFT6yekKBQ==
X-CSE-MsgGUID: koQXb4vjRT6h4nCsIFWIzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75888663"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="75888663"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:22:53 -0800
X-CSE-ConnectionGUID: h2NlSmI4Qw2cuWfRZlcscA==
X-CSE-MsgGUID: Fc5SWN8WRe+mP2Ky5Eu7Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="217027480"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.225])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 22:22:52 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Delay inserting iomem resource until auto region commit
Date: Wed, 11 Feb 2026 22:22:46 -0800
Message-ID: <20260212062250.1219043-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During auto region assembly the region driver inserts the region
resource into the iomem tree when the first endpoint arrives and
region assembly begins. If the region later fails to assemble, the
resource can remain stranded in the iomem tree, making it appear like
a DAX region is a child of the CXL region, when that is not true.

For example:
68e80000000-8d37fffffff : CXL Window 9
  68e80000000-70e7fffffff : Soft Reserved
    68e80000000-70e7fffffff : region9
      68e80000000-70e7fffffff : dax19.0
        68e80000000-70e7fffffff : System RAM (kmem)

In the above case, region9 failed to assemble, yet proc/iomem shows
the DAX region as being parented under a CXL region. In reality, the
CXL region is in a disabled state and the DAX region is managed by the
HMEM driver.

Examining /proc/iomem is one way users inspect the memory topology,
and with this patch that view remains accurate.

Delay insertion of the iomem resource until the auto region reaches
the commit state. Introduce the res_want_insert field to track whether
the region's resource should be inserted into the iomem tree.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Putting this out for comments and I expect to rebase on 7.0-rc1 if 
this is wanted.

Today it is built upon Smita's v6 Soft Reserved set [1] because it
is with that set where the failover to DAX starts happening and the
confusing /proc/iomem can appear. Without that set, the resource of 
the failed region appears in /proc/iomem, but it's less confusing
since it doesn't show any children.

There is an option for Smita's set to teardown the CXL regions when
it takes over the resource for HMEM DAX, however latest revision, v6,
has taken a gentler approach and leaves the regions intact.


[1] https://lore.kernel.org/linux-cxl/20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com/


 drivers/cxl/core/region.c | 32 ++++++++++++++++++++------------
 drivers/cxl/cxl.h         |  4 ++++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 96ed550bfd2e..9ecc1748e9de 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -666,6 +666,7 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
 	}
 
 	p->res = res;
+	p->res_want_insert = false;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 
 	return 0;
@@ -2094,6 +2095,24 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		p->state = CXL_CONFIG_COMMIT;
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
 
+		/*
+		 * Insert iomem resource only once at first commit. The
+		 * resource remains for the lifetime of this region, across
+		 * disable/enable cycles, and is only removed at unregister.
+		 *
+		 * Set res_want_insert to false on the first attempt, even if
+		 * it fails, to avoid retries if the platform firmware did
+		 * not split resources like "System RAM" on CXL window
+		 * boundaries. Resource is not required to be in iomem tree.
+		 */
+		if (p->res && p->res_want_insert) {
+			rc = insert_resource(cxlrd->res, p->res);
+			if (rc)
+				dev_warn(&cxlr->dev,
+					 "cannot insert iomem resource\n");
+			p->res_want_insert = false;
+		}
+
 		return 0;
 	}
 
@@ -3604,19 +3623,8 @@ static int __construct_region(struct cxl_region *cxlr,
 	if (rc)
 		return rc;
 
-	rc = insert_resource(cxlrd->res, res);
-	if (rc) {
-		/*
-		 * Platform-firmware may not have split resources like "System
-		 * RAM" on CXL window boundaries see cxl_region_iomem_release()
-		 */
-		dev_warn(cxlmd->dev.parent,
-			 "%s:%s: %s %s cannot insert resource\n",
-			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			 __func__, dev_name(&cxlr->dev));
-	}
-
 	p->res = res;
+	p->res_want_insert = true;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
 	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c796c3db36e0..2b977ab33af6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -480,6 +480,9 @@ enum cxl_config_state {
  * @interleave_ways: number of endpoints in the region
  * @interleave_granularity: capacity each endpoint contributes to a stripe
  * @res: allocated iomem capacity for this region
+ * @res_want_insert: true if the resource should be inserted into the iomem
+ *		tree. Set to false after the first attempt to insert or if
+ *		res originates from the iomem tree via alloc_free_mem_region()
  * @targets: active ordered targets in current decoder configuration
  * @nr_targets: number of targets
  * @cache_size: extended linear cache size if exists, otherwise zero.
@@ -492,6 +495,7 @@ struct cxl_region_params {
 	int interleave_ways;
 	int interleave_granularity;
 	struct resource *res;
+	bool res_want_insert;
 	struct cxl_endpoint_decoder *targets[CXL_DECODER_MAX_INTERLEAVE];
 	int nr_targets;
 	resource_size_t cache_size;
-- 
2.37.3

