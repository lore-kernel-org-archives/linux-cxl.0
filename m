Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211E2356D9
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151960; cv=none; b=VaaDltpt7h1zB+lKTjHnw38gafdkF5dTA06/I/MVTb1jOk8g+VVvWGUEuy1BKxAU3k/UALCXSClO89tuVckh1OI8Z4bzvXfPjBNLcTZt3Vny3g4VCIOsUJ7yzxfjdUi6mB3Aup6ROByIeN8IO7f/T2RjiIJNXmXYFdD92ENAZDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151960; c=relaxed/simple;
	bh=lIVOmvvPH3pwlNSN9xcybqe7dTqwmd75htX+KexFx9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NncxOVaCwTNbh/TsZUMy4fLHOD13BLx2CguLjUpIVRxwF8IsHE9b8mOd80STdkRcS/QfkimuVJvMS33X9CkqyLppFJncTaYhPkxUzHtsZaLTEuczXm1Iew0OgpV/RcIKIdmNxFEjVwqp4bjYa0CrGZEpZuYMhIS+Up9UNBR1Yk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxpxoLeN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxpxoLeN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784151960; x=1815687960;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lIVOmvvPH3pwlNSN9xcybqe7dTqwmd75htX+KexFx9E=;
  b=nxpxoLeNH+QQn7uUPJe8TBxTx8eQk0p96YuV5k/gJx/EytNYjQ+dX07e
   7pkf/onCS2zfgrQHQc+fNtwkw66XKZTthDvqI+eh1ukTLUbtX4I/UmYEq
   +aGBYTGsB2YbfXEfEP9uq5XkdbMo/JfIasS3pueSZB8bPEN63+34c5/bG
   frkJs4sTtdfo992VyEXIEryZKHYSdqtBu9K0y5nv0yRYWxWfAXjBvxzck
   JG1xBi+984gZTf9x7+8T33AjrTNs7YwzgYe3fp7oSSTYdXWDdsEk79G5V
   mvhxB/cVP4AbUpBjJp84JGzjs5o+GjblIUPLEAO+x3NUPPEOVq0LwqDyw
   A==;
X-CSE-ConnectionGUID: c+FE95fsQyawuxX22HITyQ==
X-CSE-MsgGUID: gmiunD4tR1GawJ+URjdOGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88632831"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88632831"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:45:59 -0700
X-CSE-ConnectionGUID: 1Gn6iu4XSTeVoODUkaohFQ==
X-CSE-MsgGUID: l6zJW+avQIKleEdzPLPuMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="254549520"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.156])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:45:58 -0700
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
Subject: [PATCH v2 0/3] Harden HDM decoder enumeration
Date: Wed, 15 Jul 2026 14:45:46 -0700
Message-ID: <cover.1784150131.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- P1: Handle uncommitted decoders (Sashiko)
- P1: Reject switch decoders with zero targets (Sashiko)
- P1: Add in code comment clarifying target_count (Sashiko)
- P1: Update commit log
- P3: Reset commit_end on the failure path only (Sashiko)
- P3: Update commit log
- No changes in P2

Here are 3 Sashiko reported cleanups.
Only the first includes a link to the complaint, since the others did
not originally appear on Lore for me to add public links. 

Srirangan: I believe the first 2 of these also address pre-existing
issues Sashiko posted in reply to your reset series, Patch 02/11.


Alison Schofield (3):
  cxl/hdm: Reject switch decoder interleave ways that overflow targets
  cxl/hdm: Make switch decoder target parsing endian-safe
  cxl/hdm: Restore commit_end when decoder enumeration fails

 drivers/cxl/core/hdm.c  | 58 ++++++++++++++++++++++++++++++++---------
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  2 ++
 3 files changed, 48 insertions(+), 14 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

