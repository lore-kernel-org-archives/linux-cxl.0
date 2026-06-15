Received: from coral.ash.relay.mailchannels.net (coral.ash.relay.mailchannels.net [23.83.222.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46607413608
	for <linux-cxl@vger.kernel.org>; Mon, 15 Jun 2026 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544034; cv=none; b=gAgDovHP5P3PTxfuOI0bjdwp37ZTnekFAfqpvrh7KkvpiRcW9DFHiQLLu5dvqBWoT3pl+EyIUy/llgtaOKutVB5sNn+1QUdvC/VE9qYEHhWesGoN8vxMOpmISEps5Er1BAiKgUeOar/YODdsdNSdNPsjZaVz04Yl9Jewo2EXXKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544034; c=relaxed/simple;
	bh=79o1QlHiPzRhx89zXVNbcM7j0l7dJFz+93sTV9pn12g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZeY8ZmnzEJk3nUhWOv66abscrUajL4rkfjvt4AZ1BuhA/PgZOEV8QCgDn7D1vIcSjWJC/uwkYCjFW0zU6ayplzooyLnKaaX4wYpO7upgbZpo/06kKrZgOIPUKL4gje+Dbw6HUo04UyxzMc8jtzbGqXAVtdTNv1bv+oy1o6BoMkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nO8/OA6g; arc=none smtp.client-ip=23.83.222.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nO8/OA6g"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8101D41DBD;
	Mon, 15 Jun 2026 14:56:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (100-96-18-11.trex-nlb.outbound.svc.cluster.local [100.96.18.11])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 24BA841CB7;
	Mon, 15 Jun 2026 14:56:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Little-Cooperative: 74d82d162ecf0f1f_1781535372444_3727923879
X-MC-Loop-Signature: 1781535372444:2848760028
X-MC-Ingress-Time: 1781535372444
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.18.11 (trex/7.1.5);
	Mon, 15 Jun 2026 14:56:12 +0000
Received: from offworld.lan (unknown [138.84.34.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4gfCqY2bHCz1dZ;
	Mon, 15 Jun 2026 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781535372;
	bh=6hTItL5Yt5dSlwxgI5AYN2kF+cIfh4gJtceqnMSiv/E=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nO8/OA6gdmBDIicVgx5zILcZCvWRguEbwSkf4dMjbYQU6+fo/fvUYCSuVNU9aUMm9
	 6Nsz+XgasFZgvk3/umJPGyMgBwo9S/2Kz2CbkKulWdOhlIT6JD/fe8euRMoZGmYMBN
	 cRwlSQhqpn0UZEktUYAJc83M+JjBB587wjfbenXg5rqd2NKPkzxs0xFWyOIdCZ2/Au
	 74B4IDiYvlZztBKLxfqUUdxYb+JF/KKzFGTyTldkCWuC5gzCaGms8lTS6UgsEyhM+4
	 vHp/cvwHtwQKy/QBN84O91JzTaXcK+33ifc37ruvx16YrhBSufXYHkL2zuxCp/p61r
	 yrgV2oEd/oVjg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	djbw@kernel.org
Cc: jic23@kernel.org,
	benjamin.cheatham@amd.com,
	icheng@nvidia.com,
	alucerop@amd.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v5 5/5] cxl/hdm: Rename decoder coherency flags
Date: Mon, 15 Jun 2026 07:55:29 -0700
Message-Id: <20260615145529.13848-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260615145529.13848-1-dave@stgolabs.net>
References: <20260615145529.13848-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align with the ACPI CXL Window restriction naming and convert
CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
Type3 coherency models were named prior to Back-Invalidate.

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
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
index 71801dfd614b..63005cf0fa91 100644
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
 
@@ -357,8 +357,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
@@ -368,8 +368,8 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 29231d0db470..b0b4ea4ff8a5 100644
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

