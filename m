Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E61313E1B
	for <linux-cxl@vger.kernel.org>; Thu, 16 Apr 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776362406; cv=none; b=AZwTYVJnrBLUKZEn1wmjmTpww705vBfs9kBKMBXoKP2569wDuOHXfZjnT2WvIv6oNP4coazLnndiuYBfzdK1Vf6wxiBqhHEpCU6Jvt8BtU/jY8RgGvaLA3hA8JvgpNPzPLVmuav8cDdYfHk+Orps+nvqXBUjIXpISrCvMzGLQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776362406; c=relaxed/simple;
	bh=TNspeMPygPz2lnf8xf52xwwmtQ27Bl5AK1lGdosMLmA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GXZXDtATKxkdnVHtMqxbKXYa/Pyiycq+sw4yOI7VXIIj9Jwill/PslXx6QjLCnTZVl3VbgUHduxicv/+bAbnD2EVKUu38464eraVBWecR3ObsIKYbpQKlltbm2rQoU6Woxo+4hWodqAPqWOwpvm9z1nxeDSO21eRzuZdOOPXQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKqqqftJ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKqqqftJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776362405; x=1807898405;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=TNspeMPygPz2lnf8xf52xwwmtQ27Bl5AK1lGdosMLmA=;
  b=VKqqqftJm0xp13+7H5ksVf59Om7yeq6lmd4oMwYyNntwYKSQ6riTETgU
   ybjbX8X+Bcu+nKUfdSuTe8PHwp/MtQdq1lTHpoPm3gAIsRwnqE0xHh0qf
   CBkNG4sS+EzH26JZxyV+EWalgM70XyXCH9jH9O7xa82LkscgAKwz6HVmJ
   xtoZ3uwdlHGAulANhps6qu7MLu5vmPtmZT3thWUD3FCCpDo+DT3Wttqa7
   zQz/byigg5IRR6PrulGf+WylK0vngOl+VXLuJwXzZ91Zuyp9MGoFAiiCw
   banEg7flRQquRF+fADrJL1J9tdx0e0YAWeTHvmMIAd6reWZKd7my5L/Y+
   g==;
