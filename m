Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002238;
	b=cOXtysVX1LbAnBpXPf3lp5a0f3WehxY2nm9d9kRj5kDnQT4aS7297O9esQM2ZBjteQ6t
	 7zmH4xswUJfgDXn8dB0shjYIj6VfOScnYMHAM5EE2Z/gpRGDu24pE2rQFZO+GeaBNnc5e
	 uYUncMJaYBAXkt8f4Ze6DWIwnZ74kTtuzx7gMupOq2xC/93quiIeh3qSPKTMBgMMTAlm+
	 eldbAwmiZtmqjADfSvr9WUw9RT34zRJOTNS11L2OlGWP06r2MKIhRUQUNPU5rsT437btT
	 ROkpn7qWmBBnhkEmFfB4Mca7fMDyWvAJgNh8bZ9Axre1ni0xM4IrI6P9jrBcMnArDSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002238;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V/YSbkXuE0maeR+p4aHP7NiJTi/QA1uIJ5qoDr2gw9E=;
	b=voOUsEVBSGCuQhjQUbC2nnkBAEc0Ox/i/f1UMM3PNdFD2eNs+q4JUKCjyr/aS2oRWGvm
	 yXdMWq6qFcWfrlLwN6Z4kRlBwQNQTXJIlrzqUrZp67Al4BvsXGnHTm917Jm3eHba6ZBvD
	 XpEcph8wmFcnTqyw1l67XLDG5g454OWGNrGCpLPh7eF0VEsBQpFf2Z02AmfpCDSMzJPFf
	 XJmDohNz8V4a0kQHCf3FZ65DB3Uf5Gn47RaUSontWfN1xeSevvuPzI2qS1QkiMJHet3by
	 WGrMiP5Dq+TMCJREHLTu2oVbyh349LRnqQn1opQezH4q7h++xyDHaao9u63olcO8UGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LRTN2wsV;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80997606A32C
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 21:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80997606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LRTN2wsV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794002238; x=1825538238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o23Pf0KdPjajS7Ij6znwI5Wa+YdcfedzR86aqMxIMV8=;
  b=LRTN2wsV0UfEZJokcXXPzud+PijbMsr7EtYJl4GIdzc5OMJSNmtNu5FW
   AzAWKRX8pxWqgMzlIlwOXe8G7ZTLeWGiKY07Nl9yWH5Os5KV/gBdoJ2HX
   NOC5glt+GRyneaI1cnyv81tPWh5yX/7VjZa6qIaVBlZsNZMqLZrFeYNUZ
   5eBEla8fls5aljzdRpyuqCJow9ntqPEedKhOeFidbhcFjNxAGCkBAWKSq
   sgn+2X0m07/l7bDaOmWybbWqyCy+yTx2y1XNvd5DsUHPt/rFlFTzvN86/
   F4mHKl9ILo4y7QmzAnkiabF1X5FnAJ/mKfX9KOs+9ayl/7lYtYNjdSyyd
   w==;
X-CSE-ConnectionGUID: QdJSs0FKRZSW5qblBX7WAw==
X-CSE-MsgGUID: dnVArIK9SSCnpx48Jh9zIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2812906"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2812906"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:17 -0800
X-CSE-ConnectionGUID: ugmfq7YLQlugjCOP9EiHyQ==
X-CSE-MsgGUID: lsoT2dwyQru4d4CmkUw/xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9147231"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:57:16 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v7 1/5] Documentation/cxl: Describe region granularity finer than the root
Date: Fri,  6 Nov 2026 13:57:08 -0800
Message-ID: <3523b5a355c77863a52c7b1418230da203d2841c.1794000806.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1794000806.git.alison.schofield@intel.com>
References: <cover.1794000806.git.alison.schofield@intel.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux has required that a region's interleave granularity equal the
interleave granularity of its interleaving root decoder. Upcoming changes
lift that restriction for one configuration: a region granularity finer
than the root's, provided granularity refines monotonically from the root
toward the endpoints.

That support introduces interleave relationships that are not obvious
from the existing CXL documentation. This is particularly true for the 3-,
6-, and 12-way configurations and for understanding which configurations
permitted by the CXL Specification are supported by Linux.

Document which region granularities Linux supports relative to the root,
and the monotonic refinement model for a region finer than the root.
Include the relevant configurations from CXL 4.0 Section 9.13.1.1 and
annotate their Linux support status.

This intentionally repeats information from the CXL Specification. The
specification remains authoritative, but showing the Linux support policy
alongside the legal configurations ensures readers do not mistake an
unsupported Linux setup for a configuration unsupported by the CXL
Specification.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index 212df4fb8d63..fd17ea5c444f 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -637,6 +637,11 @@ derived from their upstream port connections. In `Cross-Link First` interleave
 configurations, the :code:`interleave_granularity` of a decoder is equal to
 :code:`parent_interleave_granularity * parent_interleave_ways`.
 
+When the region granularity is finer than the granularity of an interleaving
+root decoder, the relation inverts: the :code:`interleave_granularity` of a
+decoder is equal to :code:`parent_interleave_granularity / interleave_ways`.
+See `Finer-Than-Root Region Granularity`_.
+
 At Endpoint
 ~~~~~~~~~~~
 `Endpoint Decoders` are programmed similar to Host Bridge and Switch decoders,
@@ -654,6 +659,120 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
 Linux does not support unbalanced interleave configurations.  As a result, all
 endpoints in an interleave set must have the same ways and granularity.
 
