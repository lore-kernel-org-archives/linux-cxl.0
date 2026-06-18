Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE07313E36
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781807263; cv=none; b=BLCNvRuHry0nWVRSKZfc0o5HflN+SulaSuwEjoWJHx83wex+fXHdYLr9/Q4q7t3q1Bib7X3E4Ml48nYWxtsR3Ilwr8F1ackivrthqCagDCPILs4UcsN9wzHTFfINs3uoUF5wwAaGoahmR9ax6xaZJS2DJYHPz1S4MBDS0LHrlNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781807263; c=relaxed/simple;
	bh=tjzOfcF9ze7WuSoiKjrMVJXg284zMiNTYwFQE8chGSo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ClS1ad0j/v1i3nT5eui3xk2LqPt02SpLmdDfvYOrcpgmuknZM5CypiogvYhgX+vXZ8kJQh7TS65iJLDzY6sJxzZKatyO9HmKJoylm05TxXWczhuSMz/BIqhnzm+G/KV5DOn7pSjx6lxz5ql1Wgp4V9XRVNwvmjBq8EzFfINOBNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIw/Su9M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIw/Su9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781807261; x=1813343261;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=tjzOfcF9ze7WuSoiKjrMVJXg284zMiNTYwFQE8chGSo=;
  b=FIw/Su9MNbcwoOK7yXc3U6QawBJltxDrElvLjE96QAZw/yDIeDz6w+V5
   6CrG64WRxLw8QFpt8G2WDKdUiUEF+MW9g/Jxx0F/u69vO5f2NNiI5Gps1
   aYJaHkOIayyONKNinKYOdw/I/76hyoFlO99HzJPveZY26qe1M9PGffCYK
   VpjLseTdRZKxEaUAR9ZsY1zqnd9/5WCOqocxXupOy5xrhNtrAmU1AFULv
   /9mjt+sqNbj6t5xYvBJ6H/kRNI8dwtuw4P2K16meynNAR52EF8qdjG+1w
   aOFj7Gkq5XCxduOvT+CjI+hZRnNR6Fq6L1kOAD/kw0WbH6WOxoR5fVAAE
   Q==;
X-CSE-ConnectionGUID: 2tR6nGh+REiY3o/Lx7LfTA==
X-CSE-MsgGUID: qNiAP4PjSTCbmKKzYhKoWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="100081346"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="100081346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 11:27:41 -0700
X-CSE-ConnectionGUID: 9R7pDNTMRJCapJQ8wSo25Q==
X-CSE-MsgGUID: BsfAqQZAQVeFDJnI4oEA3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="244089229"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 11:27:40 -0700
Message-ID: <a2506e5e-9159-4f8e-86de-4a11e88522a8@intel.com>
Date: Thu, 18 Jun 2026 11:27:39 -0700
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
 Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 7.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.2

...to receive a collection of CXL fixes and changes, including an update to
MAITAINERS to add Ming Li as a CXL subsystem reviewer. There's also a series
to introduce devm_cxl_probe_mem() core API in order to pave the way for CXL
type2 device drivers to setup and retrieve CXL region resource during probe.

These have all appeared in -next for a few days with no reported issues.

---

