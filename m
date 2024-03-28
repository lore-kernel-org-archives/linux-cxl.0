Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3ED13ACC
	for <linux-cxl@vger.kernel.org>; Thu, 28 Mar 2024 04:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711600599; cv=none; b=drDOxqIOE8yD4+uGXNjQ2U4/On873WfD1celhl1CdTBjVXxZYoxhHNwPCABeYOpg8Kv/SEpJn7sdRirLHO8bWTDe2lHnqqobJcd+eEUwgUlNsQnKXHfzKr3hmwf0KaCeS9h2fTy1sKqfKWhzoQ2OTuMDeSX8Lsd3otzJ3nuQBgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711600599; c=relaxed/simple;
	bh=JUrSTz7PBHK8QgiSPNFq3kuaJWEbDPRBi29rJVZ5Umg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhJnoEc/QXN/B7hdVIhCxVbu/K4yYve/Nkd0Qfdh190avHpPFX4JFn6HXKAeXfR0KWyzOitWE9GNPpeqVjnYe77xr8pAMbIivxHGsmReOPa+iFUZ2dbY13SJ2sy3mxrCQvq7t0HaqsutZepG/lmigpthtUz2/ryVh7EUfeJKkN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnfMCB8Z; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnfMCB8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711600597; x=1743136597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JUrSTz7PBHK8QgiSPNFq3kuaJWEbDPRBi29rJVZ5Umg=;
  b=LnfMCB8ZWVowBgaAremhQoW1wfPdzc2TXOaFITk+Wxh+Wr9zrHJjehFT
   Sxk2EBPm3dMGsj4W2o9M5ZldC8+LnuoG0uMwK6MB8rJnxmbM5BFnLi3ew
   axmMIyjCewn4/eypJEk7yQOJ/biVjjDJhF56nrYWqoiIfO169kBFMNexz
   IC9/Dr7+pXkod0UrgLvObhg8WKlJh6B2jRHNmGJ8ylEcZ4s/eWIFhPbNC
   0iovnbv33Hy9cqoK+yqib5E/7Xsu9PUX9jldVTG9toIOD4fv7ltvys+tM
   2uRSbNyy8VGBrTtqOQqCDZ7x21Qp35G9OjQiimqKmaNtz0O+eD+yZAKSw
   w==;
X-CSE-ConnectionGUID: K65tqKZuRUKM2VqQpi+TgA==
X-CSE-MsgGUID: T8vEjA/ERayDU6Vzs5+NeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="10542202"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="10542202"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21184454"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.82.250])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 21:36:35 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/4] Add DPA->HPA translation to dram & general_media
Date: Wed, 27 Mar 2024 21:36:29 -0700
Message-Id: <cover.1711598777.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Add HPA translations to CXL events: cxl_dram and cxl_general_media

Patches 1 & 2:
Before adding the new support, do some housekeeping and move related
helpers to the region driver because there is no looking up region
related info without CONFIG_CXL_REGION.

Patch 3:
The new functionality is introduced - cxl_dram & cxl_general_media
events will lookup and log the DPA->HPA translation along with the
region name and region uuid.

Patch 4:
Apply the new lookup helpers to the existing cxl_poison event, so it
can be the same, share in the new goodness, and also tidy up its
implementation.

An update to the cxl_event unit test is posted separately.


Alison Schofield (4):
  cxl/region: Move cxl_dpa_to_region() work to the region driver
  cxl/region: Move cxl_trace_hpa() work to the region driver
  cxl/core: Add region info to cxl_general_media and cxl_dram events
  cxl/core: Remove cxlr dependency from cxl_poison trace events

 drivers/cxl/core/core.h   |  20 +++++
 drivers/cxl/core/mbox.c   |  22 ++++--
 drivers/cxl/core/memdev.c |  52 +------------
 drivers/cxl/core/region.c | 151 +++++++++++++++++++++++++++++++++++++-
 drivers/cxl/core/trace.c  |  91 -----------------------
 drivers/cxl/core/trace.h  |  76 +++++++++++++------
 drivers/cxl/cxlmem.h      |   3 +-
 7 files changed, 239 insertions(+), 176 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

