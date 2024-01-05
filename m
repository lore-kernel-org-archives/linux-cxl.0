Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CF2114
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iocnhAHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704417487; x=1735953487;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sk4rORHTzXK2l2+wnomA2mUsQQVITOVhcErf4bKMFj0=;
  b=iocnhAHCpjrJWfyLBBSPh6Q7RT+rzKxkxcY40BgxXvfohMixQpigUXfd
   q2LF7nxJ2JllWEzSgvWRRDa6mrQCFNk0OiraZCT5i83c84g+h13KNjMc/
   NX/aRwfONFQzKVWith4GGBBT+8GsElSc2wFvDfpt/pOTH3cv/x4Lcb1IO
   JGxqC7ZByZXE2ezMix8C1Nyuo1tD4cS3NmCQDgqg1KMGNtGpd45U+GyUB
   GcHaoH9D07LXdt6VJylLAN83iNIKbyP6MVLmLYS1M8j+LrdN0Sot25gd3
   nAh3ag/tPPDM8vVE1Fd29ob0AFzcjCwaV1EM8JWBUZiDHg+aWwUmtAH1x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="463802159"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="463802159"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:18:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027613239"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="1027613239"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 17:17:57 -0800
Subject: [PATCH v4 0/6] find_cxl_root() related cleanups
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Thu, 04 Jan 2024 18:17:57 -0700
Message-ID: <170441738812.3632067.2103652995360101907.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series provides a number of small cleanups to make fix_cxl_root()
and related code more readable and safer.

---

Dave Jiang (6):
      cxl: Introduce put_cxl_root() helper
      cxl: Convert find_cxl_root() to return a 'struct cxl_root *'
      cxl: Convert qos_class() to use 'struct cxl_root *' directly
      cxl: Fix missing dereference of 'struct device' in cxl_port_perf_data_calculate()
      cxl: Refactor to use __free() for cxl_root allocation in cxl_find_nvdimm_bridge()
      cxl: Refactor to use __free() for cxl_root allocation in cxl_endpoint_port_probe()


 drivers/cxl/acpi.c      |  6 ++----
 drivers/cxl/core/cdat.c | 22 ++++++++++++++--------
 drivers/cxl/core/pmem.c |  8 +++++---
 drivers/cxl/core/port.c | 13 +++++++++++--
 drivers/cxl/cxl.h       | 17 ++++++++++-------
 drivers/cxl/port.c      |  9 +++++----
 6 files changed, 47 insertions(+), 28 deletions(-)

--

