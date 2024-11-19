Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF0714A60C
	for <linux-cxl@vger.kernel.org>; Tue, 19 Nov 2024 21:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732050957; cv=none; b=oEBfmQmoypKVT5fHi0T5n6M48/OZqgJpUm+o4fRZCVQGf07DoB5YQ1+8qleL6eCmAlnFbucaZFESto5LrET78wFqoVKNk1uN5f9/wI+xcOY2h29UXq541U6xbop40cHM6WBM6gRQqhSSnjnYNPxParq4/+NpDHO3xDJcuFzFpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732050957; c=relaxed/simple;
	bh=ux225bc/kYDGBTdDoCIxES3Olm4pitHo1sL/c0ETdY4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MRbN2XQcK6sA3aAVJ2JJdarFfrqxxGcjkibfQ1fvoP7PpZngw0YOxtxbc2lqkm/7CM1YAKG8+8HO/tRZ/9yUc6w6rmLvTyT5npCb7BqPRktP4LmtyE97wj4XM4xy5nysD3hL7L9a2Rkx8x+2y7lvBqljYeZnW+B+ldVxWj48kyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUraNtod; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUraNtod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732050956; x=1763586956;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=ux225bc/kYDGBTdDoCIxES3Olm4pitHo1sL/c0ETdY4=;
  b=JUraNtod6imoiU+MKgI+AP7dpbD45ieUpWtGKaNMTY/RlpBIWgwzuM9e
   lHKns6DcRhC6b5cOzysyY1Fgnr0Pg0cG5FxLaSwV16PnE6eHt1VHSUEHW
   cJFkGrEbtvdWq4p8eG/4YGXPywJ9gxXVIb66ZqjKymR/aSm4l6Ayx2PCv
   uARM2PZwhdBhtKEXJtVilE2uSpZ2y3ZSRNO5xmgKGMK0On40krI6Ljv9i
   l1UAPLmpMQBr+KZdvluNi/hMllv30U/3oxFkGOZrD4kZivj4xVQyfHpPZ
   OsN0a0WCNA1sSBcWn1oxedRP3IKnuVvd+iQVjts0p99HWYfEgQrouU5tO
   A==;
X-CSE-ConnectionGUID: w6gyKij+RvaetvetFmksFg==
X-CSE-MsgGUID: IexaDZ7aTYC9MEmrCqZtlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32011989"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32011989"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 13:15:55 -0800
X-CSE-ConnectionGUID: FgUI5eYGSA66Cfw8JMZtVA==
X-CSE-MsgGUID: aVAHz24STEybKzPV+UZ9wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="94623233"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.91]) ([10.125.109.91])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 13:15:55 -0800
Message-ID: <5662041f-2563-486c-8e71-077f31dc2ecd@intel.com>
Date: Tue, 19 Nov 2024 14:15:53 -0700
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
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.13
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.13

...to receive updates for CXL subsystem.

Main changes contain adding sysfs support for displaying Restricted CXL Device
capabilities for lspci, support for %pra in order to emit 'struct range'
for printk, and preparation and cleanup code for introducing support for
CXL Dynamic Capcity Devices (DCD) support.

These have all appeared in -next for a week plus with no reported issues.

---

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.13

for you to fetch changes up to a83383e2ae7c499ff7b318945d9b2fe4e3006c2c:

  Merge branch 'cxl/for-6.13/dcd-prep' into cxl-for-next (2024-11-08 09:50:07 -0700)

----------------------------------------------------------------
cxl changes for v6.13

- Constify range_contains() input parameters to prevent changes.
- Add support for displaying RCD capabilities in sysfs to support lspci for CXL device.
- Downgrade warning message to debug in cxl_probe_component_regs().
- Add support for adding a printf specifier '$pra' to emit 'struct range' content.
  - Add sanity tests for 'struct resource'.
  - Add documentation for special case.
  - Add %pra for 'struct range'.
  - Add %pra usage in CXL code.
- Add preparation code for DCD support
  - Add range_overlaps().
  - Add CDAT DSMAS table shared and read only flag in ACPICA.
  - Add documentation to 'struct dev_dax_range'.
  - Delay event buffer allocation in CXL PCI code until needed.
  - Use guard() in cxl_dpa_set_mode().
  - Refactor create region code to consolidate common code.

----------------------------------------------------------------
Coly Li (1):
      cxl: downgrade a warning message to debug level in cxl_probe_component_regs()

Dave Jiang (2):
      Merge branch 'cxl/for-6.12/printf' into cxl-for-next
      Merge branch 'cxl/for-6.13/dcd-prep' into cxl-for-next

Ira Weiny (11):
      kernel/range: Const-ify range_contains parameters
      test printf: Add very basic struct resource tests
      Documentation/printf: struct resource add start == end special case
      printf: Add print format (%pra) for struct range
      cxl/cdat: Use %pra for dpa range outputs
      range: Add range_overlaps()
      ACPI/CDAT: Add CDAT/DSMAS shared and read only flag values
      dax: Document struct dev_dax_range
      cxl/pci: Delay event buffer allocation
      cxl/hdm: Use guard() in cxl_dpa_set_mode()
      cxl/region: Refactor common create region code

Kobayashi,Daisuke (2):
      cxl/core/regs: Add rcd_pcie_cap initialization
      cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 Documentation/core-api/printk-formats.rst |  20 +++++-
 drivers/cxl/core/cdat.c                   |   8 +--
 drivers/cxl/core/core.h                   |   5 ++
 drivers/cxl/core/hdm.c                    |  21 ++----
 drivers/cxl/core/region.c                 |  46 ++++++-------
 drivers/cxl/core/regs.c                   |  58 +++++++++++++++-
 drivers/cxl/cxl.h                         |   9 +++
 drivers/cxl/pci.c                         | 109 +++++++++++++++++++++++++++---
 drivers/dax/dax-private.h                 |  26 +++++--
 fs/btrfs/ordered-data.c                   |  10 +--
 include/acpi/actbl1.h                     |   2 +
 include/linux/range.h                     |  17 ++++-
 lib/test_printf.c                         |  61 +++++++++++++++++
 lib/vsprintf.c                            |  57 ++++++++++++++--
 14 files changed, 375 insertions(+), 74 deletions(-)
