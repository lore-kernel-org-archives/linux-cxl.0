Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8A41F76BB
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536353; cv=none; b=tceJ/rHqjaXOjEx0B8jCnEoW/78lSWFk4Ec+bRZi32WoThgTpvc71OOsfwhVnh4yGr6Z4RxYfSkexKqg4wCFDK7w2TitxwxH8MhWVGkx8oPVzA51CGXcojcRdAzh55UmQyCsZEUUvFf3sqgz7arR6X46GkATMgTGahPLj12HIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536353; c=relaxed/simple;
	bh=NlsQpIYyiwwfY0nj3DObElEwBMRxlKhKQU+Qep9VIL4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=q5ZLrX1jqXtWQOBBTnBEPw0YzOFrMT1QYTISn5+XKWEJ0xyE/qreLKVM0Vw1qa7LVg+dhdtk9k37vT0KowUzeqtGkf8ZvlV7KIE30m9nA//BEMyel1Mwnx1z7VX0f8b0Z71dW5Hx8hWeGmwr9OagjjG6F5Eryu2QlhQyjDWe5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kRiJVJlg; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kRiJVJlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737536352; x=1769072352;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NlsQpIYyiwwfY0nj3DObElEwBMRxlKhKQU+Qep9VIL4=;
  b=kRiJVJlgrj6oqQHIURx0Ak8uv07HAVk5LKfrK9Wj3/2TQa+lj2k9Xz2Q
   ucsxYiAmZLnV4v8CORAzQqhAeH3ISb/DxSd9TCLDAW9uzKbUuXs+ZzaYH
   4MvZ8EfdS4sNO5iDq/sHNc2xj4MqGGwCOtSOM/yds2UktA89nAxaKAbNb
   QBcLH1G6HA+DYpMg4SmN/kmiiuqWvjvjTvQk328weo4KDrHVtlGYYcNhA
   TvOM5aj9CTPRs/HFamIGBQHNcH36Es08mT2Cq0Tiis+xC4bLW7ZJMeDNZ
   /PpO183x0JBcuQ3zwfk6P8oHhXaMlO/wSXdKxJR7eUC1MNxn4R6QjMunv
   A==;
X-CSE-ConnectionGUID: V6ZZb3AwSuqO7Wza0nGadw==
X-CSE-MsgGUID: yE8BHqBjTRyOslz/jcX5/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55395945"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="55395945"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:59:11 -0800
X-CSE-ConnectionGUID: qSMVhNqHT4ueFsiogMAabg==
X-CSE-MsgGUID: 8oB8Z/A6Qnah7nTnCWQXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130378038"
Received: from ldmartin-desk2.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.77])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 00:59:11 -0800
Subject: [PATCH v2 0/5] cxl: DPA partition metadata is a mess...
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Alejandro Lucero <alucerop@amd.com>, dave.jiang@intel.com,
 Jonathan.Cameron@huawei.com
Date: Wed, 22 Jan 2025 00:59:10 -0800
Message-ID: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Changes since v1: [0]
- Stop requiring PMEM to be at partition-index 1, i.e. remove empty
  partitions. (Jonathan)
- Document the assumptions and implementation of
  {request,release}_skip() (Jonathan, Alejandro)
- Kill 'enum cxl_decoder_mode' to cleanup remainder of hard-coded
  expectations of a static PMEM partition always being present

[0]: http://lore.kernel.org/173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com

---

As noted in patch3, the pending efforts to add CXL Accelerator (type-2)
device [1], and Dynamic Capacity (DCD) support [2], tripped on the
no-longer-fit-for-purpose design in the CXL subsystem for tracking
device-physical-address (DPA) metadata.

In fact there was no design at all, just a couple of open-coded 'struct
resource' instances for 'ram' and 'pmem' and a pile of explicit code
referencing those resources directly.

See patch3 for more details on the specific problems that caused, and
patch4 for the eyesore reduction of making the DPA allocation algorithm
partition number agnostic.

The motivation with this effort is to make it easier to land the Type-2
and DCD series.

[1]: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com
[2]: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com

---

Dan Williams (5):
      cxl: Remove the CXL_DECODER_MIXED mistake
      cxl: Introduce to_{ram,pmem}_{res,perf}() helpers
      cxl: Introduce 'struct cxl_dpa_partition' and 'struct cxl_range_info'
      cxl: Make cxl_dpa_alloc() DPA partition number agnostic
      cxl: Kill enum cxl_decoder_mode


 drivers/cxl/core/cdat.c      |   74 +++++-----
 drivers/cxl/core/core.h      |    4 -
 drivers/cxl/core/hdm.c       |  310 +++++++++++++++++++++++++++++++-----------
 drivers/cxl/core/mbox.c      |   66 +++------
 drivers/cxl/core/memdev.c    |   43 ++----
 drivers/cxl/core/port.c      |   20 ++-
 drivers/cxl/core/region.c    |  138 ++++++++++---------
 drivers/cxl/cxl.h            |   40 +----
 drivers/cxl/cxlmem.h         |   94 +++++++++++--
 drivers/cxl/mem.c            |    2 
 drivers/cxl/pci.c            |    7 +
 tools/testing/cxl/test/cxl.c |   22 +--
 tools/testing/cxl/test/mem.c |    7 +
 13 files changed, 511 insertions(+), 316 deletions(-)

base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
