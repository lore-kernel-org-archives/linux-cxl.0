Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4B816CD3B
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723196586; cv=none; b=VTP3x3LPPJPjoq57OsRv+6x9g1x8MpLw7A7RjqUJHeleRYZLhKlZoTirdqW5OM6/O7jOtHkZqaXmaPm60vMSvGXtynWEuk8aya2XHmLRqF767dRLPR8BSWTiNoxEKDPhzfnAt3Z1MbZ9+53gY4fDL2eETyQDkr3haoHzo4FDxMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723196586; c=relaxed/simple;
	bh=ZLMlZJxAqnNXhoufnqYpsiIJf9q/dKoKNS9M8RJEL4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaSLedjbYwlCGa5tueoMVvnC23z9Mrc84GoVeVZLq+Ry6IZ+A1oZPlCdvP7ZCcj33j6hQ1WI6kbX7hLKZGtHPrxHdjYVK3EHnk6nZhEQvPVsXHQlwwt/U+Nj5hFvtMZiTlxdlDwAnG0b8PF79+U2V7rTlZc7REaI/ukWwsGMbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je1/by2a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je1/by2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723196584; x=1754732584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLMlZJxAqnNXhoufnqYpsiIJf9q/dKoKNS9M8RJEL4Q=;
  b=je1/by2ahaEc83VE9FrRBWTNY24z6q8lMPVDtQusessdWbztSVS9iJfw
   +FDBfK2rQnYNeI5JsVSqfAMVXANMjbO1u08JT2xS1wmJZOLRFOPmqhTse
   +xdlv3RxgYgN+uMmsWBkN65+Yc5yNu/FF4rbcYm0nvGcIZW+I66fs9vLK
   D6WrcFwLOhET+LIZTOVG79BfPCx3JhqUT0QtwydyvetNk4k3H9Vc4K2KJ
   Nr+J9ExzMlI9QtMZq7eQTQxKa1EffA7N7gfFJtIEcxU1oMDqNJ+SUZ90g
   CqsrD2j7r9VErGev3KJ/4bwMOP9fUzW176gMfr2UK68wA1jtgWUXBQu4+
   g==;
X-CSE-ConnectionGUID: JcOLusRTQrOyYJA19/r4Qg==
X-CSE-MsgGUID: aswBCQEuQJG4ASimqZmHaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38869670"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="38869670"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:43:04 -0700
X-CSE-ConnectionGUID: is/nUQGURl6CI6eISzppmg==
X-CSE-MsgGUID: unSUNDWIR3OOEcDR6MpUmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="62352862"
Received: from tower.bj.intel.com ([10.238.157.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 02:43:02 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v2 4/4] cxl/pci: Simplify the code logic of cxl_hdm_decode_init
Date: Fri,  9 Aug 2024 17:34:42 +0800
Message-Id: <20240809093442.646545-5-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240809093442.646545-1-yanfei.xu@intel.com>
References: <20240809093442.646545-1-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HDM decoders exist but is not enabled, the cases can be divided into
two categories: DVSEC range enabled and not enabled. Extract the check of
mem_enabled out to improve code readability. No functional change.

Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
---
 drivers/cxl/core/pci.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index e822cc9ce315..09d63a62f05b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -438,7 +438,15 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	else if (!hdm)
 		return -ENODEV;
 
-	if (!info->ranges && info->mem_enabled) {
+	if (!info->mem_enabled) {
+		rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
+		if (rc)
+			return rc;
+
+		return devm_cxl_enable_mem(&port->dev, cxlds);
+	}
+
+	if (!info->ranges) {
 		dev_err(dev, "No available DVSEC register ranges.\n");
 		return -ENXIO;
 	}
@@ -452,14 +460,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
 	 * Decoder Capability Enable.
 	 */
-	if (info->mem_enabled)
-		return 0;
-
-	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
-	if (rc)
-		return rc;
-
-	return devm_cxl_enable_mem(&port->dev, cxlds);
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 
-- 
2.39.2

