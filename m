Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDA426D1F
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401648; cv=none; b=iemYxP6sbwk6YGBR7zuC4ywjQ5k0Dc5RduEzNOz1o8TdFnyttTlsT/Qk3v47FPi8rNqRpvnOyx5/tb4QhmUpJw8le9EZLxS7tZ4qAEV6UFXy4nkV+D07A+Zo07WTUnjNGDoI/8rDagEWJKoAPUfFVlOF0Ln1Bu+QytLg3BFx77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401648; c=relaxed/simple;
	bh=ZV4yJEhygvxQYpdz+FJkxqS3F7rbplhyWBC6ulV8QaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rRe84Bw3hi2KOocc17bZwN3Gu3DkqzFGhLtwgixpNmn2M7cH53LLMh/oJGoau4NV5yteaelYVyhKoaPIoeN2gG+mtiPYHzds3Hqs43s3Tvp0C7S+mt8hTJrRdOmtagTV9z1iOlY59t8MDci3+NPw/jrFAllX69YMBuQ9wfBsbRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+GBcsrh; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+GBcsrh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770401648; x=1801937648;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZV4yJEhygvxQYpdz+FJkxqS3F7rbplhyWBC6ulV8QaI=;
  b=f+GBcsrhEc9fZdJfV+3l5mBg8p8eWsTlUtXkDdVbdfmGhhxj7RWsmBAZ
   cZLpKor6PsetE3bqAHEgPgXLYh+mCOmCfwVTvPrhkPhUC4Pj11PxXdZMB
   RJDr8JFQARmqFN+x9H2WwFO+AujxkR3frNJ+JZ41zpwJL1E2RGfjgrtG7
   z9JobGG/mw2WkRJp9wnNwZhTliM4JwjyyK3BvbRh6J5ccxtovlsnJUMZj
   ErxseX1qnwvKXpmMJTrAqGCoLT/7BzVCnjDajoLA+0AJkk8rLUDuuE8Dy
   GfDqT3IJEVv/2lqqrFRxTVy/X+LYKvGseAuNaywN1MbsqtDkLDwyOyPoN
   g==;
X-CSE-ConnectionGUID: 1LrxP6JXQxK/vuZ7PnpSjA==
X-CSE-MsgGUID: ZkKNQRRTQ+aStJYaxU+34A==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75234650"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="75234650"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 10:14:08 -0800
X-CSE-ConnectionGUID: Ewkr+Y40RoeDIUoCRj4AnA==
X-CSE-MsgGUID: 34IdQXGsSHy80eceWefgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210725871"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.184])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 10:14:07 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl: Test decoder flags as bitmasks
Date: Fri,  6 Feb 2026 10:14:02 -0800
Message-ID: <20260206181404.1025991-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL decoder flags are defined as bitmasks, not bit indices.
Using test_bit() to check them interprets the mask value as a bit
index, which is the wrong test.

For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
flags word, making the flag sometimes appear set and blocking creation
of CXL region debugfs attributes that support poison operations.

For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
the test to always return false and allowing resets that should have
been blocked.

Replace test_bit() with a bitmask check.

Found with cxl-test.

Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Obsoletes prior patch that only fixed up one test:
cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
https://lore.kernel.org/linux-cxl/20260206013135.1012375-1-alison.schofield@intel.com/


 drivers/cxl/core/hdm.c    | 2 +-
 drivers/cxl/core/region.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e3f0c39e6812..c222e98ae736 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -904,7 +904,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
 		return;
 
-	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
+	if (cxld->flags & CXL_DECODER_F_LOCK)
 		return;
 
 	if (port->commit_end == id)
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 08fa3deef70a..befa2a7b81c2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1100,12 +1100,12 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 static void cxl_region_setup_flags(struct cxl_region *cxlr,
 				   struct cxl_decoder *cxld)
 {
-	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
+	if (cxld->flags & CXL_DECODER_F_LOCK) {
 		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
-	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
+	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
 		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
 }
 

base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
-- 
2.37.3

