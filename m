Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265CB2441A0
	for <linux-cxl@vger.kernel.org>; Tue,  3 Jun 2025 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971527; cv=none; b=RVLKyjsuSev4cTspWCvT5oi+EEyDc9dqbmBgRuptfH44Lq037yciYala6W78LKl1ACpdfFtiveaBgXVh0ZqiIJmYfz6iN7oPbBN534sPtrd90uLUKofUd7MG5MEvDanqVwYUoN1QdLKdb2wk5+CylEJOVkNit2vpsyncC5/gfuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971527; c=relaxed/simple;
	bh=5yCfF5DatZbVqZQ985j5ZNRp+nOsB9yZrNoE2davFlA=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=XpnLdV97BrpEPA301FQyZ2PU1+0K4x/uFgplKvuzekcBv9VQ7hmSPrx9s+qCMtDWF7sXEYneX+pAr/y0MKPYoA8o/KSz/MJoBF4wHvv0EqFop1Atwq8HXLw3gRlBhymSxaXrv0Na5YKaWoHCpu94zsHfeJ3uO7xSYNetks41SBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gq7uPJr7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq7uPJr7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748971525; x=1780507525;
  h=message-id:date:mime-version:cc:from:subject:to:
   content-transfer-encoding;
  bh=5yCfF5DatZbVqZQ985j5ZNRp+nOsB9yZrNoE2davFlA=;
  b=Gq7uPJr7pZMT3eNNF/sME5L08KbLAfwJl7tkB9JM32NTNuB2OJWUUah5
   cRu8hsVXfDEp/BbCVjx0v7tkL0ZopPM4HBiKC3D4ui4QLrkCM6Wnj3696
   htCEsYYNQHHGVUAbb+9hYWURjUzFVHxhlm/5TsBdp7W9dYzKgk9Ikh/30
   ssdrQwUMVD+nt0AmsfKiQ7RJdOkCxbor/pObmcQJn15XEVu2fnSPJrf/+
   7JCAdfUDkSeRT5iXxsSB0vf4U77Dp/ELIL2ASG+9tUZ6io2WQPg6AFk0/
   /CKsKEOzmDiYjtSBzgs15V2ROkuaFeOphquLVkJ5Z4MDxKZ+1dzGB5j54
   g==;
X-CSE-ConnectionGUID: wKDtKNv9Ry6yLGdiW3WjGw==
X-CSE-MsgGUID: XecRhUbORQyK8yzN2i0Psg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="53651734"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="53651734"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:25:25 -0700
X-CSE-ConnectionGUID: dFUFhYvlQOqppmNQgiu3hg==
X-CSE-MsgGUID: eABdop3qSKS+ppd0rgbSAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="144951974"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.110.198]) ([10.125.110.198])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 10:25:23 -0700
Message-ID: <fa4797c7-e7a5-4703-bce3-7c5bfb827234@intel.com>
Date: Tue, 3 Jun 2025 10:25:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 6.16
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.16

...to receive the changes for CXL subsystem.

A series of documentation additions and updates are included in this pull
request. Gregory Price created a detailed set of documentation for the CXL
sub-system explaining the CXL sub-system end to end. Note, that this
documentation did elicit some strong reactions to the state of the CXL
subsystem [1], but it is just documenting what already exists. There is
general agreement that the long term direction of CXL needs to find a
better ABI.

A series to connect CXL to EDAC for RAS features is also included in this pull
request. The EDAC core changes were accepted in the previous kernel. The CXL
changes now light up those EDAC changes for CXL RAS support.

In addition to these two large changes, there are a number of cleanups, fixes,
and refactors to improve the CXL codebase. That includes a large refactor
series from Robert Richter to prepare for AMD Zen5 translate code support.

These have all appeared in -next for a week or more with no reported issues.
 
[1]: https://lore.kernel.org/linux-cxl/aCIjMNooAzKaONod@casper.infradead.org/

---

The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add530e:

  Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.16

for you to fetch changes up to 9f153b7fb5ae45c7d426851f896487927f40e501:

  Merge branch 'for-6.16/cxl-features-ras' into cxl-for-next (2025-05-23 13:26:24 -0700)

----------------------------------------------------------------
CXL changes for v6.16

- Remove always true condition in cxl features code.
- Add verification of CHBS length for CXL 2.0
- Ignore interleave granularity when interleave ways is 1
- Add update addressing mising MODULE_DESCRIPTION for cxl_test
- A series of cleanups/refactor to prep for AMD Zen5 translate code
- Clean %pa debug printk in core/hdm.c
- Documentation updates
  - Update to CXL Maturity Map
  - Fixes to source linking in CXL documentation
  - CXL documentation fixes, spelling corrections
  - A large collection of CXL documentation for the entire CXL subsystem, including
    documentation on CXL related platform and firmware notes
