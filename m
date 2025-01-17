Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A717555
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094232; cv=none; b=eCsI9rxrhIGrk4FYipAyjCkgxyfbiK7/vcPDtc1DKZ2CzPHrIyGgWLT56aFSO4CbsmtnX3GxSNm7gqxsFBqGHQvB5e0Od8bdCU5GektcsUtjJ5HbAUzEoKoekLLdYheV48II9fdzTobGaFeig8lFM9GUGaXYYIxljSybHIkHpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094232; c=relaxed/simple;
	bh=+EjjzbdDgSmcl1BY+JiIc0FPDGcuH1NqnqdkWThXOII=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=NBulRElk2BFnfRi12IhfCk2HN6G9R9nALHnTrtgsZWjaS9ld9klRwITq0/lwExqoUq0Bzd6aXBoFa6mpkvKCW5RXmQk7+dT5g3r38Z61eZ7Y4JBdN27ZBxdb/IobdgmzwI7AWZ05j+8CSp1nNgXaVKYuo/kN8PLsEfRDG62F0Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fjNDEn14; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fjNDEn14"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094230; x=1768630230;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+EjjzbdDgSmcl1BY+JiIc0FPDGcuH1NqnqdkWThXOII=;
  b=fjNDEn14xuNCmnAgTylUbu6hGhz093LObVTwDPFLQftoOIiANBOzxJ31
   1LL4gd+f7ostrSIfxYfb2myw+tjml+051s6hYUBOOvREGCtEQDuy7h7s2
   7XO5/T3EgqCKNFrWONoocDx25AeTfZJL9beuJ3MOYiJB3Cw48ELs8cFO8
   kuN61jOhWMJcRJKwEvkgOUkt5oySLrow12eDnaAZ0tK33TKQU59dIOax1
   RYvgcq3nr53KA3r+xCJ0bh8wLgLMY8Q0mKy29fRpT3ZfZDb2meyM3IPJR
   t7ADReR0feJozWFE7+bvCtMy1JBXpBgKNnBSJS61RgMXe9WgWN6RFAaJn
   A==;
X-CSE-ConnectionGUID: nFQUsAVZTfa01MC5EqASLg==
X-CSE-MsgGUID: saeYkH36T+CSkAcSiDvpRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41280262"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="41280262"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:28 -0800
X-CSE-ConnectionGUID: cTfg7tTBTkCZiKzpKaS5jQ==
X-CSE-MsgGUID: J4rBks2pSFGnIp2KbEk6xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="105897990"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.114])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:27 -0800
Subject: [PATCH 0/4] cxl: DPA partition metadata is a mess...
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alejandro Lucero <alucerop@amd.com>, dave.jiang@intel.com
Date: Thu, 16 Jan 2025 22:10:26 -0800
Message-ID: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

As noted in patch3, the pending efforts to add CXL Accelerator (type-2)
device [1], and Dynamic Capacity (DCD) support [2], tripped on the
no-longer-fit-for-purpose design in the CXL subsystem for tracking
device-physical-address (DPA) metadata.

In fact there was no design at all, just a couple of open-coded 'struct
resource' instances for 'ram' and 'pmem' and a pile of explicit code
referencing those resources directly.

See patch3 for more details on the specific problems that caused, and
patch4 for the eyesore reduction of making the DPA allocation algorithm
partition number agnostic.

The motivation with this effort is to make it easier to land the Type-2
and DCD series.

Next on the cleanup list is 'enum cxl_decoder_mode' which has little to
exist after partition info is centralized. That cleanup is left as an
exercise for the DCD series.

This series passes a cxl-test run at every patch.

[1]: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com
[2]: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com

---

Dan Williams (4):
      cxl: Remove the CXL_DECODER_MIXED mistake
      cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
      cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
      cxl: Make cxl_dpa_alloc() DPA partition number agnostic


 drivers/cxl/core/cdat.c      |   63 ++++++-----
 drivers/cxl/core/hdm.c       |  244 +++++++++++++++++++++++++++++++++---------
 drivers/cxl/core/mbox.c      |   84 ++++++--------
 drivers/cxl/core/memdev.c    |   42 ++++---
 drivers/cxl/core/region.c    |   22 +---
 drivers/cxl/cxl.h            |    4 -
 drivers/cxl/cxlmem.h         |   94 ++++++++++++++--
 drivers/cxl/mem.c            |    2 
 drivers/cxl/pci.c            |    7 +
 tools/testing/cxl/test/cxl.c |   22 ++--
 tools/testing/cxl/test/mem.c |    7 +
 11 files changed, 396 insertions(+), 195 deletions(-)

base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
