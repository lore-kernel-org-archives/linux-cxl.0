Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683315;
	b=VKhLaFlg3eYkAsbAtAimVi+ReYiMQf3Sh1bXWdOMCPV18ooHVTfvR177nUxX1g2/RuRI
	 h+YrGSoi0PNBsMKC8o533+eHhiq4YSEnAVzXu6m9neVEmxdKKbp2hIdcANBgaMbE8Bc1u
	 NzzeToxY0kDB/fBvoQWHh7DFN5uyonmq6GbjokiUi5YhcfGxqL1DkUtueczC1E9beGNoe
	 JUPGDK+WEGMNz3FKk4tagqGU3v3jV2JmnEtNNgIK/Ej5JX7vbzb5Nqt7uiQbmiDM6kmvR
	 likKPilIX6ghzk3rUpIJpqpN3xQxWt6NvhIAMVWdB31meTxfQYXXinneCtzs8vWgp9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683315;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Content-Language:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=bRPBmKoL0A1v5qlWWBmasXxCt/v3zkrgnJU6KAvWaLo=;
	b=k5Kko6jyTtJpv6KLZ49ebVtYFgEhOi2pY2B8TMKcmb0Q1wVXthyUvXgCQftZn5pCP7hi
	 j2IxOvruojRLyg4JLv4J5gZqcAodAYLwPk54YPhr7BZ7oPZB0S+Sh9KnyAaKojgtkChqM
	 Y3xnmKEHMFidcq2tvOk7qrhk0RiGn/YTZGbeCBPKvBJl/adwLBt+U5IQTiRMUMZybBRxW
	 F7nOTGni95ER1ZyAlcTSKFNlVcGtibBVD3kEmwq1HKY+lbZS7ghiWqYA08VmYto2dBtZG
	 LXiPhkGKC8a4kzpq6Zf9G7+CcTubqTDsbNC3ClbXJ75XvQK0b+XzfgTut1ruenZaBgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CAINpOr4;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3DA606A319;
	Thu, 22 Oct 2026 15:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A3DA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CAINpOr4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792683313; x=1824219313;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=JED64snVytGZMSUslIgUVzLkXsSfaDn27qVZO1beloA=;
  b=CAINpOr46o/b+A5YjvXzSLgj+9GKP2m8fHJLhoMw8XYRdyR52FP1ytlH
   mO0KB0Jh7T0vgikxFOT80EgkXVQWzvCtWpxfnX6/R7XpLr1K12oihRh4P
   ZIRtk5HvEvDfGMfeR6SQGt5vneSXuExr/sd4Vo2EpsA+IBBZOS5hYvClG
   fIHN50D77kPM+Yq/R/TSxH7/Nn0OE3GncKsoMH6esvGhoo2iV5PQIabVM
   x3WTpDpDa9+yZ/nwwpW/SfSlnZ2VHc+TBEa60gxKj81fJsocx3L7MRkpF
   th+n+eNU5kSkQ0wAnNOxfNRebeHeO+zheqhGOoSEhvmBg8La43P6vpsYy
   w==;
X-CSE-ConnectionGUID: MffwxpiTQnumpGPPB9IuyA==
X-CSE-MsgGUID: LNgl1ZPwSKqsMuJYM9PtHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1334778"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1334778"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:35:12 -0700
X-CSE-ConnectionGUID: xGht6dEIS2m6MTG+tT+r5w==
X-CSE-MsgGUID: rWxb+i5LSZuIPaJrzzXdIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3870664"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.111.207]) ([10.125.111.207])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 08:35:11 -0700
Message-ID: <038679a4-e6c7-495a-8283-c3d0670ac191@intel.com>
Date: Thu, 22 Oct 2026 08:35:10 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
Subject: [GIT PULL] Compute Express Link (CXL) for 7.4
To: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Ira Weiny
 <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 Li Ming <ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.4

...to receive a series of changes for CXL. The headline item is the first
part support for Dynamic Capacity Devices (DCD). It covers flagging DCD
support in the mailbox, reading the dynamic capacity configuration from
the device, gathering DSMAS data for the DCD partitions, and configuring
the dynamic capacity interrupts. It also adds a documentation update and
a cleanup that enforces partition ordering. DCD is not enabled yet with
these code changes. Patches are applied to reduce the whole set in order
to relief the burden of very large patch set review.

Zero sized HDM decoders are now allowed, along with cxl_test support for
them. There is also a set of decoder hardening patches for switch decoder
enumeration. Latency calculations now account for link width and use
consistent units. The GPF timeout programming has been reworked. The pull
also has a number of misc patches.

A large number of bug fixes against pre-existing issues make up the rest of
the pull. Many of these were flagged by review of patches posted to the
mailing list by sashiko.

Also adding Richard Cheng as a reviewer (R) to the CXL sub-system.

These have all appeared in -next for 5 days or more with no reported
issues.

---

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.4

