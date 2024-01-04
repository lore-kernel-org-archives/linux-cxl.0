Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312662D600
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BExemkJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704412099; x=1735948099;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rK0P2gHYlBRdYI952bCbrIkdYBw9DeKmGyGtHi7XTt0=;
  b=BExemkJ7EGY8+Pn6DaP2EnAGiKaz2CGpj15H5MTEqgY06HBvIUE1HrEJ
   W/plSIW9bsV2CL8geUird1B2X5cur5KRxeG+PcUmPkJFzDyNGpiJX5jE5
   Xj1Zy6F5nKyan0UlVIHw5e2XBrjbZFwdRjFBVXq+Bal4Oo5/baTWR4i/a
   3I72blmD2mbLkO9WhSkGsyl0/P3ChaXYSy7yUIl6U5/t5ObvW2WUCmoBm
   RVbZ7o4YbBxtfAqEOGyOSHq1LABdzxVXaMUhX5C88XHhT2yKMWlYT7o4F
   TMGcKovUUgGLZu6+DNkxLzySXRWaDih0g5h/3XOnKccE18by60Z0NcY9V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382369851"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="382369851"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871087821"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="871087821"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:17 -0800
Subject: [PATCH v3 0/3] cxl: Add support to report region access coordinates
 to numa nodes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang,
 Ying" <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 04 Jan 2024 16:48:17 -0700
Message-ID: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

v3:
- Make attributes not visible if no data. (Jonathan)
- Fix documentation verbiage. (Jonathan)
- Check against read bandwidth instead of write bandwidth due to future RO devices. (Jonathan)
- Export node_set_perf_attrs() to all namespaces. (Jonathan)
- Remove setting of coordinate access level 1. (Jonathan)

v2:
- Move calculation function to core/cdat.c due to QTG series changes
- Make cxlr->coord static (Dan)
- Move calculation to cxl_region_attach to be under cxl_dpa_rwsem (Dan)
- Normalize perf latency numbers to nanoseconds (Brice)
- Update documentation with units and initiator details (Brice, Dan)
- Fix notifier return values (Dan)
- Use devm_add_action_or_reset() to unregister memory notifier (Dan)

This series adds support for computing the performance data of a CXL region
and also updates the performance data to the NUMA node. The series depends on
the posted QTG ID support series [1].

CXL memory devices already attached before boot are enumerated by the BIOS.
The SRAT and HMAT tables are properly setup to including memory regions
enumerated from those CXL memory devices. For regions not programmed or a
hot-plugged CXL memory device, the BIOS does not have the relevant
information and the performance data has to be caluclated by the driver
post region assembly.

Recall from [1] that the performance data for the ranges of a CXL memory device
is computed and cached. A CXL memory region can be backed by one or more
devices. Thus the performance data would be the aggregated bandwidth of all
devices that back a region and the worst latency out of all devices backing
the region.

[1]: https://lore.kernel.org/linux-cxl/170248552797.801570.14580769385012396142.stgit@djiang5-mobl3/T/#t

---

Dave Jiang (3):
      cxl/region: Calculate performance data for a region
      cxl/region: Add sysfs attribute for locality attributes of CXL regions
      cxl: Add memory hotplug notifier for cxl region


 Documentation/ABI/testing/sysfs-bus-cxl | 60 ++++++++++++++++++
 drivers/base/node.c                     |  1 +
 drivers/cxl/core/cdat.c                 | 53 ++++++++++++++++
 drivers/cxl/core/region.c               | 84 +++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  8 +++
 5 files changed, 206 insertions(+)

--

