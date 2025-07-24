Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241F2DEA80;
	Thu, 24 Jul 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753367105; cv=none; b=r+vjuZTiFKXAI/2IR5xhGTXvE5x3BsP9s/TMywVN1chj0Q16rYFOAA5PaQYqqxMseWHbPYzPx6uKJQulAeF1sWzCF9z6oYkKl/AU+8upAoLgijdKT8WHCvjdVls/EH44rKuJds71AaQpHKOtCtr+dEiZ/2+0kX7477pHoU8udEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753367105; c=relaxed/simple;
	bh=vzs8kcKWJHaamV71LWKk22OR8zL50WkNbXej3rtsrak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qM3qvISCy9/Q5lxn8OXBWiviBiyGzgCxOqK3A9OysIWtIk9SzG3+x6QM/EturbzSUD2R2lK6xFIv9v+b2r70HPQoZ3PlxfsZbS1pJPvusBTJ1f/iIEDIKRtBWiwSP/oosz3iII+5zD1HPnKkrTG4TVcEygIFu1qbn3Twhnw9Kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIGvK+B+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIGvK+B+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753367103; x=1784903103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vzs8kcKWJHaamV71LWKk22OR8zL50WkNbXej3rtsrak=;
  b=PIGvK+B+ufHvzIcxXFIGI2XVwNAYJfDYlLgrtbIR/mlZtNlXpAUL955Q
   QWW7yCagjvYCIsFhT+3hyNT5NiGhgWqnRXUGUscPDXl++67HSTgvAMKPx
   /gY7juMOl4lrJS8UUKMkGung8XMqMVnGHpWOAOLQM7oDIsXDwVX+pzHHu
   4Nj8R35Q7LSSBSuLbzKRsOrnpw85+U2MG9H+g/74jaZ5ApJ84k0cgwhUL
   jWWuF4wetESM4VMcyXzTivQSvH+os45ALljo/t9gUGbWSIUijXpTN5xf8
   QTU6ceofZBbzbqvkfAvEEFzMAndEAGg/mOjgr1XFN+j3DekUkjyGE7M9w
   A==;
X-CSE-ConnectionGUID: HFLli1bcQ/+h1UjM9fFeQg==
X-CSE-MsgGUID: Vfc1HNVhTCqfs38PU7j0/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="66250189"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="66250189"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:25:02 -0700
X-CSE-ConnectionGUID: OlyNoVqkSey5XW6tnCFhWA==
X-CSE-MsgGUID: CxB+AlCLThKvUTCS7L4Qrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160245635"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.151])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 07:24:58 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Robert Richter <rrichter@amd.com>,
	ming.li@zohomail.com,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH 0/4 v4] cxl/core: Enable Region creation/attach on x86 with LMH
Date: Thu, 24 Jul 2025 16:20:30 +0200
Message-ID: <20250724142144.776992-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Many thanks to Alison, Dan, Dave and Ira for their help.

Commenting on v1, Alison wrote a couple of observations on what users
will see. I suggest anyone interested to see how this series affect
users to take a look at her observations.[0] Thank you!

Changes for v4:

  Re-base on top of 
	"cxl: Address translation support, part 1: Cleanups and refactoring";[1] 
  Drop no more necessary 2/4;
  Drop collected tags because of major changes throughout the series.

  1/3 - Adjust Endpoint Decoders dpa_res->end (Alison) [2] 
  3/3 - Use weak/strong mechanism (Dan) [3]

Changes for v3:

  Re-base the series on cxl/next.

  1/4 - 2/4:
        Constify local variables.
  3/4:
        Call arch_match_region() from region_res_match_cxl_range().
  4/4:
        arch_match_region() - Check that region end is under start + 4G;
        arch_match_spa() - Check that SPA range start is cfmws_range_start.

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

 drivers/cxl/Kconfig               |   5 ++
 drivers/cxl/core/Makefile         |   1 +
 drivers/cxl/core/platform.c       |  86 +++++++++++++++++++
 drivers/cxl/core/platform.h       |  32 +++++++
 drivers/cxl/core/region.c         | 113 ++++++++++++++++--------
 tools/testing/cxl/Kbuild          |   2 +
 tools/testing/cxl/mock_platform.c | 137 ++++++++++++++++++++++++++++++
 tools/testing/cxl/test/cxl.c      |  10 +++
 tools/testing/cxl/test/mock.h     |   1 +
 9 files changed, 352 insertions(+), 35 deletions(-)
 create mode 100644 drivers/cxl/core/platform.c
 create mode 100644 drivers/cxl/core/platform.h
 create mode 100644 tools/testing/cxl/mock_platform.c

base-commit: acc2913692413df9d1

-- 
2.50.1

