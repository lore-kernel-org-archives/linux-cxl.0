Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07792D94A4
	for <linux-cxl@vger.kernel.org>; Tue, 12 Aug 2025 01:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963395; cv=pass; b=IODw2xZmJzEtncIsHv8wN+eAU0iqQOddw0aq7L1wtWDqued4q5GxJraLmgr5yhciLVRy2HveBoavpyITu8+nCmvyDYi45uSoiYNZwGg0rNcXennzduP4bJWefvnL4DfUra2QmvNdpoxNHsv+g9W0moW75kPwZyt6pSNU23ZGaZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963395; c=relaxed/simple;
	bh=0KKCJiXSImOjXOxgTvr1XTktKgKf3ae1YwTD4zmmMrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sxFY1DCngToGi5klUK5sRWytLwntsubXrhAnKD0+R9a7UkNzzbUWoNJUQkoRTw7ivQ7v3SgfyLfwIAbu8Oh1y3Ay9jQmq0VNCTAaRyJCSL8qzjPBhiX1qM7O13X8Y6S3lnWWcCoiVpspQB5GGDsBHsTtfkiNhU6Iw3wAPJAvUt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YWmMt9Es; arc=pass smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YWmMt9Es"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EDAAB2C64B2;
	Tue, 12 Aug 2025 01:02:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (trex-blue-1.trex.outbound.svc.cluster.local [100.96.55.144])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9518C2C6657;
	Tue, 12 Aug 2025 01:02:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1754960552; a=rsa-sha256;
	cv=none;
	b=IO/EcOGoCmgY0eWIeCOZALWLhuawUgojBzIt0aDy+XNQ7SmNChnOMKJJgZ6/o4B6Y53z52
	H1EyrIoH2cvKmwFDL9b6YbRCyBT0wKx8FORhlmJgxqgrq1ebtzte78o2j5HmZZVYT/XhvW
	gtpOqZoIvuaLvP1wMiOXpdlx3Z5+pJVi9IqjkfnOByRr3wvuJis7Zh1CkxabOZS0Sx1OdX
	ClDswOtCx2HhKo/bE0n4fphWvxarMtE1u3JQN549efjpEvCDYV7vTOtzjqq+5d937x59F2
	dkzKyRqe/3AXFoOVKlLIK0mmPY+rUP0uLYwb9TX76U+AzQ2nJf6Z4+TyzaeWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1754960552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=HjfR/OBcHPVGiuEOSPLTf3OqQarmCfO90EcHdI2zOEQ=;
	b=glUBSXO+elJ9tOanoRhlhdBJbfa0VLKPkV6wvbfdfhBU0y0fGqHkedjgE+sHuspSYhUjEC
	lY5Dcdx4QqYt9RLLoYWRxaMyE6rVUX922Uk2vF/+G1ndtuI66OPsTondpHFUeNs9h0tixg
	Cbaq1PPHFEOKkd7jl6Ye4mJp/goQu1mw7qC1MaM6DIvDdLIZLu+GxMD5+LA68G8LKpzbEY
	0iUPWV+ePw/QpAt5/DfYQi/XWO0qQizixuwVjAFYO/pegN+jLsvodsIloRGsJCQBiYoxXx
	9sJ47jOYVOgVgvWQjCiaVZTpZfarOHUnAz1z1R0dGsmFHCtgOIb4dDl+8ax7Tw==
ARC-Authentication-Results: i=1;
	rspamd-865b9ccc6c-k9ztl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Ski: 1174c2c43f0b1cf2_1754960552881_1710805499
X-MC-Loop-Signature: 1754960552881:2848415330
X-MC-Ingress-Time: 1754960552881
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.55.144 (trex/7.1.3);
	Tue, 12 Aug 2025 01:02:32 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4c1CsM6JXgzLg;
	Mon, 11 Aug 2025 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1754960552;
	bh=HjfR/OBcHPVGiuEOSPLTf3OqQarmCfO90EcHdI2zOEQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=YWmMt9EscHt10QpmmBv0rwUKZmhhuV9QkdfrtFvHq/cmYDwDASkvwY3pV9w+cLk3K
	 Tj9aAN2+NCIDHij0IJl0iP80HABDCD/9mU0CVtTDmt998tA3YsLSxAMPHc7DNc93eI
	 17Qxx/84NMV+cCxPtAHit+YYuOkHnz3mvpmFBLL9RdF219GlK3LHl1pGO1p/3ncYeI
	 In75FvL9rQ4Sn6mC8xP4JQU3Bip64xKHBqdJTOSTwVHPtydRmkvxSpmP6AdsRst8Fk
	 RWglNBGJKnojPFcQA46eisYaL9hjh4ippOad2CHRwtS+JKmCcQAlzIECuM3T/wbRVS
	 Cs4Z0GrmqgeQQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com,
	dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	alucerop@amd.com,
	a.manzanares@samsung.com,
	anisa.su@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/3] acpi, tables: Rename coherency CFMW restrictions
Date: Mon, 11 Aug 2025 18:02:27 -0700
Message-Id: <20250812010228.2589787-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250812010228.2589787-1-dave@stgolabs.net>
References: <20250812010228.2589787-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has been renamed in more recent CXL specs, as
type3 (memory expanders) can also use HDM-DB for
device coherent memory.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/acpi.c           |  4 ++--
 include/acpi/actbl1.h        |  4 ++--
 tools/testing/cxl/test/cxl.c | 18 +++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 712624cba2b6..9b32392c82fc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -113,9 +113,9 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
 	unsigned long flags = CXL_DECODER_F_ENABLE;
 
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)
 		flags |= CXL_DECODER_F_TYPE2;
-	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE3)
+	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM)
 		flags |= CXL_DECODER_F_TYPE3;
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
 		flags |= CXL_DECODER_F_RAM;
diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 99fd1588ff38..eb787dfbd2fa 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -560,8 +560,8 @@ struct acpi_cedt_cfmws_target_element {
 
 /* Values for Restrictions field above */
 
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2      (1)
-#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3      (1<<1)
+#define ACPI_CEDT_CFMWS_RESTRICT_DEVMEM      (1)
+#define ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM (1<<1)
 #define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE   (1<<2)
 #define ACPI_CEDT_CFMWS_RESTRICT_PMEM       (1<<3)
 #define ACPI_CEDT_CFMWS_RESTRICT_FIXED      (1<<4)
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 6a25cca5636f..ba50338f8ada 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -210,7 +210,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -225,7 +225,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -240,7 +240,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -255,7 +255,7 @@ static struct {
 			},
 			.interleave_ways = 1,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -270,7 +270,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 4UL,
@@ -285,7 +285,7 @@ static struct {
 			},
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M,
@@ -302,7 +302,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 0,
 			.granularity = 4,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -318,7 +318,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 1,
 			.granularity = 0,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_256M * 8UL,
@@ -334,7 +334,7 @@ static struct {
 			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
 			.interleave_ways = 8,
 			.granularity = 1,
-			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
+			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = FAKE_QTG_ID,
 			.window_size = SZ_512M * 6UL,
-- 
2.39.5

