Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B813A20C465;
	Tue, 29 Oct 2024 20:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234158; cv=none; b=RryyLEX6I8CC2ymv2M+WMSNp007liHZvn0VIuCI/Pp6ltnxU9Ur9UqjS1nUFk6FjfldW1XkX4qbWONIXTlOqa0Jbb/d7e/+CfpkMOnrXOFP/Xuh3BE0E0y+cioRrUT4RK5vsdu72wPEkcA0052Z4x4v7K0hbDuJQ8yoccpcRxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234158; c=relaxed/simple;
	bh=mjj07qibmfpdowiIbTJj5gx4HirKQSbJsP6X+hB9fFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tV2YS05m3a/6YbIQihDJXJulAKc8AQUJGEDMOKZdiUzjE7lGKA07BfaXQ/TrJcgSYnUbjm4F6xlTZUo/qJ7iQADhWXbTlo5ZWxY6/DNAdDjAz7xkdzwCngLA7Z6bsSMv6gEPLyfmAgRmgf4XB1Rz2Cwe5mFxjRQmSh1wT0CtoQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kE0anPob; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kE0anPob"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730234156; x=1761770156;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mjj07qibmfpdowiIbTJj5gx4HirKQSbJsP6X+hB9fFg=;
  b=kE0anPobKxHz4oVSv2gIY1dmM0wQcX4E3Z0yWDo1n6GOt720FPrf13gm
   /ktsm1sivF51PoNUYQNIxlGxd/X/6WiEoRekmMMo9MaZ+cPDzZYUmtven
   SyiCpkGHnhATToCIS2XEt8vI4vC84SbpZd+YGBgHGQEtl7nljZaMAZaWZ
   xYu9mHEF5jfKcDnG1o9AGBHyjQXSFVm7a7zHiTjO9ejWmGooO019Cjz4/
   KxXQetu/m0RXCaPZP/5iaZ/Y+klQVxVbzU3GAjMuO8A6C3K2MuzPynuq0
   V/ZvoDcLMkve3pxg7khipppcQa4ZnGBGx1eLWr2BM6fohL480LnaUAy7g
   g==;
X-CSE-ConnectionGUID: III4CkZaSnKRyfDlbNs41w==
X-CSE-MsgGUID: AxaQ9tsyRxCIvnjRKe7IDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="52457589"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="52457589"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:55 -0700
X-CSE-ConnectionGUID: FcLXlyYGQdyXlkxf8EQGcg==
X-CSE-MsgGUID: VrVXlxFyTLa7fqHrXAXCCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="119561281"
Received: from ldmartin-desk2.corp.intel.com (HELO localhost) ([10.125.108.77])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 13:35:54 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 29 Oct 2024 15:34:51 -0500
Subject: [PATCH v5 16/27] cxl/events: Split event msgnum configuration from
 irq setup
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-dcd-type2-upstream-v5-16-8739cb67c374@intel.com>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
In-Reply-To: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730234086; l=2755;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=mjj07qibmfpdowiIbTJj5gx4HirKQSbJsP6X+hB9fFg=;
 b=in4L9O0M/i5kz21guHpe/GqTS2CJhFTSf4KiMCYTRKUeFK0BMoHJk+65lHp90Mh+bb1fe7k41
 WP9ML+JwVohAWYd7X0e7+OoUaeVt+4hhZJQpAyWaXP/nwkZLv7WM6pu
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

Dynamic Capacity Devices (DCD) require event interrupts to process
memory addition or removal.  BIOS may have control over non-DCD event
processing.  DCD interrupt configuration needs to be separate from
memory event interrupt configuration.

Split cxl_event_config_msgnums() from irq setup in preparation for
separate DCD interrupts configuration.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming4.li@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[Jonathan: move zero'ing of policy to future patch]
---
 drivers/cxl/pci.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c8454b3ecea5c053bf9723c275652398c0b2a195..8559b0eac011cadd49e67953b7560f49eedff94a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -702,35 +702,31 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 	return cxl_event_get_int_policy(mds, policy);
 }
 
-static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
+static int cxl_event_irqsetup(struct cxl_memdev_state *mds,
+			      struct cxl_event_interrupt_policy *policy)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct cxl_event_interrupt_policy policy;
 	int rc;
 
-	rc = cxl_event_config_msgnums(mds, &policy);
-	if (rc)
-		return rc;
-
-	rc = cxl_event_req_irq(cxlds, policy.info_settings);
+	rc = cxl_event_req_irq(cxlds, policy->info_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
+	rc = cxl_event_req_irq(cxlds, policy->warn_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
+	rc = cxl_event_req_irq(cxlds, policy->failure_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
+	rc = cxl_event_req_irq(cxlds, policy->fatal_settings);
 	if (rc) {
 		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
 		return rc;
@@ -777,11 +773,15 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 		return -EBUSY;
 	}
 
+	rc = cxl_event_config_msgnums(mds, &policy);
+	if (rc)
+		return rc;
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
 
-	rc = cxl_event_irqsetup(mds);
+	rc = cxl_event_irqsetup(mds, &policy);
 	if (rc)
 		return rc;
 

-- 
2.47.0

