Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95F7134A8;
	Fri, 22 Nov 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290772; cv=none; b=UotLpo4D3VC33JiVH4boXG0iL0sQfQIG2RVCpBP9f9+qj/h7vLRdInLgB+QGufKZwBoEGn7oY5cPG1LVpM24tWvWRPD1R9pPaWTucxXT+SdYjZcnTE7jjz0d693EDk81lKxETfQilx4oY9QaDCc64bYHqt4TfwKSss2PkbpzUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290772; c=relaxed/simple;
	bh=/nJfmQyJ67nzCNA3z8uStBYy6+t0+JuNtCjhBj64mHQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=N3GTKxL53453Rqyz9xLz9/ZqGb9hfMTi4poT01yip8Gvdq8+qtJZ27KGozGPyVtrChSpj+MBhy9VlF3dke467LW+0a1RLscyXiobuKlKZc1XlffonOTZmTF+LBiDhFmutA92CkIeiXRikysvYrUAKT4unYKMj3oKcPnGQhT8JQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrHNncyg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrHNncyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732290771; x=1763826771;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/nJfmQyJ67nzCNA3z8uStBYy6+t0+JuNtCjhBj64mHQ=;
  b=mrHNncyguheNcpE77fdxuvwOc04qUolUE2uTBoF2aVodoSbV60VaoEv1
   mO+cnADkjedlIyfOBCLomrBVmBf/CbjX27anabAdX6LxMxYvDNR8Nfpwo
   yxIZE078Agy0YXvat7nO306vcbdyhw85kger8s6fKI8TiY4/E4vGEA19m
   Jw5Xl6HtQ/73H27yMPQRWls9sRv2BLfzBObbeZ8AK4U5DdbSoHFI/5RgI
   HQPcuSVPxLRhh3MfgMgl/dV3GZZV/gF1VRc6sdLx3tlCEcI8g9LokoYBb
   g0mJMfOuD8fx3giK6XVm+yMwbTAPVTd+9UqBjrs62G2S1zxS+fyXpBmZc
   A==;
X-CSE-ConnectionGUID: fjB6CCJ5R7qlPAgZupnwWg==
X-CSE-MsgGUID: /HirSHEVRmulXIbtl82j7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="32386555"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="32386555"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:52:50 -0800
X-CSE-ConnectionGUID: RjKzTc2VRHWS4lG3j66D6A==
X-CSE-MsgGUID: lXCeWv6TQ4uySPf0cPE7vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="91408720"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.244.64])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 07:52:45 -0800
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Huang Ying <ying.huang@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>,
	Li Ming <ming4.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] cxl/core: Enable Region creation on x86 with Low Mem Hole
Date: Fri, 22 Nov 2024 16:51:51 +0100
Message-ID: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.46.2
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
Decoder's.

Then detect SPA/HPA misalignment and allow CXL Regions construction and 
attach if and only if the misalignment is due to x86 Low Memory Holes.

- Patch 1/3 changes the calling conventions of three match_*_by_range()
  helpers in preparation of 2/3.
- Patch 2/3 detects x86 LMH and enables CXL Regions construction and
  attach by trimming HPA by SPA.
- Patch 3/3 simulates a LMH for running the CXL tests on patched driver.

Many thanks to Alison, Dan, and Ira for their help and for their reviews
of my RFC on Intel's internal ML.

Fabio M. De Francesco (3):
  cxl/core: Change match_*_by_range() calling convention
  cxl/core: Enable Region creation on x86 with Low Memory Hole
  cxl/test: Simulate an x86 Low Memory Hole for tests

 drivers/cxl/Kconfig          |  5 +++
 drivers/cxl/core/Makefile    |  1 +
 drivers/cxl/core/lmh.c       | 58 ++++++++++++++++++++++++++
 drivers/cxl/core/region.c    | 80 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxl.h            | 32 +++++++++++++++
 tools/testing/cxl/Kbuild     |  1 +
 tools/testing/cxl/test/cxl.c |  4 +-
 7 files changed, 161 insertions(+), 20 deletions(-)
 create mode 100644 drivers/cxl/core/lmh.c

-- 
2.46.2

