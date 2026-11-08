Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175697;
	b=qTR73i5I9ih4WGk+kEsMpeVQCXMTcsGKMNRBKZC3Vkijhy/HvK2xxvDyZJVXYBlahTNa
	 35ZFNh4hE6rqBqkLPugWRiTrstNjGwfUATiyckW3Piv0Lwwk9ujbf8U6AVYAT5uIzo6d6
	 9X91i1Yft9aer0ZNUGSdqnlifbbj1OGm3jiO21P/Tn6ivcNR6nyn4ar3tH6W9q7i8AoPa
	 vDhOWouUouEXTcMjJSqANprrO+FvX7colikUi4CMx/WonfjTeZEht3wkXB/A1Ep+A9Kzj
	 z+T82WfFHp88Uhjz+zvhUhch7z0UfLMR+rdPuW2HiGPr6kCfEfep2VDuApw0TvaY2TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175697;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Fearful-Zesty:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tgFWH4UIVWQMeLytVnhZieog+ysNgZ0ujg4Qitqn7NI=;
	b=vgB7+qzeUvH+XqhE9weqH7O500XBIBVBLayH5h0AC3fRNfJ25FO71YYMo260HaCcMHMe
	 kq/M3kB0WSOW05fedZjo4+5QzfjturqvtZhEPzVvupIO4+8euukBUiRcjIBiL1PqRnD+4
	 VA8QX/Khhgt7G1Lw+j0dOe3zFxz50o/2nWH4YhXQ4yiPN5apIvYrDpojFDRaHIlkJHnLu
	 cgnQJxbKGc2di/5NFh6r6PVCsoKglUdYvuEH5rXWGO+DYH2aS4Yb8dw+Ps4lRIoGMQ/j0
	 +rgRp1543tx5v8sUa081TWUoEX89KWQNBKpYgWh4RpXOz1P566kzCtWjP4FpBo35y4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=fyCNTQWB;
	arc=none smtp.remote-ip=23.83.222.66
Received: from gecko.ash.relay.mailchannels.net (gecko.ash.relay.mailchannels.net [23.83.222.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04432606A31C
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04432606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=fyCNTQWB
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8AB3E64083F;
	Sun, 08 Nov 2026 22:08:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (100-99-186-37.trex-nlb.outbound.svc.cluster.local [100.99.186.37])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 601716402C0;
	Sun, 08 Nov 2026 22:08:10 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Zesty: 0af4d3594b2c82d2_1794175690490_3002158979
X-MC-Loop-Signature: 1794175690490:4219364879
X-MC-Ingress-Time: 1794175690490
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.186.37 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:10 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vd5LC7z1056;
	Sun,  8 Nov 2026 14:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175690;
	bh=tgFWH4UIVWQMeLytVnhZieog+ysNgZ0ujg4Qitqn7NI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=fyCNTQWBP3EoRJtElUWhpd+CgnOvnqaefeS+DqwOp9s3S1Wp7ZkuzBUluZ2uCZXr1
	 h8vcdem6xbYOkX73DxjC0uzk967iwe5p+LhccWeFwiyGua+W0b9RNYPHau1otXweSe
	 4O7jB6yL7w327HvHByLweaKYx0njsQtNhSQvaKSH4ZMG07Q5cznlQ5SiM29hHBDDnw
	 vtCweRKLgOo/i6AiPQFGa92nVg+RpYdliGJTkB2XWywUZZrafRYdxJJosajLHANgTx
	 Ls3sO+31x8HjGivg6cEffVLKhG0TD96o3KUeP1WRufrIMT8t21U/DbUpCmsJ/xAaHt
	 ja20Xjzz51T1g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v11 05/10] cxl/hdm: Rename decoder coherency flags
Date: Sun,  8 Nov 2026 14:07:34 -0800
Message-Id: <454f4d2ae6dbb731c405763303316091b5db0138.1794172701.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794172701.git.dave@stgolabs.net>
References: <cover.1794172701.git.dave@stgolabs.net>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Align with the ACPI CXL Window restriction naming and convert
CXL_DECODER_F_TYPE2/F_TYPE3 to F_DEVMEM/F_HOSTONLY. Type2 and
Type3 coherency models were named prior to Back-Invalidate.

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c        |  4 ++--
 drivers/cxl/core/port.c   | 12 ++++++------
 drivers/cxl/core/region.c |  2 +-
 drivers/cxl/cxl.h         |  4 ++--
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3f43c957ea58..e5533af2e45b 100644
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6f12c1d21c92..fffcb9954dde 100644
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
 
@@ -374,8 +374,8 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_PMEM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_PMEM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
@@ -385,8 +385,8 @@ static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 	unsigned long flags = cxlrd->cxlsd.cxld.flags;
 	unsigned long hdm_h, hdm_db;
 
-	hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
-	hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
+	hdm_h = CXL_DECODER_F_HOSTONLY | CXL_DECODER_F_RAM;
+	hdm_db = CXL_DECODER_F_DEVMEM | CXL_DECODER_F_BI | CXL_DECODER_F_RAM;
 
 	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
 }
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9a3d36a6dd09..d7f605beaa49 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3904,7 +3904,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	 * restrictions can.
 	 */
 	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
-	       CXL_DECODER_F_TYPE2 : CXL_DECODER_F_TYPE3;
+	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
 	if (!(cxlrd->cxlsd.cxld.flags & need)) {
 		dev_dbg(&cxlrd->cxlsd.cxld.dev,
 			"%s:%s range type not permitted by the window\n",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b34f25dee019..7e2112d7ca96 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -305,8 +305,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
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

