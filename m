Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F21078A
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3Hnw7Mu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682156; x=1734218156;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vC22WWNp0orYIlAALkOSzNZBjwx3gWM8MPXCGeDbxR4=;
  b=k3Hnw7Mu9zaULAeh0J9IcXlbY6CsxyeFeQejBEundx1LRXguxq0ggslX
   CMTQJ7Jk5XvrU0wDrfixQrbvb1viCnAVvJhxf0CPYj38Aa66cUQDpvV2R
   Xy1zwdGt07P0qecfM/AK45j9q6RETLbfFk5Lgl8jRt42NW3NzUT+Nr/6m
   hXvBcsJ/HV/2DoLpy8ewOF28EydIYYNpe22itkk6HMkH4ebm58lOTZTFS
   +ud1umjrqAtAnDXHV3zw9R18B3/mSMoiQDqnES64jE+FfGo9ne1Cgffp2
   p0tmrLP8W7hPxk3hHStHOwn6BBYRPwS3EGeyX2zfKaWafU36MP93B4VH+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2165612"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2165612"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1106277586"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="1106277586"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.188.77])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:15:54 -0800
Subject: [PATCH v2 0/3] cxl: Add support to report region access coordinates
 to numa nodes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Huang,
 Ying" <ying.huang@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net, brice.goglin@gmail.com,
 nifan.cxl@gmail.com
Date: Fri, 15 Dec 2023 16:15:53 -0700
Message-ID: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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


 Documentation/ABI/testing/sysfs-bus-cxl | 56 ++++++++++++++++++++
 drivers/base/node.c                     |  1 +
 drivers/cxl/core/cdat.c                 | 53 +++++++++++++++++++
 drivers/cxl/core/region.c               | 68 +++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  8 +++
 5 files changed, 186 insertions(+)

