Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE41C6A5
	for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727445789; cv=none; b=hJeMX0D/FD1kjkMCVx8hFuJNjv1V/Jdxc9E9iD2zFJFqK61luA/VJ0tc8c6TW1BMAn8BXBssKc8d5UG47YhjbtifdaMpFV3NPOz3R4RmhZuw7MFT02eBatgGPJdGHM+2llpKz4w2AAmlb0ImSbg/uyKQgUYkZ6MDfnzJ7DubDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727445789; c=relaxed/simple;
	bh=aa7fptxLg5hhuLC9545GybWqmtEy7NltjQ+ZlEE88BY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=szOPCXuWH0TbR2uZGiC337V/HyTmLLTWYq3V0OhdLAvpRBSy17Tu3ifeMKgl2m7dWDz2/ka04Bbrw+0ZWD6STa5/8G9mThi/RE3xB6iWoFoPmjFXtZWzubHSDt7mLdelTCkSl+3gdNRo3QQ1+OoEk+Z1EDrfTqMy29IyMs0CPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KY+ifbO1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KY+ifbO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727445787; x=1758981787;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=aa7fptxLg5hhuLC9545GybWqmtEy7NltjQ+ZlEE88BY=;
  b=KY+ifbO1CJnI/DtE/SWXbuv2xtBoLC8U0pUufbnCiBKao10uPf1fASC0
   8zLAXYF8tIwP60FZA04gnR1Hb/w3/p9GCIFINqiS5L0B1lJGxRsMLGeMY
   Pd9gNLET0O7J+a/mhXI0AXTp2Ter7aJdiC9OZMex0buyInQsQZ6m69HVw
   5JEIgfbkRFplVYjKr54qI2u7iOV8hEZHIQaELSxn8iLw788nYwmDAe1/A
   9VTwPEzF02E/doRg9fW6BvA1qqQoW8g9yALJpfLcjj1jThCMHuk10MGMV
   ZrE8qYLWlB8uf/g5FmP6lU0/RZvGLgk95H3Z2EAgHhqoFYEs+zwo5IfGu
   g==;
X-CSE-ConnectionGUID: rKTYcPecSgmFT5e8FWME8Q==
X-CSE-MsgGUID: Tlsj6PNsSoaSBk1jiqXklg==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="37171354"
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="37171354"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 07:02:58 -0700
X-CSE-ConnectionGUID: A1xn9U98Tiu7TNPmdkdCaw==
X-CSE-MsgGUID: R4N0vw43ScWTLLQa3cmtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,158,1725346800"; 
   d="scan'208";a="72847885"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.108.33]) ([10.125.108.33])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 07:02:58 -0700
Message-ID: <9c4d4de9-5c24-4644-ba41-875bf19da10b@intel.com>
Date: Fri, 27 Sep 2024 07:02:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.12
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-for-6.12

...to receive updates for CXL subsystem.

Changes contain a patch series to address HDM decoder initialization from DVSEC
ranges, a patch series that refactors the code related to cxl mailboxes to be
independent of the memory devices, a patch series that adds support for shared
upstream link access_coordinate calculation, as well as a change to remove
locking from memory notifier callback. In addition, a number of misc cleanups
and refactoring of the code are also included.

These have all appeared in -next for a few days with no reported issues.

---

The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:

  Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-for-6.12

for you to fetch changes up to 2c70677dabb5e326467160e28915b804b925b53b:

  cxl: Add documentation to explain the shared link bandwidth calculation (2024-09-22 21:29:08 -0700)

----------------------------------------------------------------
cxl changes for v6.12

Misc cleanups:
- Convert devm_cxl_add_root() to return using ERR_CAST().
- cxl_test use dev_is_platform() instead of open coding.
- Remove duplicate include of header core.h in core/cdat.c.
- use scoped resource management to drop put_device() for cxl_port
- Use scoped_guard to drop device_lock() for cxl_port
- Refactor __devm_cxl_add_port() to drop gotos
- Rename cxl_setup_parent_dport to cxl_dport_init_aer and cxl_dport_map_regs()
  to cxl_dport_map_ras().
- Refactor cxl_dport_init_aer() to be more concise.
- Remove duplicate host_bridge->native_aer checking in cxl_dport_init_ras_reporting().
- Fix comment for cxl_query_cmd()

