Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50951296BA9;
	Mon,  6 Oct 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766331; cv=none; b=dsBav7P3iFRwLj3g3ksRZhw+FMV/nkKYpZP+laE9UoLrZTQrQaF5VmCHM3qCoSDv4T6/78ZLxR37aGXkI33W6uysIimbH9qeLDgG0Cj254fvBoKR/98VDDweD8fHf3CSJYkdCYbszzjo1elxJVguwsWd54qnYz1ZnYaS1oan1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766331; c=relaxed/simple;
	bh=smquUjtAajFZGugjREyxZNDH4yDb7DFsGdns88zCoL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrXjuIwfaWdI9gGvVxsdaXoPYcgnxHi6lWBz/D+Y/waI3rgPUACjaEHUi7caiQtpIrpLBj2Ep5OPcR/kTGpzMWUFP4s5YTMPTnbcAEuNZ33yqRfUO6PO29l1PvokufNlkWFMKRaC72bLibo21XgHAgVQiRe4UYSNiU3ampwfnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+cCDwHr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a+cCDwHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759766330; x=1791302330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=smquUjtAajFZGugjREyxZNDH4yDb7DFsGdns88zCoL4=;
  b=a+cCDwHrKy4HoZyuIrUcvp9ZekSYR/iCyuLOOzhmcvsWusz3yUCAWsYy
   HwI+nQJpKCdpqfWoi8QgMPpsU6cyg1keUs00uAIqNdztZkmkCABGyKRV+
   qE4oM2qlaj8QcQ2JZKvFulCFJSKac8gnNwUyLvjW62TfDOaxGtnpJPkld
   oNGHnF9z0MOTWq1JM3xlArk3TOvjx2E65Z0KbVeYzKbxVm9r6EIlhkja9
   YhL6x2Fwa24yHrZk+rJ17LV11wcwwEaMVQA1Ri8nQC5kzeQkWf4gpYDKH
   ChM8QxuxrKfX5cNISreZ4s43S5WtNwC4qs/KI83K/KjyTC+pMwvpcD7Dx
   g==;
X-CSE-ConnectionGUID: rG37C2DoTd+o84b02yAQ+g==
X-CSE-MsgGUID: C+GV1tNMSoKq+2q8qmR33Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="61150547"
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="61150547"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:49 -0700
X-CSE-ConnectionGUID: GyxMqBqwTfK/p3QCE9fw5w==
X-CSE-MsgGUID: zBRTuDzOQfCiqLABRJzm2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,320,1751266800"; 
   d="scan'208";a="185189558"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.245.98])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 08:58:43 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	Robert Richter <rrichter@amd.com>,
	Cheatham Benjamin <benjamin.cheatham@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/4 v5] cxl/core: Enable Region creation/attach on x86 with LMH
Date: Mon,  6 Oct 2025 17:58:03 +0200
Message-ID: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
Host Physical Address (HPA) windows that are associated with each CXL
Host Bridge. Each window represents a contiguous HPA that may be
interleaved with one or more targets (CXL v3.2 - 9.18.1.3).
 
The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
memory to which systems cannot send transactions. On those systems, BIOS
publishes CFMWS which communicate the active System Physical Address
(SPA) ranges that map to a subset of the Host Physical Address (HPA)
ranges. The SPA range trims out the hole, and capacity in the endpoint
is lost with no SPA to map to CXL HPA in that hole.
 
In the early stages of CXL Regions construction and attach on platforms
with Low Memory Holes, the driver fails and returns an error because it
expects that the CXL Endpoint Decoder range is a subset of the Root
Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.

Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
Decoders or already made CXL Regions and Decoders to allow the
construction of new CXL Regions and the attachment of Endpoint Decoders,
even if SPA < HPA. If needed because of LMH's, adjust the Endpoint
Decoder range end to match Root Decoder's.

- Patch 1/4 changes the calling conventions of three match_*_by_range()
  helpers in preparation of 3/4.
- Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
  the HPA range end for CXL Regions construction.
- Patch 3/4 enables CXL Regions construction and Endpoint Decoders
  attachment by matching Root Decoders or Regions with Endpoint
  Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
  constraints while Endpoints decoders' attachment.
- Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver,
  rewrite the two functions of 2/4 to test the construction of a region
  and the attachment of the decoders in the test environment.

Many thanks to Alison, Dan, Dave and Ira for their help.

Commenting on v1, Alison wrote a couple of observations on what users
will see. I suggest anyone interested to see how this series affect
users to take a look at her observations.[0] Thank you!

Changes for v5:

  Patch 1/4:
	Add Reviewed-by tag. (Jonathan) 
	Use Reverse Christmas Tree notation. (Benjamin)
	Rename three match_*(). (Dave)

  Patch 2/4:
	Rewrite two paragraphs on the commit message for better clarity
	and flow. (Dave)
	Fix grammar and syntax errors in the commit message. (Benjamin, Dave)
	List the conditions under which the platform*() helpers match root
	decoders or regions with intermediate switch or endpoint decoders.
	(Dave)
	Rename platform.c to platform_quirks.c. (Dave)
	Rename local variables for root and endpoint decoders. (Dave)
	Have one conditional per line. (Dave)
	Reword comments in platform_res_adjust(). (Benjamin)
	Make "inline" the platform*() functions declarations in #else block.
	(Benjamin)
	Make kdocs from regular comments on functions. (Benjamin)
	Rename platform_*_contains() functions to platform_cxlrd_matches_cxled()
	and platform_region_matches_cxld() to better reflect their semantics.
	Reference a commit to CXL documentation.

  Patch 3/4:
	Update commit message to Spec 3.2 (Benjamin)
	Return result of platform_region_contains() directly (Benjamin, Dave)
	Make a logical OR of two if statements (Benjamin, Dave)
	Fix grammar errors and improve readability of the commit message (Dave)

  Patch 4/4:
	Base the LMH simulation on the redirect/mock mechanism (Dave)
	Rename a few local variables (Dave)

Changes for v4:

  Re-base on top of 
	"cxl: Address translation support, part 1: Cleanups and refactoring";[1] 
  Drop no more necessary 2/4;
  Drop collected tags because of major changes throughout the series.

  1/3 - Adjust Endpoint Decoders dpa_res->end (Alison) [2] 
  3/3 - Use weak/strong mechanism (Dan) [3]

v4 - https://lore.kernel.org/linux-cxl/20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com/
v3 - https://lore.kernel.org/linux-cxl/20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com/
v2 - https://lore.kernel.org/linux-cxl/20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com/
v1 - https://lore.kernel.org/all/20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com/

[0] - https://lore.kernel.org/all/Z0Tzif55CcHuujJ-@aschofie-mobl2.lan/
[1] - https://lore.kernel.org/linux-cxl/20250509150700.2817697-1-rrichter@amd.com/
[2] - https://lore.kernel.org/linux-cxl/Z9tzZkn1rqd2Uk_6@aschofie-mobl2.lan/
[3] - https://lore.kernel.org/linux-cxl/67ee07cd4f8ec_1c2c6294d5@dwillia2-xfh.jf.intel.com.notmuch/

Fabio M. De Francesco (4):
  cxl/core: Change match_*_by_range() signatures
  cxl/core: Add helpers to detect Low Memory Holes on x86
  cxl/core: Enable Region creation on x86 with LMH
  cxl/test: Simulate an x86 Low Memory Hole for tests

 drivers/cxl/Kconfig                  |   4 +
 drivers/cxl/core/Makefile            |   1 +
 drivers/cxl/core/platform_quirks.c   | 104 +++++++++++++++++++++++++
 drivers/cxl/core/platform_quirks.h   |  49 ++++++++++++
 drivers/cxl/core/region.c            | 109 ++++++++++++++++++---------
 tools/testing/cxl/Kbuild             |   1 +
 tools/testing/cxl/cxl_core_exports.c |  23 ++++++
 tools/testing/cxl/exports.h          |   7 ++
 tools/testing/cxl/test/cxl.c         |  54 +++++++++++++
 tools/testing/cxl/test/mock.c        |  48 ++++++++++++
 tools/testing/cxl/test/mock.h        |   4 +
 11 files changed, 369 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cxl/core/platform_quirks.c
 create mode 100644 drivers/cxl/core/platform_quirks.h

base-commit: 46037455cbb748c5e85071c95f2244e81986eb58
-- 
2.50.1

