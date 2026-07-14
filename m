Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FCD423E8F;
	Tue, 14 Jul 2026 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071132; cv=none; b=kV6XAHRm/0OpNkHAspLuGCKwZBumd303eXrtz5BEhH7ELbPqopOzTGvPfjHkO5RcFtQuNNMB7xgunnfkFD0/XMKVEdH2i3vsfkCPoAekg0aJLYrYmHonWjD4f3Jo35Zvb7To2FCgCtzXr8TR6sZLhrKPqSy2bzMkGmZAfs0sKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071132; c=relaxed/simple;
	bh=v8QNWwNN9IO7A4k80GhUvgNM4Y9e+7clOOdycIE6K1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+NPt4XLhUSnh4UyWcwJYERDMiu6Vl88zPlFCg+Wx5PNzntFqbYUB/UX4Y+jlU49vKBFYkgKlTVbgFowngJB8KkqTaRF+ZlCEiZmBAkvaNPE2jPk0rRRiUfycPN1NezKkw8Ch5nDrZzOlJY0fWhIUUOIi1dCRVUFj8g9xPy1+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7FA1F00A3D;
	Tue, 14 Jul 2026 23:18:51 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: rafael@kernel.org,
	tony.luck@intel.com,
	bp@alien8.de,
	guohanjun@huawei.com,
	mchehab@kernel.org,
	xueshuai@linux.alibaba.com,
	terry.bowman@amd.com
Subject: [PATCH v2 3/7] ACPI: extlog: Avoid populating software AER metadata from raw hardware buffer
Date: Tue, 14 Jul 2026 16:18:31 -0700
Message-ID: <20260714231835.303081-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714231835.303081-1-dave.jiang@intel.com>
References: <20260714231835.303081-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

extlog_print_pcie() casts pcie_err->aer_info directly to struct
aer_capability_regs *, treating raw hardware register bytes as the
struct's software-only metadata fields header_log.header_len and
header_log.flit.

struct aer_capability_regs embeds struct pcie_tlp_log, which places
header_len and flit after the 14-element dw[] array at offset 84.
The 96-byte aer_info hardware buffer covers that offset, so the cast
populates header_len and flit with unvalidated hardware data.

pcie_print_tlp_log() uses flit and header_len to bound a loop over
dw[]. If flit is set and header_len reads as a large value, the loop
iterates past the end of the dw[] array.

Copy aer_info into a zeroed local struct aer_capability_regs and
explicitly clear header_len and flit after the copy so only known-safe
values reach pcie_print_tlp_log().

Fixes: e778ffefa34d ("ACPI: extlog: Trace CPER PCI Express Error Section")
Link: https://lore.kernel.org/linux-cxl/20260709165457.8BA181F000E9@smtp.kernel.org/
Assisted-by: Claude:claude-sonnet-4-6
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- new patch, issue raised by sashiko
---
 drivers/acpi/acpi_extlog.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index 06a944dadbc1..fbc88c584c06 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -137,6 +137,7 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 			      int severity)
 {
 #ifdef ACPI_APEI_PCIEAER
+	struct aer_capability_regs aer_regs = {};
 	struct aer_capability_regs *aer;
 	struct pci_dev *pdev;
 	unsigned int devfn;
@@ -149,7 +150,12 @@ static void extlog_print_pcie(struct cper_sec_pcie *pcie_err,
 		return;
 
 	aer_severity = cper_severity_to_aer(severity);
-	aer = (struct aer_capability_regs *)pcie_err->aer_info;
+
+	memcpy(&aer_regs, pcie_err->aer_info, sizeof(pcie_err->aer_info));
+	aer_regs.header_log.header_len = 0;
+	aer_regs.header_log.flit = false;
+	aer = &aer_regs;
+
 	domain = pcie_err->device_id.segment;
 	bus = pcie_err->device_id.bus;
 	devfn = PCI_DEVFN(pcie_err->device_id.device,
-- 
2.55.0

