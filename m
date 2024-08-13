Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917E60EC4
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547588; cv=none; b=e8+WrK6ub026WrAfQ9P3eohqq3vRyPovNFRlmY//dl5pMyQDV3PyV+wDIByAiK5alJiu96tPXRDuTTVkE6jdi4FvyH5GqXmPQ6/OdzPYBTzMC8SWeD6Eny193xgrW+Kv+BH9CTn1Nr2E8DahLuQUbr9EExtuStsPnTbuKR0wggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547588; c=relaxed/simple;
	bh=gZwhe97f+wILNfWjc23vBK22qTvjp4eHrxhYf9C7Gj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p78NgkxNr6z8Un7laTnSKG4C4jWAPvYMC4HVCDcpiFAziluZUO2s1R/qwKD4A4ZfsohhfKPexP1zjfylFBTvDbfnMXf8q6o8+C7YZDqZQXETwHvl4i/Rsc/vVU81FdePRFUj80yELOeov4rtoCgZcl3CaXqXa3VoXmBnM4n8tek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FF/DGmb1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FF/DGmb1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547586; x=1755083586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gZwhe97f+wILNfWjc23vBK22qTvjp4eHrxhYf9C7Gj8=;
  b=FF/DGmb1J1YwOcxcRPT6v252YoTzxtl44ymgmYj5NMWCukXxXiczDdUR
   MwZY10qgi1c6k15RV+jAKzTQhGL4QTBPagt15aXfktKcZLiF/T3Q5Den7
   vS4G7M517pB1pjWqvfSDFvx2F/MO09TygQkQk08hR1i08lkIwAMzLKiJh
   uHGpJTEw/5DcTibT6QWO9xn4Mf+/E6tZExiV40BHQ+yYZitL2Mr0nkmMo
   3VlwAsKXoIg3e7oISgFaREuQZmPabb/SytIuk+oXiNrTgB9Slsci77Rmn
   LY+Zi0yjSznM8SjFHJaMn/FAIVqRCNvvkKtbVPMQrIDyq3TVKpWuwXCWw
   w==;
X-CSE-ConnectionGUID: iYbGQHkIQJiBAbzUeEmfkQ==
X-CSE-MsgGUID: Jec62hZ/RQyTlT1n7C8B+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21262277"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21262277"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:06 -0700
X-CSE-ConnectionGUID: NNgYINwTQWuEMf0DlnorpA==
X-CSE-MsgGUID: mQ63OAixSz2oPScArVQ5JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58568752"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:04 -0700
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
Subject: [v3 1/4] cxl/pci: Fix to record only non-zero ranges
Date: Tue, 13 Aug 2024 19:05:29 +0800
Message-Id: <20240813110532.870869-2-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240813110532.870869-1-yanfei.xu@intel.com>
References: <20240813110532.870869-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function cxl_dvsec_rr_decode() retrieves and records DVSEC ranges
into info->dvsec_range[], regardless of whether it is non-zero range,
and the variable info->ranges indicates the number of non-zero ranges.
However, in cxl_hdm_decode_init(), the validation for
info->dvsec_range[] occurs in a for loop that iterates based on
info->ranges. It may result in zero range to be validated but non-zero
range not be validated, in turn, the number of allowed ranges is to be
0. Address it by only record non-zero ranges.

This fix is not urgent as it requires a configuration that zeroes out
the first dvsec range while populating the second. This has not been
observed, but it is theoretically possible. If this gets picked up for
-stable, no harm done, but there is no urgency to backport.

Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..2d69340134da 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -390,10 +390,6 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
 		if (!size) {
-			info->dvsec_range[i] = (struct range) {
-				.start = 0,
-				.end = CXL_RESOURCE_NONE,
-			};
 			continue;
 		}
 
@@ -411,12 +407,10 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,
 
 		base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
 
-		info->dvsec_range[i] = (struct range) {
+		info->dvsec_range[ranges++] = (struct range) {
 			.start = base,
 			.end = base + size - 1
 		};
-
-		ranges++;
 	}
 
 	info->ranges = ranges;
-- 
2.39.2

