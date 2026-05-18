Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C473F8EDE;
	Mon, 18 May 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105523; cv=none; b=N/XVRbLey3zq7mItikByW6xc4t364otQHMw1gm/yqh0VSDWrm9WvuzEDWzzjGkuLtPWMzymiyrd4LW7nUALOJJyfePTxn7eHii2+usI4FuKyoJt73iz0WjduaX83kF4om1XX7sSEu2o2FxlNcQyZvieLUDiM0nX1tZrZa8Eqjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105523; c=relaxed/simple;
	bh=VBlXOTXQbKAdsShF6qFXMsgKYyrtlFR0YPM4M0Q4J+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LUfuOP5FQCIwprCDKZc9UtNSjtMvhEYs1ijZQYSZGrgLB/AhGVVuP3373CJCHEh9/cQlIPCZYz1918cc/ky4W/bHr8CVcIiZs4VwAsVuXL5Mc0IM0GODRp0Vj0Zwn0DOijdjSjsL5B3aKh8QgEVX4WoAmaVs5ubRI4aLsocgnmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=iKI3kJ1P; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iKI3kJ1P"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A7511CE0;
	Mon, 18 May 2026 04:58:27 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FB4A3F85F;
	Mon, 18 May 2026 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779105512; bh=VBlXOTXQbKAdsShF6qFXMsgKYyrtlFR0YPM4M0Q4J+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iKI3kJ1P2tpugrijq9UeEOqiaR0keIg6UiKca9y1KPs//sWHVKfSzwvx7mug9QL8e
	 IUKR8qj5VTHtKEe9RXeGOXA6o6JBxYe1v+k0YJvoioUjSFrTvOyzDN6uum7vrky2Ls
	 dmFZhp2KyjLWI7JadYq1I0WL2WkExYlsNAYCgcEY=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Mon, 18 May 2026 12:57:46 +0100
Subject: [PATCH v4 03/10] ACPI: APEI: GHES: move GHESv2 ack and alloc
 helpers
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-3-42698675ba61@arm.com>
References: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
In-Reply-To: <20260518-topics-ahmtib01-ras_ffh_arm_internal_review-v4-0-42698675ba61@arm.com>
To: rafael@kernel.org, bp@alien8.de, saket.dumbre@intel.com, 
 will@kernel.org, xueshuai@linux.alibaba.com, mchehab@kernel.org, 
 krzk+dt@kernel.org, dave@stgolabs.net, conor+dt@kernel.org, 
 vishal.l.verma@intel.com, jic23@kernel.org, corbet@lwn.net, 
 guohanjun@huawei.com, dave.jiang@intel.com, catalin.marinas@arm.com, 
 lenb@kernel.org, tony.luck@intel.com, skhan@linuxfoundation.org, 
 djbw@kernel.org, alison.schofield@intel.com, ira.weiny@intel.com, 
 robh@kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dmitry.Lamerov@arm.com, linux-cxl@vger.kernel.org, Michael.Zhao2@arm.com, 
 acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779105490; l=4727;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=VBlXOTXQbKAdsShF6qFXMsgKYyrtlFR0YPM4M0Q4J+4=;
 b=RG6MQi029/Wuzz7XeYkDq/Om18yJLIEx7woMY5OKLHb/PTBReZRKAJvoBlDX6NnEw1ydohh4v
 fpetPBS2w0xDLTunNw30MMk3SHQqStqzCwo85eA3/Y7ZshTASiznpM0
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=

Move the GHESv2 acknowledgment and error-source allocation helpers from
ghes.c into ghes_cper.c. This is a mechanical refactor that keeps the
logic unchanged while making the helpers reusable.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 drivers/acpi/apei/ghes.c      | 65 -------------------------------------------
 drivers/acpi/apei/ghes_cper.c | 65 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3f35580e8efd..91638ae7e05e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -163,71 +163,6 @@ void ghes_estatus_pool_region_free(unsigned long addr, u32 size)
 }
 EXPORT_SYMBOL_GPL(ghes_estatus_pool_region_free);
 
