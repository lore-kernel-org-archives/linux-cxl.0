Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CBB31352B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 04:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780632313; cv=none; b=SB/TJp52+pOeL8Ht0mcPWjTn0zAXO2NzjL2+CouvTQJJI5UFW3341DSzaOMQwQDOJ5kPVvDwSU9CGdCvxKo+MhW0sH80biGZDH3+n8Ned6gJcEdiIu+otxwbLefqeXi0BopkgkttM9cWZtaDVyY8sqv5CbgZv4muk+2E0I9JZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780632313; c=relaxed/simple;
	bh=tPTYUsZqUfuGDyjyvDyI8QTtkTqXmWQEZXoH3D9nug4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WByhrpoz05kw4/r8eZ9emko3TXicCUIYXm4DtEssy3lhYBfdMLXv6M2CK5r9jH2Re5NN3HzKO0S3jlE6L6vVUtYpwSMWMXHofnRebnUkxe2ynQtn0/3oN5HjPKF8Stj2J87RPG7/gcUsNDG1L8OWOtaXEJt1+mEAKUoXz5mvobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uf16LWtJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uf16LWtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780632310; x=1812168310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tPTYUsZqUfuGDyjyvDyI8QTtkTqXmWQEZXoH3D9nug4=;
  b=Uf16LWtJr+vyyHJyZhPG5bRiDg4PvDJ7OMwT6C6KIC6arW04NPqVd/2u
   e6oRVQzUpzpjS5xfUgfUHMvB9Lzm4YZfxiM5++bjNuM0ygPvsT9DF5YM5
   GvshxKybLLYqvqpoH3ola8SUFZpQ0zxgPOvOJmgj/zp+mRdesqbXbJ1FL
   TQY79ZnIVfK0yvI8ZqDDHO4NCIQrBxqIeYtZCiqte4xVmKv/orLOKJ8KY
   IaIutp208/LaeQLLSbghhY8peKxiuif87DZoVAwBoB/P+nNVs4WtfxumW
   g7BUXp3uekxLJdEO7EbQD/eudJnFVP1OFVJLK3vEaieqg85ln54AbVRTo
   Q==;
X-CSE-ConnectionGUID: 7gIU+t3/Qf2zAqABp/okFQ==
X-CSE-MsgGUID: LC6s0J9ETbunrm4C0l5Kmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81498302"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81498302"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 21:05:10 -0700
X-CSE-ConnectionGUID: zLMfX6T7TB61l+iDCIIYhQ==
X-CSE-MsgGUID: meQPrxDBQh2ZkbKw8TiCaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="240271510"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 21:05:09 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Avoid variable shadowing in region attach paths
Date: Thu,  4 Jun 2026 21:05:01 -0700
Message-ID: <20260605040504.865728-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A couple of symbol declarations shadow earlier variables in the region
attach paths. Shadowing makes it harder to tell which object is being
referenced and can obscure future bugs.

Reuse the existing 'cxld' variable in cxl_port_attach_region() and
rename the endpoint decoder iterator in cxl_region_attach() to avoid
shadowing the function parameter.

No functional change.

Found with sparse.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index e50dc716d4e8..819392c8f753 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1224,8 +1224,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
 			nr_targets_inc = true;
 		}
 	} else {
-		struct cxl_decoder *cxld;
-
 		cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
 		if (!cxld) {
 			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
@@ -2189,14 +2187,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	 * will fail when presented as CXL_REGION_F_AUTO.
 	 */
 	for (int i = 0; i < p->nr_targets; i++) {
-		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_endpoint_decoder *target = p->targets[i];
 		int test_pos;
 
-		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
-		dev_dbg(&cxled->cxld.dev,
-			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
-			(test_pos == cxled->pos) ? "success" : "fail",
-			test_pos, cxled->pos);
+		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
+		dev_dbg(&target->cxld.dev,
+			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
+			(test_pos == target->pos) ? "success" : "fail",
+			test_pos, target->pos);
 	}
 
 	return 0;

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.37.3