+Finer-Than-Root Region Granularity
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The CXL Specification permits each decoder in a region's hierarchy to interleave
+at its own granularity, see CXL 4.0 Section 9.13.1.  Linux supports a subset of
+those configurations, defined by how the region's :code:`interleave_granularity`
+compares with the granularity of its interleaving root decoder:
+
+- Equal: granularity stays the same or coarsens at each level toward the
+  endpoints, as in `Cross-Link First`.
+- Finer: granularity stays the same or refines at each level toward the
+  endpoints.  This requires an interleaving root decoder.
+- Coarser: not supported.
+
+In both supported cases granularity changes monotonically across the decoders
+that route a request: the interleaving root, the host bridge, and any switches.
+Configurations whose granularity refines and then coarsens along that path are
+legal per the CXL Specification but are not supported by Linux.  The endpoint
+decoder is not part of that path.  It carries the region ways and granularity so
+that it can translate, as `At Endpoint`_ describes above.
+
+When the region granularity is finer than the root granularity, Linux programs
+each level below the root at its parent's granularity divided by its own ways,
+so granularity refines monotonically and the ordering follows from the region
+and root settings.  Reaching a fine granularity as early as possible remains
+available through `Cross-Link First`.  For an 8-way region at 1024 below a 2-way
+interleaving root decoder at 4096, where each host bridge interleaves across two
+root ports and each root port hosts a 2-way switch, Linux programs::
+
+  Level             Ways    Granularity
+  -----             ----    -----------
+  Root                 2         4096
+  Host bridge          2         2048
+  Switch               2         1024
+  Endpoint             8         1024
+
+An endpoint's *region position* is the interleave position that address
+translation applies at the region granularity: it is combined with a DPA to form
+the HPA, and removed from an HPA to recover the DPA.  It is also the index of
+the endpoint's region-granularity chunk within one full pass of the region
+interleave.  Each decoder level contributes the index of the target it routes
+the endpoint through, weighted by its granularity in region-granularity units::
+
+  position += target_position *
+              (decoder_granularity / region_granularity)
+
+That multiplier is the *weight* of a level: how many region positions pass
+between successive advances of its target index.  In the example above the root
+selects a host bridge every 4096 bytes, so it advances one target every four
+region positions, weight 4, while the switch advances one target every position,
+weight 1.  When granularity refines toward the endpoints, a level's weight is
+the product of the ways of the interleaving levels below it.  When it coarsens,
+as in `Cross-Link First`, the weight is the product of the ways of the levels
+above it, so the root has weight 1.
+
+The *region granularity* is the region's :code:`interleave_granularity`, the
+granularity at which its endpoints translate.  A region finer than the root
+must describe the same interleave *span* as the root decoder, the address range
+in which the interleave pattern completes one full pass::
+
+  root_ways * root_granularity == region_ways * region_granularity
+
+Linux rejects a region that does not describe that span.  A same-granularity
+region below a power-of-two root decoder is exempt: it may be wider than the
+root and repeat the root targets, so its span is a multiple of the root's.
+
+Mod3 Interleave Configurations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+A 3-way, 6-way, or 12-way interleave, known as a Mod3 interleave, selects its
+target modulo 3 rather than from binary interleave selector bits alone, see CXL
+4.0 Section 9.13.1.1.  The cross-host bridge selection carries the factor of
+three, and any remaining x2 or x4 is binary interleave selection below it.  A
+6-way region at IGB across three host bridges is therefore a 3-way root
+interleave at 2*IGB with a 2-way interleave at IGB below it, both describing the
+same span::
+
+  3 * (2 * IGB) == 6 * IGB
+
+CXL 4.0 Section 9.13.1.1, Tables 9-6, 9-7, and 9-8, list the legal compositions
+for a 12-way, 6-way, and 3-way device-level interleave at IGB.  The
+specification is normative.  The tables are summarized below, annotated with the
+subset Linux supports.
+
+CXL 4.0 Table 9-8, 3-way device-level interleave at IGB::
+
+  Row  Cross-host bridge  Host bridge    Switch         Linux
+  ---  -----------------  -----------    ------         -----
+   1   3-way @ IGB        none           none           supported
+
+CXL 4.0 Table 9-7, 6-way device-level interleave at IGB::
+
+  Row  Cross-host bridge  Host bridge    Switch         Linux
+  ---  -----------------  -----------    ------         -----
+   1   6-way @ IGB        none           none           supported
+   2   3-way @ 2*IGB      2-way @ IGB    none           supported
+   3   3-way @ 2*IGB      none           2-way @ IGB    supported
+
+CXL 4.0 Table 9-6, 12-way device-level interleave at IGB::
+
+  Row  Cross-host bridge  Host bridge    Switch         Linux
+  ---  -----------------  -----------    ------         -----
+   1   12-way @ IGB       none           none           supported
+   2   6-way @ 2*IGB      2-way @ IGB    none           supported
+   3   6-way @ 2*IGB      none           2-way @ IGB    supported
+   4   3-way @ 4*IGB      4-way @ IGB    none           supported
+   5   3-way @ 4*IGB      none           4-way @ IGB    supported
+   6   3-way @ 4*IGB      2-way @ IGB    2-way @ 2*IGB  unsupported
+   7   3-way @ 4*IGB      2-way @ 2*IGB  2-way @ IGB    supported
+
+Table 9-6 row 6 is legal per the CXL Specification but is unsupported by Linux:
+from the root toward the endpoints its granularity goes 4*IGB -> IGB -> 2*IGB,
+which refines and then coarsens.  Row 7 interleaves the same 12 endpoints at the
+same granularity with those two levels exchanged, 4*IGB -> 2*IGB -> IGB, so a
+12-way device-level interleave across three host bridges remains available.
+
 Example Configurations
 ======================
 .. toctree::
-- 
2.37.3

