Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C151614C
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790121441; cv=none; b=bh9eCwZ/YGS3Y1y7PPIunQ7+Qnw51rtct/KMWPrQv2AWGIgXHnux4+di8KtR0xaOcpcU6aAp9bCQ2JgL8PFL8fG3Fj2kPHSE019JYjDBqn8CKSh3I3kh76SEgCjrBew6vgOUuPVQZTyH41cJM+rKUSfl+3pJd3PJZpX3yBr3LPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790121441; c=relaxed/simple;
	bh=cZL9+JO11MWga7mKZUuKiOn3tgHT9gwDKT5N62uuFyA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phF74N9LQTFfOXoKEkfR7Y28C1vfQJvp8wdvotURnh4CGh/pWNeotgKYSFAl5b8MKD+rr4ZaITNW7RpvWRJrXKS31W4yxm8AO2AOowNi4SCgwEVDPtGTuI4EY/D7nZUiEmURNBp8DYdHyCz81NGRzh0bIrkgyBPMKhDM0ioupj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=nLS/7ySZ; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="nLS/7ySZ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9252F7E2522;
	Tue, 22 Sep 2026 23:39:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-99-163-208.trex-nlb.outbound.svc.cluster.local [100.99.163.208])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 639FB7E24FA;
	Tue, 22 Sep 2026 23:39:03 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Snatch-Company: 33dd8c3617a2644a_1790120343511_3555170696
X-MC-Loop-Signature: 1790120343510:1908054673
X-MC-Ingress-Time: 1790120343510
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.163.208 (trex/8.0.2);
	Tue, 22 Sep 2026 23:39:03 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4hqGlB3GHHzPK;
	Tue, 22 Sep 2026 16:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790120343;
	bh=TPb8+UQ+DNRFk5HVgZQ2Uv5s+PZIE3Be92i4kwhUVlY=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=nLS/7ySZ5ZkeOBBX1aed4wa/Ue6HofXbtwhG+nsiL8k7K+DwkHc4VRjBGKyDPG+Ff
	 45nufW3hpkFpkFPgp3V3FajEZS3wse7+HHwnthY1vmPZhcQ0gZrqGOZGaAFgRnVR7k
	 bzpmXdcYldTSK58fGtZIFg7JpYbwmr4ZpKIdZzo+5df0pwfSvkVZCDGhaDp0KXq/7G
	 FzSEVQZSLM4AS9oP2Zze9zaTlNqrtbAvyE3IHCQ5eh+icjpoVOhQCi7IChwDeTLLrn
	 +RF8W/hznZkPpUqhjpDZMjc/KYWP6WAHFAGGUiZuPwg3+8tP2RddUxW9i42KpSN8RA
	 ea0M55d48ObFQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	alucerop@amd.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 05/10] cxl/hdm: Rename decoder coherency flags
Date: Tue, 22 Sep 2026 16:38:42 -0700
Message-Id: <3586f226c41a1b49e798d1f36b77ea54e573fc87.1790103847.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1790103847.git.dave@stgolabs.net>
References: <cover.1790103847.git.dave@stgolabs.net>
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
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
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
index 9fb0278e2ce4..3639cd2daf0c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -296,8 +296,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
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

