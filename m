Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE932E6CD0
	for <linux-cxl@vger.kernel.org>; Thu, 12 Feb 2026 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935031; cv=none; b=gf6qVQyrnylBh5Lb1fIasbUZ7EOBsKqsYuVzy79pt5jdT1ZzR562MPASZKLSTU3IdVLxZJvxYpdzGibfst0dkUBpNhnypIfXqvcMbaANaYjfCZV+rsexQk1oiDQ7cy8kZfeN7nctcuktWUfYqvy97/fP7xOaMmvIcea8MOyQ4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935031; c=relaxed/simple;
	bh=3pe2lXq+OsQThJZsB0tXLVGGIMomY7KPAFKXUjdSSwU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GZMlgjxH2bc1CvVFjB8BnxGJsEWjDx/2T+y7Ai4Lk0yIdFaz/sOspZGtkvl5zHEFyFWJjbJaX/bGnr8p4QmMsYlWzDL4WSbOhP6llwBA2AYjG1sPuG4RicexNCFNmrnJtnF5Oou16QO0DY0RdJTDEHgUCyundKFqXx2ASs6sB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfyA6hU+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfyA6hU+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770935029; x=1802471029;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=3pe2lXq+OsQThJZsB0tXLVGGIMomY7KPAFKXUjdSSwU=;
  b=lfyA6hU+kFtPI4ybwNwB6xUID+QGqo+WRuvZmu30S3cctAYdCOcWKFxJ
   689U/bHpF/2RYqHSNk1GsMl0RAgsfvqj4haAQyyOFfFWA5VXFyj7vbpyK
   Zn/8Mp5kNTktQzAttiPEZYKKY8YmC9WaDW9DHZSRaUPRbL9HCZwdlxxxT
   HrfR+seNA3z6UrLL9NpAZknPEOCUDYY+/f3Jd5mdA780MREQ6V2FCAXHz
   RlXWJMZGr9/gaDOtd1tZJbpfTA/+Xr2wrtvmR9MHDXcqCm6SzAbYVzEJs
   4GN0XkinSnkFft+FH88dIkny/8lc6rRpz45sLPJBXwZZ5+46BMNCoyXnH
   A==;
X-CSE-ConnectionGUID: Newsg9UwTJKR9xg5Wu+4NA==
X-CSE-MsgGUID: eR2UQswlQZmrW7S5gXPsqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="72025843"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="72025843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:23:48 -0800
X-CSE-ConnectionGUID: G0RVxuUlQi+4g3Dko5wbZg==
X-CSE-MsgGUID: e+1gWhV9S+y+qnfteC+YLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="216888158"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.204]) ([10.125.108.204])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 14:23:48 -0800
Message-ID: <a7496d42-eb0a-412e-b5c7-66b45f9e5258@intel.com>
Date: Thu, 12 Feb 2026 15:23:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 7.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.0

...to receive a collection of CXL changes. 

There is a merge conflict that has been resolved [1] by the -next tree and I
agree with the resolution. I also did a test merge [2] of cxl/next with
upstream.

Main changes in this pull request includes a set of patches that are going
ahead to prepare for CXL type2 accelerator enabling series and Soft
Reserved labeled memory handling series for CXL that are aimed for the next
kernel merge window, part of a set of patches to enable CXL port error handling
through PCIe AER that is aiming to be wrapped up in the next kernel merge window,
a series to enable AMD Zen5 platform address translation for CXL, and a small
number of updates and fixes for the CXL subsystem. The patches touching the PCI
sub-system have ACKs from Bjorn.

These all have appeared in -next for about a week with no reported issues.

[1]: https://lore.kernel.org/linux-next/aWo3Xj3WU6Rqav5m@sirena.org.uk/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/?h=7.0-merge-test

---

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.0

for you to fetch changes up to 63fbf275fa9f18f7020fb8acf54fa107e51d0f23:

  Merge branch 'for-7.0/cxl-prm-translation' into cxl-for-next (2026-02-04 10:53:33 -0700)

