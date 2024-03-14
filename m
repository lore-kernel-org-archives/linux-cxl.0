Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23915B7
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 04:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710391386; cv=none; b=bdEbzkYgDlTEIJBcDMLPb9SUAj+NoCOWlx1xYISzj34CUPsyh2N23N1zOCL8xu3oiKvEZjwz1ORjFsCLu2l9ilx+a1XOkKof07sK/PSfjEIAwRXZ3EM6bHEwoNXUdYuFcYe3db+vLBq5J+oostHJ9sC7WjuvBEoLp/LCOMMZw7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710391386; c=relaxed/simple;
	bh=ZtCpUKn2zFP0sZkx1utgDuUQzl8Q1v2C3qEoqiNcOaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDAtXFPPvMlWtVXvuamNjleks/cfrh5pAPi2vrh+z2br9uTu5+p41fmlLXqmNYe22mnZN7RtKJd3Gw58ewrbKpcvzr+2obp8gzLJe6JK7JZkWk48oGWa4qhU75IASqA5HSYny10dMScIwBj4Jwe4eqgYi6QBLNe1LXyfGtbRHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jfc31vty; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jfc31vty"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710391385; x=1741927385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZtCpUKn2zFP0sZkx1utgDuUQzl8Q1v2C3qEoqiNcOaM=;
  b=Jfc31vty7FUpw0/4qIEufSDPEf5cUHW+zoe6qTokH0k7UjAQL48P6/rt
   /XTTaCkNmkbXMhuTJHJBpsf+zsfda5rfaZdwGlczEn/00esvpmb7awQ8W
   dpiR+tEDhcdPKozheOax0qzLmVJ6vFbBM9JWKZhyUsEyZXLtFqEbfpYnF
   VnvfIRXAV7CvrUs32UXoP3D1pHllj5Py7A719/99q280/wMRobbqc2/rf
   HLtntJxbIiiOemQz6Xkozl0xp+NHECSJfns5dzJbtu5wp6GnddBqhbiJz
   Q/hbEwIxTauEZ23sC2H7697xS9665DPmZepJ59l9fbafx37AeM5lKZzXE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5319571"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="5319571"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 21:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16761651"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.86.131])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 21:43:03 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/trace: Initialize cxl_poison region name to NULL
Date: Wed, 13 Mar 2024 21:43:01 -0700
Message-Id: <20240314044301.2108650-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The TP_STRUCT__entry that gets assigned the region name, or an
empty string if no region is present, is erroneously initialized
to the cxl_region pointer. It needs to be initialized to NULL
otherwise its length is wrong and garbage chars can appear in
the kernel trace output: /sys/kernel/tracing/trace

Impact is that tooling depending on that trace data can miss
picking up a valid event when searching by region name. The
TP_printk() output, if enabled, does emit the correct region
names in the dmesg log.

This was found during testing of the cxl-list option to report
media-errors for a region.

Fixes: ddf49d57b841 ("cxl/trace: Add TRACE support for CXL media-error records")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index bdf117a33744..bc5ca4d530d1 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -657,7 +657,7 @@ TRACE_EVENT(cxl_poison,
 		__string(host, dev_name(cxlmd->dev.parent))
 		__field(u64, serial)
 		__field(u8, trace_type)
-		__string(region, region)
+		__string(region, NULL)
 		__field(u64, overflow_ts)
 		__field(u64, hpa)
 		__field(u64, dpa)

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
-- 
2.37.3

