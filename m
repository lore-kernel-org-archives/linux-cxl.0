Received: from skyblue.cherry.relay.mailchannels.net (skyblue.cherry.relay.mailchannels.net [23.83.223.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566FB2206A7
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780620313; cv=none; b=RhH/mZ5ILcvYl/3iwbSt2AvNB1uwgCtaRSuIdIPlDOQy6OhxuEW7+teTibJ/zRHoy5FluDzC6gLNDqcdJMxB0nyfmPo8P+ow7HWoRvJUAnxNZGc+TRfkbhNXM/oSgSwHaW/qVlDDlb6ZZJ6LpOPcPaMPmA+xlEHLl7rD58kHgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780620313; c=relaxed/simple;
	bh=M/SHMaHiz1sUoOiP9LmTBy5S9F10cfyW4sd2KDOuQ7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IA4OhDfA4+38L+0PDJyErGtWzm2OfNR/QfnfW9DfhgttT8aUxYnWTtJDpdKlKG6fB2MKKmObJPFeD0L0ZacnFYOsXFP+VLZ7OxcIEEy0k0wtUYCkX32Vgy7trPWk6UIuLqJmF0jpHYkz6vZQ3vj5heSre0ZG8Xch5D8aafzbGG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=O9cw+Y54; arc=none smtp.client-ip=23.83.223.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="O9cw+Y54"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C3E0280166C;
	Fri, 05 Jun 2026 00:34:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a258.dreamhost.com (100-116-180-175.trex-nlb.outbound.svc.cluster.local [100.116.180.175])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6AD708008DA;
	Fri, 05 Jun 2026 00:34:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Tank: 10a9d61a0919943f_1780619659714_3816845602
X-MC-Loop-Signature: 1780619659714:17905940
X-MC-Ingress-Time: 1780619659714
Received: from pdx1-sub0-mail-a258.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.180.175 (trex/7.1.5);
	Fri, 05 Jun 2026 00:34:19 +0000
Received: from localhost.localdomain (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a258.dreamhost.com (Postfix) with ESMTPSA id 4gWj9g3VCRz1040;
	Thu,  4 Jun 2026 17:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780619659;
	bh=UiqYWGcVc/7K6SMF5lJvrK8U0LJgT4TNiKoJjAbBER8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=O9cw+Y542U2TN2AWN9QK8ubKot2UZSJEqZL6Uec3pHhCF+ZPnTECqM7V+RmUZ+TtL
	 KOGd6VPl2Y09hPxlasSwmD6TLLBQKEIMyKWi5b1BPvxKcwF14NguGM8RemPQK4ttwA
	 3q9kCkiu8YCh0zTZCzUjqQw9xW69qC8GECsRYOq3Nwv6d+fTUMpMwLdPOXPWaCIKIG
	 zCN0sFdSr6mS9G0VkNC6Bo/WbAcN0xHuMmrnvSXMr92gNJAzZPwkTHCeZZXoX00jUb
	 RbKiHighZ+LlK3wJY82hUTN+UVaXKreYEtTZyXz7xdb+dtNSPppYgP4RofXBYz4XrC
	 PdoviPiukVtew==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 5/5] cxl/hdm: Rename decoder coherency flags
Date: Thu,  4 Jun 2026 17:33:29 -0700
Message-Id: <20260605003329.2584012-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260605003329.2584012-1-dave@stgolabs.net>
References: <20260605003329.2584012-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align with the ACPI CXL Window restriction naming and convert
CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
Type3 coherency models was named prior to Back-Invalidate.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c      |  6 +++---
 drivers/cxl/core/port.c | 12 ++++++------
 drivers/cxl/cxl.h       |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 6a9ba82719e9..087dd1e86d40 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -143,9 +143,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 	unsigned long flags = CXL_DECODER_F_ENABLE;
 
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
-		flags |= CXL_DECODER_F_TYPE2;
+		flags |= CXL_DECODER_F_DEVMEM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
-		flags |= CXL_DECODER_F_TYPE3;
+		flags |= CXL_DECODER_F_HOSTONLY;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
 		flags |= CXL_DECODER_F_RAM;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_PMEM)
@@ -445,7 +445,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = (cxld->flags & CXL_DECODER_F_TYPE2) ?
+	cxld->target_type = (cxld->flags & CXL_DECODER_F_DEVMEM) ?
 		CXL_DECODER_DEVMEM : CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2b463a8b06a7..495a5fe869a1 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -128,8 +128,8 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
-CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
-CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
+CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
+CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLY);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
 CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
 
@@ -354,8 +354,8 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 {
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
-	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
-	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
+	unsigned long hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
+	unsigned long hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI |
 			       CXL_DECODER_F_PMEM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
@@ -364,8 +364,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 {
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
-	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
-	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
+	unsigned long hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
+	unsigned long hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI |
 			       CXL_DECODER_F_RAM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 73d4d2d4616d..bab8ca3dc2a4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -282,8 +282,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
  */
 #define CXL_DECODER_F_RAM   BIT(0)
 #define CXL_DECODER_F_PMEM  BIT(1)
-#define CXL_DECODER_F_TYPE2 BIT(2)
-#define CXL_DECODER_F_TYPE3 BIT(3)
+#define CXL_DECODER_F_DEVMEM BIT(2)
+#define CXL_DECODER_F_HOSTONLY BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
 #define CXL_DECODER_F_ENABLE    BIT(5)
 #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
-- 
2.39.5

