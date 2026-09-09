Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A259333439
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973420; cv=none; b=TEjyklM1gQTtK+HdTqty4faEYpgxZIs6UmJ+v60hzQO7rK4HcEmtw/t0sOZl5xP7y8b/zmljOwQaX3utmphtAgGCRQOLIjKPTCrw84WSq/bNcEnjkYB4041N0+ikbuuLhzqZZ2/NCAoZAipYR6rryiDSW50QTzel/obFg5znAQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973420; c=relaxed/simple;
	bh=y7PwJcouYvwfNNfvicw37Kl917pm8SelRNId6TEOQRg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X9xQQ6XVS3uNyGzuyYfaKGoGSRth+TchneXFI4KCgrkmyvJOVAnjUI7z8H2yr9Do0qfu6Y0ylC1bDAxI1HU0KfeJ9eli2Obbo0nvKINckXlNvbw+QsBKhequkmraUEbPDY05SodtjA4v3WZoIfaNuljgAkGLNIhV8LHwNftYLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=h81FPH1R; arc=none smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="h81FPH1R"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EA4398C2952;
	Wed, 09 Sep 2026 17:03:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.96.173.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B46BD8C11A9;
	Wed, 09 Sep 2026 17:03:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Irritate: 1a9d8d824eeee227_1788973411834_796978173
X-MC-Loop-Signature: 1788973411834:696167126
X-MC-Ingress-Time: 1788973411834
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.173.63 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:31 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zq0lN9z1S9;
	Wed,  9 Sep 2026 10:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973411;
	bh=pnRL2lZ1XoTnD8BaqEThTPMtJ/oxXykOuoEvv63dE4c=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=h81FPH1R+jIcy9Dvko2jTYmD7WJY8f7y5Vwdl0TILiCD/k8lnS34glAWoHA42+M6M
	 /ia9XX1rFi8KqMnUBi4Z2RxE0tpPqEqnpyCRo4kwZbHeokzG5lsOGHjtZ0Qn0brgiL
	 Jnb/wcfJisdBhvv+ceq02dnI5whioYXGM60EsCQZ3V3AflW/SXVi+ceMFTxYDcIPEW
	 2oPw6KhDQgqaZqw8aTHqAnZfB/k+qQsQLwcz/xnxNuSzTVA/v9JIYv846UoNbTpye3
	 v7k3rDl9BJYd2U8T16qKscNVWkoMNc1sgDA/vsQWfrrghN+LxhZiNTPLwN4i64xQgi
	 1fQVmDtOheLdg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v8 05/10] cxl/hdm: Rename decoder coherency flags
Date: Wed,  9 Sep 2026 10:02:57 -0700
Message-Id: <20260909170302.1550680-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909170302.1550680-1-dave@stgolabs.net>
References: <20260909170302.1550680-1-dave@stgolabs.net>
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c      |  8 ++++----
 drivers/cxl/core/port.c | 12 ++++++------
 drivers/cxl/cxl.h       |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 2e8e31544a5f..f04ac5275af8 100644
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
@@ -459,8 +459,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	/* host-only wins if firmware sets both coherency restrictions */
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	if (cxld->flags & CXL_DECODER_F_TYPE2) {
-		if (cxld->flags & CXL_DECODER_F_TYPE3)
+	if (cxld->flags & CXL_DECODER_F_DEVMEM) {
+		if (cxld->flags & CXL_DECODER_F_HOSTONLY)
 			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
 		else
 			cxld->target_type = CXL_DECODER_DEVMEM;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d26cd7c88a1..fa1574b46b6f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -129,8 +129,8 @@ static DEVICE_ATTR_RO(name)
 
 CXL_DECODER_FLAG_ATTR(cap_pmem, CXL_DECODER_F_PMEM);
 CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
-CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
-CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
+CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_DEVMEM);
+CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_HOSTONLY);
 CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
 CXL_DECODER_FLAG_ATTR(cap_back_invalidate, CXL_DECODER_F_BI);
 
@@ -365,8 +365,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
@@ -376,8 +376,8 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3a3fefaf5cfa..c12009674445 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -295,8 +295,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
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

