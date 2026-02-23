Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91A36AB79
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874029; cv=none; b=GFQVgD9+xYFQjdFieyLAIbrClc8A2dCcVo/e1fFhEiR7pHVDl+ZT1A66m4OjylbAJeIunTarjDJHJuhs/69Vy/a2crnPpX3qA6J5ZhTzCsS6a9KfL5ph6zQuHE1wkdNYdNa8+bnEXJAEWCziXxuGgBk5cLTP2eJeZf4otAx2jv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874029; c=relaxed/simple;
	bh=Xj0aYmjwPHeQjrpldJnNkSBambKeZWiCmpNFwY/r2ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OPkKuVD16zqwP3ViqTLuqxNnr4gZ2J9eZ+XZrcOoQSSy1EZRGqxH53Ccq0t/pjmSjDKo3SH5lsoGs9VU2t6N2SttBdxJZ1EOk/wg4PCm8qzcrF/f7mFIHjrUDsMiZotb8Zrqh3dO0Uva044goXy4iN4LvKYwmmMD/rAdGtHbXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTYJ7/bF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTYJ7/bF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771874027; x=1803410027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xj0aYmjwPHeQjrpldJnNkSBambKeZWiCmpNFwY/r2ws=;
  b=YTYJ7/bFb450eNA0iC8qdIuFfgVlEFQeYTQnWaLQoztD1Ec60u/akdbK
   TcfGYKhhNFZfOIrRur1QeVLldyKjnySlLNJcp/cDi46Z5MY0A8sjvCL5f
   VULjLYZOpQHc1CzsynJydpviREVbLxhvMqDncGfePSqBpjGfeScr14zAz
   dso5zj2QvEwO45dQqBbaaukgt+ndtXN6sfe8INy1sXWYgMAARCDuf8Awy
   MvqZoxTA9OEBuw0wO2ll4WJhQP41eTwaSYYmSMuYArsmerB6MEk/kl6nH
   QCSIjww2L5ff2UUZHGttoPm5EfPt8ZR8j3B9OnvGbAtjXJe9U2PlPezu/
   g==;
X-CSE-ConnectionGUID: aPsgPttNSz6ziqGpTsYOLA==
X-CSE-MsgGUID: IaG1n6IWTRKhpCUPhvfklw==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72943923"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72943923"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:13:46 -0800
X-CSE-ConnectionGUID: O929ra9DST6a3ZJ+fURDWQ==
X-CSE-MsgGUID: FKrz2m9jRjKmU9N1AEt/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="246244222"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.141])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:13:46 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/2] cxl: Test CXL_DECODER_F_LOCK as a bitmask
Date: Mon, 23 Feb 2026 11:13:39 -0800
Message-ID: <98851c4770e4631753cf9f75b58a3a6daeca2ea2.1771873256.git.alison.schofield@intel.com>
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

For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
the test to always return false and allowing resets that should have
been blocked.

Replace test_bit() with a bitmask check.

Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Changes in v2:
Split patches to align w Fixes Tags for backport ease
Rebased on 7.0-rc1

 drivers/cxl/core/hdm.c    | 2 +-
 drivers/cxl/core/region.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index fec37af1dfbf..780ec947ecf2 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1100,7 +1100,7 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 static void cxl_region_setup_flags(struct cxl_region *cxlr,
 				   struct cxl_decoder *cxld)
 {
-	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
+	if (cxld->flags & CXL_DECODER_F_LOCK) {
 		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}

base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.37.3

