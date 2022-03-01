Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0495C433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Mar 2022 02:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiCACuX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiCACuV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 28 Feb 2022 21:50:21 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576DC48327;
        Mon, 28 Feb 2022 18:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102971; x=1677638971;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WSASaml+/DezX9y2ikDtAn54SMESZKM5xL0R4lEghco=;
  b=nU8YnTHtcLlz99xFolDdN34/MRLSVmk4mvA7wFaxGoIzr5PqlEb4plFG
   l7c2iekiMOdCRSU9AJ7/Bw44Ib4ZDjQX5DUK+n5LL9Ueo+DQY3ltIu3GT
   NiOrR2vJPZCDM9LNMl37VjNbcljBk39FygN2IYSiOtInjN3fnmWeGJWxQ
   uTCNWO41SAg5DkPOzgtG68Rq++xscLfawRT8oEnSGZZhcZ8IdOEJKO1XW
   GAZpucle0L17xPi6EtSqrkGuOfNkEOp1km5DiUXfhcOdXQ38GOq25FUeN
   3tBJ2hRvkehikDgSJevT0FSwrX+bCshc+l6PDQa4Qwrl8LTuYNLDhL6js
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="252774093"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="252774093"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:27 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="507645876"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:27 -0800
Subject: [PATCH 07/11] libnvdimm: Refactor an nvdimm_lock_class() helper
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, alison.schofield@intel.com,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:49:27 -0800
Message-ID: <164610296761.2682974.11157102809606978208.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for moving to the device-core device_lock lockdep
validation, refactor an nvdimm_lock_class() helper to be used with
device_set_lock_class().

Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/nd-core.h |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
index 2650a852eeaf..772568ffb9d6 100644
--- a/drivers/nvdimm/nd-core.h
+++ b/drivers/nvdimm/nd-core.h
@@ -197,22 +197,27 @@ enum {
 	LOCK_CLAIM,
 };
 
-static inline void debug_nvdimm_lock(struct device *dev)
+static inline int nvdimm_lock_class(struct device *dev)
 {
 	if (is_nd_region(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_REGION);
+		return LOCK_REGION;
 	else if (is_nvdimm(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_DIMM);
+		return LOCK_DIMM;
 	else if (is_nd_btt(dev) || is_nd_pfn(dev) || is_nd_dax(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_CLAIM);
+		return LOCK_CLAIM;
 	else if (dev->parent && (is_nd_region(dev->parent)))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_NAMESPACE);
+		return LOCK_NAMESPACE;
 	else if (is_nvdimm_bus(dev))
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_BUS);
+		return LOCK_BUS;
 	else if (dev->class && dev->class == nd_class)
-		mutex_lock_nested(&dev->lockdep_mutex, LOCK_NDCTL);
+		return LOCK_NDCTL;
 	else
-		dev_WARN(dev, "unknown lock level\n");
+		return -1;
+}
+
+static inline void debug_nvdimm_lock(struct device *dev)
+{
+	mutex_lock_nested(&dev->lockdep_mutex, nvdimm_lock_class(dev));
 }
 
 static inline void debug_nvdimm_unlock(struct device *dev)

