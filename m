Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYyeEfpa"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D578E
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485760; x=1734021760;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMR1UlBFrXyM8/HWu2VU58KfNl7NefLPe5eBfLTizUI=;
  b=VYyeEfpalx8mcB7uGBpIJig3MST1aJd1UUHEzGg8CrRAfLlgiR26L0nj
   iT8nynJun/8KXhPUgUY6sDGWDoB/qSrGL1/SlXv/y2mb8EsTQM/5QoKIH
   KTM7yCnFw4PaT0rJ+db52c3NUwisb5pbey0HxVHQfvaMD4mXtdAFTsTU1
   8ezUROqN1wknCV0JZd5PiZ49MjHyopIlTp0vMM2CDDOiWGN/fbCL9KUlg
   9gPFNms+4B3x3XfpbnaDcAj59lM+v8cx5gv3waLKVA+nfWj+6GPJLIVqo
   T+fNXzFEZuDrDPGvKJubqh0MGwcVQcpK06w/Xg4EFCIMWHvLoUrtm3w6f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398833677"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="398833677"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774009781"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774009781"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:38 -0800
Subject: [PATCH v14 13/19] tools/testing/cxl: Add hostbridge UID string for
 cxl_test mock hb devices
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:38 -0700
Message-ID: <170248575836.801570.5557829930004485031.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
 


