Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BA1917CD
	for <linux-cxl@vger.kernel.org>; Mon,  4 Aug 2025 08:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297568; cv=none; b=VDhcpkM2cEIvy99gROBnAM4gqz+WH9+hp6I/NnmRLO3huhNnmqOHrdnAt+lcRGqsQByL5BPNrGkV0fEkbhNQ8pM2e94fp1/tzTKngIdTtMulR9v9EWQ51QjPj3stBwibyxhC+Y+VubJcu+pr/mYfU/D+0I2UIHgM877fFIztvts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297568; c=relaxed/simple;
	bh=8a91BKCavkLol2mQjAgwmSBLZl4JxpWi0OqSMSiL+jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm3ll7KK5w6i46/P5QiRAI1HBuNDOSEDl50QCUS3C+RcMLdoiSJNqAvhfNqd5KHURGnoJg9mFzlm+/17Arj4mi0u3XsPs3jeqavjlbLL5ucTbBpfLfXe/NS1yBEkxXo9Dpn9TJ4+SnDBVQGVd8AbmAffpWNhpMwLqackkKTx4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6X0KAQs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6X0KAQs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754297567; x=1785833567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8a91BKCavkLol2mQjAgwmSBLZl4JxpWi0OqSMSiL+jc=;
  b=B6X0KAQsyHusHtFVwDYgXtQCcmLm0v3C0+5v1rW5SIy0bnwoHeBmsAb4
   /amXHHQsU57eZLkxhQO5PwldaBkkrpYFUsa26xYg5ANr1g03YI1hsPN54
   fDD6Yko4OTl/L62efdclV2DZ8MesORecWOK3MflDc1zP/MH00xWqMHaLx
   bNitqdTcM6OKCjKIRF/v5JeYg3H4wtk3tdW/qB0A5UzewO27M3hEJm5Zf
   7uNypytU6YS/dXkspQMc7UZw8MCXC+M/X/g0ZDDVwboXvPMn0M8ciJa+E
   +qbSQxVXBZEJNINQm2LvC0Qxh6JJ7GoYzEXX/XgBz81vBK4/wGnq+Qd3S
   w==;
X-CSE-ConnectionGUID: yTGvIgpVQAudQjETjnpjAA==
X-CSE-MsgGUID: Y9YYRT6+Tr6XD+LRoWlpKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56442161"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56442161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:52:47 -0700
X-CSE-ConnectionGUID: 9ob1oevXT7K1rOS44nbKWA==
X-CSE-MsgGUID: jqh75wz/Q9+Jrl59lkhP5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164104233"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.77])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 01:52:46 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] CXL: Add a loadable module for address translation
Date: Mon,  4 Aug 2025 01:52:38 -0700
Message-ID: <cover.1754291501.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

This set doesn't have a base commit. It is based on cxl/next plus the
Poison by Region Offset patchset [1], plus the fix to Limit XOR map
application based on host bridge ways [2] which this test module exposed.

[1] https://lore.kernel.org/linux-cxl/cover.1754290144.git.alison.schofield@intel.com/
[2] https://lore.kernel.org/linux-cxl/20250804082357.2590809-1-alison.schofield@intel.com/

This series refactors CXL address translation code to support testing
and adds a dedicated test module for validation of the translation
calculations.

The work is presented in 3 patches:
1. Extracts the core translation logic into standalone, testable functions.
2. Provides access to XOR interleave calculations without exposing internal
   CXIMS structures to test modules.
3. Adds the test module that validates both Host to Device, and Device
   to Host address translations.

Accessing the core functions in the test module was implemented by 
adding the needed core/region functions to cxl_core_exports.c and 
adding a similar 'cxl_acpi_exports.c' to access the cxl/acpi.c funcs.

The companion CXL Unit Test script will be posted separately.


Alison Schofield (3):
  cxl/region: Refactor address translation funcs for testing
  cxl/acpi: Make the XOR calculations available for testing
  cxl/test: Add cxl_translate module for address translation testing

 drivers/cxl/acpi.c                     |  51 ++++-
 drivers/cxl/core/region.c              | 145 +++++++-----
 drivers/cxl/cxl.h                      |   3 +
 include/linux/acpi.h                   |   7 +
 tools/testing/cxl/Kbuild               |   1 +
 tools/testing/cxl/cxl_acpi_exports.c   |  13 ++
 tools/testing/cxl/cxl_core_exports.c   |  11 +
 tools/testing/cxl/test/Kbuild          |   2 +
 tools/testing/cxl/test/cxl_translate.c | 298 +++++++++++++++++++++++++
 9 files changed, 467 insertions(+), 64 deletions(-)
 create mode 100644 tools/testing/cxl/cxl_acpi_exports.c
 create mode 100644 tools/testing/cxl/test/cxl_translate.c

-- 
2.37.3

