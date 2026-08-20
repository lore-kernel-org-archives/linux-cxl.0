Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57F3914FF
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268694; cv=none; b=ZBETpBSvRM1jvhCEAtEMiYk8bUvIVENaoi34a0ZpMnamHAw4xbOmRuI7cbhKjTecctWZAxIAzg96RYfMraIo/bpdqUrh7WWNUHlIEn8n3MHf25hC7CLkP6tb8aGZSqUkdtjsAZVX3KF+u9d/xJcXunF48ZzKbIrsrLCEYtTIBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268694; c=relaxed/simple;
	bh=vslFqR/l0H3F7gd5LgpVRGK9n4TtGWbA42X4tZIho9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T56wFqNeJGRoBUK8DowqkMEnlh7FR62tH0wf01FtQsw+AmIm/vK0YSl7hM+JfUjByofa48fA3UidT3DbdQ3vNGYB6tert9D6l/3QTjWEjWI6SPYTUxqUpNcpDbD+v84VXCuoW7KrG1NSLM+mvnj/Lp5In+9ZMZ7dtRnuH5m05TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XJ5BGCjy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XJ5BGCjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268693; x=1818804693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vslFqR/l0H3F7gd5LgpVRGK9n4TtGWbA42X4tZIho9k=;
  b=XJ5BGCjykVpe6J2F1/IyU1AID3w+IyWGgFCDzrbp/MbHjlUkt1p1qePZ
   TsMe3dz71+Uqb0kw7DOn43biSmItep7uXfitHA43DBoO5MlKDRX8GD1Ka
   5Qx1p/lImEVOQN0nAkYEYk1cV0ttklvuvDAg6rKPg/w4vH82ddJJfeOFs
   SqKVEKitYI02yH8aNM0vB5Q+3Q5XHH92IhzBoXPCvb5rUs9lHCvkcpxGj
   G6RXTp/Xo8aYdpMsUqmhE1ArTasbsDpGDeNJoZ6EAt89fhI8TGXH+DbHr
   lEsNo1XGhB22C3ULUTNAiMtUKGKcs2NMY5yzM7OpGeFE37cVyr+ehAWHq
   Q==;
X-CSE-ConnectionGUID: ajAMAJfySQKRUdRiEemoEA==
X-CSE-MsgGUID: I7AB9AbrTSCOweckGKahKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98483435"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="98483435"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:33 -0700
X-CSE-ConnectionGUID: pMlzC13GSUenDOJhPlYVqw==
X-CSE-MsgGUID: n6E7xNzdSDalbOXVSbTR4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="261906005"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:32 -0700
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
Subject: [PATCH v4 4/6] cxl/region: Support mixed-granularity user created regions
Date: Thu, 20 Aug 2026 16:31:22 -0700
Message-ID: <9ad72488ca2b45c4568fd74bd6c857612a37a5e0.1787255388.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User region creation currently requires an interleaving root to have
the same granularity as the region.

That rejects valid mixed-granularity layouts where the region
granularity is finer than the root granularity. A region granularity
coarser than the root remains invalid because it produces incorrect
DPA translations.

Allow a region granularity finer than an interleaving root and
continue to reject a coarser granularity. Validate the complete
ways/granularity relationship when the region endpoints are attached.

For example, CXL 4.0 Section 9.13.1.1 Table 9-7 describes a 6-way
region at IGB across three host bridges as a 3-way root interleave at
2 * IGB with a 2-way interleave at IGB below it.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 637d1b60a570..4bbfb7cd7e01 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -571,15 +571,8 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
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
+	if (cxld->interleave_ways > 1 && val > cxld->interleave_granularity)
 		return -EINVAL;
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
-- 
2.37.3

