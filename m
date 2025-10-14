Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0B30F942
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430281; cv=none; b=N/t1SLjEGqjBkGqn1RGNQB/6x7NinqNH6qW/kZ55HQKrGkISS/V6WfI978D+nksnrIutw9JBv6qmDEEbm5L5guW75uTYqqArY2a2ksivss0SY9wre3MT6U9OtYeiifPwfWaz1oUCJrPWY0Tv2IktSANgXKUbnFIWSoVHJddoM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430281; c=relaxed/simple;
	bh=Yy+ScprvPvoncnJdqcu0N4rOAgl99OwqatJsqtI0S/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bhTYBFvrFYZfjzpiyhytL+9KPWzgKE4hmoAvX1MfcjpydNTDJybWm0lpP6LZ4Fs7WgiJ+QAwjUrvLVNRRhzJYSMeyngFr3DGXULZ57hNv+Eq3EjwMTuDFOdCDhhlH09El783zhTDXOOwDkErjw7LSKzxEg0m7h0CHyXaT4g5Nwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agHmrUOj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agHmrUOj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760430279; x=1791966279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yy+ScprvPvoncnJdqcu0N4rOAgl99OwqatJsqtI0S/s=;
  b=agHmrUOjre0pGoIDSiuuvl4Qy5otwkBPMq80uWA8dvNYG7qZz6VjNz6m
   zBMnObufvX4sOEGWa2g0zukrgbRzhjYsE9SVciyrAcP9c06SMNuvgDFQ6
   J5/tn6jwM9a5xI92viiNMrvQHTGkl41UJtHW2i09ewUkhAYPTyzWNtBic
   NLmblYs3eWjfqW3T/AszYIKdF5Xf8qD0j2CD7exuVEAkO0ZdpRNBMXmJi
   OVHNZe7G+ydFFO7ioQKGEF7GJQ4K5rNptkL44SCFS2JwtQ8TGTJ2bAhme
   o//WmQ6NqOCfyLyBxapFW4iXht7eAbQ3AOT0Mag+qpBxPWt7CsEYz1SPp
   Q==;
X-CSE-ConnectionGUID: Rm7eIR/SREqO9dBTSILFug==
X-CSE-MsgGUID: hcz2mHMwTJe/Ob6bfmWjiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62619305"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62619305"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:24:39 -0700
X-CSE-ConnectionGUID: Z6tfv8HNREiNJ4fW8gzcuA==
X-CSE-MsgGUID: P7GHuFP2TBSXUZ7VQazSXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="218966052"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 01:24:39 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/3] CXL: Add a loadable module for address translation
Date: Tue, 14 Oct 2025 01:24:29 -0700
Message-ID: <cover.1760429439.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
- Rebase on 6.18-rc1
- Sync to a rename: EXPORT_SYMBOL_FOR_MODULES per a 6.18-rc1 patch

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
EXPORT_SYMBOL_FOR_MODULES() for cxl_translate only.

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


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.37.3

