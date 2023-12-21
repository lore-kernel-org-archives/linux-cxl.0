Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF1977F01
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRrARRmv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196227; x=1734732227;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMR1UlBFrXyM8/HWu2VU58KfNl7NefLPe5eBfLTizUI=;
  b=KRrARRmvWKezPfe0qmTU0RWcjApJDasNwmjMGx0u8nZLOIzykxYRhY5S
   wG+a4V8KAXAHIJX2dmY0APlg/UpRjdWunta0Xl/v09qsB7WeyAo6oB+fA
   HN1i+o8V+PVIxK8+YBPalQkjsraVt9vL5qq80WgIh9uTemT1kNuF+Q14E
   Q4WGUqARC20w0kYfye4JAU43owi3nxOa/PqOjXLJft24IW2JQ7ggOozQE
   c41+orAoxI+fPlPL0yqZ4+VMY6bl0fCTGOxRgD1G7neD7/iDCxmRTCUsg
   F8R+Kvtxxq91bYuaLUM+Mq12LGlb0NQMa/vzbeAa9wDK1f/PMk4I1F2sq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="376184524"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="376184524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="25116270"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:46 -0800
Subject: [PATCH v15 13/19] tools/testing/cxl: Add hostbridge UID string for
 cxl_test mock hb devices
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:45 -0700
Message-ID: <170319622564.2212653.1534465446670631698.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In order to support acpi_device_uid() call, add static string to
acpi_device->pnp.unique_id.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index b88546299902..6d61e2854aab 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -68,15 +68,19 @@ static struct acpi_device acpi0017_mock;
 static struct acpi_device host_bridge[NR_BRIDGES] = {
 	[0] = {
 		.handle = &host_bridge[0],
+		.pnp.unique_id = "0",
 	},
 	[1] = {
 		.handle = &host_bridge[1],
+		.pnp.unique_id = "1",
 	},
 	[2] = {
 		.handle = &host_bridge[2],
+		.pnp.unique_id = "2",
 	},
 	[3] = {
 		.handle = &host_bridge[3],
+		.pnp.unique_id = "3",
 	},
 };
 