- Remove redundant code of cxlctl_get_supported_features()
- Series to support CXL RAS Features
  - Including "Patrol Scrub Control", "Error Check Scrub", "Performance Maitenance"
    and "Memory Sparing". The series connects CXL to EDAC.

----------------------------------------------------------------
Alison Schofield (3):
      cxl: Sync up the driver-api/cxl documentation
      Documentation: Update the CXL Maturity Map
      cxl/features: Remove the inline specifier from to_cxlfs()

Alok Tiwari (1):
      cxl/Documentation: Fix typo in sysfs write_bandwidth attribute path

Dan Carpenter (1):
      cxl/hdm: Clean up a debug printk

Dave Jiang (8):
      cxl: Remove always true condition for cxlctl_validate_hw_command()
      cxl/test: Address missing MODULE_DESCRIPTION warnings for cxl_test
      Merge branch 'for-6.16/cxl-cleanups' into cxl-for-next
      Merge branch 'for-6.16/cxl-docs' into cxl-for-next
      cxl: docs/platform/cdat reference documentation
      cxl: docs/platform/acpi/srat Add generic target documentation
      cxl: doc/linux/access-coordinates Update access coordinates calculation methods
      Merge branch 'for-6.16/cxl-features-ras' into cxl-for-next

Gregory Price (18):
      cxl: core/region - ignore interleave granularity when ways=1
      cxl: update documentation structure in prep for new docs
      cxl: docs - access-coordinates doc fixups
      cxl: docs/devices - add cxl device and protocol reference
      cxl: docs/platform/bios-and-efi documentation
      cxl: docs/platform/acpi reference documentation
      cxl: docs/platform/example-configs documentation
      cxl: docs/linux - overview
      cxl: docs/linux - early boot configuration
      cxl: docs/linux - add cxl-driver theory of operation
      cxl: docs/linux/cxl-driver - add example configurations
      cxl: docs/linux/dax-driver documentation
      cxl: docs/linux/memory-hotplug
      cxl: docs/allocation/dax
      cxl: docs/allocation/page-allocator
      cxl: docs/allocation/reclaim
      cxl: docs/allocation/hugepages
      cxl: docs - add self-referencing cross-links

Li Ming (1):
      cxl/feature: Remove redundant code of get supported features

Li Zhijian (1):
      cxl/acpi: Verify CHBS length for CXL2.0

Robert Richter (14):
      cxl: Remove else after return
      cxl/pci: Moving code in cxl_hdm_decode_init()
      cxl/pci: Add comments to cxl_hdm_decode_init()
      cxl: Introduce parent_port_of() helper
      cxl/region: Rename function to cxl_port_pick_region_decoder()
      cxl/region: Avoid duplicate call of cxl_port_pick_region_decoder()
      cxl/region: Move find_cxl_root() to cxl_add_to_region()
      cxl/port: Replace put_cxl_root() by a cleanup helper
      cxl/region: Factor out code to find the root decoder
      cxl/region: Factor out code to find a root decoder's region
      cxl/region: Add function to find a port's switch decoder by range
      cxl/region: Add a dev_warn() on registration failure
      cxl/region: Add a dev_err() on missing target list entries
      cxl: Add a dev_dbg() when a decoder was added to a port

Shiju Jose (8):
      EDAC: Update documentation for the CXL memory patrol scrub control feature
      cxl: Update prototype of function get_support_feature_info()
      cxl/edac: Add CXL memory device patrol scrub control feature
      cxl/edac: Add CXL memory device ECS control feature
      cxl/edac: Add support for PERFORM_MAINTENANCE command
      cxl/edac: Support for finding memory operation attributes from the current boot
      cxl/edac: Add CXL memory device memory sparing control feature
      cxl/edac: Add CXL memory device soft PPR control feature

