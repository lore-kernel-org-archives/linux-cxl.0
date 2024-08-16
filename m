Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B0A1BBBF9;
	Fri, 16 Aug 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817299; cv=none; b=YYaltrVt1Z2ifQsgjkmI2lEh1cHFVbnFInWhGDEfvWnxjwSZ89+zexeMMmxPmEubrvDjdyV76j26rdJ0E8sjD3QXJRMliRTN0Vv4wgjJQ5j9VF20DxTSThK5oZq4z53M1g1pfuV3wRinLAcoA1tw3coawWbcFV23tJm8Zo84cmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817299; c=relaxed/simple;
	bh=A5E1QO0Muv9CKMLT/sotcOqRhE+vFwm9Hd7FndpNHeo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N6BoQOZUyJka1fvmzfEw/40BbvzB68q1S0b2JcqgiAmveQsa6I+JZTLq9gm3qMTYgxP7DvfzJprZmDYr2nXHdyyFyYe98FRg04pcNn/EIl/5CzdEbi7KWudsR6E6mEVJ6KYmz+O4We9KbGifTxS9GHml8Iec3s4XmI7l78N+akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hg5go46G; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hg5go46G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817297; x=1755353297;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=A5E1QO0Muv9CKMLT/sotcOqRhE+vFwm9Hd7FndpNHeo=;
  b=Hg5go46G+63mX0zGQRolC3iUgVe48RcQmi/S4aebhZEm55DzWO3nOXv7
   6V80Msu2NrdKR9W2FU+eukGVndoNAo43kDe7GeJZb4WDiQNXl70v97dbn
   K5fKNZGRMmRgNyLE+6l4HorEXKcqWVH1uOwgE+kF7cUXW9evAcOEYVvDr
   76uldGtxUD4ofnPntfczjNfjtvuh+MIhl5gYfMWczvJO5kEpgcMjLI99c
   sBWk+JVfkn0dFa4StPVXRD1SObY9mnouLolILty5QiYVrt0EI8eJnyX6W
   nCe+a342VckOcd7XDB5m1BdL7+E92mNNhhtvo7NBqCrIsotGu4ka1e4Le
   Q==;
X-CSE-ConnectionGUID: mLmzxcOGT12P/bGW3DtFOQ==
X-CSE-MsgGUID: WmLoXRnDSLaiuaF6XpphRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260869"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260869"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:12 -0700
X-CSE-ConnectionGUID: cwlhtwqjRNCRNt8odLjERg==
X-CSE-MsgGUID: nllQUs4uTFawvzIpMIAQ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847752"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:11 -0700
From: Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH RESEND v2 00/18] DCD: Add support for Dynamic Capacity
 Devices (DCD)
Date: Fri, 16 Aug 2024 09:08:05 -0500
Message-Id: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=5925;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=A5E1QO0Muv9CKMLT/sotcOqRhE+vFwm9Hd7FndpNHeo=;
 b=65BEVxppegT9lwtVWazBHQB/7kmpqfIuLfGaTvom4Q3q5RhkMWlrrunhWuOvUquii5Mh4tGxT
 P5XUILrD52FDVebScDDrxOaFKvb4ACKptZkwCcY5ylmuDHRAAkpQJjk
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

A Dynamic Capacity Device (DCD) (CXL 3.0 spec 9.13.3) is a CXL memory
device that implements dynamic capacity.  Dynamic capacity feature
allows memory capacity to change dynamically, without the need for
resetting the device.

Even though this is marked v2 by b4, this is effectively a whole new
series for DCD support.  Quite a bit of the core support was completed
by Navneet in [4].  However, the architecture through the CXL region,
DAX region, and DAX Device layers is completely different.  Particular
attention was paid to:

	1) managing skip resources in the hardware device
	2) ensuring the host OS only sent a release memory mailbox
	   response when all DAX devices are done using an extent
	3) allowing dax devices to span extents
	4) allowing dax devices to use parts of extents

I could say all of the review comments from v1 are addressed but frankly
the series has changed so much that I can't guarantee anything.

The series continues to be based on the type-2 work posted from Dan.[2]
However, my branch with that work is a bit dated.  Therefore I have
posted this series on github here.[5]

