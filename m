Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4F1DF744;
	Wed, 29 Jan 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168095; cv=none; b=f+BkmLfCfv7gdpZAn2DflFvoViUzbq6sIo3ICfP0/adMCqzOZBEtjRqqiRlWseQpH2fgYBR3mHvpun1SFCJYqPDRVMn8RAyvqRoSLWCTBlp4Gdd8xFyLlmVvlQ19HvLTds+N0lZBYqXB5ojtSaXUWh1hNo02KlOL+sN+esooVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168095; c=relaxed/simple;
	bh=bLU+NXU88bYMBxYSA0aldNZBNdo9lQaZQZw0KuPoDVs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pxaA8jApvDrJrGujyTSuWo4OxRBnLaIjJwwucBv4kDpqJDPXz2JdSbheXBvvoQpZtqY5+kAEieS2d10gvyH60kbME4W9wHpmgfvrYnKu6xbOweEApJJhXQ6QammL12rp4ocyNHDerWJbXRD22+NG602HR/puekuQYg9tFr8OcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDya26Zh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDya26Zh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738168093; x=1769704093;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=bLU+NXU88bYMBxYSA0aldNZBNdo9lQaZQZw0KuPoDVs=;
  b=KDya26Zh62rxucIuPiAZjAh46mwB7/nKrrfOJxqo5kD0YE+4Z3e1ClCV
   eAocePZujyqTWCArZoL+2TOeAY69VYEW471ttKAfBpCl4y/NBKpZV/+eG
   UBRAbyfcZs5ayAYYp1+SyA83L/Y/5dHSs7bjG/LgMsPu0AWjP/K2ypsd+
   dJrhV7AgrFeC5ZMGngIAeDneO+T8ouxCrlxksCRpR1yAgT3S6/dAKzZAN
   CudGXXJqPa3QpfYkK5DIhfnwJ2jCb+1nZipSUtgOXtPrP5bJ/UH4eWSZf
   lvVmQELbvGmrBZQnd0SDWUj4g/ipY3bu1w9n2XhD2x6HpY+YHAeptLJ5G
   g==;
X-CSE-ConnectionGUID: GLWfrhCJQZG/V0XL19CnIA==
X-CSE-MsgGUID: H6baEUzVRQum73AcGYRKuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38793415"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38793415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 08:28:12 -0800
X-CSE-ConnectionGUID: QP+89bJmTZuIbm4rgLwk6Q==
X-CSE-MsgGUID: 1rK6eANyRkqAgi9LzSQvvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146276355"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.127]) ([10.125.108.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 08:28:12 -0800
Message-ID: <96c924e7-a684-45c9-b23d-6401ae727159@intel.com>
Date: Wed, 29 Jan 2025 09:28:11 -0700
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
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 6.14
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from
  
git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.14

...to receive a small set of changes for CXL for v6.14.  The changes includes
a tweak to the HMAT output that was acked by Rafael, a prep patch for CXL type2
devices support that's coming soon, refactoring of the CXL regblock
enumeration code, and a series of patches to update the event records to CXL
spec r3.1.

These all have appeared in -next for a few days with no reported issues.

---

The following changes since commit fc033cf25e612e840e545f8d5ad2edd6ba613ed5:

  Linux 6.13-rc5 (2024-12-29 13:15:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.14

for you to fetch changes up to 448a60e85ae2afe2cb760f5d2ed2c8a49d2bd1b4:

  cxl/core/regs: Refactor out functions to count regblocks of given type (2025-01-22 08:55:21 -0700)

----------------------------------------------------------------
cxl changes for v6.14

- Move HMAT printouts to pr_debug()
- Add CXL type2 support to cxl_dvsec_rr_decode() in preparation for
  type2 support
- A series that updates CXL event records to spec r3.1 and related
  changes
- Refactoring of cxl_find_regblock_instance() to count regblocks

----------------------------------------------------------------
Alejandro Lucero (1):
      cxl/pci: Add CXL Type 1/2 support to cxl_dvsec_rr_decode()

Dan Williams (1):
      ACPI/HMAT: Move HMAT messages to pr_debug()

Huaisheng Ye (1):
      cxl/core/regs: Refactor out functions to count regblocks of given type

Shiju Jose (6):
      cxl/events: Update Common Event Record to CXL spec rev 3.1
      cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
      cxl/events: Update General Media Event Record to CXL spec rev 3.1
      cxl/events: Update DRAM Event Record to CXL spec rev 3.1
      cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
      cxl/test: Update test code for event records to CXL spec rev 3.1

 drivers/acpi/numa/hmat.c      |  24 ++--
 drivers/cxl/core/pci.c        |   6 +-
 drivers/cxl/core/regs.c       |  56 +++++----
 drivers/cxl/core/trace.h      | 259 +++++++++++++++++++++++++++++++++++-------
 drivers/cxl/cxl.h             |   6 +-
 drivers/cxl/pci.c             |   6 +-
 drivers/cxl/port.c            |   2 +-
 include/cxl/event.h           |  28 +++--
 tools/testing/cxl/test/mem.c  |  23 +++-
 tools/testing/cxl/test/mock.c |   6 +-
 10 files changed, 319 insertions(+), 97 deletions(-)
