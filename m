Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1CF28680;
	Wed, 15 May 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715794928; cv=none; b=OM1wn5JUvsvvHsoZMJHCUbmNqd5HVegK1OTGD79JYmaLY1YWIaEuVFwwlKvNriIvOJMeSqlxDLfC/ngXGwcp6tATgagPxy4/SVHLsnNR96gL4wGBEvvHh+arhziPuwAFBtzkXhq2mEPwqlaEBseXVlzFKtF/lWc9ItbobEghw7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715794928; c=relaxed/simple;
	bh=8yFwQFqY7nFSNnMmWdr9xFSkxUvwNuY1boF6Y0JMpSQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ay6qGL6603Hk41gnV2xvlul2KC2OUsbDkIfMuEE4djeMZpYV/htpzN1bUlgKe2NvLLNwt62lUyUR05raF73yguiTkcAoVZJbU60TYmabSeKoitBxsiaVNyoMLpky+6keipkBxwP9hbVtNH5d+5V2Y+msQTeeAcax8Om7o0NSypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpOqpK4M; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpOqpK4M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715794927; x=1747330927;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=8yFwQFqY7nFSNnMmWdr9xFSkxUvwNuY1boF6Y0JMpSQ=;
  b=VpOqpK4M6Ls9TB6JWdlkPTz3XgdjkJRPuJ1gp9nt8W897WVP/D/LozOR
   godG94AfUk2qRNsReG596MrqxTRKT8g4MMRLET8BjcF4AoKgeY9kJJnrE
   mrLhsNmmxHzLK2HO+my7J0F72Et50rMR2roCohRDz0GHhZoViPuI2soNC
   AUhmGzqgl8xkEXbHwPON4lWrzHtrHORMmSGbg9JsCNj9NVB93jlGetrhp
   stfdSWRparfsztymXywoj8M88cT0cS24PeVQPVIIW7gJtgBiU3t0Fn4KA
   v//SQIVdcMdf0MaxJe7DUh02KGVbWUI3i3uQsWpk8CdDfqbpPoTqelQXY
   g==;
X-CSE-ConnectionGUID: YjieAHdBRsSDMHKRsJQZ3Q==
X-CSE-MsgGUID: x3wZNKxITEyfQFFvnZgGgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11676908"
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="11676908"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 10:42:06 -0700
X-CSE-ConnectionGUID: EyEgZ7vjSQGs6ajSTGIv6A==
X-CSE-MsgGUID: 9YIJB80hT2ONOk50X/lFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,162,1712646000"; 
   d="scan'208";a="31719459"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 10:42:05 -0700
Message-ID: <99729afb-d538-4172-9659-ea12b993c6c3@intel.com>
Date: Wed, 15 May 2024 10:42:04 -0700
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
 linux-kernel <linux-kernel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) for 6.10
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.10

...to receive 3 feature updates and some fixes and cleanups for CXL.

Three CXL mailbox passthrough commands are added to support the populating and clearing
of vendor debug logs.

The second feature is adding support of Device Phyiscal Address (DPA) to Host Physical
Address (HPA) translation for CXL events of cxl_dram and cxl_general media. The support
allows user space to figure out which CXL region the event occured via trace event.

The third feature connects CXL to CPER reporting. If a device is configured for firmware
first, CXL event records are not sent directly to the host. Those records are reported
through EFI Common Platform Error Records (CPER). Support is added to route the CPER
records through the CXL sub-system in order to provide DPA to HPA translation and also
event decoding and tracing. This is useful for users to determine which system issues
may correspond to specific hardware events.

A number of misc cleanups and fixes are also included in this pull request.

The following commits have late tags that were submitted after the commits have been
pushed to cxl/next branch:

866c0674541f cxl: Fix use of phys_to_target_node() for x86
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

d357dd8ad2f1 ("cxl/region: Convert cxl_pmem_region_alloc to scope-based resource management")
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Tested-by: Li Zhijian <lizhijian@fujitsu.com>

This pull request has appeared in the linux-next for more than a week and has build
success notification from kbuild-robot.

---

