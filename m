Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E01C31B80D
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477856; cv=none; b=k1lU8U1zVF35TqqIr4KtlvWcFOuAE5EhQ8Vqpn2JuDMdY6vxWYm10JnudlFXRTJum6k7UAZg53qt+/HJJAGB5OWhsWV8CkjfgeDGLQhvWl64Vw2890gb6Vpmh7jxaj4+0gpPO5ustfcdK9TlYrlC5hbhJcc2YQ9qaG91NzAFX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477856; c=relaxed/simple;
	bh=+WcXQvBNU6ybHd58NwIHv8dOTEdW0p4kbAontK7MDJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siKcRoJMgEc8zIUItr0rGcv3VXTdpwH9gxb2iNnIiKRX3J3vrd5HVjaRVjHOQwjTL62yLyw4C2J4IS3pS+ABJGg7ChbNEL0oo4mw/4OxKS6ZNEUYZ/o3ldMsHFxhsuNSjc7zRj73ZTGg72yYG3CE+3mZO5ynr82osqwzmp6BuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JSeJOGmj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JSeJOGmj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477854; x=1820013854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+WcXQvBNU6ybHd58NwIHv8dOTEdW0p4kbAontK7MDJs=;
  b=JSeJOGmjBvJmpTWiemwbde81AN5srIZFF3LJTbSR3kDgzTv4jL46hxWh
   A+VOVZX3eGuDMKE260PB0wMKxmjuMKmkuatr9J+y8yNvwy0/YCh7RhIF3
   LS0Fjy8BFfWim0hMFBiiW+tfb0jFnSklfi5yJ/3Md4N1Nfq4poIHlObjd
   EooJ5xisoXDvW42/ZCksslz1Gw3MnylQ7BycR6ZCXuKpxK7qgGMKMJs9M
   pEQqlWUAcZ7o+AUrOyxVhEn7KJW13mskk5ddlCozvr4V6LKoFSlIYvy9i
   lm7gjzUnZMLSJuUTUZNNFur07A6+9i5ukAi4FwvNtLdSyz2xnho9VP5Bq
   g==;
X-CSE-ConnectionGUID: l5F9PF4tTfipCpw2IZxdFw==
X-CSE-MsgGUID: F/nrQ/9oS0aNJShFKezkYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847697"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:14 -0700
X-CSE-ConnectionGUID: UQZBjmlcTJGoHovu61HY/Q==
X-CSE-MsgGUID: buCdnOzcQ46l7DCAg7Qipg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129514"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:13 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v5 6/7] cxl/region: Support mixed-granularity user created regions
Date: Thu,  3 Sep 2026 16:23:48 -0700
Message-ID: <9929a7f5a2d8c05fe345252bef28c11fc36867c6.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User region creation currently requires an interleaving root to have the
same granularity as the region.

That rejects mixed-granularity layouts, those where the region granularity
is finer than the granularity of the interleaving root decoder. A region
granularity coarser than the root remains invalid because it produces
incorrect DPA translations.

Allow a region granularity finer than an interleaving root and continue to
reject a coarser granularity. Validate the complete ways/granularity
relationship when the region endpoints are attached.

For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way region at
IGB across three host bridges as a 3-way root interleave at 2 * IGB with a
2-way interleave at IGB below it.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/cxl/core/region.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5b7104a55fdd..374d8c2c32d1 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -572,16 +572,13 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 	if (rc)
 		return rc;
 
-	/*
-	 * When the host-bridge is interleaved, disallow region granularity !=
-	 * root granularity. Regions with a granularity less than the root
-	 * interleave result in needing multiple endpoints to support a single
-	 * slot in the interleave (possible to support in the future). Regions
-	 * with a granularity greater than the root interleave result in invalid
-	 * DPA translations (invalid to support).
-	 */
-	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
+	/* Region granularity must not be coarser than an interleaving root's */
+	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity) {
+		dev_dbg(&cxlr->dev,
+			"granularity %d exceeds root decoder granularity %d\n",
+			val, cxld->interleave_granularity);
 		return -EINVAL;
+	}
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
 
-- 
2.37.3

