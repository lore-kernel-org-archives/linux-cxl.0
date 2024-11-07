Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE77B223A68;
	Thu,  7 Nov 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013150; cv=none; b=tn5Myr76GUvWALfaroC0RycHt5VhKw/qZkWRo19UEm91ILB9NCx/28X3gjIEgh3RwHNcNgonBUJY2lUI+nk6aA6+6Z0NCGggGLxxTS+JSp780+8RMunNqu6Ba3Ps1KsoXECHBMo0HmhUqy29q8mqRZWFAez6JGCXqfeqeWFVnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013150; c=relaxed/simple;
	bh=NLrrvpMgAcSkVfM1wvLzl5lPfI71ou2Lqgos0sbSipI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYOVRMk+aevB9g22WkHnUv5dEOqcGHzGrewtsWXdIO8i0e4RTcD/ry9B6xD5Zxv/h66a/84IqFSY/JISiqGEudOve5zQ1bG4/3O0XXaROKwlUjxRdQysluuJqU0mO0gKjKoqYsRw6fiY/g1/a4PjUbSayg9nSzvZ+et0GCIHFiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0xaHZ21; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0xaHZ21"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013149; x=1762549149;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NLrrvpMgAcSkVfM1wvLzl5lPfI71ou2Lqgos0sbSipI=;
  b=b0xaHZ2177gDC3jP10S1RZdMkYa6sIJx0eF4W6pLSHdY/IE8XtjQbYxx
   px+alDsIQLRAtW4CxPN7ArgVeYC4AggPq24/BmF2lG839fdYFhxc1kuiq
   +j7/1FJ9ZRJ4x9BelFC8iE1GFJw44nXjK4PVeSYVAuwunkjeol106TGrg
   qK8KZb6hItCkv+6ZaoDbi8CoUGSgUEBnKRL0xyXFnChnmYV5313EOJThZ
   r/4ZAuauqIe3F70UOu543iau2eXMHfzv6thZz9fM8b3zHtmIgUzjNcHRp
   Cjsf32HjYVAPRCR4uWuwDwLkb+U8Hz8c+gbhqBj5ifhH602yLPAo4Jp8c
   Q==;
X-CSE-ConnectionGUID: ZkWg6nlAS++DityBq8HUdA==
X-CSE-MsgGUID: SfOkCrWYQJyG59OAAmCoHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41441054"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41441054"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:59:08 -0800
X-CSE-ConnectionGUID: ncu/vzbcT3GtR6VY9EHnBg==
X-CSE-MsgGUID: KeUFTaatTeyJTbjDsJpwDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="122746031"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:59:07 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 07 Nov 2024 14:58:35 -0600
Subject: [PATCH v7 17/27] cxl/pci: Factor out interrupt policy check
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-17-56a84e66bc36@intel.com>
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Li Ming <ming4.li@intel.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=2296;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=NLrrvpMgAcSkVfM1wvLzl5lPfI71ou2Lqgos0sbSipI=;
 b=gmisqeZx9iMWY/zTMdtoC2pTLLlqcVUMTfbRKQnCEz8MtOgY+w3SWswkhY36UexusDHraeoyx
 WmsUP34C327CBPm7WNDl7+3AFDxIPKsiMhYwmcOSKdQLCwusVINyGm4
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Factor out event interrupt setting validation.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Li Ming <ming4.li@intel.com>
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/pci.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8559b0eac011cadd49e67953b7560f49eedff94a..ac085a0b4881fc4f074d23f3606f9a3b7e70d05f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -742,6 +742,21 @@ static bool cxl_event_int_is_fw(u8 setting)
 	return mode == CXL_INT_FW;
 }
 
+static bool cxl_event_validate_mem_policy(struct cxl_memdev_state *mds,
+					  struct cxl_event_interrupt_policy *policy)
+{
+	if (cxl_event_int_is_fw(policy->info_settings) ||
+	    cxl_event_int_is_fw(policy->warn_settings) ||
+	    cxl_event_int_is_fw(policy->failure_settings) ||
+	    cxl_event_int_is_fw(policy->fatal_settings)) {
+		dev_err(mds->cxlds.dev,
+			"FW still in control of Event Logs despite _OSC settings\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
 			    struct cxl_memdev_state *mds, bool irq_avail)
 {
@@ -764,14 +779,8 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	if (cxl_event_int_is_fw(policy.info_settings) ||
-	    cxl_event_int_is_fw(policy.warn_settings) ||
-	    cxl_event_int_is_fw(policy.failure_settings) ||
-	    cxl_event_int_is_fw(policy.fatal_settings)) {
-		dev_err(mds->cxlds.dev,
-			"FW still in control of Event Logs despite _OSC settings\n");
+	if (!cxl_event_validate_mem_policy(mds, &policy))
 		return -EBUSY;
-	}
 
 	rc = cxl_event_config_msgnums(mds, &policy);
 	if (rc)

-- 
2.47.0

