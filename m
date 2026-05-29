Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E120F3BCD10;
	Fri, 29 May 2026 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048291; cv=none; b=IwRahztcKG8z5stbSx8G1nJRtyykkB1Ia0z/kloCUzydqh2NpA/DPeSfY1LPMITbnNBlFqqtYu43wvOYIh7AszANJRUrHtC5ERe7Rw7MZUtpM7/PipIvMpyD7R9IDpfm/emhgWvOwcI8uZ1Nl7HG44j7cBkLAIlBY8Ptf9eEp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048291; c=relaxed/simple;
	bh=VBlXOTXQbKAdsShF6qFXMsgKYyrtlFR0YPM4M0Q4J+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StA9XdUDlHnwH6r8z0Zva3LRmu5l7kfbibfBX62689F+KemW7WugoZuJC5SvKmpzOkhWHHEB1X0Gp6SNoiuovlwI7rKnZCipT7mvWPp5bHmNPM9nD/YYdYA0G6OzNCqLyP6x4xzjt8qQX8mre3fckJGlf+xHlh9G0xWCLrGymdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=B4irZ3Z4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="B4irZ3Z4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5438132E5;
	Fri, 29 May 2026 02:51:23 -0700 (PDT)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7DE23F905;
	Fri, 29 May 2026 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780048288; bh=VBlXOTXQbKAdsShF6qFXMsgKYyrtlFR0YPM4M0Q4J+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B4irZ3Z4/zfk0EBeRDsa/WC/W5U5zyLZKeSj8pIUCTaeWyiHuZK2T6hhOsssIzI2J
	 uKFz1Qg+ZRViPXJzaOaEsHuTeAmrI7BDU5gWnllKWp7PXHp+eoWPQDzCdfHiBsulOQ
	 L0Q4umz2ph3b22RfxH7/4DA2p2MdCeHitrCVLrzU=
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 29 May 2026 10:50:43 +0100
Subject: [PATCH v5 03/10] ACPI: APEI: GHES: move GHESv2 ack and alloc
 helpers
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-3-2e0500d42642@arm.com>
References: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
In-Reply-To: <20260529-topics-ahmtib01-ras_ffh_arm_internal_review-v5-0-2e0500d42642@arm.com>
To: will@kernel.org, jic23@kernel.org, xueshuai@linux.alibaba.com, 
 saket.dumbre@intel.com, mchehab@kernel.org, dave@stgolabs.net, 
 djbw@kernel.org, bp@alien8.de, tony.luck@intel.com, guohanjun@huawei.com, 
 lenb@kernel.org, skhan@linuxfoundation.org, vishal.l.verma@intel.com, 
 rafael@kernel.org, corbet@lwn.net, ira.weiny@intel.com, 
 dave.jiang@intel.com, krzk+dt@kernel.org, robh@kernel.org, 
 catalin.marinas@arm.com, alison.schofield@intel.com, conor+dt@kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, linux-arm-kernel@lists.infradead.org, 
 Michael.Zhao2@arm.com, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
 Dmitry.Lamerov@arm.com, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org, 
 acpica-devel@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780048269; l=4727;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=VBlXOTXQbKAdsShF6qFXMsgKYyrtlFR0YPM4M0Q4J+4=;
 b=UJCFPKdH2IlyS25gSMshUk/Zhz1uXbuPB5ZLh9cN+UWLZeQvUTAEEAolq+bBCezwHYeCELlo/
 Q6TewpzQghHD+7sIOe+8rhHVQDivdsgQYaOslhm18D2QBD5EZw9OEkW
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

