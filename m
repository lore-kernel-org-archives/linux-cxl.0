Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0021CC4F;
	Mon,  1 Dec 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610402; cv=none; b=OMu76iE8OWWh3LGo1ww/HERo9dWGKVVPyUJA//7eXJouCuWchiYjLQe40RFc5XaU+0EDnzeiYZnnzk/i6oDwkIBeyTgcJEgv8bCLX1ZTOceCrsgpGBcJG1WpMq1dfCSOutqx70mYMQZ/7ZuiHqN0/LTQi5aedtGPggs2+XX+UzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610402; c=relaxed/simple;
	bh=ar6jZ4kgTl5VN6QP7NgBnmFU7TLzWYMXl5sW1h/G0K4=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=CYsEbTKF7BcU9sGUwTsKp1VREFzrX5cDO0kbFn1jFwB2H4WaHF2S7tjOkleHnJWMkVrVBV53tfOuQ3DfeAbebZJbIuw7rkuCMJSr4BGJVTO7Bc11DUs9oaIYp57z00SgcziYFTc9SXq59LWFlWkFyxWSI0JEZttD0s8jwBsrEAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ltxoXLri; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ltxoXLri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764610400; x=1796146400;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=ar6jZ4kgTl5VN6QP7NgBnmFU7TLzWYMXl5sW1h/G0K4=;
  b=ltxoXLri34s60rBqyJfzZ165BgsZWS5uovGauBlr+svW7qTzuRQJeixJ
   ptVEsWdjYl+yPoZ5ya1BF661vHfXCV88umkjMG31pEisaG7O1ETjyrOyF
   1WsUTV+JinVwb4DY1FU5dNUEbVCuN2iVfeCOGaMrxhpsMIVotj9O2POLp
   JaBddYlnhbTn/uJ2qRKSBkZiZGFSCBtJ2EXJj6M9JFu6DoORM8faRWJ2z
   8+oexJmrq/wLCUbmsQ42AOiW5pE2dq135KiHqisTDh2kaRrr7XgBRic8w
   rQo54eCYs2pfd5CbwBrjWy5i7V8NBgNTRfWxeELKmDp16SMml06c0z5C5
   w==;