----------------------------------------------------------------
cxl changes for v7.0

- A set of commits that introduces cxl_memdev_attach and pave way for
  soft reserved handling, type2 accelerator enabling, and LSA 2.0
  enabling. All these series require the endpoint driver to settle
  before continuing the memdev driver probe.

dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is ready
cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation
cxl/mem: Drop @host argument to devm_cxl_add_memdev()
cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
cxl/port: Arrange for always synchronous endpoint attach
cxl/mem: Arrange for always-synchronous memdev attach
cxl/mem: Fix devm_cxl_memdev_edac_release() confusion

- A set to address CXL port error protocol handling and reporting. The
  large patch series was split into 3 parts. Part 1 and 2 are included
  here with part 3 coming later. Part 1 consists of a series of code
  refactoring to PCI AER sub-system that addresses CXL and also CXL
  RAS code to prepare for port error handling. Part 2 refactors the
  CXL code to move management of component registers to cxl_port
  objects to allow all CXL AER errors to be handled through the
  cxl_port hierarchy.

Part 2:
cxl/port: Move endpoint component register management to cxl_port
cxl/port: Map Port RAS registers
cxl/port: Move dport RAS setup to dport add time
cxl/port: Move dport probe operations to a driver event
cxl/port: Move decoder setup before dport creation
cxl/port: Cleanup dport removal with a devres group
cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition

Part 1:
cxl: Update RAS handler interfaces to also support CXL Ports
cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
PCI/AER: Update struct aer_err_info with kernel-doc formatting
PCI/AER: Report CXL or PCIe bus type in AER trace logging
PCI/AER: Use guard() in cxl_rch_handle_error_iter()
PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
PCI/AER: Export pci_aer_unmask_internal_errors()
cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c
PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
cxl/pci: Remove unnecessary CXL RCH handling helper functions
cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
PCI: Introduce pcie_is_cxl()
PCI: Update CXL DVSEC definitions
PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h

- A set of patches to provide AMD Zen5 platform address translation for
  CXL using ACPI PRMT. Set includes a conventions document to explain
  why this is needed and how it's implemented.

cxl: Disable HPA/SPA translation handlers for Normalized Addressing
cxl/region: Factor out code into cxl_region_setup_poison()
cxl/atl: Lock decoders that need address translation
cxl: Enable AMD Zen5 address translation using ACPI PRMT
cxl/acpi: Prepare use of EFI runtime services
cxl: Introduce callback for HPA address ranges translation
cxl/region: Use region data to get the root decoder
cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
cxl/region: Separate region parameter setup and region construction
cxl: Simplify cxl_root_ops allocation and handling
cxl/region: Store HPA range in struct cxl_region
cxl/region: Store root decoder in struct cxl_region
cxl/region: Rename misleading variable name @hpa to @hpa_range
Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
cxl, doc: Moving conventions in separate files
cxl, doc: Remove isonum.txt inclusion

- A set of misc CXL patches of fixes, cleanups, and updates. Including
  CXL address translation for unaligned MOD3 regions.

cxl: Fix premature commit_end increment on decoder commit failure
cxl/region: Use do_div() for 64-bit modulo operation
cxl/region: Translate HPA to DPA and memdev in unaligned regions
cxl/region: Translate DPA->HPA in unaligned MOD3 regions
cxl/core: Fix cxl_dport debugfs EINJ entries
cxl/acpi: Remove cxl_acpi_set_cache_size()
cxl/hdm: Fix newline character in dev_err() messages
cxl/pci: Remove outdated FIXME comment and BUILD_BUG_ON
Documentation/driver-api/cxl: device hotplug section
Documentation/driver-api/cxl: BIOS/EFI expectation update

----------------------------------------------------------------
Alison Schofield (3):
      cxl/region: Translate DPA->HPA in unaligned MOD3 regions
      cxl/region: Translate HPA to DPA and memdev in unaligned regions
      cxl/region: Use do_div() for 64-bit modulo operation

