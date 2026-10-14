Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8301FF1DA
	for <linux-cxl@vger.kernel.org>; Wed, 14 Oct 2026 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791951482; cv=none; b=HmsD5JqTstzssHDZCziR0Lr/Np1/YlOPwrGJk8Mu1tchUiP/HrieMSCyr5nNSERZcrQOxhnnm8/9sY+at8CH2qlSwhR6WEH17C5xCB95TaIiMCGbQHAZgsQ7zRPzRDeOdMx4lR9kUcRU5TZtlcrdqpgBSiP4twb76LlLQenf+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791951482; c=relaxed/simple;
	bh=zVOqtDrajLZkGLp1D2DB/zgNJiH0gxlpl9o4x8ROFwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4jbhZxkwM+02s3d16CqyX7esZ+t76jkRuzyzftT5UFnTtpSN8RQb6G1TtRzsyJLYPMbfnkl0wulZzB9MbONU1BeFB68vauHXg9waLUo4UPdJKcMCVXvBQU8IeSXnMal5p7TDsF8YdJGiaF7NOHR9xw8Bb/FENwdbKSnJu+ofaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrU2RpjL; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrU2RpjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791951481; x=1823487481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zVOqtDrajLZkGLp1D2DB/zgNJiH0gxlpl9o4x8ROFwM=;
  b=RrU2RpjLU5RNAAfXy4BBqY+Q9PEPH8vFAuxzfyCmgv9RTVHNhdjTxWau
   2+hsuooiLdJG/IIdITIZCjt4/s6Pdv+rayenDpvf5/4cftuXKnPefqy91
   k1dKzkvMbrBDPurZjWmH9koDm/dXE26lomNwHhhNvMMMJfDRUAmY8NB+L
   or8RGPUqhgy8EU/XsZJqju8Cb7c4VxT+zRNI5zoavuIxU84RGAUagjmVz
   vBS5KXdwSHgdKWUssA5KX21jTqCXRB5JAv3U3UAUdGvgn3jp0eGGcVUun
   IGUXv3Sz99h3m63LX8PSIQNbXsugn1fUGakLtdo6CaDBJT0NAjuJgZ13/
   Q==;
X-CSE-ConnectionGUID: lkgEM3KFS6SWvWK36mQNmw==
X-CSE-MsgGUID: VwOJt4jHS4O1gUCXp2r9XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="696232"
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="696232"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:00 -0700
X-CSE-ConnectionGUID: T9MT9JQ4RdOb+7NrffCQGQ==
X-CSE-MsgGUID: HS4BM9O2RdOY1FN0vSmoSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="1783569"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 21:18:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/4] cxl: Add KUnit tests and documentation
Date: Tue, 13 Oct 2026 21:17:51 -0700
Message-ID: <cover.1791949910.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL subsystem has no KUnit tests. Its automated test coverage comes
from cxl_test and the ndctl suite, which exercise the driver stack through
an emulated CXL topology. KUnit complements that coverage by testing self-
contained logic and error paths in isolation.

This series introduces CXL KUnit infrastructure and documentation describing
how it complements the existing cxl_test coverage.

The first KUnit suite, a collection of related test cases, exercises the HDM
decoder interleave encoding helpers, providing a starting point for testing
self-contained CXL logic. The second suite exercises mailbox command handling,
including error paths that are difficult to reach through cxl_test.

The mailbox tests also demonstrate the value of regression coverage. An
unknown device return code can cause an out-of-bounds read and allow a failed
command to be reported as successful. The series corrects that behavior, then
adds tests that reproduce the failure without the correction. With KASAN enabled,
the tests also expose the out-of-bounds read.

Together, the two suites establish a pattern for adding KUnit coverage
to CXL, both for existing functionality and for bugs as they are found.



Alison Schofield (3):
  Documentation/driver-api/cxl: Add a testing page
  cxl: Add KUnit tests for HDM decoder encoding helpers
  cxl/mbox: Add KUnit tests for cxl_internal_send_cmd()

Gaobin Huang (1):
  cxl/mbox: Treat unknown device return codes as errors

 Documentation/driver-api/cxl/index.rst   |   1 +
 Documentation/driver-api/cxl/testing.rst | 120 +++++++++++
 drivers/cxl/.kunitconfig                 |   4 +
 drivers/cxl/Kconfig                      |  16 ++
 drivers/cxl/Makefile                     |   1 +
 drivers/cxl/core/Makefile                |   1 +
 drivers/cxl/core/tests/Makefile          |   5 +
 drivers/cxl/core/tests/mbox_kunit.c      | 249 +++++++++++++++++++++++
 drivers/cxl/cxlmem.h                     |   6 +
 drivers/cxl/tests/Makefile               |   5 +
 drivers/cxl/tests/hdm_encoding_kunit.c   | 156 ++++++++++++++
 11 files changed, 564 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/testing.rst
 create mode 100644 drivers/cxl/.kunitconfig
 create mode 100644 drivers/cxl/core/tests/Makefile
 create mode 100644 drivers/cxl/core/tests/mbox_kunit.c
 create mode 100644 drivers/cxl/tests/Makefile
 create mode 100644 drivers/cxl/tests/hdm_encoding_kunit.c

-- 
2.37.3

