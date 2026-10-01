Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664E13B8D41
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 04:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830614; cv=none; b=sVTOE+UMN9aZpxfA3qmtPSzHJiycd4U5P2biaIJEliRH1EsuAXz//0ZwdDhnGdRfUWAHQF9DloXQ/vdrY27RD24iYzZ1KPsu+IkfvqqVAj/ZSsq27q/LU9i+8pvixMCChTRFYqOJ7SEFa9SLwLTEYitvIr84rIlIqZ+afKaQB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830614; c=relaxed/simple;
	bh=R7Y9Svw/108mpRXKPgQBpgDbx5+jAdP5y+gKB000x8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBHRyr0FuyUgKL2Ykq/VtSYKiEG+O8FWgp5nAkocjglsH2aNS/Vht/6qK0ksFG8o6XagYE1JYRZapOWMxdfIvB06jRydUug664klSPfVEJ2vykXcR3zKm2u81HWcRUinj1aY/4RGGpL15LDLj8LYbJ2Gf3WmjJx9VoQ0QKvUzuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iwb0vTiC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iwb0vTiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790830611; x=1822366611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R7Y9Svw/108mpRXKPgQBpgDbx5+jAdP5y+gKB000x8k=;
  b=Iwb0vTiCOiDARNGIY8tR79VqZjSadnKl9A1cXoYcvKno5yu99hcaVYP0
   XLFKnIp8AJsxZFI0KeXOQCMnAfcO5APET4RapmGeQcFinioJTV77AjQga
   2nZSAMyhDUXE2cKDFMLc7zBp+VeUz0fyxKTK5YPo+rWdymD7BUwDcsuJk
   EDRn7b7YKViJnu+2ZgWfzAFaK9sAfuW6/BDKlbSYVxEVao4be8wINGq0D
   QHHmm+yAH4S0gv+QEv0SlCUKhyXHDH5HUcpJ5Hfa6xyevNwpu70rxiA/z
   z6Ui1BJDs6EoRcyOSI3LYHxx4jLKMuMyUCELVqsrMJxxI2g1K6MGkJGCF
   w==;
X-CSE-ConnectionGUID: 6zPHe5DJQLqbZ7Od6gVkiQ==
X-CSE-MsgGUID: lioXdaaxT7axOQd/wMOP7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="101739083"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="101739083"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 21:56:51 -0700
X-CSE-ConnectionGUID: MzbgoMkqS/O9Wo72J9Je9w==
X-CSE-MsgGUID: RKC5QLoCQxa23jMxC4cVdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="279184331"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.57])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 21:56:51 -0700
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
Subject: [PATCH 1/2] cxl/region: Reject a repeat write of an endpoint decoder to targetN
Date: Wed, 30 Sep 2026 21:56:38 -0700
Message-ID: <94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing an endpoint decoder to a region targetN attribute that already
holds it returns -EBUSY, but leaves the partially populated region in an
inconsistent state. The targetN attribute still names the decoder, so the
failed write gives no indication that the region was damaged.

Filling the remaining target positions can then trigger a NULL pointer
dereference in cxl_region_setup_targets(). Root can reproduce this
through sysfs:

  echo $decoder > /sys/bus/cxl/devices/region0/target0
  echo $decoder > /sys/bus/cxl/devices/region0/target0
  echo $other_decoder > /sys/bus/cxl/devices/region0/target1

Reject a write to an already assigned position before modifying the region.

Fixes: b9686e8c8e39 ("cxl/region: Enable the assignment of endpoint decoders to regions")
Assisted-by: LLM
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---


An ndctl patch backstopping this fix in the cxl unit tests will follow.



 drivers/cxl/core/region.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..f9aafe89e5bb 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (p->targets[pos] == cxled)
-		return 0;
-
 	if (p->targets[pos]) {
 		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
 		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.37.3