Cheatham, Benjamin (1):
      cxl/core: Fix cxl_dport debugfs EINJ entries

Dan Williams (17):
      cxl/mem: Fix devm_cxl_memdev_edac_release() confusion
      cxl/mem: Arrange for always-synchronous memdev attach
      cxl/port: Arrange for always synchronous endpoint attach
      cxl/mem: Convert devm_cxl_add_memdev() to scope-based-cleanup
      cxl/mem: Drop @host argument to devm_cxl_add_memdev()
      cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation
      dax/hmem, e820, resource: Defer Soft Reserved insertion until hmem is ready
      PCI/AER: Replace PCIEAER_CXL symbol with CXL_RAS
      cxl/mem: Clarify @host for devm_cxl_add_nvdimm()
      cxl/port: Cleanup handling of the nr_dports 0 -> 1 transition
      cxl/port: Reduce number of @dport variables in cxl_port_add_dport()
      cxl/port: Cleanup dport removal with a devres group
      cxl/port: Move decoder setup before dport creation
      cxl/port: Move dport probe operations to a driver event
      cxl/port: Move dport RAS setup to dport add time
      cxl/port: Move endpoint component register management to cxl_port
      cxl/port: Unify endpoint and switch port lookup

Dave Jiang (6):
      cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c
      Merge branch 'for-7.0/cxl-aer-prep' into cxl-for-next
      Merge branch 'for-7.0/cxl-init' into cxl-for-next
      Merge branch 'for-7.0/cxl-misc' into cxl-for-next
      Merge branch 'for-7.0/cxl-aer-prep' into cxl-for-next
      Merge branch 'for-7.0/cxl-prm-translation' into cxl-for-next

Gregory Price (2):
      Documentation/driver-api/cxl: BIOS/EFI expectation update
      Documentation/driver-api/cxl: device hotplug section

Li Ming (1):
      cxl/acpi: Remove cxl_acpi_set_cache_size()

Robert Richter (17):
      cxl/hdm: Fix newline character in dev_err() messages
      cxl, doc: Remove isonum.txt inclusion
      cxl, doc: Moving conventions in separate files
      Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
      cxl/region: Rename misleading variable name @hpa to @hpa_range
      cxl/region: Store root decoder in struct cxl_region
      cxl/region: Store HPA range in struct cxl_region
      cxl: Simplify cxl_root_ops allocation and handling
      cxl/region: Separate region parameter setup and region construction
      cxl/region: Add @hpa_range argument to function cxl_calc_interleave_pos()
      cxl/region: Use region data to get the root decoder
      cxl: Introduce callback for HPA address ranges translation
      cxl/acpi: Prepare use of EFI runtime services
      cxl: Enable AMD Zen5 address translation using ACPI PRMT
      cxl/atl: Lock decoders that need address translation
      cxl/region: Factor out code into cxl_region_setup_poison()
      cxl: Disable HPA/SPA translation handlers for Normalized Addressing

Samasth Norway Ananda (1):
      cxl/pci: Remove outdated FIXME comment and BUILD_BUG_ON

Terry Bowman (15):
      PCI: Move CXL DVSEC definitions into uapi/linux/pci_regs.h
      PCI: Update CXL DVSEC definitions
      PCI: Introduce pcie_is_cxl()
      cxl/pci: Remove unnecessary CXL Endpoint handling helper functions
      cxl/pci: Remove unnecessary CXL RCH handling helper functions
      PCI: Replace cxl_error_is_native() with pcie_aer_is_native()
      cxl/pci: Move CXL driver's RCH error handling into core/ras_rch.c
      PCI/AER: Export pci_aer_unmask_internal_errors()
      PCI/AER: Update is_internal_error() to be non-static is_aer_internal_error()
      PCI/AER: Move CXL RCH error handling to aer_cxl_rch.c
      PCI/AER: Use guard() in cxl_rch_handle_error_iter()
      PCI/AER: Report CXL or PCIe bus type in AER trace logging
      PCI/AER: Update struct aer_err_info with kernel-doc formatting
      cxl: Update RAS handler interfaces to also support CXL Ports
      cxl/port: Map Port RAS registers

