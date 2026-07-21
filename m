Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B43FFF82
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599188; cv=none; b=X7qZTvjak6kFv82l1EG36md98NjQmeUAC0rrYeS68aSvIwzk0A2u0fQxP1gdPRIFnVhZZw1gmK65KnrMhAJls1VHHeUwQgIO1VwFDCVDiY5vtBvGqIWcT30Wworq4kZnylMvS7LrvMUg71uCwNJJbLQf46DvwXE7Gd9qf1E1lB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599188; c=relaxed/simple;
	bh=IvjhkqnumpofAGJ1ObWD+m31U3DpGy8nMsKwiSFuO3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PoDfOpPempRsUyxdrilL4kujFG4ks7Dm+V/aJZczuB/2uoh3pMce/wx6bA9uadpFmNRM/T/5frmNyIosjaqCF2PG+YFKhmI/zUJ5Dm97b5nxngVo6hqRDesZiCwMSQ7w5avKSMNgd6xrnzAvZvhoLaP1kANhtOHXtiwD8Zx85RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvrMbDm8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvrMbDm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784599186; x=1816135186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IvjhkqnumpofAGJ1ObWD+m31U3DpGy8nMsKwiSFuO3w=;
  b=bvrMbDm8DoS3QUtaRDffobgufTL7jh5B39ZhZIwznYFkvkiVQcWiQt8y
   MA+l1PGoCKgs2bT9P1Y46zyZJWR4mRV+QnjDBN3f8LPVQHMBbSjAM6T0D
   IqgbGgTLcR7Bj47Df3Jxpy/MDLKWHQKZDOIsrpcVbmthbahZpNaPr0B9W
   jiQIfhDITyjtL4NJCwAe5p2fLVskkmG1CfSXuu0XNPx7fmZBkBe+dbmEi
   r8b5vIJ7nlq0QLgngJihlasgjvGC20G9AhooQZMuCsSrHzh4Lsbrb1rOC
   OX85jWlvu4hemjlZf8dGCUreazt09hRAZ5vJosmX1Ovh7nkBh/6S5hg/c
   Q==;
X-CSE-ConnectionGUID: OoO49dN3ThOOd2L0RSkLwg==
X-CSE-MsgGUID: GxrV4J32QE2uRYTXN84ZEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85209202"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85209202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:46 -0700
X-CSE-ConnectionGUID: ahwqppJ5Rmudn3584T/E4Q==
X-CSE-MsgGUID: MeXaZfNzSuKt9MbZ1pD6lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255837058"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.174])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v4 0/4] Harden HDM decoder enumeration
Date: Mon, 20 Jul 2026 18:59:36 -0700
Message-ID: <cover.1784595445.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
A new patch was inserted as Patch2, so now set is 4 patches.
   Sashiko is likely to complain in Patch 1 for something fixed in
   Patches 2 and 3, but reordering does not makes sense.
P2: Only interpret interleave settings on committed decoders (Ming)
    This is the newly inserted patch
P4: Register reset w devm_add_action (Ming)
P4: Fix up a kernel-doc comment issue (lkp)

Changes in v3:
P1: Move zero-target reject to init_hdm_decoder() (RichardC)
P3: Reset commit_end via a devres action after decoder teardown (RichardC)

Changes in v2:
P1: Handle uncommitted decoders (Sashiko)
P1: Reject switch decoders with zero targets (Sashiko)
P1: Add in code comment clarifying target_count (Sashiko)
P1: Update commit log
P3: Reset commit_end on the failure path only (Sashiko)
P3: Update commit log
No changes in P2


This set started as Sashiko reported cleanups, and at v4, Patch 2/4
was added based on Li Ming's review and catch.

Only the first includes a link to the original Sashiko complaint, since
the others did not originally appear on Lore for me to add public links. 

Srirangan: I believe patches 1 and 3 of these also address pre-existing
issues Sashiko posted in reply to your reset series, Patch 02/11.


Alison Schofield (4):
  cxl/hdm: Reject switch decoder interleave ways that overflow targets
  cxl/hdm: Only interpret interleave settings on committed decoders
  cxl/hdm: Make switch decoder target parsing endian-safe
  cxl/hdm: Restore commit_end when decoder enumeration fails

 drivers/cxl/core/hdm.c | 98 +++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h      |  2 +
 2 files changed, 76 insertions(+), 24 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

