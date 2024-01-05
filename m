Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1C93455D
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPqO8GjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704477780; x=1736013780;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zl0fpQsMTj9a/tMoJ5Xq7oor3Jce3eFf9PqXF1XKQJE=;
  b=YPqO8GjMoTwH0wSxOdyAKEq8lqqFcoSmp0xF55qUdcY34zHhm+xe1icb
   LSZXqPJmj9vTB3Y1gePEVibMVJZW/GBi5tfDcJ53970HKA6afyAolu0ti
   Qc0SxNW+idvGirM75zX87B9QUSq+y25Q3c8dOOPeHBxuALcs0ZK81nPRi
   X+dgAdxihRAVC+BaiTU71cV43DrfGqYaycf9sGuhkjWBYdbOkNhFe6Xb+
   UhW0G7nVC53OFK5eOg9a9AfwcYOl8EwPHGt4DdX4Kr/AGTNqiw5PDqx1L
   9ZZGnDaHI0AQtBWnUCCh8Q1ajSb/jTC32XJEQLGfqHycsgd7ovuDiLSmP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="377047481"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="377047481"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:03:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10944"; a="773905495"
X-IronPort-AV: E=Sophos;i="6.04,334,1695711600"; 
   d="scan'208";a="773905495"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.109.135])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 10:02:59 -0800
Subject: [PATCH v5 0/5] cxl: find_cxl_root() related cleanups
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Robert Richter <rrichter@amd.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, rrichter@amd.com
Date: Fri, 05 Jan 2024 11:02:58 -0700
Message-ID: <170447769575.3687480.11698914923419362733.stgit@djiang5-mobl3>
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
 drivers/cxl/port.c      |  9 +++++----
 6 files changed, 46 insertions(+), 29 deletions(-)


