Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NeHdXwER"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B2110DD
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991905; x=1733527905;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qTSsgviOLrkMxZTALKuSaV7ebRQdHAnSCDTRwqPeCUA=;
  b=NeHdXwERaDSBTwLk2XJlZm4Ym5h0eezkABnzNEfZYSJLCyGQug4F0TV0
   xuIGRWHSQnwqkwWQrBeg0H3Xv4m7vkLB7vQp/FN/hTG/Di5ladL/NfvPA
   LEhh4IllFm2tc2A74X9NFCcRCXyhzk7eFh7deobcI+pm3tWbfTzudnKh/
   pUHTYlDBP0WPD76SgPqIGlR4sQF662EeO94qzIQ3irVW5BvP4AVNCMW/B
   5yE8nvd/oZZKbAuSZDOJTCE9QCsNStI6fV8mBijcC8ty2D5moEY5phZUQ
   ejdxoUMpAY7v7qRZq3wlKNMtVUzOaqgpA2YDKeEiLI1H4PZCipirYijXH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1431985"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1431985"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:31:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895326273"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="895326273"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:31:44 -0800
Subject: [PATCH 0/3] cxl: Add support to report region access coordinates to
 numa nodes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 jonathan.cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:31:43 -0700
Message-ID: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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

[1]: https://lore.kernel.org/linux-cxl/170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3/T/#t

---

Dave Jiang (3):
      cxl/region: Calculate performance data for a region
      cxl/region: Add sysfs attribute for locality attributes of CXL regions
      cxl: Add memory hotplug notifier for cxl region


 Documentation/ABI/testing/sysfs-bus-cxl |  40 ++++++
 drivers/base/node.c                     |   1 +
 drivers/cxl/core/region.c               | 162 ++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |   3 +
 4 files changed, 206 insertions(+)


