Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UedKQRdb"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB671710
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701989983; x=1733525983;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MMR1UlBFrXyM8/HWu2VU58KfNl7NefLPe5eBfLTizUI=;
  b=UedKQRdbWqPev5HrPbgyzmt7Au6mbcgvmLz9Rs/AW9rHPYJnEuR5+yzh
   GC3z8peLOuBTeihkC091f6Gtpq5Xe3d/qur2DEWFBRAV3e+ByMA1/x2qa
   pl5sODJDRsZnFtGF491ussdDFlIFdYBfW5rxFx4xoYiInUe1HrSNk5t1L
   yMgWAQJt8HsssZ2nRyrcYgFusebuFq1l/AIadvrRmbPu1EVN3T1sFaKtM
   eFVkotTzZBqRzVLx2BB75takSvCXu25hLOAz/kWzcJhu1+0wPRIxnPIRZ
   xS1gFCD08uCjTiIknj79d8NBlzjM8iovavtaE6REQk8Fjeqh0hys46lNw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="397107791"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="397107791"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895312761"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="895312761"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:59:42 -0800
Subject: [PATCH v13 13/19] tools/testing/cxl: Add hostbridge UID string for
 cxl_test mock hb devices
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 15:59:40 -0700
Message-ID: <170198998073.3522351.16210977630727736213.stgit@djiang5-mobl3>
In-Reply-To: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
References: <170198976423.3522351.8359845516235306693.stgit@djiang5-mobl3>
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
 


