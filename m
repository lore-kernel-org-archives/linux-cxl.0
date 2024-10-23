Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E18520323
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647825; cv=none; b=GGmnfoz16SisvFg2bHpWeS03bkEh9bbvqycsnjgwFZ7PLb98YaSTYtd6pstRPYumRlcqH+88XBr+yMU75J8ocmzMNdsS/tBcxjIc4LjUkTj11ZTO5Ai5qKLr/C4B4tr4Sb+247UaOuv9mz3O5KZAgaTBydfkKVQr596eHk4nnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647825; c=relaxed/simple;
	bh=juOGAtdjznPc0RKrnj5+K0hX4qicmjHRC5I+vDohYYI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itc/TKVLtJj1SgHnCRz7rL/zD7Np/BdO/8YnSb4SS29Z80JEY6xCdbpmlB5acz/lRlGBVkepLOdcEexWcx0Gct9XKiYXQDbhQ/HHQdVIzQff0qe6E6RehGQGw1T7GijsW4eFNhi8TE1kRVY5CszGg0KE1hkq5Sel09m+Pkkxg0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YaKOaXKk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YaKOaXKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647824; x=1761183824;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=juOGAtdjznPc0RKrnj5+K0hX4qicmjHRC5I+vDohYYI=;
  b=YaKOaXKkL4FCh74strGq9dr+KGCQgsM+zBJCzh2ozC8HzpLxYQ221gee
   pGI9Ncbi8kcWxhnuhkLWGj8wvhQIa2tPiOQQ2B6J/4/T5LMAwkbS25pGN
   GzmzKYO3xFSzYg/eLrlYfNAIgU5DjgKCZa3SfEeruZY48nKYP+iaTurDT
   ue3ldbLlYO47MECWGTih02dHUEozEU1RAzUKtfBZ870rlTW0vahtOaPpv
   hK73HMDBsgJ8yAREW4ywXmP6iCYv1i/cX4IrSQMuiKQSj5DMo2wgmkct7
   jaqKkfep/yGfvZO7gAuaxUN4+85yDlnEQjY2+VHR5T/LYYrtCBQS/az+d
   g==;
X-CSE-ConnectionGUID: o8LpFVF9Sn+fwxqEVBnehQ==
X-CSE-MsgGUID: IiqqZbeXSR+qhiEXxpy3lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28658057"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="28658057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:43 -0700
X-CSE-ConnectionGUID: sh9FYzkmT2Gp3DCdZhSqFg==
X-CSE-MsgGUID: DM8MvJYvS++44cn4ZY8GWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84630744"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.222])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:43:42 -0700
Subject: [PATCH v2 3/6] cxl/acpi: Ensure ports ready at cxl_acpi_probe()
 return
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: vishal.l.verma@intel.com, alison.schofield@intel.com, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 22 Oct 2024 18:43:40 -0700
Message-ID: <172964781969.81806.17276352414854540808.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
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

