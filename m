Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39A7080D
	for <linux-cxl@vger.kernel.org>; Mon, 31 Mar 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743444168; cv=none; b=sBgm/HKrAq+lx++JiwS+I+I/VeLxS56aEQT1KpvK/HVubReDp3wqGsQSduAdfEu+6TJR8L+c1TNc+En25hCT+sQ8YY0IWQlYcjXQYVePjtCtHHov5+yGQGIcnyOqM640CHzSiIwu7saDXTMlE6cUzjr4cf0E4sAf1Ky+E0QmgXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743444168; c=relaxed/simple;
	bh=fJROREDS+JTfnNk+VKxc9J1Vptjf1AzCwyXSAch0Xa8=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=g1+s6d/luiQFQw0nQb2bvllSS6Kzs35njv1z8DrvFrtM6AUJ2BB03raPP6ukrHQw+gEMlYU0R+K2pUeV7hxu1ULu3i0B5/vusmVjc4O9Yke62Nd43bNhK0PoSapvFGe0XNOL1YsWp4vWE86dXBYqvppQRpDeFpTFucuASSStWQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoxGKf7L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoxGKf7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743444166; x=1774980166;
  h=message-id:date:mime-version:cc:from:subject:to:
   content-transfer-encoding;
  bh=fJROREDS+JTfnNk+VKxc9J1Vptjf1AzCwyXSAch0Xa8=;
  b=DoxGKf7L0maPHFvxb948U4tf5jdI9+VMGHsuxN9eSVBPqK2A2OSL/CLf
   52tWloH/wrHgpRhoDvCvNgx5E3V9nJbxub9vcWBVaR1nbnHBhxPrh10hc
   XYYNYZ1RtGOoSDvbkyQZm9AcQdwV5q1EV4TiVGPKehT0QqEufqCGMCWiK
   2fDtVUymcxlXzBnlIuMn50gzQKf/iIQsJEhx+TcodqLzLMLfhLcX6E2lQ
   rKBa+HT3nZxV+R4qdBDx/KkjQja6aIo0RTEMwVKpSUTElNKiGLFMlWKoG
   bWZ/gyL5r/aAmhMtgW3C9smoT8Tu0P/L6rxL0+TuQdv0gpkeJmGRxHcbM
   Q==;
X-CSE-ConnectionGUID: F0zi5sN1RVOxqVb7PFBtxA==
X-CSE-MsgGUID: W7kgmimbS/CNVkVFsTk9IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44629304"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="44629304"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 11:02:44 -0700
X-CSE-ConnectionGUID: VPW7pAlmRMiJd8LaoyNVqw==
X-CSE-MsgGUID: FMqKYMcRRi6NshGVJcsdmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="126384845"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.81]) ([10.125.109.81])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 11:02:39 -0700
Message-ID: <6a5fe8c7-614a-48ea-9f0e-74da972a6589@intel.com>
Date: Mon, 31 Mar 2025 11:02:36 -0700
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
 Alison Schofield <alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 6.15
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.15

...to receive a set of changes for CXL for the 6.15 merge window.

Major additions include
- A series to support Global Persistent Flush (GPF) in order to do dirty
  shutdown accounting for CXL type3 memory devices.

- A series to add firmware first error logging support for CXL protocol errors.
  This includes changes to the ACPI GHES code to process CXL CPER protocol
  errors and trace logging for CXL PCIe port RAS errors. Raphael Wysocki has
  deferred the reviewing of ACPI and RAS changes to Tony Luck. His review tags
  are included with the relevant patches.

- A series to add support for CXL mailbox Features commands that allow
  retrieving info on the device supported Features, retrieving of the Feature
  data and setting of the Feature data. This addition is in preparation for both
  kernel side usage by EDAC to perform tasks such is PPR and memory sparing, and
  supporting of user Feature usages via Firmware Control (fwctl) subsystem. The
  Features info retrieved from a device provide write effects by the device
  which are gated by the fwctl restriction levels based on those effects. Jason
  Gunthorpe has already submitted the accepted PR [1] for fwctl and includes the
  branch that has the CXL fwctl patches included in the CXL PR. Jason mentioned
  a trivial conflict to resolve in his PR.

- A series to support extended linear cache support described by the ACPI HMAT
  table via approved ACPI ECN [2]. The series adds support for enumeration of
  the cache via ACPI and adds support to the CXL driver to retrieve that
  information. An MCE notifier is also added to the CXL driver in order to
  report the aliased address when the cache is present. The current
  implementation involves a 1:1 layout of DRAM and far memory based on CXL
  memory.

