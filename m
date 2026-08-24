Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD67356A0D;
	Mon, 24 Aug 2026 17:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593789; cv=none; b=Sqs2ZTQeBv2fCFU+BbbW9rHT4pAEtR/qb2DiLGWd6HNPECydBT/LKFBAsB0oufJHRw4bPjwzDopMcBHT5jCLyQ+exPCBySbenMMH+X03s2n/4V3ZmUG57sTi48N91TmpCF0+mz+dx2nR5be70BvvN68l+sCGmD9CuGcJMnCAA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593789; c=relaxed/simple;
	bh=PnG6ggQDN1k0RqpGVzooxTa4E7kWWI7ucrLbnDFbNJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5s97/PiRUK+G+tdnxYINL4bMFI1XkOa8lvv06wRZobABVtsEXi2NrKaLffnCJcK3tPUq2VOgazzwzZcWbDWWNDZ4Z0mujKjep53Oygm2/3Sk1vpSD4IIVWV97LBxjXtds3qUB9wy7CoJcfHDQfz/BKo3apyjJ0YalbcoihY8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D05F1F000E9;
	Mon, 24 Aug 2026 17:49:48 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com,
	benjamin.cheatham@amd.com,
	alison.schofield@intel.com
Subject: [PATCH v4 07/13] ACPI: extlog: Fix CONFIG_ACPI_APEI_PCIEAER guard typo
Date: Mon, 24 Aug 2026 10:49:30 -0700
Message-ID: <20260824174936.939059-8-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824174936.939059-1-dave.jiang@intel.com>
References: <20260824174936.939059-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The guard reads "#ifdef ACPI_APEI_PCIEAER" rather than
"#ifdef CONFIG_ACPI_APEI_PCIEAER". That symbol is never defined, so the
extlog PCIe AER handling is always compiled out.

Use the CONFIG_ prefixed symbol.

Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Corrected the Fixes tag: e778ffefa34d added the "#ifdef ACPI_APEI_PCIEAER"
  guard, not 95350effc3ad.
- Dropped Reported-by: sashiko-bot; it reviewed this patch rather than
  reporting the typo.
---
 drivers/acpi/acpi_extlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 3aec73187b51..ebedf3b136a8 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -136,7 +136,7 @@ static int print_extlog_rcd(const char *pfx,
 static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 			      int severity, u32 len)
 {
-#ifdef ACPI_APEI_PCIEAER
+#ifdef CONFIG_ACPI_APEI_PCIEAER
 	struct aer_capability_regs aer_regs = {};
 	struct pci_dev *pdev;
 	unsigned int devfn;
-- 
2.54.0

