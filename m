Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313611EC01B;
	Tue,  5 Nov 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831955; cv=none; b=TkJiZpWmU92Vb+oV8ZASXvo/KL2Hk+MNRrn0l+c5+l6sGiFAQUdx4mvS7Lfqy43Sccco8NLbj9ZR6BAo+lOG2kJCcg4HPhAzgp0a/YaZz4EG6QBR9lZqQWDkG34d5eM8CNYbEDOh1dLBw7Yvf22fLpxNfHo13i/o4f0rChMgKQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831955; c=relaxed/simple;
	bh=pS9Qof+pyeDGeHwjHKLkYWCZilYylGln+u/5SoCi5VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDvwhM4CCoRz6f3o/4lOFSQCzN4RdTLz+Sj+5Yy7rkTbbn2tr3pEquNKg8Oeyv9VG8+KLH+C0Dz+YEqXMQ3FZzy0qc44oYlkbzoHOH227CKu3FfAczXJzJifCjMQ96W1YFvN+28C3v9a+Fq6YrE6asf5/uoJvC0QQHzOEMUAo4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CCejYQca; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CCejYQca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730831954; x=1762367954;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pS9Qof+pyeDGeHwjHKLkYWCZilYylGln+u/5SoCi5VM=;
  b=CCejYQcaFRc1qcRT5vBd6zU2fLz1+lAnuLqF9sCLabhHqTAyCY7x+3ys
   LeJwocJBffK1koT7r2cDlF3MbWbMrdXowGyQBgIcsUP7NjyfEGWiOq2gE
   l1ytp0OHJ5Lxf6hjMsUttH8VSyKsSKiAxrveVVB9uKRBA/fcGAp9zfBt1
   chfw2Js0d5nfvdmWxmKWLN9ZeGiab2kNVkLALdaNuojvs1h2aeWcUZKon
   PZ5QBQOfQgYBz592BSCqzjxD5c5naaIhX1VpIcemJbJ8isE/dGI4mEHv4
   4IpFoNHEx2p2BmGSgPRQdXXPbU39x6/hKzjeMLcA7vMIsskFsfXf3cfQ8
   w==;
X-CSE-ConnectionGUID: BzTzZXS5S9OFYOCSCBgVJA==
X-CSE-MsgGUID: CpOfXW9mQauBF3uFFuOzFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30012722"
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="30012722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:39:13 -0800
X-CSE-ConnectionGUID: qLOpTEbUQoW6wl+UzbIj+Q==
X-CSE-MsgGUID: ilESrLmLRQarZV4s1kmIfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,260,1725346800"; 
   d="scan'208";a="88624538"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO localhost) ([10.125.109.247])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 10:39:11 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 05 Nov 2024 12:38:39 -0600
Subject: [PATCH v6 17/27] cxl/pci: Factor out interrupt policy check
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dcd-type2-upstream-v6-17-85c7fa2140fe@intel.com>
References: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
In-Reply-To: <20241105-dcd-type2-upstream-v6-0-85c7fa2140fe@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730831904; l=2142;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=pS9Qof+pyeDGeHwjHKLkYWCZilYylGln+u/5SoCi5VM=;
 b=ePwyvzAMiTHtKL4ON8tRaRIaANKOXCa6/Ac0sV4ki4uDeZYPEslpHbh0ffaOJ2floITHn3hi3
 7zHGjVh1iynACfKPf69+f1gOv2Rp4Ll2M8eIWWtVBtgbT0vpE25yCuq
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

