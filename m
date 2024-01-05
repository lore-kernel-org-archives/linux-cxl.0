Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBA2E412
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cCLCKo5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704492911; x=1736028911;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FJemlQ7OSepss+F2iYBw4m1iWlVCwYARitS1BxCw8HM=;
  b=cCLCKo5kQjzIBEkqMswdnmyhmAQ5YbatLP4oaS8Gg73A8z5uvBOsjl5A
   zYVJbzJwNp0TsKtZHKDJoQ6nAj/sw/meqL6D6o07DqUuUikAQtGpf31BO
   WayzNWcI+W5NKP8kAYBT5mFxoj3xOTurYvIRwg/8pitaCcgBgVdb1dbQK
   r2pjabuI8irR0Ocwhb5jvqTZfT1LBY1UZK29jWhfj6qxcwoPmd0myu/fo
   fFq7YWa9oZH7KYs19sEkk3QaXSXQKVdNC7OV5nGzhR45IssMbgvDEJw1u
   R5DiKcnEn2cYM3qV7pJdzIB5gx8KSKfsKY0/7Fnh9Nxl1TaoB/02G3BJS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="11082586"
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="11082586"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,335,1695711600"; 
   d="scan'208";a="22608491"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 14:07:28 -0800
Subject: [PATCH v6 0/5] cxl: find_cxl_root() related cleanups
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Robert Richter <rrichter@amd.com>, Ira Weiny <ira.weiny@intel.com>,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net,
 rrichter@amd.com
Date: Fri, 05 Jan 2024 15:07:27 -0700
Message-ID: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

v6:
- Fix breakage in previous series for device_find_child() (Dan)
- Move DEFINE_FREE() for put_cxl_root() to first patch (Dan)
- Don't touch put_device() until final cleanup. (Dan)
- Add review tag from Ira.

This series provides a number of small cleanups to make fix_cxl_root()
and related code more readable and safer.

---

Dave Jiang (5):
      cxl: Introduce put_cxl_root() helper
      cxl: Convert find_cxl_root() to return a 'struct cxl_root *'
      cxl: Fix device reference leak in cxl_port_perf_data_calculate()
      cxl: Refactor to use __free() for cxl_root allocation in cxl_find_nvdimm_bridge()
      cxl: Refactor to use __free() for cxl_root allocation in cxl_endpoint_port_probe()


 drivers/cxl/acpi.c      |  6 ++----
 drivers/cxl/core/cdat.c | 22 ++++++++++++++--------
 drivers/cxl/core/pmem.c |  8 ++++----
 drivers/cxl/core/port.c | 13 +++++++++++--
 drivers/cxl/cxl.h       | 17 ++++++++++-------
 drivers/cxl/port.c      |  5 +++--
 6 files changed, 44 insertions(+), 27 deletions(-)


