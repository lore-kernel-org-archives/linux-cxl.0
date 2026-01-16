Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADB6335573;
	Fri, 16 Jan 2026 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768586593; cv=none; b=SY0aEvjXlBQ2nC40POB3cXfWViq+j2WfYXyEVfxSUblMGT3jFfcFUErPwg4IgEG4jS0PWLa5p9Y+0/OW+IAmP/elkc5BYPc3n16vIU/ckzXwnk5ZpPahc59PY5WOWKcedRFOAPFVzISrnorvBIVzutuwP9G1X/8fJLBxRGLvOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768586593; c=relaxed/simple;
	bh=Bv3IvUR1jfSlqCzmtRehs+9OlgYje6w/aFbGWQncG6A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HcMgwDjOOw3pScc4DbIyIIfJGisuPUGOYdRQjEWOMUCfX6+Nqh2lkQYn0RPiGHvvX7Yvtrm+d/4bsDRwWyPcmYVRG6uNW+zoaH+MQSbdx5eep5JxmRHkLOAJn0xcdCpk/nAGi6CX+tqktkSR5kMrBEBL7wLgZthFuuOkbrtv8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO3fpEss; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO3fpEss"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768586593; x=1800122593;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=Bv3IvUR1jfSlqCzmtRehs+9OlgYje6w/aFbGWQncG6A=;
  b=bO3fpEssMGdRTIC9aOOiEIdZkYc6ssRmfVmk2C8R7WnYOkrdAcHUj4pT
   SQ8zQNPr1HYz+XuMQU+fQ8u6tJhWFHaU8IwW/3az+tOcPfVXkn8gSC+2X
   ebcY7wrTh4QyRi1ynxwCs5/bDQJjJPhD8S81GcVhCK2ioK36wznmpF5cy
   2xTe2r19gfwSCLFbBCytXC96d4wSGnzjSaiwcOr2rsF66kvyPlMRJhBP0
   DwmufGdfwSIg7nvUFolPhmSZIRTEj32BpOOZvjr0+lrtMwrpfwGSNBZ+/
   ba6ZXf7l3dJ5nlJy5SPmA+dzVT1VHRYDr0j1MJhy7jtdG7zhre6zuDe3t
   A==;
X-CSE-ConnectionGUID: dCdhXvOCSYeYCUxp49+CFA==
X-CSE-MsgGUID: 2TAfKJ76QEOGXcTXvjS01Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="81020797"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="81020797"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 10:03:12 -0800
X-CSE-ConnectionGUID: mWzsypZdQHuaBzzvBIwLTQ==
X-CSE-MsgGUID: Rs6YYJpZSCuP4+0oZ4Dn8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="205333711"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 10:03:11 -0800
Message-ID: <fe2b0fb8-8203-4630-b974-54d223353c24@intel.com>
Date: Fri, 16 Jan 2026 11:03:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.19-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.19-rc6

...to receive a collection of CXL fixes.

This commit, 269031b15c14 ("x86/kaslr: Recognize all ZONE_DEVICE users as physaddr consumers")
is for x86 but was reported through a CXL issue. The commit has an ack from Dave Hansen.

These have all appeared in -next for a few days with no reported issues.

---

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.19-rc6

for you to fetch changes up to 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c:

  cxl: Check for invalid addresses returned from translation functions on errors (2026-01-13 08:30:40 -0700)

----------------------------------------------------------------
cxl fixes for v6.19-rc6

- Recognize all ZONE_DEVICE users as physaddr consumers
- Fix format string for extended_linear_cache_size_show()
- Fix target list setup for multiple decoders sharing the same
  downstream port
- Restore HBIW check before derefernce platform data
- Fix potential infinite loop in __cxl_dpa_reserve()
- Check for invalid addresses returned from translation functions on
  error.

----------------------------------------------------------------
Alison Schofield (1):
      cxl/acpi: Restore HBIW check before dereferencing platform_data

Arnd Bergmann (1):
      cxl/region: fix format string for resource_size_t

Dan Williams (1):
      x86/kaslr: Recognize all ZONE_DEVICE users as physaddr consumers

Li Ming (1):
      cxl/hdm: Fix potential infinite loop in __cxl_dpa_reserve()

Robert Richter (2):
      cxl/port: Fix target list setup for multiple decoders sharing the same dport
      cxl: Check for invalid addresses returned from translation functions on errors

 arch/x86/mm/kaslr.c                    | 10 +++++-----
 drivers/cxl/acpi.c                     | 11 +++++++++--
 drivers/cxl/core/hdm.c                 |  4 ++--
 drivers/cxl/core/port.c                |  2 +-
 drivers/cxl/core/region.c              | 36 +++++++++++++++++++++++++---------
 drivers/pci/Kconfig                    |  6 ------
 mm/Kconfig                             | 10 +++++++---
 tools/testing/cxl/test/cxl_translate.c | 26 ++++++++++++++----------
 8 files changed, 67 insertions(+), 38 deletions(-)
