Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3EA41207
	for <linux-cxl@vger.kernel.org>; Thu, 11 Apr 2024 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878635; cv=none; b=YEh7L7cZCmrTBXhpIXyafUE29eNNVo8dkRvixRXcOb9AKYzFq+007Q6IdMKNPNsgKpu2sN0QkYqdKgy5zKdnl4kZWxhlWr9l2X+7K9fyIEWSWq7bNGTiXo3l3I2BEP9O0mZF7dMlzj7Ul57sz7m6VD5B6k4SefFt9ynPEqtmjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878635; c=relaxed/simple;
	bh=jWEn95MivdTzCOTeOWA0EP1pAcGrsXTtIzcBl/6j6ys=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tzgkzbG/7QvgJH4TaX/tNk87JePRp85YtlXvXB92+aZFEC1U0nUFvYzm0ePyV09EIBIrwLN4VPI+BdbcE3d0Wdgb9nmEG6PfACONrt5xm4GP5Q0rOtQpBg4kvQf6iI8NZB2fRNs8YQR1Rzpx8eCw/2DotOYvcqezNg1YD+FJ3PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/T7da/E; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/T7da/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712878633; x=1744414633;
  h=message-id:date:mime-version:from:subject:to:cc:
   content-transfer-encoding;
  bh=jWEn95MivdTzCOTeOWA0EP1pAcGrsXTtIzcBl/6j6ys=;
  b=F/T7da/E6UdHmIrrkg8DqQ5O6KgHur5t8zNmW5L/pKqiKGsp18VgRXgM
   zYAG/y2rD32SxZkwXVIvJ7dk44JPHC3mSYxW24Ycl+5cMGRDGsS1IlMzC
   GT48rIjtmtNE2o6zRhJN2DJBr3nlndGLqnkwUFeBa0dpT8Mrc3e4T4mBQ
   lRWgEBp7ITlyTclhp5SYlHOOsol9apTrKX/Mr73A9ipBAOro7Zb2DGO1Y
   xwzC4qywGLAgW+hTqy6fJn7cDZgec11/xRF2MPUrQb+dVBoipbQW4MoiV
   iR8E7RwUNCcK3vGXfTQB6Xf067c6iAFFEZ6zLW5SuTlcb1KXhULWCPEDt
   Q==;
X-CSE-ConnectionGUID: yuxc68QcSG6D9xVqGBZaVQ==
X-CSE-MsgGUID: DxSQOBa+SJaGDtE6JVlnSg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8240516"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="8240516"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:37:11 -0700
X-CSE-ConnectionGUID: QhwSohbmRZe9ueLx6k2gSg==
X-CSE-MsgGUID: TFn2V/8tTlmmGbzTLueiug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="58485012"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.164.35]) ([10.213.164.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:37:11 -0700
Message-ID: <02842127-1716-4372-a77e-d742d7dcab8a@intel.com>
Date: Thu, 11 Apr 2024 16:37:10 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.9-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.9-rc4

...to receive a collection of fixes for the CXL subsystem.

A set of patches to deal with fixing the computation of access_coordinate performance data computed for the CXL device path. 
- An error in the PCI topology walk is addressed to pick up the host bridge performance data from the correct location along the path. 
- The incorrect calculation while doing picoseconds to nanoseconds conversion of the CDAT latency data is fixed. 
- And a check to verify that the access_coordinate data are valid (not zeroes) is added in the computation path to prevent failed perf data from leaking to the user space via sysfs.

Fix an of off by 1 indexing of Clear Event Record handles in cxl_clear_event_record().

Fix of a use before init of a variable map->reg_type in cxl_decode_regblock().

Fix of initialization of mbox_cmd.size_out in cxl_mem_get_records_log() before sending to hardware.

This has build success notification from the kbuild-robot. They have been in the -next for a week with no reported issues.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.9-rc4

for you to fetch changes up to 7bcf809b1e7889ab7e75fe1fcf8f1a98332f36d2:

  cxl: Add checks to access_coordinate calculation to fail missing data (2024-04-08 08:25:21 -0700)

----------------------------------------------------------------
cxl fixes for v6.9-rc4

- Fix index of Clear Event Record handles in cxl_clear_event_record().
- Fix use before init of map->reg_type in cxl_decode_regblock().
- Fix initialization of mbox_cmd.size_out in cxl_mem_get_records_log().
- Series fixing CXL path access_coordinate computation.
  - Remove unneded check of iter in loop.
  - Fix of retrieving of access_coordinate in PCI topology walk.
  - Fix of incorrect region access_coordinate data calculation.
  - Consolidate of access_coordinates attached to downstream port
    context.
  - Add check to validate access_coordinate validity to prevent
    incorrect data being exposed via sysfs.

----------------------------------------------------------------
Dave Jiang (6):
      cxl/core/regs: Fix usage of map->reg_type in cxl_decode_regblock() before assigned
      cxl: Remove checking of iter in cxl_endpoint_get_perf_coordinates()
      cxl: Fix retrieving of access_coordinates in PCIe path
      cxl: Fix incorrect region perf data calculation
      cxl: Consolidate dport access_coordinate ->hb_coord and ->sw_coord into ->coord
      cxl: Add checks to access_coordinate calculation to fail missing data

Kwangjin Ko (1):
      cxl/core: Fix initialization of mbox_cmd.size_out in get event

Yuquan Wang (1):
      cxl/mem: Fix for the index of Clear Event Record Handle

 drivers/cxl/acpi.c           |  13 +---
 drivers/cxl/core/cdat.c      | 152 ++++++++++++++++++++++---------------------
 drivers/cxl/core/mbox.c      |   5 +-
 drivers/cxl/core/port.c      | 114 +++++++++++++++++++-------------
 drivers/cxl/core/regs.c      |   5 +-
 drivers/cxl/cxl.h            |   8 +--
 drivers/cxl/cxlmem.h         |   2 +-
 tools/testing/cxl/test/cxl.c |  10 +--
 8 files changed, 164 insertions(+), 145 deletions(-)   
