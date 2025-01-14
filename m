Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B341459FD;
	Tue, 14 Jan 2025 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886887; cv=none; b=MAsVawBVDhq98Lk8bb4EMr/Iwc/tG7rVlteHa6wzyJ5bO08D9BJdlGM1nEjMw5UgfWb6pedPZtSosJlDhZj8dUahstPY9WxDy85zeM523zQKhNO8zyw3Cwu1vxPnt2xixwPxKRR84cs4DDIh6gStFOBqLemTUG9K+nSu8jpdE50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886887; c=relaxed/simple;
	bh=+hWfFe9P0jjxAfxf90PKYBqv4LgjtnNgp8cUo26hgXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=um7AfwCqJxv6NqXjnq9sHLj47cZU3o0KIyFgk9GjNOSddS816QcnPpbGtxlJXC5PGetnAHpPFdMWSOorzU7bAumyAKNW1HP3GD5BYJUrxFib9Rc4aR8A0am391BpxFrY3Ej13AkNv+Kp6HtPHbWwVbWakubDTIpeX/trN4GacvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhK/jACR; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhK/jACR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736886886; x=1768422886;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+hWfFe9P0jjxAfxf90PKYBqv4LgjtnNgp8cUo26hgXw=;
  b=MhK/jACRjAj4unf1Ryja7hrcDbCcWvXVkYlY2RAr6EGL0F7Mozop0KJw
   uyf005+ow2JivI7tAGrD1piUTERioyaXdPbZ0s3OW38LK+UILg4KT6gfK
   YLb9FQHsbqj857K5qNIm/zREwwGVXOMckHhSiR1HmA0XX7kotusvFFQou
   jC7mWmc+bnIJZ0RTSrAjfp3rDs2E+ZoXFiJRKdNIBrccvPQuBJkuUeVVK
   C3T5RXbfPCRvHifGlBt5hGCaw4/vPi23X/S0ChSXuRlefACdGEZgGelcS
   jRnmUKX3hCUkq/i5Emk8EIBzpL5U/7Jm3RCE3RhItTO4TGn1nXaehbzqp
   w==;
X-CSE-ConnectionGUID: WIrt9N/ZQb+Q4f6BGu1sLQ==
X-CSE-MsgGUID: a+PRCEVFSIWB24YktfK/kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="47693508"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="47693508"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:46 -0800
X-CSE-ConnectionGUID: fH+s870JQmemGyk8B4gYAA==
X-CSE-MsgGUID: 3LxHb0lESzmVsts+KB2dNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="135751325"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.88])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 12:34:41 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/4 v2] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Tue, 14 Jan 2025 21:32:52 +0100
Message-ID: <20250114203432.31861-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
Physical Address (HPA) windows that are associated with each CXL Host
Bridge. Each window represents a contiguous HPA that may be interleaved
with one or more targets (CXL v3.1 - 9.18.1.3).

The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
memory to which systems cannot send transactions. On those systems, BIOS
publishes CFMWS which communicate the active System Physical Address (SPA)
ranges that map to a subset of the Host Physical Address (HPA) ranges. The
SPA range trims out the hole, and capacity in the endpoint is lost with no
SPA to map to CXL HPA in that hole.

In the early stages of CXL Regions construction and attach on platforms
with Low Memory Holes, the driver fails and returns an error because it
expects that the CXL Endpoint Decoder range is a subset of the Root
Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.

Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
Decoders or already made CXL Regions and Decoders to allow the
construction of new CXL Regions and the attachment of Endpoint Decoders,
even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
range end to match Root Decoder's.

- Patch 1/4 changes the calling conventions of three match_*_by_range()
  helpers in preparation of 3/4.
- Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
  the HPA range end for CXL Regions construction.
- Patch 3/4 enables CXL Regions construction and Endpoint Decoders
  attachment by matching Root Decoders or Regions with Endpoint
  Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
  constraints while Endpoints decoders' attachment.
- Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.

Many thanks to Alison, Dan, and Ira for their help and for their reviews
of my RFC on Intel's internal ML.

Commenting on v1, Alison wrote a couple of observations on what users
will see. I suggest anyone interested to see how this series affect
users to take a look at her observations.[0] Thank you!

Changes for v2:

  Cover: 
	Extend and elaborate more on how the series works.
  1/4:
	Add Reviewed-by tags (Alison, Ira).
  2/4:
	Make a separate patch for LMH helpers. (Alison)
	Add spaces before final returns. (Alison)
	Change trim_by_spa() to arch_adjust_region_resource(). (Alison)
	Check that SPA is below CFMWS range start + 4GB. (Ming)
	Change storage class of default helpers to "static".[1] (KTR)
  3/4:
	Add dev_dbg() logs before and after adjusting resource for Region
	construction to match the Root Decoder range. (Alison)
  4/4:
	Conditionally create a LMH simulation only if
	CXL_ARCH_LOW_MEMORY_HOLE is set. (Jonathan)
	Make the start address of the CFMWS range dependent either on
	real hardware (0x0) or on mock_cfmws[0] for tests. (Alison)
	Extend the commit message to confirm successful creation of
	a Region with a LMH on loading of the cxl-test module. (Alison)
	Define the CFMWS range start on real hardware as
	LMH_CFMWS_RANGE_START (Alison)
	
v1 - https://lore.kernel.org/all/20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com/

[0] - https://lore.kernel.org/all/Z0Tzif55CcHuujJ-@aschofie-mobl2.lan/
[1] - https://lore.kernel.org/oe-kbuild-all/202411252126.T7xKY88q-lkp@intel.com/ 

Fabio M. De Francesco (4):
  cxl/core: Change match_*_by_range() calling convention
  cxl/core: Add helpers to detect Low memory Holes on x86
  cxl/core: Enable Region creation on x86 with Low Memory Hole
  cxl/test: Simulate an x86 Low Memory Hole for tests

 drivers/cxl/Kconfig                  |  5 ++
 drivers/cxl/core/Makefile            |  1 +
 drivers/cxl/core/lmh.c               | 81 ++++++++++++++++++++++++++++
 drivers/cxl/core/lmh.h               | 30 +++++++++++
 drivers/cxl/core/region.c            | 81 +++++++++++++++++++++-------
 tools/testing/cxl/Kbuild             |  1 +
 tools/testing/cxl/cxl_core_exports.c |  2 +
 tools/testing/cxl/test/cxl.c         | 10 ++++
 8 files changed, 193 insertions(+), 18 deletions(-)
 create mode 100644 drivers/cxl/core/lmh.c
 create mode 100644 drivers/cxl/core/lmh.h

-- 
2.47.1