Sumanth Gavini (1):
      docs: ABI: Fix "firwmare" to "firmware"

 Documentation/ABI/testing/sysfs-bus-cxl            |    4 +-
 .../driver-api/cxl/access-coordinates.rst          |   91 -
 Documentation/driver-api/cxl/allocation/dax.rst    |   60 +
 .../driver-api/cxl/allocation/hugepages.rst        |   32 +
 .../driver-api/cxl/allocation/page-allocator.rst   |   85 +
 .../driver-api/cxl/allocation/reclaim.rst          |   51 +
 .../driver-api/cxl/devices/device-types.rst        |  165 ++
 Documentation/driver-api/cxl/index.rst             |   46 +-
 .../driver-api/cxl/linux/access-coordinates.rst    |  178 ++
 Documentation/driver-api/cxl/linux/cxl-driver.rst  |  630 ++++++
 Documentation/driver-api/cxl/linux/dax-driver.rst  |   43 +
 Documentation/driver-api/cxl/linux/early-boot.rst  |  137 ++
 .../linux/example-configurations/hb-interleave.rst |  314 +++
 .../example-configurations/intra-hb-interleave.rst |  291 +++
 .../example-configurations/multi-interleave.rst    |  401 ++++
 .../linux/example-configurations/single-device.rst |  246 +++
 .../driver-api/cxl/linux/memory-hotplug.rst        |   78 +
 Documentation/driver-api/cxl/linux/overview.rst    |  103 +
 Documentation/driver-api/cxl/maturity-map.rst      |    6 +-
 Documentation/driver-api/cxl/platform/acpi.rst     |   76 +
 .../driver-api/cxl/platform/acpi/cedt.rst          |   62 +
 .../driver-api/cxl/platform/acpi/dsdt.rst          |   28 +
 .../driver-api/cxl/platform/acpi/hmat.rst          |   32 +
 .../driver-api/cxl/platform/acpi/slit.rst          |   21 +
 .../driver-api/cxl/platform/acpi/srat.rst          |   71 +
 .../driver-api/cxl/platform/bios-and-efi.rst       |  262 +++
 Documentation/driver-api/cxl/platform/cdat.rst     |  118 ++
 .../driver-api/cxl/platform/example-configs.rst    |   13 +
 .../platform/example-configurations/flexible.rst   |  296 +++
 .../example-configurations/hb-interleave.rst       |  107 +
 .../example-configurations/multi-dev-per-hb.rst    |   90 +
 .../example-configurations/one-dev-per-hb.rst      |  136 ++
 ...{memory-devices.rst => theory-of-operation.rst} |   27 +-
 Documentation/edac/memory_repair.rst               |   31 +
 Documentation/edac/scrub.rst                       |   76 +
 drivers/cxl/Kconfig                                |   71 +
 drivers/cxl/acpi.c                                 |   24 +-
 drivers/cxl/core/Makefile                          |    1 +
 drivers/cxl/core/cdat.c                            |    2 +-
 drivers/cxl/core/core.h                            |    4 +-
 drivers/cxl/core/edac.c                            | 2102 ++++++++++++++++++++
 drivers/cxl/core/features.c                        |   43 +-
 drivers/cxl/core/hdm.c                             |   11 +-
 drivers/cxl/core/mbox.c                            |   11 +-
 drivers/cxl/core/memdev.c                          |    5 +-
 drivers/cxl/core/pci.c                             |   50 +-
 drivers/cxl/core/port.c                            |   23 +-
 drivers/cxl/core/region.c                          |  189 +-
 drivers/cxl/cxl.h                                  |   23 +-
 drivers/cxl/cxlmem.h                               |   30 +
 drivers/cxl/mem.c                                  |    4 +
 drivers/cxl/port.c                                 |   15 +-
 drivers/edac/mem_repair.c                          |    9 +
 include/cxl/features.h                             |    2 +-
 include/linux/edac.h                               |    7 +
 tools/testing/cxl/Kbuild                           |    1 +
 tools/testing/cxl/test/cxl.c                       |    1 +
 tools/testing/cxl/test/mem.c                       |    1 +
 tools/testing/cxl/test/mock.c                      |    1 +
 59 files changed, 6770 insertions(+), 267 deletions(-)
 delete mode 100644 Documentation/driver-api/cxl/access-coordinates.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/dax.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/hugepages.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/page-allocator.rst
 create mode 100644 Documentation/driver-api/cxl/allocation/reclaim.rst
 create mode 100644 Documentation/driver-api/cxl/devices/device-types.rst
 create mode 100644 Documentation/driver-api/cxl/linux/access-coordinates.rst
 create mode 100644 Documentation/driver-api/cxl/linux/cxl-driver.rst
 create mode 100644 Documentation/driver-api/cxl/linux/dax-driver.rst
 create mode 100644 Documentation/driver-api/cxl/linux/early-boot.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/intra-hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/multi-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/linux/example-configurations/single-device.rst
 create mode 100644 Documentation/driver-api/cxl/linux/memory-hotplug.rst
 create mode 100644 Documentation/driver-api/cxl/linux/overview.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/cedt.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/dsdt.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/hmat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/slit.rst
 create mode 100644 Documentation/driver-api/cxl/platform/acpi/srat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/bios-and-efi.rst
 create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configs.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/flexible.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/hb-interleave.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/multi-dev-per-hb.rst
 create mode 100644 Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
 rename Documentation/driver-api/cxl/{memory-devices.rst => theory-of-operation.rst} (95%)
 create mode 100644 drivers/cxl/core/edac.c
