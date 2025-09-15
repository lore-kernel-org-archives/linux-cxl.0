Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465F42D7DCE;
	Mon, 15 Sep 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948304; cv=none; b=RH5kYK93JEIYTNew5LadHtfypCyHJ9zdhUF90aspH8Kkr9Tep4bko7gviyOjDJuGCTjULSFy11XefHgBhcVz/28+qQQ5IP8NllOSaAlMLCybYwgLdjiIcNB5xRILeIuzZYyGyAOOJIlBgcp8XpPXRc2mbt1Aa2V97xoyEY3ThSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948304; c=relaxed/simple;
	bh=RZDbgiuYUemwihGWAOZNTM6teDV+Gwo6rUSUU0EUoVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q7WSMVbFqxQIxgRxevd95ynjSx3Yr4gjnQT0/W2C2y2DGWn7Tf8oXYpjXBXju9ar5oZ699p9m2S67neHEqA4631k6ZdlRhJ1JQ3IqJ2YABJ4i2et9tB0tHtVvNt49KB30+4pUXQ0k3x4v9NBVa04clRml0UWMGOfxH9qbLDokkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIH728GC; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIH728GC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757948304; x=1789484304;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZDbgiuYUemwihGWAOZNTM6teDV+Gwo6rUSUU0EUoVU=;
  b=nIH728GCFG3p3joZggigaHXoDmtazosprbYwSkjoRzBixsimsDlFtUYK
   3oG3R6TSKhks7oJTQllLldFMLrTOJRHopGbd+n2ZBSjobyZcZOTGITIul
   xKrCbS/Ml8C3zvcp6sgwi80/gTOxyCTQ4/hPxFev9kglfbjnbZWrbz6g6
   BxnHlB0kPDcdhcmHLtd1gcx3urFE6DQsa28PK+Eh3JxmjqsR8TMv25N2p
   H6yvrH+EnAVpT6dpT/SyW5HBbWzYC/GD9p6JRKEFyQkzKghP0+oI2op/i
   dy4Tu7AfBx2hTmmuuLAh3yqUV/rlVhU1YcCeOPALMz/rgEH5NeMBUNOMS
   w==;
X-CSE-ConnectionGUID: qluD5bkzSgKYY2rAOH16FA==
X-CSE-MsgGUID: iZZjJu26QReEbM7BhKCfiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70455746"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="70455746"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:58:22 -0700
X-CSE-ConnectionGUID: ttUN8l+tTe+m0OoBWDrUvA==
X-CSE-MsgGUID: dUMgHo4DQ7e6HUep6Aggog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="174274000"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.245.103])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 07:58:16 -0700
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
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v6] cxl: docs/driver-api/conventions resolve conflicts between CFMWS, Low memory Holes, Decoders
Date: Mon, 15 Sep 2025 16:57:20 +0200
Message-ID: <20250915145810.16872-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation on how to resolve conflicts between CXL Fixed Memory
Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
Decoders.

Reviewed-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

v5 -> v6: Extend "Summary of The Change" with detailed explanation about
	  the mismatch between the Root and the other HDM Decoders HPA
	  range sizes (Gregory)
	  Clarify that this change is exclusively intended to enable x86
	  platforms which map CXL memory under 4GB (Gregory)

v4 -> v5: Fix grammar and syntactic errors (Dave)
	  Spell out CXL, OSPM, on first use (Dave)
	  Rewrite a few sentences for better clarity (Dave)
	  Talk about SPA vs HPA and SPA's relationship to CFMWS (Dave)
	  Adjust a table for htmldocs output (Bagas)
	  Use bullet list (Bagas)
	  Correct the CFMWS[1] HPA range to not overlap CFMWS[0] (Robert)
	  Correct the CFMWS[1] HPA range to the NIW*256MB rule (Robert)

v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
	  Switch and Endpoint Decoders match and attach Regions in
	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
	  Remove a wrong argument about large interleaves (Jonathan)

v2 -> v3: Rework a few phrases for better clarity.
	  Fix grammar and syntactic errors (Randy, Alok).
	  Fix semantic errors ("size does not comply", Alok).
	  Fix technical errors ("decoder's total memory?", Alok).
	  
v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.

 Documentation/driver-api/cxl/conventions.rst | 135 +++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index da347a81a237..6bce7c614fff 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -45,3 +45,138 @@ Detailed Description of the Change
 ----------------------------------
 
 <Propose spec language that corrects the conflict.>
