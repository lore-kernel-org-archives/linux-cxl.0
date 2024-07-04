Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA65D2F56
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jul 2024 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053506; cv=none; b=Ut59Yjg0VIJKkfk1fnXoI8NCgdq/iXTHvcGMCRX8Susx6b6EJmizUpE4W3h+TUrrrpS++wNk59GcVi7yhDFQX6J/FgN3L3V4T54I1JhLOQt4orcPlzESYN5lQd3Fo2ZNbay4KHK5+Bjwo/ty6aLC7ZDwiHHabwxfF0yBg9cdNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053506; c=relaxed/simple;
	bh=87vvSQgB2swXxugR26mZNigjzUIcLxmyWz1dkbTsvjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZIEoqR1becXk1liTZLEJnZCOo2XgqHg8scMbSKod1uhjHhh4YJtqFYhKgFtXjSVsnja83y31fA4t2fNQ6sA6RROxaMs2zkqRQ7weEkJQvp46zBAp0mX1hI4roQBC1Z2F82o3g3bKiW4RnvGQazmLyIcLTS2uxnHLdLUMbc1nE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNlhcJVx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNlhcJVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720053505; x=1751589505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87vvSQgB2swXxugR26mZNigjzUIcLxmyWz1dkbTsvjI=;
  b=WNlhcJVx2TZF+9VUu21avrSwz+lxllpCwuPg2lgzO1pR0LKH6cQuoM/+
   LKL0dQL5VuzaZMecCJc+WqD6+dxcCXrglrsaQLhGaqJu3bqCQNO6FIo0l
   VEk7E45U54LdJuD8RzJfaXqSiwu7gSYZbuWSX1sQQsfg5gowLOuNgdPrh
   2kXDKnm5VsnS9ATOey6WJmcCGBwc8eCyrhTvGShCvin7cy/H6afoEmpG3
   uGTilK36p/4b8AkWSegJ4NmXwJqf8Xfm9aCOgFbrtIt0Tq/HRt8SYq8dn
   ZxAA1IB4xWes9KS3V79PFywt5thaUsYaGGUPxgQf8x1X3eZO8ywuGkLtL
   Q==;
X-CSE-ConnectionGUID: nL3CHSvgT7ygX/Vho5c5nQ==
X-CSE-MsgGUID: Xcd+/PYIRfqKeHVGdVPyvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17524543"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17524543"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:38:24 -0700
X-CSE-ConnectionGUID: cTTZwjBjRxeQ9H7QnJMprg==
X-CSE-MsgGUID: of3d2peiTICWd9mhZYIXog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="46309093"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.55.113])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 17:38:23 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] cxl/test: Replace ENXIO with EBUSY for inject poison limit reached
Date: Wed,  3 Jul 2024 17:38:17 -0700
Message-Id: <e13e59c43a456f56e275d039cd0f67c6117230c8.1720052137.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1720052137.git.alison.schofield@intel.com>
References: <cover.1720052137.git.alison.schofield@intel.com>
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

Do the same here in cxl-test.

Reminder: the cxl-test per device injection limit is a configurable
attribute: /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/mem.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index eaf091a3d331..5e0c84d4d9f8 100644
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
 			MOCK_INJECT_DEV_MAX);
-		return false;
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

