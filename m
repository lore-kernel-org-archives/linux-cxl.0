Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F592701C5;
	Fri,  1 Aug 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754069705; cv=none; b=S5F3HGp/wH3BGrphDS2w4PJGGVzK+DFyK4MMQ/yCLfhhO2sF9ldrKd/5sieO4I4JQDxTDuPHBq3EfokYlXb1cp550S0BAoSWDe4BTuWQqwOV8c0EGnqzW0jOkzQ/f+epTtjFiivNyQw0gAy6dVCuBsbPgHlvBuG6ugtHW/3lB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754069705; c=relaxed/simple;
	bh=XorjTCov3BO+tMM8ilJN1xFvVOk6ZIFxmFEsiv+1Wc8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HyB3E6oh4aK+lkw3pkhayCipwUevZgHpVfQYaF3/ebybD2PZov7NZygVumMIe+2yylZotixbhBBHHaQC5NhkEgl1SjSO1eY9qos/ShedONZAFWYWi0pTytneFjhjLD9V9NgicgKN1tikQg6gxzuiN0xa/XD5NlwPUAjmKu2w12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bh1puHl+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bh1puHl+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754069704; x=1785605704;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=XorjTCov3BO+tMM8ilJN1xFvVOk6ZIFxmFEsiv+1Wc8=;
  b=Bh1puHl+wezZGo79dXZi2/Zvxs4lljdCpa4386DdaMZ9KLnQcPunZ8d1
   xtwynnXJ8QJbFGZ2ADHCdo4SdsaRZBhDqCRSpe+OBCUXOcJ4RK97DQyrL
   YpGtJ2PnoV9ifT87Hri8Hsdchci84ZFYCFWeBeLDcP8B9nwW2A13RdyAA
   3uQ/seXJ9lHmacaToPhm2my/98hM8dt3id8jn90AxzqbUUw93GGUoVUxV
   7ye8PISNXDgT/YOD0TooeEUdKRknVpp/Xb8+LykNWnyK1jCa0UjjJeQXJ
   SeoEVY8DtNyahNJKiv3YQDMXG3cRR+vGj4uevx6Wc/bR4lft+/uaw98c7
   Q==;
X-CSE-ConnectionGUID: rFe1nnfOTnWE/g8yZs6pHw==
X-CSE-MsgGUID: 3UL4R8BRS8mhe1fV5phUVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56356410"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="56356410"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:35:03 -0700
X-CSE-ConnectionGUID: pKD9N90sQt2x2d6uciyGDw==
X-CSE-MsgGUID: ybUHPORoT6SqPOiCVJDQcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; 
   d="scan'208";a="163311726"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.40]) ([10.247.119.40])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2025 10:34:57 -0700
Message-ID: <d354ab06-852a-41ed-b9de-0663e8efce5d@intel.com>
Date: Fri, 1 Aug 2025 10:34:52 -0700
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
 <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 6.17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:
  
git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.17

...to receive a collection of fixes and updates to the CXL subsystem.

The most significant changes in this pull request is the series that introduces
ACQUIRE() and ACQUIRE_ERR() macros to replace conditional locking and ease the
pain points of scoped_cond_guard(). The series also includes follow on changes
that refactor the CXL sub-system to utilize the new macros. There is a known
issue [1] that is observed with W=1 clang build. The issue can be addressed by a
a follow on fix during the 6.17 RC cycles.

The rest have all appeared in linux-next for a week or more with no reported issues.

[1]: https://lore.kernel.org/linux-cxl/aIo18KZpmKuR4hVZ@black.igk.intel.com/

---