-static int map_gen_v2(struct ghes *ghes)
-{
-	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
-}
-
-static void unmap_gen_v2(struct ghes *ghes)
-{
-	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
-}
-
-struct ghes *ghes_new(struct acpi_hest_generic *generic)
-{
-	struct ghes *ghes;
-	unsigned int error_block_length;
-	int rc;
-
-	ghes = kzalloc_obj(*ghes);
-	if (!ghes)
-		return ERR_PTR(-ENOMEM);
-
-	ghes->generic = generic;
-	if (is_hest_type_generic_v2(ghes)) {
-		rc = map_gen_v2(ghes);
-		if (rc)
-			goto err_free;
-	}
-
-	rc = apei_map_generic_address(&generic->error_status_address);
-	if (rc)
-		goto err_unmap_read_ack_addr;
-	error_block_length = generic->error_block_length;
-	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
-		pr_warn(FW_WARN GHES_PFX
-			"Error status block length is too long: %u for "
-			"generic hardware error source: %d.\n",
-			error_block_length, generic->header.source_id);
-		error_block_length = GHES_ESTATUS_MAX_SIZE;
-	}
-	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
-	ghes->estatus_length = error_block_length;
-	if (!ghes->estatus) {
-		rc = -ENOMEM;
-		goto err_unmap_status_addr;
-	}
-
-	return ghes;
-
-err_unmap_status_addr:
-	apei_unmap_generic_address(&generic->error_status_address);
-err_unmap_read_ack_addr:
-	if (is_hest_type_generic_v2(ghes))
-		unmap_gen_v2(ghes);
-err_free:
-	kfree(ghes);
-	return ERR_PTR(rc);
-}
-
-void ghes_fini(struct ghes *ghes)
-{
-	kfree(ghes->estatus);
-	apei_unmap_generic_address(&ghes->generic->error_status_address);
-	if (is_hest_type_generic_v2(ghes))
-		unmap_gen_v2(ghes);
-}
-
 static inline int ghes_severity(int severity)
 {
 	switch (severity) {
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 7bb72fe57838..8080e0f76dac 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -62,6 +62,71 @@ static void ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 	apei_write(val, &gv2->read_ack_register);
 }
 
+static int map_gen_v2(struct ghes *ghes)
+{
+	return apei_map_generic_address(&ghes->generic_v2->read_ack_register);
+}
+
+static void unmap_gen_v2(struct ghes *ghes)
+{
+	apei_unmap_generic_address(&ghes->generic_v2->read_ack_register);
+}
+
+struct ghes *ghes_new(struct acpi_hest_generic *generic)
+{
+	struct ghes *ghes;
+	unsigned int error_block_length;
+	int rc;
+
+	ghes = kzalloc_obj(*ghes);
+	if (!ghes)
+		return ERR_PTR(-ENOMEM);
+
+	ghes->generic = generic;
+	if (is_hest_type_generic_v2(ghes)) {
+		rc = map_gen_v2(ghes);
+		if (rc)
+			goto err_free;
+	}
+
+	rc = apei_map_generic_address(&generic->error_status_address);
+	if (rc)
+		goto err_unmap_read_ack_addr;
+	error_block_length = generic->error_block_length;
+	if (error_block_length > GHES_ESTATUS_MAX_SIZE) {
+		pr_warn(FW_WARN GHES_PFX
+			"Error status block length is too long: %u for "
+			"generic hardware error source: %d.\n",
+			error_block_length, generic->header.source_id);
+		error_block_length = GHES_ESTATUS_MAX_SIZE;
+	}
+	ghes->estatus = kmalloc(error_block_length, GFP_KERNEL);
+	ghes->estatus_length = error_block_length;
+	if (!ghes->estatus) {
+		rc = -ENOMEM;
+		goto err_unmap_status_addr;
+	}
+
+	return ghes;
+
+err_unmap_status_addr:
+	apei_unmap_generic_address(&generic->error_status_address);
+err_unmap_read_ack_addr:
+	if (is_hest_type_generic_v2(ghes))
+		unmap_gen_v2(ghes);
+err_free:
+	kfree(ghes);
+	return ERR_PTR(rc);
+}
+
+void ghes_fini(struct ghes *ghes)
+{
+	kfree(ghes->estatus);
+	apei_unmap_generic_address(&ghes->generic->error_status_address);
+	if (is_hest_type_generic_v2(ghes))
+		unmap_gen_v2(ghes);
+}
+
 static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 				  int from_phys,
 				  enum fixed_addresses fixmap_idx)

-- 
2.43.0

