Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936843AB26A
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785450074; cv=none; b=YdczeMGFQZ+Boegzbc3zcVeECxErsPgnoPu5D4N9Di2ihfJmy3cJWDEryVkJuSVwTr8zf5vvxHbvdcHQ6/phc5sds2qsbrZF808N8qkqucKH1fWhjglCfuUi75OSoaTW1k111Yvyh38W+lDVNUS5qYT2fABeU+XEHXYnd7OieiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785450074; c=relaxed/simple;
	bh=DvZmVYx+pDByyNmzyeoU4p17X64quS7DUS4l1TVsRKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxcXpt4Y6kuiMWdcDBXuLNwoi2tA2GkIsMAstD0x264oNvSKYvW2CB5+MZ0ovwoJgZX5yzpNkwVdowlNo55e9OXKCXwYqUe7AXMIEzURHyUcCMm6XaPDk73cQ8vne6y72Bpy4mEv+9a1KEPtkA9YOS2wI/1CwjBvmZdqlNZ/fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1PcQivq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1PcQivq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785450072; x=1816986072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DvZmVYx+pDByyNmzyeoU4p17X64quS7DUS4l1TVsRKM=;
  b=S1PcQivqIFzsi2Mh0FyiiEMlMkaJvS+USc5krPAs3OWUfcvxDFBT1WU3
   Oxe0eH40lnbyTj9MXDPa9lTh6B3GxlzA/P0aUiG92q7zwuQm5HWA9nXK+
   QJZBZ0ma2v/q5bkBkATuDaLtkHQMVrIjKkMMZJ11sttttergPOF2pmOIp
   UlTMrqCp9VHSWHinnArjcVRN2bHjCqkQJIZ0O6IHYKDxOMuQjkx98FhIH
   wknKHiDQE0hNMfi8XsmIehxxtM2X+GcgZ0nBNtXoXoFvVK5I5w8DlvA9C
   G1Wcks0GawL7fPuBPbDEZB8NtjDHHzHjjctun1iZbT4OUx/k9NSuOlpa6
   A==;
X-CSE-ConnectionGUID: 1R2SBCjLQLiuGE+7KI6Kow==
X-CSE-MsgGUID: R07kBNakS9S+Oz68RGLuVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="96665414"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="96665414"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:50 -0700
X-CSE-ConnectionGUID: SkwQ6SaQRHGjEnFnDswMJw==
X-CSE-MsgGUID: s0DIopjbRAuWoiGgP5bG2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="265482277"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.90])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 15:20:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 9/9] Documentation/cxl: Describe multi-level interleave validation
Date: Thu, 30 Jul 2026 15:20:29 -0700
Message-ID: <b7fc3bf435335aa6b266d54ea198b95e90b93ab5.1785444498.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1785444498.git.alison.schofield@intel.com>
References: <cover.1785444498.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL defines the legal ways and granularities for multi-level
interleaves, including configurations where the region granularity is
finer than the root decoder granularity.

Add a short guide that points to the controlling CXL specification
sections and summarizes where Linux validates and applies that
interleave geometry.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 Documentation/driver-api/cxl/index.rst        |  1 +
 .../cxl/linux/region-granularity.rst          | 66 +++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/region-granularity.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 3dfae1d310ca..1ae193ea4020 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    linux/dax-driver
    linux/memory-hotplug
    linux/access-coordinates
+   linux/region-granularity
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/driver-api/cxl/linux/region-granularity.rst b/Documentation/driver-api/cxl/linux/region-granularity.rst
new file mode 100644
index 000000000000..8f23ef6992b9
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/region-granularity.rst
@@ -0,0 +1,66 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Multi-Level Interleave Region Geometry
+========================================
+
+CXL regions may route an address through a root decoder and one or more
+switch decoders before reaching an endpoint decoder. Each interleaving
+decoder selects one of its targets from the region address. The decoder
+levels must use a compatible combination of interleave ways and
+granularities so that their routing decisions form one region interleave.
+
+The CXL specification defines the legal multi-level combinations and is
+the authority for the interleave geometry:
+
+* CXL 4.0 Section 9.13.1.1, ``Legal Interleaving Configurations``
+* CXL 4.0 Tables 9-6, 9-7, and 9-8
+* CXL 4.0 Figures 9-17 and 9-18
+
+Those sections cover both power-of-2 interleaves and the 3-way interleave
+family, including regions whose granularity is finer than the root decoder
+granularity.
+
+Linux implementation
+====================
+
+The CXL core validates region geometry while walking the decoder topology
+in ``drivers/cxl/core/region.c``.
+
+For each port decoder, Linux:
+
+* collects the HPA selector bits already used by the root and ancestor
+  switch decoders;
+* rejects overlapping selectors or selectors outside the region selector;
+* derives the port decoder granularity from the selector bits available at
+  that level;
+* validates firmware-programmed values for auto-discovered regions and
+  programs the derived values for user-created regions; and
+* checks that endpoint positions agree with the decoder target lists.
+
+Mixed-granularity regions require different endpoint position arithmetic
+because one decoder target may cover multiple region positions before the
+next target is selected. The driver expresses that as the number of region
+positions covered by one decoder target and uses it while reconstructing
+endpoint positions.
+
+For 3-way-family roots, selector bits alone do not describe the full
+interleave span. Linux therefore also checks that the root and region cover
+the same span.
+
+Implementation details
+======================
+
+The implementation is documented with the functions that enforce each
+part of the model:
+
+* :c:func:`get_selector`
+* :c:func:`get_parent_selectors`
+* :c:func:`derive_port_granularity`
+* :c:func:`root_positions_per_target`
+* :c:func:`cxl_calc_interleave_pos`
+* :c:func:`check_gran_ordering`
+* :c:func:`cxl_port_setup_targets`
+
+The region-level granularity and 3-way-family span checks are performed in
+``cxl_region_attach()``.
-- 
2.37.3