X-CSE-ConnectionGUID: Vlzrj25+S2KPIRt1D8D7Fw==
X-CSE-MsgGUID: Kt0tm2R7QwmhMA6zkngoOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66516334"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66516334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:33:20 -0800
X-CSE-ConnectionGUID: AIxx0RrzRseL+GDM34468g==
X-CSE-MsgGUID: /7+INt8ZS1SEFhrZplaJrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="198333928"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.120]) ([10.125.111.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 09:33:20 -0800
Message-ID: <59b991e0-d7dd-4285-b052-c3574249409f@intel.com>
Date: Mon, 1 Dec 2025 10:33:18 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 6.19
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.19

...to receive a collection of changes for CXL.

The additions of note are adding CXL region remove support for locked CXL decoders,
adding unit testing support for XOR address translation, and adding unit testing
support for extended linear cache.

These have all appeared in -next for more than a week with no reported issues.

---

The following changes since commit e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c:

  Linux 6.18-rc5 (2025-11-09 15:10:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.19

for you to fetch changes up to ea5514e300568cbe8f19431c3e424d4791db8291:

  Merge branch 'for-6.19/cxl-misc' into cxl-for-next (2025-11-18 16:27:58 -0700)

----------------------------------------------------------------
cxl for v6.19

Misc:
- Remove incorrect page-allocator quirk section in documentation.
- Remove unused devm_cxl_port_enumerate_dports() function.
- Fix typo in cdat.c code comment.
- Replace use of system_wq with system_percpu_wq
- Add locked CXL decoder support for region removal.
- Return when generic target updated
- Rename region_res_match_cxl_range() to spa_maps_hpa()
- Clarify comment in spa_maps_hpa()

Enable unit testing for XOR address translation of SPA to DPA and vice versa.
- Refactor address translation funcs for testing in cxl_region.
- Make the XOR calculations available for testing.
- Add cxl_translate module for address translation testing in cxl_test.

Extended Linear Cache changes:
- Add extended linear cache size sysfs attribute.
- Adjust failure emission of extended linear cache detection in cxl_acpi.
- Added extended linear cache unit testing support in cxl_test

Preparation refactor patches for PRM translation support.
- Simplify cxl_rd_ops allocation and handling.
- Group xor arithmetric setup code in a single block.
- Remove local variable @inc in cxl_port_setup_targets()

----------------------------------------------------------------
Alejandro Lucero (1):
      cxl/test: remove unused mock function for cxl_rcd_component_reg_phys()

Alison Schofield (5):
      cxl/region: Refactor address translation funcs for testing
      cxl/acpi: Make the XOR calculations available for testing
      cxl/test: Add cxl_translate module for address translation testing
      cxl/test: Remove ret_limit race condition in mock_get_event()
      cxl/test: Assign overflow_err_count from log->nr_overflow

Alok Tiwari (1):
      cxl: fix typos in cdat.c comments

Dave Jiang (16):
      cxl: Adjust extended linear cache failure emission in cxl_acpi
      cxl/region: Add support to indicate region has extended linear cache
      cxl: Add handling of locked CXL decoder
      acpi/hmat: Return when generic target is updated
      cxl: Rename region_res_match_cxl_range() to spa_maps_hpa()
      cxl: Clarify comment in spa_maps_hpa()
      Merge branch 'for-6.19/cxl-misc' into cxl-for-next
      Merge branch 'for-6.19/cxl-addr-xlat' into cxl-for-next
      Merge branch 'for-6.19/cxl-elc' into cxl-for-next
      Merge branch 'for-6.19/cxl-prm' into cxl-for-next
      cxl/test: Standardize CXL auto region size
      cxl/test: Add cxl_test CFMWS support for extended linear cache
      cxl/test: Add support for acpi extended linear cache
      Merge branch 'for-6.19/cxl-elc-test' into cxl-for-next
      Merge branch 'for-6.19/cxl-misc' into cxl-for-next
      Merge branch 'for-6.19/cxl-misc' into cxl-for-next

Gregory Price (1):
      Documentation/driver-api/cxl: remove page-allocator quirk section

Li Ming (1):
      cxl/port: Remove devm_cxl_port_enumerate_dports()

Marco Crivellari (1):
      cxl/pci: replace use of system_wq with system_percpu_wq

Robert Richter (3):
      cxl: Simplify cxl_rd_ops allocation and handling
      cxl/acpi: Group xor arithmetric setup code in a single block
      cxl/region: Remove local variable @inc in cxl_port_setup_targets()

 Documentation/ABI/testing/sysfs-bus-cxl            |  11 +-
 .../driver-api/cxl/allocation/page-allocator.rst   |  31 --
 drivers/acpi/numa/hmat.c                           |  11 +-
 drivers/cxl/acpi.c                                 |  73 ++--
 drivers/cxl/core/cdat.c                            |   4 +-
 drivers/cxl/core/hdm.c                             |   3 +
 drivers/cxl/core/pci.c                             |  87 +---
 drivers/cxl/core/port.c                            |   1 -
 drivers/cxl/core/region.c                          | 313 ++++++++++-----
 drivers/cxl/cxl.h                                  |  29 +-
 drivers/cxl/cxlpci.h                               |   1 -
 drivers/cxl/pci.c                                  |   2 +-
 tools/testing/cxl/Kbuild                           |   3 +-
 tools/testing/cxl/test/Kbuild                      |   1 +
 tools/testing/cxl/test/cxl.c                       |  86 ++--
 tools/testing/cxl/test/cxl_translate.c             | 445 +++++++++++++++++++++
 tools/testing/cxl/test/mem.c                       |  11 +-
 tools/testing/cxl/test/mock.c                      |  52 +--
 tools/testing/cxl/test/mock.h                      |   4 +-
 19 files changed, 840 insertions(+), 328 deletions(-)
 create mode 100644 tools/testing/cxl/test/cxl_translate.c
