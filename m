Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF2379C40;
	Mon, 17 Aug 2026 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786989361; cv=none; b=TL9oDPnqEYT/VCxFRxlAl5fhRaaEWyfsCDs2rDXpB/YDbr39QgP1SmiP4IfvGgYkRqlb2tKM2oaeXVgQHHFvNAe0zAYaL4wVdLiH7yfJkJqVcLFJwN5g43MwrQ0Fu6eM8e3Era3akD7OfCjV+l0cOEWH9bYsU9+l8D8ix5LtrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786989361; c=relaxed/simple;
	bh=ybaS+/SE85/f1DWpiC5a+ti3mEyrrLTr9OmUU3qflTQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=auDqdMn+2624oYqIoCCjerJZr//DKeQci+IZ5J1+/MayCCY8meN2wL2IzMH36DsH7AQcxTi8qmUdzklMumoDhTLLXJpy0JcgOzoATuis3DbT0cb4SOG9oRN4lW+8wsB0Ksaw0jOIF9IP6z2u5YJvnZngWMnBTDoEjAO8u5IoEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X/0WIMzb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/0WIMzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786989360; x=1818525360;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=ybaS+/SE85/f1DWpiC5a+ti3mEyrrLTr9OmUU3qflTQ=;
  b=X/0WIMzbQOGwQMPcY/4ZZf18szupPHDc6uhpOkmxm617RZtkiugJ6k8C
   O5D03hnvllykPq51jjCecDWikCwPILepDwCA72PWET2R2H54ZViYeqcRZ
   mQGfWn9jzeLTFFSAjS4ID2gX5bWxNRUKJFqMI/9ZxTtTnL/xgUzwsyWIa
   Ld3trWUGXjG0LYr3cEfIqNtVdbvD9BeqmQuJ4dVNV+VAj9D06dXQmYNnq
   3V1ptw/npE8g1mf6/XBbP5dvKxC3af6u+VDGYtpUTNPuQADdTaWs8W9qN
   97JP9ZSRdEBPUMVTTCqlpkdd22zD0Nfqh0KOZGaIr8YBxqyUm6+DNIiRd
   Q==;
X-CSE-ConnectionGUID: dZhZKSQVQUKDcc4fN9KH7w==
X-CSE-MsgGUID: OSYVZ+y4Tzaxl0jk6soO8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87326456"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="87326456"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 10:56:00 -0700
X-CSE-ConnectionGUID: vgshiJFSSwieKAVaF4FuVw==
X-CSE-MsgGUID: 5SIrfonHQeOQLKFhshypxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="268472023"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.160]) ([10.125.111.160])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 10:55:58 -0700
Message-ID: <fc9dcf76-4825-4152-9f5d-072270bf3b87@intel.com>
Date: Mon, 17 Aug 2026 10:55:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
Subject: [GIT PULL] Compute Express Link (CXL) changes for 7.3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.3

...to receive a series of changes for CXL. The changes include the remaining patches to complete the basic support for CXL type2 (accelerators) drivers by the CXL core. A set of unit testing support to catch regressions for the CXL core type2 exported functions has also been added. The actual CXL type 2 driver support for the AMD Solarflare NIC driver has been picked up by net-dev.

A set of preparatory patches has been picked up from the CXL port error handling series in order to reduce the number of patches in that series for review. The rest of that series is getting close to be merged but was not ready for the 7.3 merge window.

There are also a number of misc patches and a large number of bug fixes against pre-existing issues flagged by sashiko reviews as contributors post new patches on the mailing list. We will continue to work through the sashiko raised issues as they show up.

These have all appeared in -next for a week or more with no reported issues.

---

