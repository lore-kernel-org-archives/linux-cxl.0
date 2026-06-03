Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E64375F65
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jun 2026 18:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780513077; cv=none; b=TqFzWRZcGry8pDgX95gHKl6p2sh+rpNYlY7c9cytcfhg5eGYAdU7FIxF+b9vdFNGGPFh+BidzCte4ykrTzLnaI3uqXrvFkhUa/JNpUVYf5mbMG91QM/wVcqf88hAgQ4w17wHfhS3QP2SxPQ5yOaTx1rT85sjuzZz64ho7WJXVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780513077; c=relaxed/simple;
	bh=faZdRt3T/hznVMg12zolN2HwQyJEAUknnPxqvqVMpAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWeEPcGiebDg1R2ZY94/FU1dJK6xjNJN7zWSYF0IJ72BdOkSm4TJ7gxn/P7W+0/P+BS/QqjsqLzwUeZMnZDE1ibrU7kAnb5F/IHf03FSUOCDn5XTTO4D3FvDmENMG4+uiyYhulqWdyFIsHzb4/abV38DI9yN30PBTD9Henl+pHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B941F00893;
	Wed,  3 Jun 2026 18:57:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	djbw@kernel.org
Subject: [PATCH 2/2] cxl/pci: Convert PCIBIOS errors to errno on DVSEC config accesses
Date: Wed,  3 Jun 2026 11:57:52 -0700
Message-ID: <20260603185752.4149725-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603185752.4149725-1-dave.jiang@intel.com>
References: <20260603185752.4149725-1-dave.jiang@intel.com>
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

cxl_dvsec_rr_decode() and cxl_dvsec_mem_range_valid() are the two that
have callers make such assumptions so far in the cxl/core. Convert the
postive error values to negative errno values so the checks are correct
on error paths.

While the chances of a config access failure are low, fix for correctness
and to avoid confusion in the future when more DVSEC accesses are added.

Fixes: 6612bd9ff0b1 ("PCI: Update CXL DVSEC definitions")
Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory related info")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 43885c59a7f2..cb33dc8139dc 100644
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

