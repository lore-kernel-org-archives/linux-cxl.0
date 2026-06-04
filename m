Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2072E45000
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jun 2026 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596124; cv=none; b=Cg/69MXWHwVMD1tT/XvVIDXqaUcECjD/250rQQk2K2S5fLG1C+fklZRXnFSOxbDgeZwgtLuDv+KPXgNcgBYzatJRkSomk2CAej4CcQOOA85l4oP8G1vazQ4bfGSOdF4eLkCYv7+2jTnzhe8TWfPnvxI8sdhs/hK2zJPyujNtMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596124; c=relaxed/simple;
	bh=ybj/xlvDYB+wQMGhgzaBx1gCZOTtTc/wofmVr9E3khQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p37/1HanfJxopD2Hlf+tLHJ8ELdN48Ce0LW3DMS6Lnf7h9ndS2w6NNxKRNr/WTEXhRUTZy2PRvkb8mLdLAzxe4zIpVx1LdzO8HXN9Rk2iTfM5LkVAT7GccQU0BePLjpUfuapaIr33ZJ9GQU7j6q/5gpIDgf9K4ubIH9OhO9B2SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC861F00893;
	Thu,  4 Jun 2026 18:02:02 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com
Subject: [PATCH v2 2/2] cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
Date: Thu,  4 Jun 2026 11:01:54 -0700
Message-ID: <20260604180154.1925149-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604180154.1925149-1-dave.jiang@intel.com>
References: <20260604180154.1925149-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI config space accessors return positive PCIBIOS_* status codes on
failure that are positive integers. Several DVSEC accesses in the CXL
core propagated these raw values to callers that test for failure against
less than 0. Thus silently misinterpret the return value as success.

Convert the postive error values to negative errno values so the checks
are correct on error paths.

While the chances of a config access failure are low, fix for correctness
and to avoid confusion in the future when more DVSEC accesses are added.

Fixes: 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration in the core")
Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Fixup cxl_dvsec_mem_range_active() and cxl_awai_media_ready(). (Alison)
- Fix fixes tag (Alison)
---
 drivers/cxl/core/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 43885c59a7f2..e4338fd7e01b 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -89,7 +89,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
 					   d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id),
 					   &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		valid = FIELD_GET(PCI_DVSEC_CXL_MEM_INFO_VALID, temp);
 		if (valid)
@@ -123,7 +123,7 @@ static int cxl_dvsec_mem_range_active(struct cxl_dev_state *cxlds, int id)
 		rc = pci_read_config_dword(
 			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(id), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		active = FIELD_GET(PCI_DVSEC_CXL_MEM_ACTIVE, temp);
 		if (active)
@@ -156,7 +156,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	rc = pci_read_config_word(pdev,
 				  d + PCI_DVSEC_CXL_CAP, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	hdm_count = FIELD_GET(PCI_DVSEC_CXL_HDM_COUNT, cap);
 	for (i = 0; i < hdm_count; i++) {
@@ -275,7 +275,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 
 	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CAP, &cap);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE)) {
 		dev_dbg(dev, "Not MEM Capable\n");
@@ -299,7 +299,7 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 	 */
 	rc = pci_read_config_word(pdev, d + PCI_DVSEC_CXL_CTRL, &ctrl);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	info->mem_enabled = FIELD_GET(PCI_DVSEC_CXL_MEM_ENABLE, ctrl);
 	if (!info->mem_enabled)
@@ -316,14 +316,14 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 		rc = pci_read_config_dword(
 			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_HIGH(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		size = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
 			pdev, d + PCI_DVSEC_CXL_RANGE_SIZE_LOW(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		size |= temp & PCI_DVSEC_CXL_MEM_SIZE_LOW;
 		if (!size) {
@@ -333,14 +333,14 @@ int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
 		rc = pci_read_config_dword(
 			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_HIGH(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		base = (u64)temp << 32;
 
 		rc = pci_read_config_dword(
 			pdev, d + PCI_DVSEC_CXL_RANGE_BASE_LOW(i), &temp);
 		if (rc)
-			return rc;
+			return pcibios_err_to_errno(rc);
 
 		base |= temp & PCI_DVSEC_CXL_MEM_BASE_LOW;
 
-- 
2.54.0