A number of significant cleanups and refactoring:
- Cleanup of DPA partition metadata handling in preparation for CXL type2
  device enabling.
- A series that uses guard() to clean up open coded mutex lockings and remove
  gotos for error

And a number of minor cleanups and fixes such as removing unused code, fixing
existing documentation issues, and others...

[1]: https://lore.kernel.org/linux-cxl/Z+F2tcBM1LJpTDF9@nvidia.com/
[2]: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/

---
The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.15

for you to fetch changes up to aae0594a7053c60b82621136257c8b648c67b512:

  cxl/region: Fix the first aliased address miscalculation (2025-03-20 11:28:45 -0700)

----------------------------------------------------------------
cxl for v6.15

- Add support for Global Persistent Flush (GPF)
- Cleanup of DPA partition metadata handling
	- Remove the CXL_DECODER_MIXED enum that's not needed anymore
	- Introduce helpers to access resource and perf meta data
	- Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
	- Make cxl_dpa_alloc() DPA partition number agnostic
	- Remove cxl_decoder_mode
	- Cleanup partition size and perf helpers
- Remove unused CXL partition values
- Add logging support for CXL CPER endpoint and port protocol errors
	- Prefix protocol error struct and function names with cxl_
	- Move protocol error definitions and structures to a common location
	- Remove drivers/firmware/efi/cper_cxl.h to include/linux/cper.h
	- Add support in GHES to process CXL CPER protocol errors
	- Process CXL CPER protocol errors
	- Add trace logging for CXL PCIe port RAS errors
- Remove redundant gp_port init
- Add validation of cxl device serial number
- CXL ABI documentation updates/fixups
- A series that uses guard() to clean up open coded mutex lockings and remove gotos for error
  handling.
- Some followup patches to support dirty shutdown accounting
	- Add helper to retrieve DVSEC offset for dirty shutdown registers
	- Rename cxl_get_dirty_shutdown() to cxl_arm_dirty_shutdown()
	- Add support for dirty shutdown count via sysfs
	- cxl_test support for dirty shutdown
- A series to support CXL mailbox Features commands. Mostly in preparation for CXL EDAC
  code to utilize the Features commands. It's also in preparation for CXL fwctl support
  to utilize the CXL Features. The commands include "Get Supported Features", "Get Feature",
  and "Set Feature".
- A series to support extended linear cache support described by the ACPI HMAT table. The
  addition helps enumerate the cache and also provides additional RAS reporting support for
  configuration with extended linear cache. (and related fixes for the
  series).
- An update to cxl_test to support a 3-way capable CFMWS.
- A documentation fix to remove unused "mixed mode".

----------------------------------------------------------------
Alison Schofield (2):
      cxl/test: Define a CFMWS capable of a 3 way HB interleave
      cxl/region: Quiet some dev_warn()s in extended linear cache setup

Dan Williams (6):
      cxl: Remove the CXL_DECODER_MIXED mistake
      cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
      cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
      cxl: Make cxl_dpa_alloc() DPA partition number agnostic
      cxl: Kill enum cxl_decoder_mode
      cxl: Cleanup partition size and perf helpers

Dave Jiang (15):
      cxl: Refactor user ioctl command path from mds to mailbox
      cxl: Enumerate feature commands
      cxl: Add Get Supported Features command for kernel usage
      cxl/test: Add Get Supported Features mailbox command support
      cxl: Setup exclusive CXL features that are reserved for the kernel
      acpi: numa: Add support to enumerate and store extended linear address mode
      acpi/hmat / cxl: Add extended linear cache support for CXL
      cxl: Add extended linear cache address alias emission for cxl events
      cxl: Add mce notifier to emit aliased address for extended linear cache
      Merge branch 'for-6.15/fw-first-error-logging' into cxl-for-next2
      Merge branch 'for-6.15/guard_cleanups' into cxl-for-next2
      Merge branch 'for-6.15/dirty-shutdown' into cxl-for-next2
      Merge branch 'for-6.15/extended-linear-cache' into cxl-for-next2
      cxl: Fix warning from emitting resource_size_t as long long int on 32bit systems
      Merge branch 'for-6.15/features' into cxl-for-next

Davidlohr Bueso (7):
      cxl: Plug typos in ABI doc
      cxl: Document missing sysfs files
      cxl/pci: Support Global Persistent Flush (GPF)
      cxl/pci: Introduce cxl_gpf_get_dvsec()
      cxl/pmem: Rename cxl_dirty_shutdown_state()
      cxl/pmem: Export dirty shutdown count via sysfs
      tools/testing/cxl: Set Shutdown State support