The following changes since commit d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af:

  Linux 6.16-rc4 (2025-06-29 13:09:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.17

for you to fetch changes up to f11a5f89910a7ae970fbce4fdc02d86a8ba8570f:

  Documentation/ABI/testing/debugfs-cxl: Add 'cxl' to clear_poison path (2025-07-25 10:26:27 -0700)

----------------------------------------------------------------
cxl for v6.17

- Add documentation template for CXL conventions to document CXL platform quirks
- Replace mutex_lock_io() with mutex_lock() for mailbox
- Add location limit for fake CFMWS range for cxl_test, ARM platform enabling
- CXL documentation typo and clarity fixes
- Use correct format specifier for function cxl_set_ecs_threshold()
- Make cxl_bus_type constant
- Introduce new helper cxl_resource_contains_addr() to check address availability
- Fix wrong DPA checking for PPR operation
- Remove core/acpi.c and CXL core dependency on ACPI
- Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks
  - Add CXL updates utilizing ACQUIRE() macro to remove gotos and improve
    readability
- Add return for the dummy version of cxl_decoder_detach() without CONFIG_CXL_REGION
- CXL events updates for spec r3.2
- Fix return of __cxl_decoder_detach() error path
- CXL debugfs documentation fix

----------------------------------------------------------------
Alison Schofield (2):
      cxl/pci: Replace mutex_lock_io() w mutex_lock() for mailbox access
      Documentation/ABI/testing/debugfs-cxl: Add 'cxl' to clear_poison path

Alok Tiwari (3):
      Documentation: cxl: fix typos and improve clarity in memory-devices.rst
      cxl: docs/devices Fix typos and clarify wording in device-types.rst
      cxl/edac: Use correct format specifier for u32 val

Dan Carpenter (1):
      cxl/region: Fix an ERR_PTR() vs NULL bug

Dan Williams (9):
      Documentation/driver-api/cxl: Introduce conventions.rst
      cxl/mbox: Convert poison list mutex to ACQUIRE()
      cxl/decoder: Move decoder register programming to a helper
      cxl/decoder: Drop pointless locking
      cxl/region: Split commit_store() into __commit() and queue_reset() helpers
      cxl/region: Move ready-to-probe state check to a helper
      cxl/region: Consolidate cxl_decoder_kill_region() and cxl_region_detach()
      cxl: Convert to ACQUIRE() for conditional rwsem locking
      cleanup: Fix documentation build error for ACQUIRE updates

Dave Jiang (2):
      Merge branch 'for-6.17/cxl-acquire' into cxl-for-next
      Merge branch 'for-6.17/cxl-events-updates' into cxl-for-next

Greg Kroah-Hartman (1):
      cxl: make cxl_bus_type constant

Jonathan Cameron (1):
      cxl_test: Limit location for fake CFMWS to mappable range

Li Ming (3):
      cxl/core: Introduce a new helper cxl_resource_contains_addr()
      cxl/edac: Fix wrong dpa checking for PPR operation
      cxl/core: Using cxl_resource_contains_addr() to check address availability

Li Zhijian (1):
      cxl: Fix -Werror=return-type in cxl_decoder_detach()

Nai-Chen Cheng (1):
      Documentation: fix typo in CXL driver documentation

Peter Zijlstra (1):
      cleanup: Introduce ACQUIRE() and ACQUIRE_ERR() for conditional locks

Robert Richter (1):
      cxl: Remove core/acpi.c and cxl core dependency on ACPI

Shiju Jose (4):
      cxl/events: Update Common Event Record to CXL spec rev 3.2
      cxl/events: Add extra validity checks for corrected memory error count in General Media Event Record
      cxl/events: Add extra validity checks for CVME count in DRAM Event Record
      cxl/events: Trace Memory Sparing Event Record

 Documentation/ABI/testing/debugfs-cxl              |   2 +-
 Documentation/driver-api/cxl/conventions.rst       |  47 ++
 .../driver-api/cxl/devices/device-types.rst        |  10 +-
 Documentation/driver-api/cxl/index.rst             |   1 +
 Documentation/driver-api/cxl/linux/cxl-driver.rst  |   2 +-
 .../driver-api/cxl/theory-of-operation.rst         |  12 +-
 drivers/cxl/acpi.c                                 |  59 +++
 drivers/cxl/core/Makefile                          |   1 -
 drivers/cxl/core/acpi.c                            |  11 -
 drivers/cxl/core/cdat.c                            |   6 +-
 drivers/cxl/core/core.h                            |  36 +-
 drivers/cxl/core/edac.c                            |  55 ++-
 drivers/cxl/core/hdm.c                             | 125 +++---
 drivers/cxl/core/mbox.c                            |  37 +-
 drivers/cxl/core/memdev.c                          |  52 +--
 drivers/cxl/core/port.c                            |  29 +-
 drivers/cxl/core/region.c                          | 486 +++++++++++----------
 drivers/cxl/core/trace.h                           | 133 +++++-
 drivers/cxl/cxl.h                                  |  17 +-
 drivers/cxl/cxlmem.h                               |  12 +-
 drivers/cxl/pci.c                                  |   2 +-
 include/cxl/event.h                                |  37 +-
 include/linux/cleanup.h                            |  94 +++-
 include/linux/mutex.h                              |   2 +-
 include/linux/rwsem.h                              |   3 +-
 tools/testing/cxl/Kbuild                           |   1 -
 tools/testing/cxl/config_check.c                   |   1 +
 tools/testing/cxl/test/cxl.c                       |   7 +-
 28 files changed, 827 insertions(+), 453 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/conventions.rst
 delete mode 100644 drivers/cxl/core/acpi.c
