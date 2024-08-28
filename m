Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DB15ECDF
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835019; cv=none; b=LQXO9rZ4RSyQK5YBV3yJEvvlemZ1zjxla0RtNUatP1QRtaKYSzq3ZXA03l2iry/+0BTS4wnqH39L1ocTPzVx/eYYOHGVJePJusoa/fdBGYMjVb1hahKZxLytUM8hNe2dhET0ceGIuh/2kColiLwC1JJtvG+Q0xF9N28OwtECo3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835019; c=relaxed/simple;
	bh=PvEWhAEI/tCdHo06VsYqKztrs2pLHWpr3bJc4P6bHBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCqaQVMDAh3mrn4B+znE0QdVJI9EL6LdZiFlBjVB2Ox0Zov9/CLg0WUsU660++8jQi4NPAZXEzfuo6+Lgp7H67LrCKgtzPatJh8ufXvJtN/Mo11HV0hHVdwi6gG8GzekviFsBNQjbkmwsLPK4VudV+bWRATeilhqoe9tJWAFpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQrbWULq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQrbWULq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724835018; x=1756371018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PvEWhAEI/tCdHo06VsYqKztrs2pLHWpr3bJc4P6bHBQ=;
  b=DQrbWULq/pfu/SDh6qfNgkEdIu5vTVvtIMf/x26LlQf2LXf0Ad9f6TW/
   b2lf4pl0kOJ+2ObF853386HYV+mE/FTlAq5ug1VDonYxaT6LjC9glQwEC
   2sgBh5Ad6RkNY7kWBSL8JEPMABWpduMifRmZ/lGFKU6KHseopU9FFqjpS
   c4+/gt6bfCcA0/BiXA7XsA6vlsvyJVSLgeFb27+oyOrdY9zyUkj2zeQPe
   F5rsJ6AstTrqgV57sMHBxbuDf29xVrmbDm9D2qdKMNzKXrPaZXMy8t1Yx
   QTXMQwW64q6KwruZLTFxIWBPpBTYhg3CI3PBmyHUyYPJhcX06k/Gn23r8
   w==;
X-CSE-ConnectionGUID: Pyu7oofyTgKksdE8f/tdKg==
X-CSE-MsgGUID: TAMvk1nDTyyiLltTOxh0cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="22874632"
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="22874632"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:18 -0700
X-CSE-ConnectionGUID: 4s4WUgIxSESiSXbP6Z1ZIA==
X-CSE-MsgGUID: fQKVm0bNQdu2YnfgN4GehA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,182,1719903600"; 
   d="scan'208";a="62999078"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 01:50:14 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v4 3/4] cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
Date: Wed, 28 Aug 2024 16:42:30 +0800
Message-Id: <20240828084231.1378789-4-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240828084231.1378789-1-yanfei.xu@intel.com>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory a device might set the mem_info_valid bit for a first range
after it is ready but before as second range has reached that state.
Therefore, the correct approach is to check the Mem_info_valid bit for
each applicable DVSEC range against HDM_COUNT, rather than only for the
DVSEC range 1. Consequently, let's move the check into the "for loop"
that handles each DVSEC range.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index f29af0b788d9..cda22feadbd3 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -324,10 +324,6 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 	if (!hdm_count || hdm_count > 2)
 		return -EINVAL;
 
-	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
-	if (rc)
-		return rc;
-
 	/*
 	 * The current DVSEC values are moot if the memory capability is
 	 * disabled, and they will remain moot after the HDM Decoder
@@ -345,6 +341,10 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
 		u64 base, size;
 		u32 temp;
 
+		rc = cxl_dvsec_mem_range_valid(cxlds, i);
+		if (rc)
+			return rc;
+
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
-- 
2.39.2

