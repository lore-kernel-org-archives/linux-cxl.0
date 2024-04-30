Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7E1369AC
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498092; cv=none; b=BdP43F8iQty/IeRfMgpWi/PffwKvBkVe6FJSnkwAdVHoPO8EJLW6Qc+nfTKakuh5wzgNoHsIi2DF16gDgsLU2+7KMZyqJ3sTcu9N1vKv+SS6Zhcw7j2H1ci4o7i0fKN5yL3v3waPZz30cVw/5fK2yqyhvxzVXyQNUM2eZXKp6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498092; c=relaxed/simple;
	bh=uNphq7yEPf4QHAdcHUaIIkXX+yeG6D4+l3ZjdySbvac=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VtAZyNuPt8/iPHArjZqfc+XVw3g5tqOPbHtpoKJO6Am5wwm8daCxhBwV2N4qEIgm2I9/kwso5q8qO99yon/JX+cSECpJ2y/DmfER6WoqOABRVeOzi9+ll2jB7WH1QS4KY2TGPazlT0BrZ6hxfTfSb7uqRFQ5f3qwcrNlvmcbVYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0x2PXn8; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0x2PXn8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714498090; x=1746034090;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uNphq7yEPf4QHAdcHUaIIkXX+yeG6D4+l3ZjdySbvac=;
  b=H0x2PXn85Ye6pCLVhIsv4qwZ8A6LUqKK1LJXHDZGXr5VgiMxM0uQyydU
   971Ya5KOv3xtjXUD0pHHsOJJmtuD/MyDsw+9dthSM/eQSJywqg4lbXaHV
   FCkltgWuhGgJn4pPqRk5SJKGhXQ6ZLtPrTBENB11KDqD2oDmND+HDyf10
   OaOvA3wa+7aQsLNtCW1PuPqKK8YKX6vqGQPU/MUgD8mAOgRFoiqOs7Qs3
   IXDVjZJH+b5GrkZT7p+yWcuHj4+RqROYIQY9Qeut7zlc0hMtGL21VE3Jy
   uj92S/g8XjpgMKQddiyVUB10G04ERni0h/yCzY4aF+K3QL6ZJ5urdnHKA
   g==;
X-CSE-ConnectionGUID: gDW13Xl9TW62JAQLhC2rKg==
X-CSE-MsgGUID: pTx2XYo8T0SkfPs/yuBItw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10069145"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10069145"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:28:09 -0700
X-CSE-ConnectionGUID: OkhJa1MSTV2bty/vFX94oA==
X-CSE-MsgGUID: 03zsJfkKSf6s03LUiPhzNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="26401129"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.17.48])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 10:28:08 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: [PATCH v6 0/4] Add DPA->HPA translation to dram & general_media events
Date: Tue, 30 Apr 2024 10:28:02 -0700
Message-Id: <cover.1714496730.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>


Changes in v6:
- No code changes
- Patch 1: Remove wrong comment about rasdaemon not being available (Jonathan)
- Patch 1: Add Fixes tag (Jonathan)
- Patch 3: Remove blank line in tag block (Jonathan)
- Patch 1,4: Add Reviewed-by tags (Jonathan, Ira)
- Link to v5: https://lore.kernel.org/cover.1714435815.git.alison.schofield@intel.com/

Begin Cover Letter:
Add HPA translations to CXL events: cxl_dram and cxl_general_media

Patch 1: 
The DPA mask fix up patch must precede or be part of this set.
It fixes the issue where upper 32 bits of DPA are truncated.

Patches 2 & 3:
Before adding the new support, do some housekeeping and move related
helpers to the region driver because there is no looking up region
related info without CONFIG_CXL_REGION.

Patch 4:
The new functionality is introduced - cxl_dram & cxl_general_media
events. Lookup and log the DPA->HPA translation along with the
region name and region uuid.

Alison Schofield (4):
  cxl/trace: Correct DPA field masks for general_media & dram events
  cxl/region: Move cxl_dpa_to_region() work to the region driver
  cxl/region: Move cxl_trace_hpa() work to the region driver
  cxl/core: Add region info to cxl_general_media and cxl_dram events

 drivers/cxl/core/core.h   |  14 ++++
 drivers/cxl/core/mbox.c   |  36 ++++++++--
 drivers/cxl/core/memdev.c |  44 -------------
 drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.c  |  91 -------------------------
 drivers/cxl/core/trace.h  |  50 ++++++++++----
 include/linux/cxl-event.h |  10 +++
 7 files changed, 226 insertions(+), 154 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

