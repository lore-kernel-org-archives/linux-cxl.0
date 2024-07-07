Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87217F8
	for <linux-cxl@vger.kernel.org>; Sun,  7 Jul 2024 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720317232; cv=none; b=N8oo2gAf1ghISbuE5/H2+V71g+Ww1oPW9c5XZySw4EEGWjqCY5RvR4Ql7naENeq2ByXi+ZkVAwgEs0mG42i+b47Tmhdr4gM9OwhGQXtqjzN7UepYOHqWtTQBsXtsBvw8oRtX2y/HS4/OQLm+3o5RvGffbq6IBwZbDKy2f2qX+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720317232; c=relaxed/simple;
	bh=HMN7EeUnBjxaKElfwy6Qc7ln9fYBBw14YAysyqF62Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHak243eRiPhTNH/TlfOBRtuTGEgpCt5GEMejxU370GvwxTiUQIy0UXakmlPhnAyvRtsh3sOaMlCalNtp/3o12yiqiyghF9TPp9LlgDBcNxNqcaUue1mZNzchMM4oQQrRjKT73DqKyx5oHK2u/5xaJxSUGiv6zmUygNVGcMQX54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jjnq8LD7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jjnq8LD7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720317231; x=1751853231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HMN7EeUnBjxaKElfwy6Qc7ln9fYBBw14YAysyqF62Ec=;
  b=Jjnq8LD7G+aXETDBagoVbPJ/rhZJD99wwx91zocAB0mBPSi1JGiRQYGe
   nEqtle7kS1nrVntDF5nOd/+qIJgHZjGNVZx9MEcp5zIyaQ8tFPyD4kV3v
   Y+oNInDGTjw1BO6df7X/v+4QwjcbXHR5c5t5ujxekwWsl5IFCNB6qxHJN
   XBKFOuJdwaF4HRpH/Plm+xOZdLvZxg04864c8CrjFnHNM+Uq9GgYQN1/O
   ziuUx9eQ9Zcdc6Nf23Ua456NC6cjYj7TRb6JMXEEh4KWM5OxC7YZ5SFQo
   LBI0YLd4tie99pmyPDjQ2E0LnDcRtDHo5WhcShGQy2etTHyf2+uf1WrX7
   Q==;
X-CSE-ConnectionGUID: doLVzY73Tgyddta7ZdrYiA==
X-CSE-MsgGUID: /T0AX84dTj604KqGU9X2mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17680741"
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="17680741"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:53:50 -0700
X-CSE-ConnectionGUID: spGDXqYPS3W4ycBlNC+XCQ==
X-CSE-MsgGUID: Yan12LlHRgCR4TriDcsSTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,189,1716274800"; 
   d="scan'208";a="46948307"
Received: from pgarg3-mobl.amr.corp.intel.com (HELO localhost) ([10.209.105.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2024 18:53:48 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 2/2] cxl/test: Replace ENXIO with EBUSY for inject poison limit reached
Date: Sat,  6 Jul 2024 18:53:44 -0700
Message-Id: <ba1b80e1658b644d85d0d5e2287112d00a48b9cf.1720316188.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720316188.git.alison.schofield@intel.com>
References: <cover.1720316188.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

The CXL driver was recently updated to return EBUSY rather than
ENXIO when the device reports that an injection request exceeds
the device's limit. That change to EBUSY allows debug users to
differentiate between limit reached and inject failures for any
other reason.

Change cxl-test to also return EBUSY and tidy up the dev_dbg()
messaging to emit the correct limit.

Reminder: the cxl-test per device injection limit is a configurable
attribute: /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 tools/testing/cxl/test/mem.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index eaf091a3d331..8088f4255a66 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1131,27 +1131,28 @@ static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
 	return (count >= poison_inject_dev_max);
 }
 
-static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
+static int mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
 {
+	/* Return EBUSY to match the CXL driver handling */
 	if (mock_poison_dev_max_injected(cxlds)) {
 		dev_dbg(cxlds->dev,
 			"Device poison injection limit has been reached: %d\n",
-			MOCK_INJECT_DEV_MAX);
-		return false;
+			poison_inject_dev_max);
+		return -EBUSY;
 	}
 
 	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
 		if (!mock_poison_list[i].cxlds) {
 			mock_poison_list[i].cxlds = cxlds;
 			mock_poison_list[i].dpa = dpa;
-			return true;
+			return 0;
 		}
 	}
 	dev_dbg(cxlds->dev,
 		"Mock test poison injection limit has been reached: %d\n",
 		MOCK_INJECT_TEST_MAX);
 
-	return false;
+	return -ENXIO;
 }
 
 static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
@@ -1175,10 +1176,8 @@ static int mock_inject_poison(struct cxl_dev_state *cxlds,
 		dev_dbg(cxlds->dev, "DPA: 0x%llx already poisoned\n", dpa);
 		return 0;
 	}
-	if (!mock_poison_add(cxlds, dpa))
-		return -ENXIO;
 
-	return 0;
+	return mock_poison_add(cxlds, dpa);
 }
 
 static bool mock_poison_del(struct cxl_dev_state *cxlds, u64 dpa)
-- 
2.37.3

