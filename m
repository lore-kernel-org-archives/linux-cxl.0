Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825072627EC
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 07:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756452105; cv=none; b=r9pvJY2KKfFY8ciaHjMkdXDrHyp7Khmnh1hPgO6JUpKbCIkF5JwmL4XUoTf5wrMPC2dSTg5k4siT7Bmn7tQU4TxCV8N3qucBtUS9p4AiLG7FhVtZ/m79s9TENt32VzJ6qtFpw7nCnv9yMXp3uQz3QuYlANIeIZcgcRXOSfriAWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756452105; c=relaxed/simple;
	bh=+r1nPJ+d0ti6gulVxzPFfg85ylZVDyH9OG9lsMRNSmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTSDStHmrz9FhVeMS8mIcJHn5asVBXF+J9NfUEizovQ6OBYwch+57MIpJpatKF9aiYMYVhoOe4Lgt3hiTXlbs61TXm2M8ELDcvHK4DdqSpzHwF8pGLM7slA4CY+TKr6vaZOgp3BPwejwDpeGk8sz1YwKeFo0FBQkg7z/lIcoFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IE7/5eIx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IE7/5eIx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756452104; x=1787988104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+r1nPJ+d0ti6gulVxzPFfg85ylZVDyH9OG9lsMRNSmc=;
  b=IE7/5eIxHnetO2Vizwqmfrj/LcH7ie3dvZvKX/09ZkK/ZLMXzLIipO65
   rcC60x7W0P8byG9vCUyGEXYU2AFz5UhiS01WfoYeFBCIQtB4LvX6/0eJU
   sD4W9UUmLZnv47bKOo6+0u8B75wUdvEPCQ/rgry9XLBLkcIAgDz8uIXN1
   A7rY9kbSha6lXZBSY7qih1Fdqq7y2Nrx0f1QRISThxx61DCYhtF51DR7H
   gvWqtQ2xIZ4Agu4QTCUaJnuSanGLbz+ctpvF+T/q2yk2iZLAY8rRekoLk
   hzxGb05HB5gN0BCDRjHLNbbbIcgqSKklpBOFmhU8uRVgTpTNWw5frFVkO
   A==;
X-CSE-ConnectionGUID: 7kknTHlPTQaHHxlqnfFnkw==
X-CSE-MsgGUID: VaRdVM1TSS6gBSgxVVpUgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58584991"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58584991"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:43 -0700
X-CSE-ConnectionGUID: KPPsMutkSfSVSiOCEH7CBQ==
X-CSE-MsgGUID: IHpZCynERIORCCX2dOl8Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175613110"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.170])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 00:21:42 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/3] CXL: Add a loadable module for address translation
Date: Fri, 29 Aug 2025 00:21:24 -0700
Message-ID: <cover.1756446925.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Accessing the core functions in the test module was implemented by 
adding the needed core/region functions to cxl_core_exports.c and 
adding a similar 'cxl_acpi_exports.c' to access the cxl/acpi.c funcs.

The companion CXL Unit Test script is posted separately.


Alison Schofield (3):
  cxl/region: Refactor address translation funcs for testing
  cxl/acpi: Make the XOR calculations available for testing
  cxl/test: Add cxl_translate module for address translation testing

 drivers/cxl/acpi.c                     |  35 ++-
 drivers/cxl/core/region.c              | 147 +++++++-----
 drivers/cxl/cxl.h                      |   5 +
 include/linux/acpi.h                   |   7 +
 tools/testing/cxl/Kbuild               |   2 +
 tools/testing/cxl/cxl_acpi_exports.c   |   7 +
 tools/testing/cxl/cxl_core_exports.c   |  12 +
 tools/testing/cxl/cxl_test.h           |  18 ++
 tools/testing/cxl/test/Kbuild          |   2 +
 tools/testing/cxl/test/cxl_translate.c | 303 +++++++++++++++++++++++++
 10 files changed, 467 insertions(+), 71 deletions(-)
 create mode 100644 tools/testing/cxl/cxl_acpi_exports.c
 create mode 100644 tools/testing/cxl/cxl_test.h
 create mode 100644 tools/testing/cxl/test/cxl_translate.c


base-commit: 561c4e30bff93b3c33e694a459f8580f8a6b3c8c
-- 
2.37.3