Yuxiong Wang (1):
      cxl: Fix premature commit_end increment on decoder commit failure

 Documentation/driver-api/cxl/conventions.rst       | 178 +-------
 .../driver-api/cxl/conventions/cxl-atl.rst         | 304 ++++++++++++++
 .../driver-api/cxl/conventions/cxl-lmh.rst         | 135 ++++++
 .../driver-api/cxl/conventions/template.rst        |  37 ++
 Documentation/driver-api/cxl/index.rst             |   1 +
 .../driver-api/cxl/platform/bios-and-efi.rst       |  23 +
 .../driver-api/cxl/platform/device-hotplug.rst     | 130 ++++++
 arch/x86/kernel/e820.c                             |  15 +-
 drivers/cxl/Kconfig                                |  11 +-
 drivers/cxl/acpi.c                                 |  46 +-
 drivers/cxl/core/Makefile                          |   4 +-
 drivers/cxl/core/atl.c                             | 211 ++++++++++
 drivers/cxl/core/cdat.c                            |   8 +-
 drivers/cxl/core/core.h                            |  40 ++
 drivers/cxl/core/edac.c                            |  64 +--
 drivers/cxl/core/hdm.c                             |  13 +-
 drivers/cxl/core/memdev.c                          | 109 +++--
 drivers/cxl/core/pci.c                             | 384 ++---------------
 drivers/cxl/core/pmem.c                            |  13 +-
 drivers/cxl/core/port.c                            | 183 ++++----
 drivers/cxl/core/ras.c                             | 198 +++++++++
 drivers/cxl/core/ras_rch.c                         | 121 ++++++
 drivers/cxl/core/region.c                          | 464 ++++++++++++++++-----
 drivers/cxl/core/regs.c                            |  14 +-
 drivers/cxl/cxl.h                                  |  80 ++--
 drivers/cxl/cxlmem.h                               |  21 +-
 drivers/cxl/cxlpci.h                               |  75 +---
 drivers/cxl/mem.c                                  |  77 ++--
 drivers/cxl/pci.c                                  |  67 +--
 drivers/cxl/port.c                                 | 162 +++++++
 drivers/dax/hmem/device.c                          |   3 +-
 drivers/dax/hmem/hmem.c                            |   5 +-
 drivers/pci/pci.h                                  |  39 +-
 drivers/pci/pcie/Kconfig                           |   9 -
 drivers/pci/pcie/Makefile                          |   1 +
 drivers/pci/pcie/aer.c                             | 137 +-----
 drivers/pci/pcie/aer_cxl_rch.c                     | 104 +++++
 drivers/pci/pcie/portdrv.h                         |  12 +
 drivers/pci/probe.c                                |  31 ++
 include/linux/aer.h                                |   2 +
 include/linux/ioport.h                             |   5 +
 include/linux/pci.h                                |   6 +
 include/ras/ras_event.h                            |  12 +-
 include/uapi/linux/pci_regs.h                      |  64 ++-
 kernel/resource.c                                  |  87 +++-
 tools/testing/cxl/Kbuild                           |   7 +-
 tools/testing/cxl/cxl_core_exports.c               |  22 -
 tools/testing/cxl/exports.h                        |  13 -
 tools/testing/cxl/test/mem.c                       |   2 +-
 tools/testing/cxl/test/mock.c                      |  36 +-
 50 files changed, 2534 insertions(+), 1251 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-lmh.rst
 create mode 100644 Documentation/driver-api/cxl/conventions/template.rst
 create mode 100644 Documentation/driver-api/cxl/platform/device-hotplug.rst
 create mode 100644 drivers/cxl/core/atl.c
 create mode 100644 drivers/cxl/core/ras_rch.c
 create mode 100644 drivers/pci/pcie/aer_cxl_rch.c
 delete mode 100644 tools/testing/cxl/exports.h
