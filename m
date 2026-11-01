Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569890;
	b=wlJFASvOq42IrhI0AX1ijGX0DjBLzV1Pzexndxuqa0tPa7pXPQYyuZ2b16Uz8J6wa8PL
	 4vuPMFZxO1Q4IzPaYL+01Q6oIdRKl7c8HJYSUSPmaS8zI6sAViQZPUvAj8M8qG+m3eJLZ
	 YloMxIVrps7PNplRhnkSAQJ2USw2VeWxxr+Cq+APjKCFbeZa7znRevB1KXLrLsFffuiMM
	 Vk1OtdEKtF4zoje23YvCdFqh0+yWqHl36Z8+kspYZc9hKS/vNwSpJdgQ4idcF19j74kxm
	 a6YwRaEvYKsRauK0iztc8JDJ5VjC6+Yb8d4aoPte9bgQEtjzDH2NhQYoGQ/Sd00CyGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569890;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Eight-Desert:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FBi6L9TjjY3nHHm1/kZkyoOYwhQqjCmpDZMeDKC73Ms=;
	b=GsrS2OyXi14ZgvT9DZJkSCRcCbhd18QONBaGkiLISZozhAmzPUgfBkbAzLaPkuIr9B6/
	 olGxY91TXnuvasJqPALmItDg2AJTqnEyadrQl6TUrBBMOaoL9BVx8BouGhwLp7En8UlHk
	 bTxj5jN8Ml2iZpsMdbWYnBl5GU7Tp6Z3etmg4FJYHlXivbvCZm66xIPZpmheJTkDq/uJp
	 sAJ2b0bjjWiQgX+SnJLSusr3WV1qkWSIlpBnFzeA68jMl/M2/JQ/D4r65xwIJXTTwyzsZ
	 +DY2lvtHzjy9KP6qTh58dytshxZzAWJX5SItflSRq0a0L8u9qvBZTzLySaiQxlZWngw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=SrZsKWCe;
	arc=none smtp.remote-ip=23.83.222.59
Received: from firebrick.ash.relay.mailchannels.net (firebrick.ash.relay.mailchannels.net [23.83.222.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D686606A324
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 21:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D686606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=SrZsKWCe
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D13947A11D0;
	Sun, 01 Nov 2026 21:51:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (100-99-188-64.trex-nlb.outbound.svc.cluster.local [100.99.188.64])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 74E367A11E4;
	Sun, 01 Nov 2026 21:51:17 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Eight-Desert: 312196a71f155082_1793569881765_1237227024
X-MC-Loop-Signature: 1793569881765:2325187427
X-MC-Ingress-Time: 1793569881765
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.64 (trex/8.0.2);
	Sun, 01 Nov 2026 21:51:21 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4jHpSN5vx6z103x;
	Sun,  1 Nov 2026 13:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793569877;
	bh=FBi6L9TjjY3nHHm1/kZkyoOYwhQqjCmpDZMeDKC73Ms=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=SrZsKWCeQVFa0V5XvkfGh2/9bKFW4svlVCPyJX+PTZWCF+1Mq4rGFAsEYwe1cqNMS
	 jh20eLwpY3CiLc7+CxFR3kNHsJqpeYqUhEAAPbI80g1tYJ2M+hFYabqXMCYNDhS8U4
	 jNL0/WwHEd2/uF5twYSUesuTz8Rio5MKvKwFtkrPDxl66n/JaVs9OAyN00AHl28BVt
	 LIeZPuTg2iX6gcua4fI7fqEsAdye8qXCz0LvbmNGmjAFUOs/03XNXEvhJult7zqWVq
	 LW0hJt1gSdHILC6A1baHhlcAGhwvauMuHiQS/xCV9RS0ujj1hrihjnf1OgFMh2LT6P
	 dv/RgI3a+n3Qw==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v10 05/10] cxl/hdm: Rename decoder coherency flags
Date: Sun,  1 Nov 2026 13:51:02 -0800
Message-Id: <31e2b88a69a374ef26baf7169c32d2edbc1887d9.1793567979.git.dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1793567979.git.dave@stgolabs.net>
References: <cover.1793567979.git.dave@stgolabs.net>
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
index cc7c99d3066d..f2700d327c20 100644
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
index 9d321f90c361..218c507891a2 100644
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
index 28c61feef06d..d369c98824ac 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3902,7 +3902,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	 * restrictions can.
 	 */
 	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
-	       CXL_DECODER_F_TYPE2 : CXL_DECODER_F_TYPE3;
+	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
 	if (!(cxlrd->cxlsd.cxld.flags & need)) {
 		dev_dbg(&cxlrd->cxlsd.cxld.dev,
 			"%s:%s range type not permitted by the window\n",
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 88c38db26c51..0397f6b3dbaa 100644
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

