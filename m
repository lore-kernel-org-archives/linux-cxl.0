Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCE1F7093
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094236; cv=none; b=Btx05fSsdBXowUKdzckv4oBzltuqlbhCSdcs6dXodiEVsYXJt19I5t6V1LxCdJj6ajrZf+vFCTSirq8XTbPDVtF97kjLHYSVfi+Zw6WaF6K2oBq5LHx0qcyC4xvlw7c4Ai1fbfQFMyQ85WsQhksNdhWd+HYDhErBgpFUQSixxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094236; c=relaxed/simple;
	bh=bw3UNFNywJlbMKTkUXk8zq+ATQ9enS4C85yLG9GGeGw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJxulSGrnoDocNWUOk03Va6sI8WfnZFXb1wY8AroFkh+eJ9GZPY+IICdxfwu8LB8fuqnqolY2LZ+JMmwys7C2P+zf3q0YR6tl6oqKyNR9GYMzjMT5IS6vTpg39s7u7G1Mx+OIv6IbDMFfxC4ArUS4524a6YyvOtrAhSTiHKZuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDBZcl/a; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDBZcl/a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094234; x=1768630234;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bw3UNFNywJlbMKTkUXk8zq+ATQ9enS4C85yLG9GGeGw=;
  b=dDBZcl/a1OK/l6CaKo54ENOOFSHHKVe3tDdPUmEO1fe8ne/mj4dk3DHe
   2qKc0Z1vbAZLKen0XDk8N0L8Nxl99crXeyCPU3W8IkSwi4NbdcPApbiEB
   /ja4zCM3InBlvQYwn98yqLLe6sqKnltvp0TQjacbl/FrlqyGI8oAXqglY
   VpNZHHVeip4+djy6maK8p/S3FDjU2wcB35jkxKiMp7iQJUI4LfcsCdHjP
   1WwpbATJ2tpMm89L6jUs3pyrAzR7/uTbbtZUM4ID1vbehGNzYZBZ+Sppo
   Ed8mUB9Bd12C/SZ9QcnFVBPezS0zY45IWwUVNzHeMw6hTs7WxcGwUhLLv
   g==;
X-CSE-ConnectionGUID: ErT6KqqZREiZp8w6U31SeQ==
X-CSE-MsgGUID: IPJuZmFrSxKgozHHFOkuxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41193768"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="41193768"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:33 -0800
X-CSE-ConnectionGUID: W2sMxw93SDifQFbk/2iAsg==
X-CSE-MsgGUID: cmWxvg80Rfuyccc2+Qa7rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109789618"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.114])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:33 -0800
Subject: [PATCH 1/4] cxl: Remove the CXL_DECODER_MIXED mistake
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com
Date: Thu, 16 Jan 2025 22:10:32 -0800
Message-ID: <173709423269.753996.17229236572128350685.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

CXL_DECODER_MIXED is a safety mechanism introduced for the case where
platform firmware has programmed an endpoint decoder that straddles a
DPA partition boundary. While the kernel is careful to only allocate DPA
capacity within a single partition there is no guarantee that platform
firmware, or anything that touched the device before the current kernel,
gets that right.

However, __cxl_dpa_reserve() will never get to the CXL_DECODER_MIXED
designation because of the way it tracks partition boundaries. A
request_resource() that spans ->ram_res and ->pmem_res fails with the
following signature:

    __cxl_dpa_reserve: cxl_port endpoint15: decoder15.0: failed to reserve allocation

CXL_DECODER_MIXED is dead defensive programming after the driver has
already given up on the device. It has never offered any protection in
practice, just delete it.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c    |    8 ++++----
 drivers/cxl/core/region.c |   12 ------------
 drivers/cxl/cxl.h         |    4 +---
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 28edd5822486..be8556119d94 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -329,12 +329,12 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	if (resource_contains(&cxlds->pmem_res, res))
 		cxled->mode = CXL_DECODER_PMEM;
-	else if (resource_contains(&cxlds->ram_res, res))
+	if (resource_contains(&cxlds->ram_res, res))
 		cxled->mode = CXL_DECODER_RAM;
 	else {
-		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
-			 port->id, cxled->cxld.id, cxled->dpa_res);
-		cxled->mode = CXL_DECODER_MIXED;
+		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
+			 port->id, cxled->cxld.id, res);
+		cxled->mode = CXL_DECODER_NONE;
 	}
 
 	port->hdm_end++;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d77899650798..e4885acac853 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2725,18 +2725,6 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
 		return rc;
 
-	/*
-	 * Regions are only created with single mode decoders: pmem or ram.
-	 * Linux does not support mixed mode decoders. This means that
-	 * reading poison per endpoint decoder adheres to the requirement
-	 * that poison reads of pmem and ram must be separated.
-	 * CXL 3.0 Spec 8.2.9.8.4.1
-	 */
-	if (cxled->mode == CXL_DECODER_MIXED) {
-		dev_dbg(dev, "poison list read unsupported in mixed mode\n");
-		return rc;
-	}
-
 	cxlmd = cxled_to_memdev(cxled);
 	if (cxled->skip) {
 		offset = cxled->dpa_res->start - cxled->skip;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..0fb8d70fa3e5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -379,7 +379,6 @@ enum cxl_decoder_mode {
 	CXL_DECODER_NONE,
 	CXL_DECODER_RAM,
 	CXL_DECODER_PMEM,
-	CXL_DECODER_MIXED,
 	CXL_DECODER_DEAD,
 };
 
@@ -389,10 +388,9 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
 		[CXL_DECODER_NONE] = "none",
 		[CXL_DECODER_RAM] = "ram",
 		[CXL_DECODER_PMEM] = "pmem",
-		[CXL_DECODER_MIXED] = "mixed",
 	};
 
-	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_MIXED)
+	if (mode >= CXL_DECODER_NONE && mode <= CXL_DECODER_PMEM)
 		return names[mode];
 	return "mixed";
 }