+
+
+Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
+============================================================================
+
+Document
+--------
+
+CXL Revision 3.2, Version 1.0
+
+License
+-------
+
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+- Fabio M. De Francesco, Intel
+- Dan J. Williams, Intel
+- Mahesh Natu, Intel
+
+Summary of the Change
+---------------------
+
+According to the current Compute Express Link (CXL) Specifications (Revision
+3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
+or more Host Physical Address (HPA) windows associated with each CXL Host
+Bridge. Each window represents a contiguous HPA range that may be interleaved
+across one or more targets, including CXL Host Bridges.  Each window has a set
+of restrictions that govern its usage. It is the Operating System-directed
+configuration and Power Management (OSPM) responsibility to utilize each window
+for the specified use.
+
+Table 9-22 of the current CXL Specifications states that the Window Size field
+contains the total number of consecutive bytes of HPA this window describes.
+This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
+
+Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
+memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
+the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
+
+The HPA represents the actual physical memory address space that the CXL devices
+can decode and respond to, while the System Physical Address (SPA), a related
+but distinct concept, represents the system-visible address space that users can
+direct transaction to and so it excludes reserved regions.
+
+BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
+with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
+resulting in lost capacity in the Endpoints with no SPA to map to that part of
+the HPA range that intersects the hole.
+
+E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB::
+
+ +--------+------------+-------------------+------------------+-------------------+------+
+ | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
+ +========+============+===================+==================+===================+======+
+ |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+ |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+
+HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
+a 12 ways region and all the intermediate Switch Decoders.  They are configured
+by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
+3GB. Instead, the CFMWS Base and CFMWS Size are used to configure the Root
+Decoder HPA range that results smaller (2GB) than that of the Switch and
+Endpoint Decoders in the hierarchy (3GB).
+
+This creates 2 issues which lead to a failure to construct a region:
+
+1) A mismatch in region size between root and any HDM decoder. The root decoders
+   will always be smaller due to the trim.
+
+2) The trim causes the root decoder to violate the (NIW * 256MB) rule.
+
+This change allows a region with a base address of 0GB to bypass these checks to
+allow for region creation with the trimmed root decoder address range.
+
+This change does not allow for any other arbitrary region to violate these
+checks - it is intended exclusively to enable x86 platforms which map CXL memory
+under 4GB.
+
+Despite the HDM decoders covering the PCIE hole HPA region, it is expected that
+the platform will never route address accesses to the CXL complex because the
+root decoder only covers the trimmed region (which excludes this).  This is
+outside the ability of Linux to enforce.
+
+On the example platform, only the first 2GB will be potentially usable, but
+Linux, aiming to adhere to the current specifications, fails to construct
+Regions and attach Endpoint and intermediate Switch Decoders to them.
+
+There are several points of failure that due to the expectation that the Root
+Decoder HPA size, that is equal to the CFMWS from which it is configured, has
+to be greater or equal to the matching Switch and Endpoint HDM Decoders.
+
+In order to succeed with construction and attachment, Linux must construct a
+Region with Root Decoder HPA range size, and then attach to that all the
+intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
+regardless of their range sizes.
+
+Benefits of the Change
+----------------------
+
+Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
+Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
+with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
+
+This change allows the OSPM to construct Regions and attach intermediate Switch
+and Endpoint Decoders to them, so that the addressable part of the memory
+devices total capacity is made available to the users.
+
+References
+----------
+
+Compute Express Link Specification Revision 3.2, Version 1.0
+<https://www.computeexpresslink.org/>
+
+Detailed Description of the Change
+----------------------------------
+
+The description of the Window Size field in table 9-22 needs to account for
+platforms with Low Memory Holes, where SPA ranges might be subsets of the
+endpoints HPA. Therefore, it has to be changed to the following:
+
+"The total number of consecutive bytes of HPA this window represents. This value
+shall be a multiple of NIW * 256 MB.
+
+On platforms that reserve physical addresses below 4 GB, such as the Low Memory
+Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
+have a size that doesn't align with the NIW * 256 MB constraint.
+
+Note that the matching intermediate Switch Decoders and the Endpoint Decoders
+HPA range sizes must still align to the above-mentioned rule, but the memory
+capacity that exceeds the CFMWS window size won't be accessible.".
-- 
2.50.1