for you to fetch changes up to cf15f9f2361dd4002203716b7b878393c0eee4bf:

  Merge branch 'for-7.4/cxl-fixes' into cxl-for-next (2026-10-15 08:13:53 -0700)

----------------------------------------------------------------
CXL for v7.4

CXL Dynamic Capacity Device (DCD) support (part 1):
cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
cxl/mem: Read dynamic capacity configuration from the device
cxl/cdat: Gather DSMAS data for DCD partitions
cxl/events: Split event msgnum configuration from irq setup
cxl/pci: Factor out interrupt policy check
cxl/mem: Configure dynamic capacity interrupts
cxl/core: Enforce partition order/simplify partition calls
Documentation/cxl: Document DPA partition layout and ordering rules

CXL zero sized decoder support:
cxl/hdm: Allow zero sized HDM decoders
tools/testing/cxl: Enable zero sized decoders under hb0
cxl/region: Simplify poison_by_decoder() error handling

CXL decoder hardening:
cxl/hdm: Reject switch decoder interleave ways that overflow targets
cxl/hdm: Make switch decoder target parsing endian-safe
cxl/hdm: Restore commit_end when decoder enumeration fails
cxl/port: Bound switch decoder target array access by nr_targets
cxl/pci: Skip reset detection for DVSEC emulated decoders

CXL latency and GPF handling:
cxl/port: Convert PCIe link latency to nanoseconds
cxl: Account for link width in latency calculation
cxl/acpi: Convert QTG _DSM latencies to picoseconds
cxl/pci: Use the Device GPF DVSEC for restricted endpoints
cxl/pci: Program the Port GPF timeouts before caching the DVSEC
cxl/pci: Update only the Port GPF timeout fields

CXL misc patches:
MAINTAINERS: Add Richard Cheng to CXL subsystem as a Reviewer
cxl: docs/platform/acpi: Fix brackets
cxl/ras: Pass the PCI device's struct device to match_memdev_by_parent()
cxl/test: Map mock device nodes to an online node
tools/testing/cxl: Don't wrap cxl_core's own exported symbols
cxl/region: Fix the return value in devm_cxl_add_region() kernel-doc
cxl/region: Warn on user region position mismatch
cxl/region: Create node access attributes for CFMWS-only NUMA nodes

CXL fixes:
cxl/events: Test CME counter expiry with equality, not bitwise AND
cxl/events: Return IRQ_NONE when no event is pending
cxl/port: Attach endpoints to a dport under the lock that pins it
cxl/core: Hold the dport host lock across dport lookup and use
cxl/port: Clear cached dport pointers when a dport is removed
cxl/acpi: Check ACPI companion before use
driver core: Add conditional guard support for device_trylock()
cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
cxl/core: Skip einj_inject creation when devm_add_action_or_reset() fails
cxl/region: Unregister the pmem region when the bridge is unbound
cxl/core: Fix dport use-after-free via the einj_inject debugfs file
cxl/port: Fix uninitialized coordinates reported for RCDs
cxl/cdat: Fix uninitialized stack use in bandwidth gathering
cxl/features: Ensure that count is set before access to ent[] __counted_by()
cxl/features: Reject feature offset that overflows 16-bit field
cxl/fwctl: Propagate feature RPC delivery errors
cxl/regs: Reject register blocks in an unassigned BAR
cxl/region: Guard against a missing peer mapping
cxl/mce: Avoid alias page retirement for corrected errors

----------------------------------------------------------------
Alison Schofield (6):
      cxl/region: Guard against a missing peer mapping
      cxl/hdm: Reject switch decoder interleave ways that overflow targets
      cxl/hdm: Make switch decoder target parsing endian-safe
      cxl/hdm: Restore commit_end when decoder enumeration fails
      cxl/port: Bound switch decoder target array access by nr_targets
      cxl/region: Warn on user region position mismatch

Anisa Su (1):
      Documentation/cxl: Document DPA partition layout and ordering rules

Ashok Raj (1):
      cxl/features: Ensure that count is set before access to ent[] __counted_by()

Dave Jiang (16):
      cxl/ras: Pass the PCI device's struct device to match_memdev_by_parent()
      MAINTAINERS: Add Richard Cheng to CXL subsystem as a Reviewer
      Merge branch 'for-7.4/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.4/cxl-misc' into cxl-for-next
      Merge branch 'for-7.4/cxl-zero-size-decoder' into cxl-for-next
      Merge branch 'for-7.4/decoder_hardening' into cxl-for-next
      Merge branch 'for-7.4/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.4/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.4/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.4/cxl-misc' into cxl-for-next
      cxl/port: Clear cached dport pointers when a dport is removed
      cxl/core: Hold the dport host lock across dport lookup and use
      cxl/port: Attach endpoints to a dport under the lock that pins it
      Merge branch 'for-7.4/cxl-fixes' into cxl-for-next
      Merge branch 'for-7.4/cxl-dcd' into cxl-for-next
      Merge branch 'for-7.4/cxl-fixes' into cxl-for-next