The following changes since commit e43ffb69e0438cddd72aaa30898b4dc446f664f8:

  Linux 7.1-rc6 (2026-05-31 15:14:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-7.2

for you to fetch changes up to f72af41a43e16276c46d44cf8a833cc0f9ba9d48:

  Merge branch 'for-7.2/cxl-type2-attach-region' into cxl-for-next (2026-06-12 13:47:53 -0700)

----------------------------------------------------------------
CXL changes for v7.2

Introduce devm_cxl_probe_mem(), in prep for type2 basic enabling:
cxl: Add dummy function for cxl_memdev_attach_region for !CONFIG_CXL_REGION
cxl/region: Introduce devm_cxl_probe_mem()
cxl/memdev: Introduce cxl_class_memdev_type
cxl/memdev: Pin parents for entire memdev lifetime
cxl/region: Resolve region deletion races
cxl/region: Block region delete during region creation

CXL Misc:
cxl/region: Fill first free targets[] slot during auto-discovery
cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
tools/testing/cxl: Resolve auto-region decoder targets like real HW
cxl: Align interleave decode/encode helpers with their callers
cxl/test: Add check after kzalloc() memory in alloc_mock_res()
cxl/test: Unregister cxl_acpi in cxl_test_init() error path
cxl/test: Zero out LSA backing memory to avoid leaking to user
cxl/test: Fix integer overflow in mock LSA bounds checks
cxl/test: Verify cmd->size_in before accessing payload
cxl/port: update reference to removed CONFIG_PROVE_CXL_LOCKING
cxl/region: Avoid variable shadowing in region attach paths
cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size
cxl/test: Fix __fortify_panic
cxl/fwctl: Fix __fortify_panic
MAINTAINERS: Add CXL reviewer
cxl/test: Enforce PMD alignment for volatile mock regions
cxl/region: Validate partition index before array access
cxl/memdev: Hold memdev lock during memdev poison injection/clear

CXL PCI fixes:
cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
cxl/pci: Fix the incorrect check of pci_read_config_word() return

----------------------------------------------------------------
Alison Schofield (3):
      MAINTAINERS: Add CXL reviewer
      cxl/region: Avoid variable shadowing in region attach paths
      cxl: Align interleave decode/encode helpers with their callers

Dan Williams (7):
      cxl/fwctl: Fix __fortify_panic
      cxl/test: Fix __fortify_panic
      cxl/region: Block region delete during region creation
      cxl/region: Resolve region deletion races
      cxl/memdev: Pin parents for entire memdev lifetime
      cxl/memdev: Introduce cxl_class_memdev_type
      cxl/region: Introduce devm_cxl_probe_mem()

Dave Jiang (10):
      cxl/pci: Fix the incorrect check of pci_read_config_word() return
      cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
      cxl/test: Verify cmd->size_in before accessing payload
      cxl/test: Fix integer overflow in mock LSA bounds checks
      cxl/test: Zero out LSA backing memory to avoid leaking to user
      cxl/test: Unregister cxl_acpi in cxl_test_init() error path
      cxl/test: Add check after kzalloc() memory in alloc_mock_res()
      Merge branch 'for-7.2/cxl-misc' into cxl-for-next
      cxl: Add dummy function for cxl_memdev_attach_region for !CONFIG_CXL_REGION
      Merge branch 'for-7.2/cxl-type2-attach-region' into cxl-for-next

Ethan Nelson-Moore (1):
      cxl/port: update reference to removed CONFIG_PROVE_CXL_LOCKING

Koba Ko (1):
      cxl/region: Validate partition index before array access

Li Ming (3):
      cxl/memdev: Hold memdev lock during memdev poison injection/clear
      cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()
      cxl/region: Fill first free targets[] slot during auto-discovery

Richard Cheng (2):
      cxl/test: Enforce PMD alignment for volatile mock regions
      tools/testing/cxl: Resolve auto-region decoder targets like real HW

Terry Bowman (1):
      cxl: Fix CXL_HEADERLOG_SIZE to match RAS Capability size

 MAINTAINERS                            |   1 +
 drivers/cxl/acpi.c                     |  10 +-
 drivers/cxl/core/core.h                |   2 +
 drivers/cxl/core/features.c            |   2 +-
 drivers/cxl/core/memdev.c              |  20 ++-
 drivers/cxl/core/pci.c                 |  26 ++--
 drivers/cxl/core/port.c                |   7 +-
 drivers/cxl/core/ras.c                 |  27 +++-
 drivers/cxl/core/region.c              | 270 +++++++++++++++++++++++++--------
 drivers/cxl/core/trace.h               |  24 ++-
 drivers/cxl/cxl.h                      |  28 +++-
 drivers/cxl/cxlmem.h                   |  34 ++++-
 drivers/cxl/mem.c                      | 105 ++++++++++---
 drivers/cxl/pci.c                      |   2 +-
 drivers/cxl/port.c                     |   2 +-
 include/cxl/cxl.h                      |   3 +
 tools/testing/cxl/test/cxl.c           |  41 +++--
 tools/testing/cxl/test/cxl_translate.c |   2 +-
 tools/testing/cxl/test/mem.c           |  47 ++++--
 19 files changed, 495 insertions(+), 158 deletions(-)