X-CSE-ConnectionGUID: 22nk4XcyQWa7V1IToA0gLw==
X-CSE-MsgGUID: qXXngE8tRgSgzpfENUlY6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88824194"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88824194"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 11:00:04 -0700
X-CSE-ConnectionGUID: 2+HGNAB0SP2/KOc0vwsjhg==
X-CSE-MsgGUID: WqpLhGK7TxqzL10VPz5xfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="268809508"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.139]) ([10.125.110.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 11:00:03 -0700
Message-ID: <a699673d-8bfa-4d5d-9831-6e420ad56280@intel.com>
Date: Thu, 16 Apr 2026 11:00:02 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <djbw@kernel.org>, jic23@kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for Linux 7.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.1

...to receive a collection of CXL changes. The significant change of interest
is the handling of soft reserved memory conflict between CXL and HMEM. In
essence CXL will be the first to claim the soft reserved memory ranges that
belongs to CXL and attempt to enumerate them with best effort. If CXL is not
able to enumerate the ranges it will punt them to HMEM.

There are also MAINTAINERS email changes from Dan Williams and Jonathan Cameron.

These have all appeared in -next for a few days (minus the MAINTAINERS change
from Jonathan that came in last minute) with no reported issues.

---

The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:

  Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.1

for you to fetch changes up to 6c724ce0ec6ed8608917673bbb363b208ce2644c:

  Merge branch 'for-7.1/cxl-misc' into cxl-for-next (2026-04-15 08:16:31 -0700)

----------------------------------------------------------------
CXL changes for v7.1

Misc patches:
tools/testing/cxl: Enable replay of user regions as auto regions
cxl/region: Add a region sysfs interface for region lock status
cxl/core: Check existence of cxl_memdev_state in poison test
cxl: Add endpoint decoder flags clear when PCI reset happens
ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
MAINTAINERS: Update address for Dan Williams
cxl/hdm: Add support for 32 switch decoders
MAINTAINERS: Update Jonathan Cameron's email address

Ensure endppoint complete initialization before usage:
cxl/pci: Check memdev driver binding status in cxl_reset_done()
cxl/pci: Hold memdev lock in cxl_event_trace_record()

Type2 prepatory patches:
cxl/region: Factor out interleave granularity setup
cxl/region: Factor out interleave ways setup
cxl: Make region type based on endpoint type
cxl/pci: Remove redundant cxl_pci_find_port() call
cxl: Move pci generic code from cxl_pci to core/cxl_pci
cxl: export internal structs for external Type2 drivers
cxl: support Type2 when initializing cxl_dev_state

Patch series that deals with soft reserved memory conflict between CXL and HMEM:
tools/testing/cxl: Test dax_hmem takeover of CXL regions
tools/testing/cxl: Simulate auto-assembly failure
dax/hmem: Parent dax_hmem devices
dax/hmem: Fix singleton confusion between dax_hmem_work and hmem devices
dax/hmem: Reduce visibility of dax_cxl coordination symbols
cxl/region: Constify cxl_region_resource_contains()
cxl/region: Limit visibility of cxl_region_contains_resource()
dax/cxl: Fix HMEM dependencies
cxl/region: Fix use-after-free from auto assembly failure
dax/hmem, cxl: Defer and resolve Soft Reserved ownership
cxl/region: Add helper to check Soft Reserved containment by CXL regions
dax: Track all dax_region allocations under a global resource tree
dax/cxl, hmem: Initialize hmem early and defer dax_cxl binding
dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
dax/hmem: Factor HMEM registration into __hmem_register_device()
dax/bus: Use dax_region_put() in alloc_dax_region() error path

Refactor CXL core/region code to make region code more manageable by
splitting out DAX and PMEM code from RAM handling code:
cxl/core: use cleanup.h for devm_cxl_add_dax_region
cxl/core/region: move dax region device logic into region_dax.c
cxl/core/region: move pmem region driver logic into region_pmem.c

----------------------------------------------------------------
Alejandro Lucero (6):
      cxl: support Type2 when initializing cxl_dev_state
      cxl: export internal structs for external Type2 drivers
      cxl: Move pci generic code from cxl_pci to core/cxl_pci
      cxl: Make region type based on endpoint type
      cxl/region: Factor out interleave ways setup
      cxl/region: Factor out interleave granularity setup

Alison Schofield (2):
      cxl/core: Check existence of cxl_memdev_state in poison test
      tools/testing/cxl: Enable replay of user regions as auto regions

Dan Williams (13):
      dax/hmem: Request cxl_acpi and cxl_pci before walking Soft Reserved ranges
      dax/hmem: Gate Soft Reserved deferral on DEV_DAX_CXL
      dax/cxl, hmem: Initialize hmem early and defer dax_cxl binding
      cxl/region: Fix use-after-free from auto assembly failure
      dax/cxl: Fix HMEM dependencies
      cxl/region: Limit visibility of cxl_region_contains_resource()
      cxl/region: Constify cxl_region_resource_contains()
      dax/hmem: Reduce visibility of dax_cxl coordination symbols
      dax/hmem: Fix singleton confusion between dax_hmem_work and hmem devices
      dax/hmem: Parent dax_hmem devices
      tools/testing/cxl: Simulate auto-assembly failure
      tools/testing/cxl: Test dax_hmem takeover of CXL regions
      MAINTAINERS: Update address for Dan Williams

Dave Jiang (9):
      Merge tag 'device_lock_cond_guard-7.1-rc1' into for-7.1/cxl-consolidate-endpoint
      cxl: Add endpoint decoder flags clear when PCI reset happens
      Merge branch 'for-7.1/cxl-consolidate-endpoint' into cxl-for-next
      Merge branch 'for-7.1/cxl-type2-support' into cxl-for-next
      Merge branch 'for-7.1/dax-hmem' into cxl-for-next
      Merge branch 'for-7.1/cxl-region-refactor' into cxl-for-next
      Merge branch 'for-7.1/cxl-misc' into cxl-for-next
      Merge branch 'for-7.1/cxl-misc' into cxl-for-next
      Merge branch 'for-7.1/cxl-misc' into cxl-for-next

Gregory Price (4):
      cxl/pci: Remove redundant cxl_pci_find_port() call
      cxl/core/region: move pmem region driver logic into region_pmem.c
      cxl/core/region: move dax region device logic into region_dax.c
      cxl/core: use cleanup.h for devm_cxl_add_dax_region

Jonathan Cameron (1):
      MAINTAINERS: Update Jonathan Cameron's email address

Kai Huang (1):
      ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on

Li Ming (5):
      driver core: Add conditional guard support for device_lock()
      cxl/pci: Hold memdev lock in cxl_event_trace_record()
      cxl/pci: Check memdev driver binding status in cxl_reset_done()
      cxl/region: Add a region sysfs interface for region lock status
      cxl/hdm: Add support for 32 switch decoders

Smita Koralahalli (5):
      dax/bus: Use dax_region_put() in alloc_dax_region() error path
      dax/hmem: Factor HMEM registration into __hmem_register_device()
      dax: Track all dax_region allocations under a global resource tree
      cxl/region: Add helper to check Soft Reserved containment by CXL regions
      dax/hmem, cxl: Defer and resolve Soft Reserved ownership

 .mailmap                                |   2 +
 Documentation/ABI/testing/sysfs-bus-cxl |  13 +
 MAINTAINERS                             |  26 +-
 drivers/acpi/numa/srat.c                |   7 +-
 drivers/cxl/core/Makefile               |   2 +-
 drivers/cxl/core/core.h                 |   4 +
 drivers/cxl/core/hdm.c                  |   2 +-
 drivers/cxl/core/mbox.c                 |  17 +-
 drivers/cxl/core/memdev.c               |  27 ++
 drivers/cxl/core/pci.c                  |  57 ++++
 drivers/cxl/core/region.c               | 479 +++++++++++---------------------
 drivers/cxl/core/region_dax.c           | 106 +++++++
 drivers/cxl/core/region_pmem.c          | 191 +++++++++++++
 drivers/cxl/core/regs.c                 |   1 -
 drivers/cxl/cxl.h                       | 123 ++------
 drivers/cxl/cxlmem.h                    |  90 +-----
 drivers/cxl/cxlpci.h                    |  13 +
 drivers/cxl/pci.c                       | 103 ++-----
 drivers/dax/Kconfig                     |   4 +
 drivers/dax/Makefile                    |   3 +-
 drivers/dax/bus.c                       |  20 +-
 drivers/dax/bus.h                       |  20 ++
 drivers/dax/cxl.c                       |  28 +-
 drivers/dax/hmem/device.c               |  25 +-
 drivers/dax/hmem/hmem.c                 | 120 ++++++--
 include/cxl/cxl.h                       | 226 +++++++++++++++
 include/linux/device.h                  |   1 +
 tools/testing/cxl/Kbuild                |   9 +-
 tools/testing/cxl/test/Kbuild           |   1 +
 tools/testing/cxl/test/cxl.c            | 449 +++++++++++++++++++++++++++++-
 tools/testing/cxl/test/hmem_test.c      |  47 ++++
 tools/testing/cxl/test/mem.c            |   6 +-
 tools/testing/cxl/test/mock.c           |  50 ++++
 tools/testing/cxl/test/mock.h           |   8 +
 34 files changed, 1626 insertions(+), 654 deletions(-)
 create mode 100644 drivers/cxl/core/region_dax.c
 create mode 100644 drivers/cxl/core/region_pmem.c
 create mode 100644 include/cxl/cxl.h
 create mode 100644 tools/testing/cxl/test/hmem_test.c
