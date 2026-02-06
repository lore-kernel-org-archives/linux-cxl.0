Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E23EBF07
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 01:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770341501; cv=none; b=uk0Iq887bsvFi8i26WCvGhHDwYGMm1L5qEXXyQZmqQqKgza3g1OvgnASn53DyiqBpaGXCv+1+rr+W5DRTQNnjsIpx5v151w4WNv7q86KNqxQwKBCxDA4FCGmDlbj0h4Js4A5WvHcM99UFBDbNdE5bHBUSXTy7nmmH5tBiwSLeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770341501; c=relaxed/simple;
	bh=3Uej2NeTQOEvB63a0n338vkGFi9Ter5aRK+IFq+uKQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uPt55IXwC+RnbOdA/IHQhan/vU+/L5ntq9xfwsKLaFRQJLDzvfkyudXNRga9SSM9dfdSn/erOuxZkUhFoleyaD+B26hMF/HyT4BZPsyOM+4iehjjNsOdLGzs1ZyE18dYfZ3w8FfB5kgFfRuV04b0Pq9PkVurnZpVEmLrCVJsnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqJQ7JHC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqJQ7JHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770341500; x=1801877500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Uej2NeTQOEvB63a0n338vkGFi9Ter5aRK+IFq+uKQM=;
  b=cqJQ7JHCna4YkNAuo3YkaNiVzBqFnRk3se0nYPZkcxcW4pRhLls+yHZh
   mIpCtwgLeG7+XdNYBAJbcPynmOm+0U4WW+TKhvAG4p+vEDEtiQfHJj9PS
   9GQPhKxEl5jZxKhJyzz98m2hU3MVAzGX6H72BYAbOP6FDPNKhrO4a4nJ5
   5mAO88pQP3RL1mzuMW6DYwR2bKxXjC/ek7k1AyJP/weV9Zd9UUGxHM93W
   ysCtJHyxzwq4dvwCiGl9pKML8nZf5mU3+fVco+dnBLmFmlHbwyAeCf1n9
   3bYteM2pqoyWh7RjLGkuzEvvBczvHz/pD9wXZ8yXhcW7KOr1GStPFP0O1
   A==;
X-CSE-ConnectionGUID: kda57fnHREScH6+9Eo1JoA==
X-CSE-MsgGUID: Or2XAkJERUmFC4TFJTvyaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82183605"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="82183605"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 17:31:39 -0800
X-CSE-ConnectionGUID: 4rccm6HgSd+zo2j6vBJ6TQ==
X-CSE-MsgGUID: s/41cAQHTyKZdvyy/b6/Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="241402747"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.106])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 17:31:39 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
Date: Thu,  5 Feb 2026 17:31:33 -0800
Message-ID: <20260206013135.1012375-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL_DECODER_F_NORMALIZED_ADDRESSING is a bitmask, not a bit index.
Using test_bit() to check it caused undefined behavior making the
flag sometimes appear set. This prevented creation of CXL region
debugfs attributes that support poison actions.

Replace test_bit() with a bitmask check.

Found with cxl-test.

Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

DaveJ: The base commit tag is linux-next today. I figure it's closest to what
we'll see w 7.0-rc1. 


 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 08fa3deef70a..00a9b57cdd80 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1105,7 +1105,7 @@ static void cxl_region_setup_flags(struct cxl_region *cxlr,
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
-	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
+	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
 		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
 }
 

base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
-- 
2.37.3

