Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14D3594A
	for <linux-cxl@vger.kernel.org>; Wed,  1 Oct 2025 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361742; cv=none; b=Hh4+/0lEN/O9Ue30x2O5YYUkl7tuRFkfOBv3k5AOdEoWoUy0TsF+EeO70oC5qvC4hlIdiA0hM86qBUlREYS8XHnRsR+0nmLJvyocotxyXUjPt9L8PAcPEk5MJpyF6H4T3Mx+Z5+++EO4/Y9KUyhp7supVW1eZb4MFCmRBdLjAow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361742; c=relaxed/simple;
	bh=s7P0MFCgA3siIAmqKl4uKfP54apftzyVl5XSu73D6RY=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=crt1WbbNu1e4nL2wf2Q5TQA7pIF4PbkBSAOb1jbOO2ALaLVJmWvL/LxwthK9be1ygRwL6lHIOyn3jADDmvu9GD4GbWhPEzXe3ONnQD7AEaWkqzHpUMFueAWgSXLa8WWsl/8R/PgL+NGxszDaLKknHYoOlQU5J60pFdX3gEGNMb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQFlnI6u; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQFlnI6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759361741; x=1790897741;
  h=message-id:date:mime-version:cc:from:subject:to:
   content-transfer-encoding;
  bh=s7P0MFCgA3siIAmqKl4uKfP54apftzyVl5XSu73D6RY=;
  b=kQFlnI6uve1q5JwlpTYCUz/U5H/qr8FuumXqxane9JwxQGs3QCOHlKTT
   8mbJSd/+b1YoaP4brszBLpI+BZiwxDGjFtHuejxyeN4NDFOGt8i6Qkl8g
   84K912StcAomrdUBeSu+ywrob87n/2rp1vPy1RcGnl4roYuxIyV2tT1Mw
   uMtnF89t6mlg8/poCc88hDOOecSLf0xTmn/jiMl9ke17jT9ATVdaVNbeU
   8jKj0AMQe/NyN33pEXDDYrHKPVLsqtmKsxefwc83WvY1FsEYR6S+8iJto
   Y8VLwk2TzFqqY/9+qMLaZ3anJJOKLenoB1F8oIGvJcQoDwKi6H38YAV9D
   A==;
X-CSE-ConnectionGUID: Tm53UFsxRSmGP6SMisaG1w==
X-CSE-MsgGUID: JhhF3VzySR6a6HHrewXZog==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="71896343"
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="71896343"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 16:35:37 -0700
X-CSE-ConnectionGUID: 81eXepEjT4OEFSul0MjYSg==
X-CSE-MsgGUID: /8gF6vIjRtKCgjAJ2wNrvw==
X-ExtLoop1: 1
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.109.218]) ([10.125.109.218])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 16:35:36 -0700
Message-ID: <6be82a4c-859b-4b5f-9a91-c398a319d38e@intel.com>
Date: Wed, 1 Oct 2025 16:35:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) changes for 6.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.18

...to receive a collection of CXL changes.

The changes includes a series that adds poison inject support, a series that
fixes CXL access coordinates update tied to CXL memory onlining, and a series
that delays the enumeration of downstream switch ports for CXL hierarchy to
ensure that the CXL link is established at the time of enumeration to address
a few issues observed on AMD and Intel platforms.

Some of the early patches in this pull request still have the link tag generated
by b4. Since they've been soaking in -next for a while and I chose not to
touch the patches to drop the link tags. The link tags will not be added in the
future unless there are information of interest to be pointed to.

These have all appeared in -next for a more than a week with no reported issues.

---

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.18

for you to fetch changes up to 46037455cbb748c5e85071c95f2244e81986eb58:

  Merge branch 'for-6.18/cxl-delay-dport' into cxl-for-next (2025-09-18 14:34:51 -0700)

----------------------------------------------------------------
CXL changes for v6.18

Misc changes:
- Use str_plural() instead of open code for emitting strings.
- Use str_enabled_disabled() instead of ternary operator
- Fix emit of type resource_size_t argument for validate_region_offset()
- Typo fixup in CXL driver-api documentation
- Rename CFMWS coherency restriction defines
- Add convention doc describe dealing with x86 low memory hole and CXL

Poison Inject support series:
- Move hpa_to_spa callback to new reoot decoder ops structure
- Define a SPA to HPA callback for interleave calculation with XOR math
- Add support for SPA to DPA address translation with XOR
- Add locked variants of poison inject and clear functions
- Add inject and clear poison support by region offset

CXL access coordinates update fix series:
- A comment update for hotplug memory callback prority defines
- Add node_update_perf_attrs() for updating perf attrs on a node
- Update cxl_access_coordinates() to use the new node update function
- Remove hmat_update_target_coordinates() and related code