Ira Weiny (2):
      cxl/memdev: Remove unused partition values
      cxl/Documentation: Remove 'mixed' from sysfs mode doc

Li Ming (10):
      cxl/core: Use guard() to replace open-coded down_read/write()
      cxl/core: cxl_mem_sanitize() cleanup
      cxl/memdev: cxl_memdev_ioctl() cleanup
      cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
      cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
      cxl/region: Drop goto pattern in cxl_dax_region_alloc()
      cxl/region: Drop goto pattern of construct_region()
      cxl/cdat: Remove redundant gp_port initialization
      cxl/mem: Do not return error if CONFIG_CXL_MCE unset
      cxl/region: Fix the first aliased address miscalculation

Shiju Jose (2):
      cxl/mbox: Add GET_FEATURE mailbox command
      cxl/mbox: Add SET_FEATURE mailbox command

Smita Koralahalli (6):
      efi/cper, cxl: Prefix protocol error struct and function names with cxl_
      efi/cper, cxl: Make definitions and structures global
      efi/cper, cxl: Remove cper_cxl.h
      acpi/ghes, cper: Recognize and cache CXL Protocol errors
      acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors
      cxl/pci: Add trace logging for CXL PCIe Port RAS errors

Yuquan Wang (1):
      cxl/pmem: debug invalid serial number data

 Documentation/ABI/stable/sysfs-devices-node   |   6 +
 Documentation/ABI/testing/sysfs-bus-cxl       |  53 +++-
 Documentation/driver-api/cxl/maturity-map.rst |   2 +-
 arch/x86/mm/pat/set_memory.c                  |   1 +
 drivers/acpi/apei/ghes.c                      | 103 +++++++
 drivers/acpi/numa/hmat.c                      |  44 +++
 drivers/base/node.c                           |   2 +
 drivers/cxl/Kconfig                           |  15 +
 drivers/cxl/core/Makefile                     |   4 +
 drivers/cxl/core/acpi.c                       |  11 +
 drivers/cxl/core/cdat.c                       | 100 +++----
 drivers/cxl/core/core.h                       |  27 +-
 drivers/cxl/core/features.c                   | 333 ++++++++++++++++++++++
 drivers/cxl/core/hdm.c                        | 382 ++++++++++++++++++--------
 drivers/cxl/core/mbox.c                       | 265 +++++++++++-------
 drivers/cxl/core/mce.c                        |  65 +++++
 drivers/cxl/core/mce.h                        |  20 ++
 drivers/cxl/core/memdev.c                     | 105 ++++---
 drivers/cxl/core/pci.c                        |  97 +++++++
 drivers/cxl/core/port.c                       |  38 ++-
 drivers/cxl/core/ras.c                        | 119 ++++++++
 drivers/cxl/core/region.c                     | 338 +++++++++++++++--------
 drivers/cxl/core/trace.h                      |  81 +++++-
 drivers/cxl/cxl.h                             |  52 ++--
 drivers/cxl/cxlmem.h                          | 124 +++++----
 drivers/cxl/cxlpci.h                          |   6 +
 drivers/cxl/mem.c                             |   2 +-
 drivers/cxl/pci.c                             |  11 +-
 drivers/cxl/pmem.c                            |  81 +++++-
 drivers/firmware/efi/cper.c                   |   6 +-
 drivers/firmware/efi/cper_cxl.c               |  39 +--
 drivers/firmware/efi/cper_cxl.h               |  66 -----
 include/cxl/event.h                           | 101 +++++++
 include/cxl/features.h                        | 191 +++++++++++++
 include/cxl/mailbox.h                         |  44 ++-
 include/linux/acpi.h                          |  11 +
 include/linux/cper.h                          |   8 +
 include/linux/node.h                          |   7 +
 tools/testing/cxl/Kbuild                      |   4 +
 tools/testing/cxl/test/cxl.c                  |  32 +--
 tools/testing/cxl/test/mem.c                  | 106 ++++++-
 41 files changed, 2417 insertions(+), 685 deletions(-)
 create mode 100644 drivers/cxl/core/acpi.c
 create mode 100644 drivers/cxl/core/features.c
 create mode 100644 drivers/cxl/core/mce.c
 create mode 100644 drivers/cxl/core/mce.h
 create mode 100644 drivers/cxl/core/ras.c
 delete mode 100644 drivers/firmware/efi/cper_cxl.h
 create mode 100644 include/cxl/features.h
