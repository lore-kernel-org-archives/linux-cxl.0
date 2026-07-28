Received: from fennec.ash.relay.mailchannels.net (fennec.ash.relay.mailchannels.net [23.83.222.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B192C0303
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250134; cv=none; b=jnJeDybG283R8kFXrkO8t/PhA4IiUvthz+RL+WdVSwoImxWBTychF1s+djnf2NvWTW6yQ+fxpe8kIVIfRP8m7Tq5A3b72YF5opSCMVsY1UdGFBBBrNNnsb6/zTTTkV31iJFKHkVshgoPUNFW716QM1GFcz68s6YNf8lFXS8HgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250134; c=relaxed/simple;
	bh=TMWJVLaVSVDqWpQyRuMSFSlQkE7PKH65iAS9PPJMrEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sXbVY+JhZ0mieY0AS3ohUc+NCmqWRlVeIAbn/iDsDEJLpYwom45FCMemRmMknJcfWIrGGqc1AJK1RPp9EAomPj1IMACTDSXw85xaR6J+uZ5/AT0YcQvGTLGPLFDPMyRhBBZZzTMN78beQmaFQhkEMoekSfUDTlBklyx/9Dp4cLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Gb6XRyOd; arc=none smtp.client-ip=23.83.222.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Gb6XRyOd"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 183397E28AA;
	Tue, 28 Jul 2026 14:41:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.106.248.77])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C91107E299F;
	Tue, 28 Jul 2026 14:41:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Quick: 0bb4e9121b3252b6_1785249710958_3649512935
X-MC-Loop-Signature: 1785249710958:3810464183
X-MC-Ingress-Time: 1785249710957
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.248.77 (trex/8.0.2);
	Tue, 28 Jul 2026 14:41:49 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4h8dT918Qrz18l;
	Tue, 28 Jul 2026 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785249709;
	bh=QG1XyQ9jHSJ+C2cMC2TCITE+wdUSo518oqtBqvGSg6A=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Gb6XRyOdTtsBNYue1KhT6tXOM4kvRt79YRDRjNMibVXdtMzMtORuIL1GjPlHCxVhK
	 e4nfgnUw43hIdecPVjD/EhMoXgXktT2TKaQf5d0Q03H9gEB/RZtExRM9EIoN7yWttp
	 lFR0Y9WK0VdIjVi2RthX3EDl4dxq11zjtOWlwBsj5pf6oskUoo4DORZI4Rg2VAIQkk
	 B/U7cm+pgB6rCLJlDia7r+laHEGebu8S2izGd3jbSW6xIIBbDI8QLEHlorbvppQZsT
	 qkshgdOF3lVI2wG9jS0tc4IijTfzG0WOYSz//tYO9o4Ypz9uZ49F2GfpnzKLXKbY2A
	 rPK31Buog1WPw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v7 5/8] cxl/hdm: Rename decoder coherency flags
Date: Tue, 28 Jul 2026 07:41:33 -0700
Message-Id: <20260728144136.709882-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260728144136.709882-1-dave@stgolabs.net>
References: <20260728144136.709882-1-dave@stgolabs.net>
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
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c      |  8 ++++----
 drivers/cxl/core/port.c | 12 ++++++------
 drivers/cxl/cxl.h       |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index eceb8dd97df2..2c54f709c45d 100644
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
@@ -447,8 +447,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
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
index 2dbd8c24f968..57882f4c2d8e 100644
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
 
@@ -364,8 +364,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
@@ -375,8 +375,8 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ec2203561446..ca7051641c47 100644
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

