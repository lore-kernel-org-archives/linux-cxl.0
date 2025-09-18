Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF8110E9
	for <linux-cxl@vger.kernel.org>; Thu, 18 Sep 2025 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758154240; cv=none; b=OVaCBCVzOnPesGQgGYyWkyWE4+W5BzKyt64MkM2S9uH7mSzo3etrCFFhLx47XE28hcQQgXQ/R9r7ZSkgwJfhTkwGgXdhqEMtp6+g1YF7teoicmkNqShKM0q+jHNshqf2sFbxyXnIa07TdNOhmVB5jB2Q2ku36Un70y7NAtg2b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758154240; c=relaxed/simple;
	bh=VtCHK+D7CataZerK4Kv7MwME/C39f/c5fAyawWlVPco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nycwi9EeBUpy7w6/xIla0FdIVczIbAIE1gSbQnlGDHU1o15XLyOVZteb7BcWhjN9RbpPIAD89hnwP7evs5Z2dM8Zhg8s4eTM65/4bPhC2NyccByH8UpIKlSmF9mexB9Kx5yDrzh8JV+CyMDQ2mZLJOTMuSdgvWYz4ZyXL1aVKjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7CbCzQY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7CbCzQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758154238; x=1789690238;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VtCHK+D7CataZerK4Kv7MwME/C39f/c5fAyawWlVPco=;
  b=Q7CbCzQY0YqYKX+a7DKAhALCarG/P9m2TS35dNo0FNbEVtT/d0J3XbX2
   89xiYN7mA/j/QcksovIU7oVNT0Z2O5vciV7M/j667BbM0+xBO/pG9rvY1
   h/rJ0BCFt+hp/8Usr1ZjzKpmk0Q/MwD1ncWgSAjrZCjyQ6vuDEuWluXcN
   LPq0XnpirjgbT2xt3Y6L+/ziYKqXszTm5epYYukN2Z6sKL2iWaBcbkP7Z
   uD8hIP0eXLcjzAiWq59ObeG5Yg21b9BFeJqsPi9zfj5pUZ/dtB8jBMFCp
   rkYJg55NAdbxXTf/TeSe6lYuVDhTyv0C7nIx/WpjmWRfb0hyoc4rwK7dK
   w==;
X-CSE-ConnectionGUID: yzBPbgTUTGOZv9wb2bYjJg==
X-CSE-MsgGUID: 0DZQ0WlyQeeIPW3PoKxkbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="63106134"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="63106134"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 17:10:38 -0700
X-CSE-ConnectionGUID: seiomdaIS2OZtxtdV5qK0w==
X-CSE-MsgGUID: GGKQP6unSL6ruKp0Byhr+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="174500014"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.125])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 17:10:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/3] CXL: Add a loadable module for address translation
Date: Wed, 17 Sep 2025 17:10:29 -0700
Message-ID: <cover.1758150087.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Rebase on latest cxl/next
  This set is posted for review based on cxl/next because it depends on
  SPA->DPA translation work only in cxl/next (the poison by region offset
  set). When cxl/next becomes v6.18-rc1, I'll rebase and resend.
- Replace __mock_exports with EXPORT_SYMBOL_GPL_FOR_MODULES()
- Replace (u64)GENMASK() w GENMASK_ULL() (DaveJ)
- Refactor cxled lookup in cxl_dpa_to_hpa() (DaveJ)
- Move struct cxl_cxims_data to cxl.h (DaveJ)
Below is new functionality in v3:
- Add and EXPORT cxl_validate_translation_parameter().
  This consolidates param validation in region.c and exporting it enables
  testing.
- Add a test of cxl_validate_translation_parameter() to test module.
- Add a random test of the exported CXL Driver translation functions.

Changes in v2:
- Rebase on cxl/next
  This set has dependencies on patches only in cxl/next.
- Make the new helpers static by default, exportable for tests (Dan)
- Restore useful dev_dbg() message for invalid position (Jonathan)
- Create and free cxims data struct in test module (Dan)
- Make some test module comments kdoc's (Jonathan)
- Move a block comment to new helper (Jonathan)
- Remove useless check for ULLONG_MAX (Jonathan)


This series refactors CXL address translation code to support testing
and adds a dedicated test module for validation of the translation
calculations.

The work is presented in 3 patches:
1. Extracts the core translation logic into standalone, testable functions.
2. Provides access to XOR interleave calculations also with a standalone
   testable function.
3. Adds the test module that validates both Host to Device, and Device
   to Host address translations.

The CXL Driver functions are made available to the test module using
EXPORT_SYMBOL_GPL_FOR_MODULES() for cxl_translate only.

The companion CXL Unit Test script is posted separately.


Alison Schofield (3):
  cxl/region: Refactor address translation funcs for testing
  cxl/acpi: Make the XOR calculations available for testing
  cxl/test: Add cxl_translate module for address translation testing

 drivers/cxl/acpi.c                     |  41 ++-
 drivers/cxl/core/region.c              | 204 ++++++++----
 drivers/cxl/cxl.h                      |  19 ++
 tools/testing/cxl/test/Kbuild          |   1 +
 tools/testing/cxl/test/cxl_translate.c | 445 +++++++++++++++++++++++++
 5 files changed, 638 insertions(+), 72 deletions(-)
 create mode 100644 tools/testing/cxl/test/cxl_translate.c


base-commit: c10b92358bdf87959c9f0b9b7efa8ed946e1fb48
-- 
2.37.3

