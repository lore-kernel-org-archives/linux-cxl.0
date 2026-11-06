Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002237;
	b=rCJQpduArx+P+BvbFpaBuNUQ6Xg3MEOl29C3LZq07GTuZkT3ZaGI2xLxhI+s2EM4z+Ls
	 FV+Z207eiwRAsbTY13gmDBEgXl+7BiNZdR81b3BJNBK5Xp5E614fDsonQRXvE/gce3rBT
	 oTISQs5TUzlnLomaazAxEXCrC3RZLkbkGbgcFo83va/bx9uioj5Ij0+ew2k3qfMVu8EfD
	 KxhdSZpDJtm5XMACS+2CZwKQuc/ftiOGnRg2iDO33L2R6f4LG74hz+RrtxW0KSpKvNWF5
	 HVQ8RbBXY19ipZNLpWY5CI2xioomkXoxo/0dIoue3soQ2llD7OuwU7mQvz52eS+Z6pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002237;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=CxmJMRFtIL0hk1OxlksLXmSaPdmSVYeymd6MjW5nQX8=;
	b=SVYNE+8/pOa2d2zU/xgWBbdJGPgpCVBImPjp8zHyDIW9iDjvqfb3DoO3s+G7YynUTfNs
	 F5gbnV1G1SR70RUYNcIuPyHKzghUJlidxuNhf/1q4ZOTS/xANmdqVy0DUc7GaVjt0AnCH
	 bDpy7DD+7tj1h1dzJVz4GZ8QBRDJ9vzKtEv9cSujtUy1u/3wdOGrYd58ZFBIe2WrhSj7H
	 3lrh/nNeRzVOu/BiuzwSWKS8GAun9bYIlroHEc1JKobdP5SMPyDZ6NEZ+ej43sEmIyv8F
	 lga5VFJEJukJi53JWvydMnIsnQKHYvlREdAHPM7PWtISVxRgSdMdZAoimPb0UuVUDNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFJxrw6c;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8C606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 21:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44B8C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kFJxrw6c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794002237; x=1825538237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P7VEyGWPPy3YRUlRStJ12M5S2WCyuJ0W4wdcpe+DB4s=;
  b=kFJxrw6c8wIeg0BzRxQlT2zm2Kh3O5SUVvAWCH6USIBUZ8OeSU0QpyME
   nXEzDEtBffc4PTO0IvUJjxWf0Qp3sMVLaucpaU72+gEN0F7wwh107mDmc
   dsErYf5G0C5E8Y2WSEL1XevIsoBg6uvUhxjCNEpaF6hNoE/9Pj9vltsF1
   +eHEl10JR/xwqbs28DFJVMDobsSMAQsA0a/RgTXeCJBvy2rh09zvtteGA
   XZJN4t3XQ98rT7bHHcx/XXDbc20u/yUZw2g8N/66qQQrZ9kij1h0lV3o6
   udAVD4P4SQ59GJvSOigtqLe2DOockOsiYh7kngteEILbmdDdSUSjf86Rq
   Q==;
X-CSE-ConnectionGUID: aLzdnyXYQ7yG/WhsyRgk7w==
X-CSE-MsgGUID: C9JRhnUSQ3GBTNjh2BBRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2812903"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2812903"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:16 -0800
X-CSE-ConnectionGUID: VHV/Anj4TfOwOwO+/reOTg==
X-CSE-MsgGUID: UQv88UvGQ4C4AVUPe8AEcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9147225"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:15 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v7 0/5] CXL: Support region granularities finer than the root
Date: Fri,  6 Nov 2026 13:57:07 -0800
Message-ID: <cover.1794000806.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v7:
- Rebase onto for-7.5/cxl-port-refactor
- Patch 3: adjust unaligned translate to work w new layouts (Sashiko)
- Patch 4: commit log wordsmith only
v6: https://lore.kernel.org/linux-cxl/cover.1791863201.git.alison.schofield@intel.com/


Begin Cover Letter:

Linux requires a region's interleave granularity to equal the interleave
granularity of its interleaving root decoder. This series relaxes that one
restriction: a region granularity may be finer than the root granularity,
provided the interleave levels between them refine monotonically toward
the endpoints.

This series does not add general support for every granularity arrangement
the CXL Specification permits. A region granularity coarser than the root
remains invalid, and configurations whose granularity refines and then
coarsens along the decoder path remain unsupported. Of the Mod3
configurations listed in CXL 4.0 Section 9.13.1.1, all are supported
except Table 9-6 row 6, the refine-then-coarsen 12-way composition.

The use case driving this series is 6- and 12-way regions behind a 3-way
host bridge interleave, CXL 4.0 Tables 9-6 and 9-7, which have no
same-granularity alternative. Power-of-two regions finer than the root
fall out of the same implementation.

Support applies to both firmware programmed auto regions and user created
regions.

Two prior proposals addressed parts of this gap:

AlisonS introduced position arithmetic and sysfs gating for auto and
user-created regions to support the 6- and 12-way interleave configurations
without a same-granularity alternative [1].

RobertR introduced an HPA selector-bit model for auto regions that allows
multi-level power-of-two interleaves regardless of granularity ordering [2].

Series structure in v7:
-----------------------
Patch 1 documents which region granularities Linux supports relative to the
root and the monotonic refinement model.

Patch 2 generalizes endpoint position calculation to account for granularity
changes between decoder levels.

Patch 3 enables auto regions with a granularity finer than the root and
validates their decoder geometry.

Patch 4 enables user created regions with a granularity finer than the root
by relaxing the existing root/region granularity restriction.

Patch 5 adds a cxl_test topology and coverage for region granularity finer
than the root.

The companion NDCTL patchset that allows these regions in 'cxl create-region'
and adds the unit test support is posted [3].

[1] https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/
[2] https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/
[3] https://lore.kernel.org/linux-cxl/cover.1791863817.git.alison.schofield@intel.com/


Alison Schofield (5):
  Documentation/cxl: Describe region granularity finer than the root
  cxl/region: Generalize endpoint position mapping
  cxl/region: Support auto region granularity finer than the root
  cxl/region: Support user region granularity finer than the root
  cxl/test: Add a topology for region granularity finer than the root

 .../driver-api/cxl/linux/cxl-driver.rst       | 119 +++++
 drivers/cxl/core/region.c                     | 224 +++++++---
 tools/testing/cxl/test/cxl.c                  | 420 +++++++++++++++++-
 3 files changed, 683 insertions(+), 80 deletions(-)


base-commit: 0e3e8b653ca3ab145aced729861cf0d1a06da69e
-- 
2.37.3