Davidlohr Bueso (1):
      cxl/test: Map mock device nodes to an online node

Guixin Liu (13):
      cxl/pci: Skip reset detection for DVSEC emulated decoders
      cxl/cdat: Fix uninitialized stack use in bandwidth gathering
      cxl/port: Fix uninitialized coordinates reported for RCDs
      cxl/core: Fix dport use-after-free via the einj_inject debugfs file
      cxl/region: Unregister the pmem region when the bridge is unbound
      cxl/region: Create node access attributes for CFMWS-only NUMA nodes
      cxl/core: Skip einj_inject creation when devm_add_action_or_reset() fails
      driver core: Add conditional guard support for device_trylock()
      cxl/memdev: Fix deadlock between poison debugfs and cxl_mem unbind
      cxl/pci: Use the Device GPF DVSEC for restricted endpoints
      cxl/pci: Program the Port GPF timeouts before caching the DVSEC
      cxl/pci: Update only the Port GPF timeout fields
      cxl/events: Test CME counter expiry with equality, not bitwise AND

Ira Weiny (7):
      cxl/mbox: Flag support for Dynamic Capacity Devices (DCD)
      cxl/mem: Read dynamic capacity configuration from the device
      cxl/cdat: Gather DSMAS data for DCD partitions
      cxl/events: Split event msgnum configuration from irq setup
      cxl/pci: Factor out interrupt policy check
      cxl/mem: Configure dynamic capacity interrupts
      cxl/core: Enforce partition order/simplify partition calls

Jiale Yao (1):
      cxl/acpi: Check ACPI companion before use

Junjie Cao (1):
      cxl/regs: Reject register blocks in an unassigned BAR

Karl Mehltretter (1):
      cxl/region: Fix the return value in devm_cxl_add_region() kernel-doc

Koichiro Den (3):
      cxl/port: Convert PCIe link latency to nanoseconds
      cxl: Account for link width in latency calculation
      cxl/acpi: Convert QTG _DSM latencies to picoseconds

Manuel Ebner (1):
      cxl: docs/platform/acpi: Fix brackets

Richard Cheng (6):
      tools/testing/cxl: Don't wrap cxl_core's own exported symbols
      cxl/features: Reject feature offset that overflows 16-bit field
      cxl/fwctl: Propagate feature RPC delivery errors
      cxl/region: Simplify poison_by_decoder() error handling
      cxl/hdm: Allow zero sized HDM decoders
      tools/testing/cxl: Enable zero sized decoders under hb0

Shaikh Kamaluddin (2):
      cxl/mce: Avoid alias page retirement for corrected errors
      cxl/events: Return IRQ_NONE when no event is pending

 Documentation/driver-api/cxl/linux/cxl-driver.rst  |  35 +++
 Documentation/driver-api/cxl/maturity-map.rst      |   4 +
 .../driver-api/cxl/platform/acpi/dsdt.rst          |   3 +-
 MAINTAINERS                                        |   1 +
 drivers/cxl/acpi.c                                 |  20 +-
 drivers/cxl/core/cdat.c                            | 107 ++++++--
 drivers/cxl/core/core.h                            |  14 +-
 drivers/cxl/core/edac.c                            |  30 ++-
 drivers/cxl/core/features.c                        |  58 ++--
 drivers/cxl/core/hdm.c                             | 144 +++++++---
 drivers/cxl/core/mbox.c                            | 294 ++++++++++++++++++++-
 drivers/cxl/core/mce.c                             |   8 +-
 drivers/cxl/core/memdev.c                          | 100 +++++--
 drivers/cxl/core/pci.c                             |  74 ++++--
 drivers/cxl/core/port.c                            | 250 ++++++++++++------
 drivers/cxl/core/ras.c                             |   6 +-
 drivers/cxl/core/ras_rch.c                         |  12 +-
 drivers/cxl/core/region.c                          | 100 ++++---
 drivers/cxl/core/region_pmem.c                     |   6 +-
 drivers/cxl/core/regs.c                            |  14 +
 drivers/cxl/cxl.h                                  |  48 +++-
 drivers/cxl/cxlmem.h                               |  88 +++++-
 drivers/cxl/mem.c                                  |  30 ++-
 drivers/cxl/pci.c                                  | 223 ++++++++++++----
 drivers/cxl/port.c                                 |   3 +
 drivers/pci/pci.c                                  |  23 +-
 include/cxl/cxl.h                                  |  29 +-
 include/linux/device.h                             |   1 +
 include/linux/pci.h                                |   2 +-
 tools/testing/cxl/Kbuild                           |  16 +-
 tools/testing/cxl/test/cxl.c                       | 117 ++++++--
 tools/testing/cxl/test/mem.c                       |   2 +-
 32 files changed, 1487 insertions(+), 375 deletions(-)