The following changes since commit 1590cf0329716306e948a8fc29f1d3ee87d3989f:

  Linux 7.2-rc4 (2026-07-19 13:54:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.3

for you to fetch changes up to 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07:

  Merge branch 'for-7.3/cxl-misc' into cxl-for-next (2026-08-06 10:14:29 -0700)

----------------------------------------------------------------
CXL for v7.3

CXL core type2 support:
cxl: Support dpa without a mailbox
cxl: Support Type2 cxl regs mapping

CXL test type2 support:
cxl/test: Rework cxl_type2_mem_init() to use cxl_mock_platform_device_add()
cxl/test: Add cxl_test accelerator driver
cxl/test: Fixup hdm init for auto region to support type2
cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
cxl/test: Add hierarchy enumeration support for type2 device
cxl/test: Refactor platform device enumerations
cxl/test: Add type2 support for mock CFMWS0
cxl/test: Add test for module parameters

CXL port error handling support prep patches:
cxl: Rename find_cxl_port() to find_cxl_port_by_dport()
cxl: Tighten CPER kfifo registration API and symbol visibility
acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks
cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read

CXL misc patches:
cxl/Documentation: Spell out globbed sysfs attribute names
cxl/test: Assign one mock memdev a full-width serial number
cxl/core: Format the memdev serial number as unsigned in TP_printk
cxl/pmem: Format the nvdimm serial number as unsigned decimal
cxl: Use %pe to print error pointers
cxl: Deny Features commands on the RAW mailbox path

CXL fixes:
cxl/region: Use __free(put_device) in find_pos_and_ways()
cxl/region: Fix use-after-free in find_pos_and_ways() error path
cxl/features: Clamp Get Feature output size to the remaining buffer
cxl/features: Reject Set Features output buffer smaller than the header
cxl/features: Reject Get Feature count larger than the output buffer
cxl/port: Restart port enumeration when a sibling adds the dport first
cxl/features: Serialize multi-part Get/Set Feature transfers
cxl/pci: Honor -EPROBE_DEFER from component register setup
cxl/mbox: Break poison list loop on an empty payload
cxl/memdev: Fix firmware upload exact-fit handling
cxl/features: bound fwctl command payload to the input buffer
cxl/mce: Make the MCE notifier per-region
cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()
cxl: docs/linux/dax-driver - fix typos
cxl: fix mailbox return code description typo
cxl/mbox: Clamp mailbox output allocation to the payload size

----------------------------------------------------------------
Alejandro Lucero (2):
      cxl: Support Type2 cxl regs mapping
      cxl: Support dpa without a mailbox

Alison Schofield (7):
      cxl/port: Restart port enumeration when a sibling adds the dport first
      cxl/region: Fix use-after-free in find_pos_and_ways() error path
      cxl/region: Use __free(put_device) in find_pos_and_ways()
      cxl/pmem: Format the nvdimm serial number as unsigned decimal
      cxl/core: Format the memdev serial number as unsigned in TP_printk
      cxl/test: Assign one mock memdev a full-width serial number
      cxl/Documentation: Spell out globbed sysfs attribute names

Dan Williams (2):
      cxl: Tighten CPER kfifo registration API and symbol visibility
      cxl: Rename find_cxl_port() to find_cxl_port_by_dport()

Dave Jiang (21):
      cxl/mce: Make the MCE notifier per-region
      cxl/test: Add test for module parameters
      cxl/test: Add type2 support for mock CFMWS0
      cxl/test: Refactor platform device enumerations
      cxl/test: Add hierarchy enumeration support for type2 device
      cxl/test: Propagate -ENOMEM on platform_device_alloc() failures
      cxl/test: Fixup hdm init for auto region to support type2
      cxl/test: Add cxl_test accelerator driver
      cxl/mbox: Break poison list loop on an empty payload
      cxl/pci: Honor -EPROBE_DEFER from component register setup
      cxl/features: Serialize multi-part Get/Set Feature transfers
      cxl: Deny Features commands on the RAW mailbox path
      Merge branch 'for-7.3/cxl-type2-support' into cxl-for-next
      Merge branch 'for-7.3/cxl-type2-test' into cxl-for-next
      Merge branch 'for-7.3/cxl-misc' into cxl-for-next
      Merge branch 'for-7.3/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.3/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.3/cxl-misc' into cxl-for-next
      Merge branch 'for-7.3/cxl-misc' into cxl-for-next
      Merge branch 'for-7.3/cxl-port-err-prep' into cxl-for-next
      Merge branch 'for-7.3/cxl-misc' into cxl-for-next

Guzebing (1):
      cxl/memdev: Fix firmware upload exact-fit handling

Li Ming (1):
      cxl/test: Rework cxl_type2_mem_init() to use cxl_mock_platform_device_add()

Richard Cheng (4):
      cxl/mbox: Clamp mailbox output allocation to the payload size
      cxl/features: Reject Get Feature count larger than the output buffer
      cxl/features: Reject Set Features output buffer smaller than the header
      cxl/features: Clamp Get Feature output size to the remaining buffer

Shaikh Kamaluddin (1):
      cxl: Use %pe to print error pointers

Terry Bowman (3):
      cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER register read
      cxl/ras: Fix cxl_rch_get_aer_severity() wrong severity register
      acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

Wei Hou (1):
      cxl/pci: Remove incorrect mbox.valid check in cxl_pci_type3_init_mailbox()

Yousef Alhouseen (1):
      cxl: fix mailbox return code description typo

Zenghui Yu (1):
      cxl: docs/linux/dax-driver - fix typos

Zhenhao Wan (1):
      cxl/features: bound fwctl command payload to the input buffer

 Documentation/ABI/testing/sysfs-bus-cxl           |  15 +-
 Documentation/ABI/testing/sysfs-bus-nvdimm        |   3 +-
 Documentation/driver-api/cxl/linux/dax-driver.rst |   4 +-
 drivers/acpi/apei/ghes.c                          |  66 +-
 drivers/cxl/core/core.h                           |   9 +-
 drivers/cxl/core/features.c                       |  23 +-
 drivers/cxl/core/mbox.c                           |  78 +-
 drivers/cxl/core/mce.c                            |  27 +-
 drivers/cxl/core/memdev.c                         |  69 +-
 drivers/cxl/core/pci.c                            |   1 +
 drivers/cxl/core/pmem.c                           |  10 +-
 drivers/cxl/core/port.c                           |  44 +-
 drivers/cxl/core/ras.c                            |   7 +-
 drivers/cxl/core/ras_rch.c                        |  27 +-
 drivers/cxl/core/region.c                         |  61 +-
 drivers/cxl/core/regs.c                           |   1 +
 drivers/cxl/core/trace.h                          |  10 +-
 drivers/cxl/cxl.h                                 |  11 +-
 drivers/cxl/cxlmem.h                              |   4 +-
 drivers/cxl/cxlpci.h                              |  12 -
 drivers/cxl/pci.c                                 |  15 +-
 drivers/cxl/pmem.c                                |   2 +-
 include/cxl/cxl.h                                 |   2 +
 include/cxl/event.h                               |  21 +-
 include/cxl/mailbox.h                             |   2 +
 include/cxl/pci.h                                 |  22 +
 tools/testing/cxl/test/Kbuild                     |   2 +
 tools/testing/cxl/test/accel.c                    |  66 ++
 tools/testing/cxl/test/cxl.c                      | 835 ++++++++++++++++------
 tools/testing/cxl/test/hmem_test.c                |   3 +-
 tools/testing/cxl/test/mem.c                      |  15 +-
 tools/testing/cxl/test/mock.h                     |   2 +
 32 files changed, 1022 insertions(+), 447 deletions(-)
 create mode 100644 include/cxl/pci.h
 create mode 100644 tools/testing/cxl/test/accel.c
