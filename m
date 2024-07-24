Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303129CA
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jul 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840007; cv=none; b=RE9mxg36NhjvLye1ZBUq3Czd5ViTOWWLty6USZUqMPyoOQWcL8QXQTUUjFSR1bJinlpbUojxmJ1tOxOUz+6pvZrBjBPKW9ohiv1ZhFcrNv2VEHnvm5J8heUPJbxY/7CFxDKH3lICFhbuhVT7xKolT1iooIz/UfCr+6a+EBMOPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840007; c=relaxed/simple;
	bh=0giwkyE2VR8Obl+IqE6CQoXlOyv0GEpCT/2fZsZL61o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=rmyjGnt/G1RWkIbLIgGgFlqQpF6F494J8sm0XspmBDXToc8bK8o2UnbfUnwDj5dxnKgm1zijag1odsgy13PzLydtXeLQAuMP3gCDEkmsqJSynGUDSf3/V0emazf+8XB1XaLXsWdr7CYPCQe4Mc3XcJYsx3J5Eb8f3qwVcY+wXS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrHcnNyn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrHcnNyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721840005; x=1753376005;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=0giwkyE2VR8Obl+IqE6CQoXlOyv0GEpCT/2fZsZL61o=;
  b=OrHcnNynPe6ozJUGAO6GKXVPQqM0juEmWnk+g6qkxn+A/jqIzDOWAgz9
   L81TC4PdzrxZ6Si8rGsrPPsOpQu+H202aH3FNgnC3s/lCJyExMggUj3Ek
   BqJmw9q1Y8YPaJjHppeCOJacmiX4XbMOq4cGYS0fumw8dhFgiHyhkaMPw
   HlAt7cHXRvqj33KBBkP0DwrRDs8e6Ls5/Y+P6BUJ+yiZXFrxi5loUUTwo
   772AlMbYezQ9OOHFrlMEWMbl689QIp1en/Or71VugDUQkZoeY0niA3+l2
   c7+8+6mgm4ox0IBjjZTvmw01TWKTn2ZPzZP3lndSfvgAmfHsUoUeV4cKN
   w==;
X-CSE-ConnectionGUID: PmX1jOOAQaKkGfexDKpLOw==
X-CSE-MsgGUID: 4E/sETRTS/WnsXu0/xX25Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30137100"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30137100"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:53:24 -0700
X-CSE-ConnectionGUID: vH/knxaZSSmRj24W+RVpvw==
X-CSE-MsgGUID: RpAVFqXIQ06DeoBwjwPYBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52329214"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.208]) ([10.125.110.208])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 09:53:23 -0700
Message-ID: <21dca9f0-639f-43b0-b858-a74317954835@intel.com>
Date: Wed, 24 Jul 2024 09:53:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.11
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.11

...to receive changes, cleanups, and fixes for CXL.

The major additions are:
A CXL maturity map has been added to the documentation to detail the current
state of CXL enabling. It provides the status of the current state of various
CXL features to inform current and future contributors of where things are and
which areas need contribution.

A notifier handler has been added in order for a newly created CXL memory
region to trigger the abstract distance metrics calculation. This should
bring parity for CXL memory to the same level vs hotplugged DRAM for NUMA
abstract distance calculation. The abstract distance reflects relative
performance used for memory tiering handling.

An addition for XOR math has been added to address the CXL DPA to SPA
translation. CXL address translation did not support address interleave math
with XOR prior to this change.

A few fixes contains:
Fix to address race condition in the CXL memory hotplug notifier.

Add missing MODULE_DESCRIPTION() for CXL modules.

Fix incorrect vendor debug UUID define.

A few minor changes added:
A warning has been added to inform users of an unsupported configuration when mixing
CXL VH and RCH/RCD hierarchies.

The ENXIO error code has been replaced with EBUSY for inject poison limit reached via
debugfs and cxl-test support.

Moving the PCI config read in cxl_dvsec_rr_decode() to avoid unnecessary PCI config reads.

A refactor to a common struct for DRAM and general media CXL events.


This pull request has appeared in the linux-next for about a week and has build
success notification from kbuild-robot.

---

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.11

for you to fetch changes up to a0328b397f3339d8d17a6ec356e94b3c110b010c:

  cxl/core/pci: Move reading of control register to immediately before usage (2024-07-17 10:35:08 -0700)

----------------------------------------------------------------
CXL for v6.11 merge window

New Changes:
- Refactor to a common struct for DRAM and general media CXL events
- Add abstract distance calculation support for CXL
- Add CXL maturity map documentation to detail current state of CXL enabling
- Add warning on mixed CXL VH and RCH/RCD hierachy to inform unsupported config
- Replace ENXIO with EBUSY for inject poison limit reached via debugfs
- Replace ENXIO with EBUSY for inject poison cxl-test support
- XOR math fixup for DPA to SPA translation. Current math works for MODULO arithmetic
  where HPA==SPA, however not for XOR decode.
- Move pci config read in cxl_dvsec_rr_decode() to avoid unnecessary acess

Fixes:
- Add a fix to address race condition in CXL memory hotplug notifier
- Add missing MODULE_DESCRIPTION() for CXL modules
- Fix incorrect vendor debug UUID define

----------------------------------------------------------------
Alison Schofield (6):
      cxl/memdev: Replace ENXIO with EBUSY for inject poison limit reached
      cxl/test: Replace ENXIO with EBUSY for inject poison limit reached
      cxl/core: Fold cxl_trace_hpa() into cxl_dpa_to_hpa()
      cxl: Restore XOR'd position bits during address translation
      cxl/region: Verify target positions using the ordered target list
      cxl: Remove defunct code calculating host bridge target positions

Dan Williams (1):
      Documentation: CXL Maturity Map

Dave Jiang (1):
      Merge branch 'for-6.11/xor_fixes' into cxl-for-next

Fabio M. De Francesco (2):
      cxl/events: Use a common struct for DRAM and General Media events
      cxl/acpi: Warn on mixed CXL VH and RCH/RCD Hierarchy

Foryun Ma (1):
      cxl/core/pci: Move reading of control register to immediately before usage

Huang Ying (3):
      cxl/region: Fix a race condition in memory hotplug notifier
      cxl/region: Support to calculate memory tier abstract distance
      cxl/region: Simplify cxl_region_nid()

Jeff Johnson (1):
      cxl: add missing MODULE_DESCRIPTION() macros

peng guo (1):
      cxl/core: Fix incorrect vendor debug UUID define

 Documentation/ABI/testing/debugfs-cxl         |   7 +-
 Documentation/driver-api/cxl/index.rst        |   2 +
 Documentation/driver-api/cxl/maturity-map.rst | 202 ++++++++++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/cxl/acpi.c                            | 125 ++++++++--------
 drivers/cxl/core/core.h                       |   8 +-
 drivers/cxl/core/mbox.c                       |   4 +-
 drivers/cxl/core/pci.c                        |   8 +-
 drivers/cxl/core/port.c                       |  21 +--
 drivers/cxl/core/region.c                     | 105 ++++++++-----
 drivers/cxl/core/trace.h                      |  36 ++---
 drivers/cxl/cxl.h                             |  13 +-
 drivers/cxl/cxlmem.h                          |   4 +-
 drivers/cxl/mem.c                             |   1 +
 drivers/cxl/pci.c                             |   1 +
 drivers/cxl/pmem.c                            |   1 +
 drivers/cxl/port.c                            |   1 +
 include/linux/cxl-event.h                     |  45 +++---
 tools/testing/cxl/test/mem.c                  |  69 ++++-----
 19 files changed, 442 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/driver-api/cxl/maturity-map.rst
