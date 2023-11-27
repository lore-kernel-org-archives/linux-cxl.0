Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENPTcu3/"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F9FB
	for <linux-cxl@vger.kernel.org>; Sun, 26 Nov 2023 16:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701043798; x=1732579798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u3zHAnxME+bfCIySqitfsXmnfgVoocB+juc7gNAtaKo=;
  b=ENPTcu3/LsqQp1cbnuuoZe8Rp0V12EAF7+ZCBv3w0JN5Di7YJocyNBtc
   A3LvMXJCQ/wWSZGBAhMOC779p0Krsf+pYTLWQs2Gp8ewxG8HnlZLHpzSg
   fDk4seFiEpkqxRCJ87u/BN1+bjxeLdVQPEy7qs/ht1O8+pvmb8JZFQr6G
   ZHGNfSUUwlvvvF8UeAEuUSH7AdId6UmwgDL0H/bl9S02HM9gJ6GC67ANU
   AcT/9qqw0NgUByqmZC+18OqMVZo3ecO4tCV4Sf7GIVKTFCq5v7HgweNu1
   IyZNW66UIPGUkfpAuY1ZhLBtysBq8ZwtW5tg2Cocr6tW7h7QdBhma3BbJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="371969636"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="371969636"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="885837362"
X-IronPort-AV: E=Sophos;i="6.04,229,1695711600"; 
   d="scan'208";a="885837362"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.90.230])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 16:09:32 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/2] cxl/core: Hold region_rwsem during poison ops 
Date: Sun, 26 Nov 2023 16:09:28 -0800
Message-Id: <cover.1701041440.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This work was previously posted as a single patch [1] and is reposted
here split into 2 patches. The first patch fixes up the poison list
and the second patch the poison inject and clear.

They both are cleaning up locking issues exposed by:
Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
added a lockdep_assert_held() to make sure all callers hold the
region state stable while doing work that depends on the number
of committed decoders.

Changes since that single patch posting:
- Put back the _interruptible() on down_reads (DavidLohr, Dan)
- Split into 2 patches (Dan)
- Add impact statements in commit logs (Dan)

[1] https://lore.kernel.org/linux-cxl/20231114025342.1123681-1-alison.schofield@intel.com/

Alison Schofield (2):
  cxl/core: Always hold region_rwsem while reading poison lists
  cxl/memdev: Hold region_rwsem during inject and clear poison ops

 drivers/cxl/core/memdev.c | 27 ++++++++++++++++++++++++---
 drivers/cxl/core/region.c |  5 -----
 2 files changed, 24 insertions(+), 8 deletions(-)


base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
-- 
2.37.3

