Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976E1F19A
	for <linux-cxl@vger.kernel.org>; Fri,  3 Oct 2025 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517714; cv=none; b=a5zTcGfp2+OyvVeAXDST75m7ztvNqg7rFGll3I16vxL/GF+bUUutR7Svy65JkJo3E4MqWuhN7EDw4AMbrXZerZMGiJTP6geqjibUG5KDQb6QNZU1QYySDSDfTu40z0Eqgi99gGsJU7MzZpw1rKMp1qoi1QD/jYoPUqqU+DXqp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517714; c=relaxed/simple;
	bh=0G70oYdQkkawyeiVz8JA1MUvZ8LHm2g5ZmnNXw6VeZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyOLdQwuZju62e5qOaCgDUzW1ZWiSUduNe5qT/40mjomd3c1AkP3/aIiJI5ssCYjwbpeB8durTTyPb5osSlkhqndF8Hp4cQvmMXPIKIZfnNW9Ov3Jn4X5yMB22pvFfgvCx1j2UguyLzcOlumqc2VgRnirluCYuwktXD42NVhfCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70287C4CEF5;
	Fri,  3 Oct 2025 18:55:13 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2] cxl: Adjust extended linear cache failure emission in cxl_acpi
Date: Fri,  3 Oct 2025 11:55:09 -0700
Message-ID: <20251003185509.3215900-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl_acpi module spams "Extended linear cache calculation failed"
when the hmat memory target is not found for a node. This is normal
when the memory target does not contain extended linear cache
attributes. Adjust cxl_acpi_set_cache_size() to just return 0 if error
is returned from hmat_get_extended_linear_cache_size(). That is the
only error returned from hmat_get_extended_linear_cache_size() as
-ENOENT.

Also remove the check for -EOPNOTSUPP in cxl_setup_extended_linear_cache()
since that errno is never returned by cxl_acpi_set_cache_size().

Suggeted-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Rename subject line to reflect new changes.
- Further analysis of the code and determined this is the correct
  change.
---
 drivers/cxl/acpi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d7a5539d07d4..cc4d7bf381d3 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -353,7 +353,7 @@ static int cxl_acpi_set_cache_size(struct cxl_root_decoder *cxlrd)
 
 	rc = hmat_get_extended_linear_cache_size(&res, nid, &cache_size);
 	if (rc)
-		return rc;
+		return 0;
 
 	/*
 	 * The cache range is expected to be within the CFMWS.
@@ -381,15 +381,13 @@ static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
 	if (!rc)
 		return;
 
-	if (rc != -EOPNOTSUPP) {
-		/*
-		 * Failing to support extended linear cache region resize does not
-		 * prevent the region from functioning. Only causes cxl list showing
-		 * incorrect region size.
-		 */
-		dev_warn(cxlrd->cxlsd.cxld.dev.parent,
-			 "Extended linear cache calculation failed rc:%d\n", rc);
-	}
+	/*
+	 * Failing to retrieve extended linear cache region resize does not
+	 * prevent the region from functioning. Only causes cxl list showing
+	 * incorrect region size.
+	 */
+	dev_warn(cxlrd->cxlsd.cxld.dev.parent,
+		 "Extended linear cache retrieval failed rc:%d\n", rc);
 
 	/* Ignoring return code */
 	cxlrd->cache_size = 0;

base-commit: 46037455cbb748c5e85071c95f2244e81986eb58
-- 
2.51.0