CXL delayed downstream port enumeration and initialization series
- Add helper to detect top of CXL device topology and remove open coding
- Add helper to delete single dport
- Add a cached copy of target_map to cxl_decoder
- Refactor decoder setup to reduce cxl_test burden
- Defer dport allocation for switch ports
- Add mock version of devm_cxl_add_dport_by_dev() for cxl_test
- Adjust the mock version of devm_cxl_switch_port_decoders_setup() due to
  cxl core usage
- Setup target_map for cxl_test decoder initialization
- Change SSLBIS handler to handle single dport
- Move port register setup to when first dport appears

----------------------------------------------------------------
Alison Schofield (5):
      cxl: Move hpa_to_spa callback to a new root decoder ops structure
      cxl: Define a SPA->CXL HPA root decoder callback for XOR Math
      cxl/region: Introduce SPA to DPA address translation
      cxl/core: Add locked variants of the poison inject and clear funcs
      cxl/region: Add inject and clear poison by region offset

Dave Jiang (18):
      Merge branch 'for-6.18/cxl-poison-inject' into cxl-for-next
      cxl: Fix emit of type resource_size_t argument for validate_region_offset()
      mm/memory_hotplug: Update comment for hotplug memory callback priorities
      drivers/base/node: Add a helper function node_update_perf_attrs()
      cxl, acpi/hmat: Update CXL access coordinates directly instead of through HMAT
      acpi/hmat: Remove now unused hmat_update_target_coordinates()
      Merge branch 'for-6.18/cxl-update-access-coordinates' into cxl-for-next
      cxl: Add helper to detect top of CXL device topology
      cxl: Add helper to delete dport
      cxl: Add a cached copy of target_map to cxl_decoder
      cxl/test: Refactor decoder setup to reduce cxl_test burden
      cxl: Defer dport allocation for switch ports
      cxl/test: Add mock version of devm_cxl_add_dport_by_dev()
      cxl/test: Adjust the mock version of devm_cxl_switch_port_decoders_setup()
      cxl/test: Setup target_map for cxl_test decoder initialization
      cxl: Change sslbis handler to only handle single dport
      cxl: Move port register setup to when first dport appear
      Merge branch 'for-6.18/cxl-delay-dport' into cxl-for-next

Davidlohr Bueso (1):
      cxl/acpi: Rename CFMW coherency restrictions

Fabio M. De Francesco (1):
      cxl: Documentation/driver-api/cxl: Describe the x86 Low Memory Hole solution

Nai-Chen Cheng (1):
      cxl/region: use str_enabled_disabled() instead of ternary operator

Rakuram Eswaran (1):
      Documentation/driver-api: Fix typo error in cxl

Xichao Zhao (1):
      cxl/hdm: Use str_plural() to simplify the code

 Documentation/ABI/testing/debugfs-cxl              |  87 ++++++
 Documentation/driver-api/cxl/conventions.rst       | 135 +++++++++
 Documentation/driver-api/cxl/maturity-map.rst      |   2 +-
 .../driver-api/cxl/platform/bios-and-efi.rst       |   2 +-
 drivers/acpi/numa/hmat.c                           |  34 ---
 drivers/base/node.c                                |  38 +++
 drivers/cxl/acpi.c                                 |  46 +--
 drivers/cxl/core/cdat.c                            |  36 +--
 drivers/cxl/core/core.h                            |  12 +-
 drivers/cxl/core/hdm.c                             | 107 +++++--
 drivers/cxl/core/memdev.c                          |  60 ++--
 drivers/cxl/core/pci.c                             |  89 ++++++
 drivers/cxl/core/port.c                            | 319 ++++++++++++++++-----
 drivers/cxl/core/region.c                          | 266 ++++++++++++++++-
 drivers/cxl/cxl.h                                  |  57 +++-
 drivers/cxl/cxlmem.h                               |   2 +
 drivers/cxl/cxlpci.h                               |   2 -
 drivers/cxl/port.c                                 |  47 +--
 include/acpi/actbl1.h                              |   4 +-
 include/linux/acpi.h                               |  12 -
 include/linux/memory.h                             |   6 +-
 include/linux/node.h                               |   8 +
 tools/testing/cxl/Kbuild                           |   7 +-
 tools/testing/cxl/cxl_core_exports.c               |  22 ++
 tools/testing/cxl/exports.h                        |  13 +
 tools/testing/cxl/test/cxl.c                       | 133 +++++++--
 tools/testing/cxl/test/mock.c                      |  96 +++----
 tools/testing/cxl/test/mock.h                      |   9 +-
 28 files changed, 1261 insertions(+), 390 deletions(-)
 create mode 100644 tools/testing/cxl/exports.h