Series to address HDM decoder initialization from DVSEC ranges:
- Only register non-zero DVSEC ranges.
- Remove duplicate implementation of waiting for memory_info_valid.
- Simplify the checking of mem_enabled in  cxl_hdm_decode_init().

Remove locking from memory notifier callback

Series that refactors the code related to cxl mailboxes to be independent of the memory devices
- Move cxl headers in include/linux/ to include/cxl.
- Move all mailbox related data to 'struct cxl_mailbox'.
- Refactor mailbox APIs with 'struct cxl_mailbox' as input instead of memory device state.

Series that adds support for shared upstream link access_coordinate calculation for
configurations that have multiple targets under a switch or a root port where the
aggregated bandwidth can be greater than the upstream link of the switch/RP upstream
link.
- Preserve the CDAT access_coordinate from an endpoint
- Add the support for shared upstream link access_coordinate calculation
- Add documentation to explain how the calculations are done.

----------------------------------------------------------------
Dave Jiang (7):
      cxl: move cxl headers to new include/cxl/ directory
      cxl: Move mailbox related bits to the same context
      cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input
      cxl: Fix comment regarding cxl_query_cmd() return data
      cxl: Preserve the CDAT access_coordinate for an endpoint
      cxl: Calculate region bandwidth of targets with shared upstream link
      cxl: Add documentation to explain the shared link bandwidth calculation

Hongbo Li (1):
      cxl: Remove duplicate included header file core.h

Ira Weiny (1):
      cxl/region: Remove lock from memory notifier callback

Kunwu Chan (1):
      tools/testing/cxl: Use dev_is_platform()

Li Ming (6):
      cxl/port: Use __free() to drop put_device() for cxl_port
      cxl/port: Use scoped_guard()/guard() to drop device_lock() for cxl_port
      cxl/port: Refactor __devm_cxl_add_port() to drop goto pattern
      cxl/pci: Rename cxl_setup_parent_dport() and cxl_dport_map_regs()
      cxl/pci: cxl_dport_map_rch_aer() cleanup
      cxl/pci: Remove duplicate host_bridge->native_aer checking

Yanfei Xu (4):
      cxl/pci: Fix to record only non-zero ranges
      cxl/pci: Remove duplicated implementation of waiting for memory_info_valid
      cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
      cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()

Yuesong Li (1):
      cxl/port: Convert to use ERR_CAST()

 .../driver-api/cxl/access-coordinates.rst          |  91 ++++
 Documentation/driver-api/cxl/index.rst             |   1 +
 MAINTAINERS                                        |   3 +-
 drivers/acpi/apei/einj-cxl.c                       |   2 +-
 drivers/acpi/apei/ghes.c                           |   2 +-
 drivers/cxl/core/cdat.c                            | 508 ++++++++++++++++++++-
 drivers/cxl/core/core.h                            |   4 +-
 drivers/cxl/core/mbox.c                            |  96 ++--
 drivers/cxl/core/memdev.c                          |  41 +-
 drivers/cxl/core/pci.c                             | 168 +++----
 drivers/cxl/core/port.c                            | 208 +++++----
 drivers/cxl/core/region.c                          |  81 ++--
 drivers/cxl/cxl.h                                  |   9 +-
 drivers/cxl/cxlmem.h                               |  27 +-
 drivers/cxl/mem.c                                  |  29 +-
 drivers/cxl/pci.c                                  |  91 ++--
 drivers/cxl/pmem.c                                 |  26 +-
 drivers/cxl/port.c                                 |   2 +-
 drivers/cxl/security.c                             |  23 +-
 include/{linux/einj-cxl.h => cxl/einj.h}           |   0
 include/{linux/cxl-event.h => cxl/event.h}         |   0
 include/cxl/mailbox.h                              |  28 ++
 tools/testing/cxl/Kbuild                           |   2 +-
 tools/testing/cxl/mock_acpi.c                      |   2 +-
 tools/testing/cxl/test/mem.c                       |  44 +-
 tools/testing/cxl/test/mock.c                      |  10 +-
 26 files changed, 1092 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/access-coordinates.rst
 rename include/{linux/einj-cxl.h => cxl/einj.h} (100%)
 rename include/{linux/cxl-event.h => cxl/event.h} (100%)
 create mode 100644 include/cxl/mailbox.h