Testing was sped up with cxl-test and ndctl dcd support.  A preview of
that work is on github.[6]  In addition Fan Ni's Qemu DCD series was
used part of the time.[3]

The major parts of this series are:

- Get the dynamic capacity (DC) region information from cxl device
- Configure device DC regions reported by hardware
- Enhance CXL and DAX regions for DC
	a. maintain separation between the hardware extents and the CXL
	   region extents to provide for the addition of interleaving in
	   the future.
- Get and maintain the hardware extent lists for each device via an
  initial extent list and DC event records
        a. Add capacity Events
	b. Add capacity response
	b. Release capacity events
	d. Release capacity response
- Notify region layers of extent changes
- Allow for DAX devices to be created on extents which are surfaced
- Maintain references on extents which are in use
	a. Send Release capacity Response only when DAX devices are not
	   using memory
- Allow DAX region extent labels to change to allow for flexibility in
  DAX device creation in the future (further enhancements are required
  to ndctl for this)
- Trace Dynamic Capacity events
- Add cxl-test infrastructure to allow for faster unit testing

To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1] https://lore.kernel.org/all/64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch/
[2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
[3] https://lore.kernel.org/all/6483946e8152f_f1132294a2@iweiny-mobl.notmuch/
[4] https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com
[5] https://github.com/weiny2/linux-kernel/commits/dcd-v2-2023-08-28
[6] https://github.com/weiny2/ndctl/tree/dcd-region2

---
Changes in v2:
- iweiny: Complete rework of the entire series
- Link to v1: https://lore.kernel.org/r/20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com

---
Ira Weiny (15):
      cxl/hdm: Debug, use decoder name function
      cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
      cxl/region: Add Dynamic Capacity decoder and region modes
      cxl/port: Add Dynamic Capacity mode support to endpoint decoders
      cxl/port: Add Dynamic Capacity size support to endpoint decoders
      cxl/region: Add Dynamic Capacity CXL region support
      cxl/mem: Read extents on memory device discovery
      cxl/mem: Handle DCD add and release capacity events.
      cxl/region: Expose DC extents on region driver load
      cxl/region: Notify regions of DC changes
      dax/bus: Factor out dev dax resize logic
      dax/region: Support DAX device creation on dynamic DAX regions
      tools/testing/cxl: Make event logs dynamic
      tools/testing/cxl: Add DC Regions to mock mem data
      tools/testing/cxl: Add Dynamic Capacity events

Navneet Singh (3):
      cxl/mem: Read Dynamic capacity configuration from the device
      cxl/mem: Expose device dynamic capacity configuration
      cxl/mem: Trace Dynamic capacity Event Record

 Documentation/ABI/testing/sysfs-bus-cxl |  56 ++-
 drivers/cxl/core/core.h                 |   1 +
 drivers/cxl/core/hdm.c                  | 215 ++++++++-
 drivers/cxl/core/mbox.c                 | 646 +++++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               |  77 ++++
 drivers/cxl/core/port.c                 |  19 +
 drivers/cxl/core/region.c               | 418 +++++++++++++++--
 drivers/cxl/core/trace.h                |  65 +++
 drivers/cxl/cxl.h                       |  99 +++-
 drivers/cxl/cxlmem.h                    | 138 +++++-
 drivers/cxl/mem.c                       |  50 ++
 drivers/cxl/pci.c                       |   8 +
 drivers/dax/Makefile                    |   1 +
 drivers/dax/bus.c                       | 263 ++++++++---
 drivers/dax/bus.h                       |   1 +
 drivers/dax/cxl.c                       | 213 ++++++++-
 drivers/dax/dax-private.h               |  61 +++
 drivers/dax/extent.c                    | 133 ++++++
 tools/testing/cxl/test/mem.c            | 782 +++++++++++++++++++++++++++-----
 19 files changed, 3005 insertions(+), 241 deletions(-)
---
base-commit: c76cce37fb6f3796e8e146677ba98d3cca30a488
change-id: 20230604-dcd-type2-upstream-0cd15f6216fd

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>