The following changes since commit e67572cd2204894179d89bd7b984072f19313b03:

  Linux 6.9-rc6 (2024-04-28 13:47:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-for-6.10

for you to fetch changes up to d99f13843237cf9dbdc1bd873a901662b4aee16f:

  cxl/cper: Remove duplicated GUID defines (2024-05-02 12:12:45 -0700)

----------------------------------------------------------------
CXL changes for v6.10 merge window

Topics:
- Add CXL log related mailbox commands
  - Add Get Log Capabilities command
  - Add Get Supported Log Sub-List Commands command
  - Add Clear Log command
- Add series for DPA to HPA translation for CXL events cxl_dram and cxl_general_media
- Add support to send CPER records to CXL for more detailed parsing.

Misc changes and fixes:
- Fix for compile warning of cxl_security_ops
- Add debug message for invalid interleave granularity
- Enhancement to cxl-test event testing
- Add dev_warn() on unsupported mixed mode decoder
- Fix use of phys_to_target_node() for x86
- Use helper function for decoder enum instead of open coding
- Include missing headers for cxl-event
- Fix MAINTAINERS file entry
- Fix cxlr_pmem memory leak
- Cleanup __cxl_parse_cfmws via scope-based resource menagement
- Convert cxl_pmem_region_alloc() to scope-based resource management

----------------------------------------------------------------
Alison Schofield (5):
      cxl/hdm: dev_warn() on unsupported mixed mode decoder
      cxl/trace: Correct DPA field masks for general_media & dram events
      cxl/region: Move cxl_dpa_to_region() work to the region driver
      cxl/region: Move cxl_trace_hpa() work to the region driver
      cxl/core: Add region info to cxl_general_media and cxl_dram events

Dan Williams (2):
      cxl/acpi: Cleanup __cxl_parse_cfmws()
      cxl/region: Convert cxl_pmem_region_alloc to scope-based resource management

Dave Jiang (4):
      cxl: Fix compile warning for cxl_security_ops extern
      Merge remote-tracking branch 'cxl/for-6.10/add-log-mbox-cmds' into cxl-for-next
      Merge remote-tracking branch 'cxl/for-6.10/dpa-to-hpa' into cxl-for-next
      Merge remote-tracking branch 'cxl/for-6.10/cper' into cxl-for-next

Huang Ying (1):
      cxl/hdm: Add debug message for invalid interleave granularity

Ira Weiny (6):
      cxl/test: Enhance event testing
      cxl/hdm: Debug, use decoder name function
      acpi/ghes: Process CXL Component Events
      cxl/pci: Process CPER events
      cxl/cper: Fix non-ACPI-APEI-GHES build
      cxl/cper: Remove duplicated GUID defines

Li Zhijian (1):
      cxl/region: Fix cxlr_pmem leaks

Lukas Bulwahn (1):
      MAINTAINERS: repair file entry in COMPUTE EXPRESS LINK

Robert Richter (1):
      cxl: Fix use of phys_to_target_node() for x86

Sangyun Kim (1):
      cxl/cxl-event: include missing <linux/types.h> and <linux/uuid.h>

Srinivasulu Thanneeru (2):
      cxl/mbox: Add Get Log Capabilities and Get Supported Logs Sub-List commands
      cxl/mbox: Add Clear Log mailbox command

 MAINTAINERS                  |   2 +-
 drivers/acpi/apei/ghes.c     |  84 ++++++++++++++++++++
 drivers/cxl/Kconfig          |   1 +
 drivers/cxl/acpi.c           |  93 +++++++++++++----------
 drivers/cxl/core/core.h      |  14 ++++
 drivers/cxl/core/hdm.c       |  13 ++--
 drivers/cxl/core/mbox.c      |  48 ++++++++++--
 drivers/cxl/core/memdev.c    |  44 -----------
 drivers/cxl/core/region.c    | 177 +++++++++++++++++++++++++++++++++++++------
 drivers/cxl/core/trace.c     |  91 ----------------------
 drivers/cxl/core/trace.h     |  50 ++++++++----
 drivers/cxl/cxl.h            |   7 ++
 drivers/cxl/cxlmem.h         |   3 +
 drivers/cxl/pci.c            |  71 ++++++++++++++++-
 drivers/cxl/pmem.c           |   2 -
 include/linux/cxl-event.h    |  39 ++++++++++
 include/uapi/linux/cxl_mem.h |   3 +
 tools/testing/cxl/test/mem.c |  19 ++++-
 18 files changed, 527 insertions(+), 234 deletions(-)
