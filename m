Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3C2F26
	for <linux-cxl@vger.kernel.org>; Fri, 11 Oct 2024 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624862; cv=none; b=Kc/aXdwIQoegvtnRCjkjeTJrPQ86ByU94xmEz7FbiOnEauFHj+/DxatEV9wRFvoKDWfLaReM1E/KdXQbEGY9hm6NsxMTyKK1RbQ0FgCBemIDQWQLmnA1ezDqXIMMAYWrG0dneexSpm0t+f0YpXsmmoNBm6c69YSi/+/gF/bKMW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624862; c=relaxed/simple;
	bh=juOGAtdjznPc0RKrnj5+K0hX4qicmjHRC5I+vDohYYI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7cMBqfwv+KA/DNlkSNrVz+v0Uk26irPxS6T730NCEVbs8jLCYSojrmRPW1U2hvjEpDQO8w/A7f/2XfQ7xFyLKORQVWAhPMJRLn3Lux0C4XDBdBecs8pMmheJqEbB0bQEbbpXwvlU8xJttPyEW4qAj/UJuo8JgVExjlablVWzNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lA7sqUve; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lA7sqUve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728624861; x=1760160861;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=juOGAtdjznPc0RKrnj5+K0hX4qicmjHRC5I+vDohYYI=;
  b=lA7sqUveSuBOIGaap59SpLhhD6hCW8t9Zt4yfAI+H1PBhTYa6LVKRkN4
   76WE5LLXXhviZFBZLQLLYpe4Fuoy57CO3SZcVqqAWOovnjE3eFvC+jD31
   VlqawPaUptITu/XOPsjgbNIXodv0KwrQRZ5YMX6sr2rzUs/IXOAwN3FkF
   ZkPWgOshc2QtCxla0lhmGVl/QVsnvjipNIu4gATZivVZE9B+W8Mb35AmM
   PC2Tmn4AG/kyOFzwMwrFUWyVStSRCyVuEhzsLYz92LGxpvbvSc7xVPlDO
   uRU+J3XyRE1sP0Xxe86ydetMt0PG1ouB5qCJkLrEDwUddAbUkLec7omhR
   Q==;
X-CSE-ConnectionGUID: S1yuStNKQCu+xqZCMAgSPw==
X-CSE-MsgGUID: +r5ZGhBmRTiturWSqosMsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="53416730"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="53416730"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:20 -0700
X-CSE-ConnectionGUID: GgI7DopJQW2ojZuB3k69Qw==
X-CSE-MsgGUID: H1BfrLXMQMGFXnTjujJ+lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="114262344"
Received: from inaky-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.111.110])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 22:34:20 -0700
Subject: [PATCH 3/5] cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com,
 linux-cxl@vger.kernel.org
Date: Thu, 10 Oct 2024 22:34:18 -0700
Message-ID: <172862485724.2150669.12670806990969973843.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
References: <172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

In order to ensure root CXL ports are enabled upon cxl_acpi_probe()
when the 'cxl_port' driver is built as a module, arrange for the
module to be pre-loaded or built-in.

The "Fixes:" but no "Cc: stable" on this patch reflects that the issue
is merely by inspection since the bug that triggered the discovery of
this potential problem [1] is fixed by other means. However, a stable
backport should do no harm.

Fixes: 8dd2bc0f8e02 ("cxl/mem: Add the cxl_mem driver")
Link: http://lore.kernel.org/20241004212504.1246-1-gourry@gourry.net [1]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8e..432b7cfd12a8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
 
 /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
 subsys_initcall(cxl_acpi_init);
+
+/*
+ * Arrange for host-bridge ports to be active synchronous with
+ * cxl_acpi_probe() exit.
+ */
+MODULE_SOFTDEP("pre: cxl_port");
+
 module_exit(cxl_acpi_exit);
 MODULE_DESCRIPTION("CXL ACPI: Platform Support");
 MODULE_LICENSE("GPL v2");

