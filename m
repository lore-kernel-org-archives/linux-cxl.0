Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C8149DF7;
	Wed, 25 Sep 2024 02:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232447; cv=none; b=q981fXf05DynEuGHMG0bmOmucseLK6g+SNPYbWENtaOJJwgm5Sv8mrBl487YDCIHezxesSDcKT/OTeCdwt3+MQVd9OmRaRo98lZMe9NT06ARmDZpYN4K+aNDP380uK2fdFVZ8TLlDt2jLEHqS+1qhmY/nZbo6NIsRfL+5sSdlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232447; c=relaxed/simple;
	bh=fiHK4fG65Xon9kkcXibHaO9Hg0EgB8moOgev/gWVaq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QbFfEMDeRBVdfOARzZWootiO15dQWIDlFN4XQIfq1bFb6cQxWP+gFcpAfagYt/6fMMzQrdHT9RVzX9AG6lj3yhluEg1MHNAHzeWQcMOSynnPYpYels0NjhEluGU2nFSn1NHzW8PzDTXS7UgTsFo+3IRmPa/tg11iN3lJ6KkOqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F01CkFB8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F01CkFB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727232446; x=1758768446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fiHK4fG65Xon9kkcXibHaO9Hg0EgB8moOgev/gWVaq0=;
  b=F01CkFB8UgT9Zdz+YaGj0yIfv+REVvgYkSMrDj371N+LUaZp2WsotZIL
   ZndZkLvkhrsMX6hWTCo/h9fQJ+IprkdrB0iyGabrCeIDKSo6jYQteb/Rn
   CeSJiWwIXkyIqDmMASV2WmEXEAh+AeekPYH7DE5TzBeM0HgJa0LwF1xFt
   /PIzn87kfPHVV9vRyk8YHrM2yZSGPf98J4uHc5RSMx/rPuIKKoiVSkuZa
   qGyBH+0FMSlj/uuirPOPGhUza3ppq45v/adb5nQqnwrINR0IMF2auwZBb
   xxiueLPZhqY8BdIAJrPofGiAuUpXfqDoQctOtIE+Mu43cZ49ItPTwU+B8
   Q==;
X-CSE-ConnectionGUID: hDIZOXMpTlGBwS7Jo/BI6w==
X-CSE-MsgGUID: vIOnRRAyQ361nmUje2JJeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26132074"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26132074"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:25 -0700
X-CSE-ConnectionGUID: moQoaoE4S9m+ypWf8ECacg==
X-CSE-MsgGUID: 6WX5nXaVQaOAq5hfkePxAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="102389059"
Received: from yhuang6-mobl2.sh.intel.com ([10.238.3.32])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:47:22 -0700
From: Huang Ying <ying.huang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huang Ying <ying.huang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 5/5] cxl: Avoid to create dax regions for type2 accelerators
Date: Wed, 25 Sep 2024 10:46:47 +0800
Message-Id: <20240925024647.46735-6-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240925024647.46735-1-ying.huang@intel.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory range of a type2 accelerator should be managed by the type2
accelerator specific driver instead of the common dax region drivers,
as discussed in [1].

[1] https://lore.kernel.org/linux-cxl/66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch/

So, in this patch, we skip dax regions creation for type2 accelerator
device memory regions.

Based on: https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9c68ec445128..b276752c38da 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3466,6 +3466,14 @@ static int cxl_region_probe(struct device *dev)
 					p->res->start, p->res->end, cxlr,
 					is_system_ram) > 0)
 			return 0;
+		/*
+		 * Accelerator regions have specific usage, skip
+		 * device-dax registration.
+		 */
+		if (cxlr->type == CXL_DECODER_ACCEL)
+			return 0;
+
+		/* Expander routes to device-dax */
 		return devm_cxl_add_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
-- 
2.39.2

