Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D16F20ED
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780099254; cv=none; b=KiyJm31bJQyUWn5toY/0dCbjpSD3fWmSQY4d2sNhKxXrDHid2gy4Nk9QoPwPFYhgzFY6ldCJ6QBiyt20DTdCdmv/W4bHcVGTgmXms+nciLOLNTxlNfgYApZjJoS2yy/99cSbpVhDHcKQdWITgCEXLnrNhtMIcyYOARpj6NHLqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780099254; c=relaxed/simple;
	bh=V9t+fJxZF9foQRgFqIF5gE6JipaJK7UcfJqR8UsReAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QU9kkSkHGEN1OnJnL9BY+3VmvZcCE2YLZf33zNWjq0F95fD8rEXEJYkGLBmoqQnH4d7h7gCWc6ZwbGviC4A9iKQweCsQ8ui+IXTGqQR1IOnUrKS3I9TMEp+QA2+qv+mWsMkrnDuBgwsNGHEs3+zCshe/c6chDXdpjQiCFV5g3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boYYg3vl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boYYg3vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780099253; x=1811635253;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V9t+fJxZF9foQRgFqIF5gE6JipaJK7UcfJqR8UsReAY=;
  b=boYYg3vl+ZZuWUROyoXKRagwzDRfaCJeMDnBNbuHpHV/NcZ2fMqn2tUK
   PC8fN5Q3tQi5V0xXMof3DRdItPgREYv1m6mbBjdRCtgQvB7ROVWhlgyIi
   7S9ryQOGJJolWYuRmWyGAkbd25lzhAJS7DKhWZ7g0QEq+cD2+G9ypbNQg
   poYw6ZuNofW09cUuyGblGTQZ4wvVeAL4lLnae/QpZnHDJC7jLT0WPwQnL
   JQruhlnDoj5grfb/bH6XGtTSpJDFAnSgy+MCeaHAwnMYYKwtxKvYADJM9
   FlGO1EU9ilymry7+WNakAaBn6eW9T0BgMfWLj/Hjj1YKDBnlt0BMsbp3w
   w==;
X-CSE-ConnectionGUID: ZTtbGxXSSQuGocjsRzqXZQ==
X-CSE-MsgGUID: h9IDzgoXRU+fAax24tUIFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91530527"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="91530527"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:53 -0700
X-CSE-ConnectionGUID: lPeRh4vOT6OYFEE4PqBy2w==
X-CSE-MsgGUID: Ea2B0Zn8RleJjh3lFyiTYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="238804343"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.60])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 17:00:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/6] cxl: Support mixed-granularity region interleaves
Date: Fri, 29 May 2026 17:00:39 -0700
Message-ID: <cover.1780095671.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CXL region interleaves across decoder levels (root, optional
switches, endpoint). CXL Spec 4.0 Section 9.13.1 requires only
that each level use a different, consecutive range of HPA bits to
select its target. The driver has historically required equal
region and root decoder granularities. That blocks the legal
mixed-granularity arrangements permitted by Section 9.13.1, and
makes the 6-way and 12-way configurations defined in Section
9.13.1.1 (Tables 9-6, 9-7, and 9-8) impossible to create.

Two prior proposals addressed parts of this gap:

AlisonS added position arithmetic and sysfs gating to allow
auto and user-created regions for the 6-way and 12-way
configurations that have no same-granularity alternative:
https://lore.kernel.org/all/20250306232239.2609017-1-alison.schofield@intel.com/

RobertR introduced an HPA selector-bit model to allow multi-level
regions regardless of granularity ordering for auto regions:
https://lore.kernel.org/all/20251028094754.72816-1-rrichter@amd.com/

This series combines those two approaches into a complete mixed-
granularity implementation. It extends Robert's selector-bit model
from auto regions to user-created regions, extends AlisonS's
position-arithmetic and gating work to all mixed-gran layouts, and
adds the remaining validation needed for both paths. The result is
support for every mixed-granularity arrangement defined by the CXL
specification.


Series structure
----------------
Patches 1 and 2 replace the old granularity ordering rule with
selector-bit validation. Patches 3 and 4 propagate that model through
the remaining region-creation paths. Patch 5 adds cxl_test coverage
for the new layouts. Patch 6 documents the region granularity model
and multi-level interleaving rules.

A companion NDCTL patchset that allows mixed-gran 'cxl create-region'
and adds the unit test is posted separately.


Alison Schofield (6):
  cxl/region: Validate interleave selector bits
  cxl/region: Derive port granularity from selector bits
  cxl/region: Account for mixed-granularity in position calculations
  cxl/region: Validate mixed-granularity at sysfs and attach gates
  cxl/test: Add a topology to test mixed-granularity regions
  Documentation/cxl: Add region granularity and multi-level interleave
    guide

 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/region-granularity.rst          | 486 ++++++++++++++++++
 drivers/cxl/core/region.c                     | 314 +++++++----
 tools/testing/cxl/test/cxl.c                  | 474 ++++++++++++++++-
 4 files changed, 1146 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/linux/region-granularity.rst


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.37.3

