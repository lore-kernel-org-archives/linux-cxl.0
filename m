Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175704;
	b=euy97BB/KWmTQclhPUEmFVIV1+L7aY9yjvs1iTrzHgFR5cwyIzWvzoD86CoqUaTOhsm2
	 p6/1gc9lGfNDHKj3geWzzZvZF7fKwOCYupyvXJ02/lhBkprsAdO+OrDwUqM1xiERQ7FiA
	 Nuq+bsBqAwSy3OCi5gMzzEQfie2sSMVuMZTi8bMnq3CSB9QzNVHaCI43ZzHJwp9NG6LEE
	 VSa/gAzIB5Yd2y3nZ+DqmG+zbrVb/7nV5KrWucYbJvt8cOfn9sBoG9OJFTQokV8awJ8Z+
	 j25EDfvHTfcODH9LMYSh/vAd3H0ODImHWnmn8NWVj19VSpuiPErcz4lZyGAsLuYxtmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175704;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Company-Madly:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=85TZ9W6WqP0ptKH2NNjLGHkr6ZOrkkbF3RWkxW6SZ7g=;
	b=zjjHCdxdjMllU6CfwiKi/D53IWnfUO+/NUKJTr3D8CCGU/dUdQQV5xvN2CDo6vQiuJap
	 dgCfU6M2/3Fjz0slpzTvrvLnW0idbxGl4Lbtsvi97I92aXt8qYYF3VsgCa2IluMbk9KlE
	 693tWzxsUp+N9uOpPeCEkiNP2uV6y65iD3GUSjVTIat0y+mGx3FOepxz4+QEEs2XG8Why
	 kdCpDbUClBRxO4am0H90kPVr/GbMfINI9gUaoDcc3woRYKDzZq7V7r+se+SdxVHjMj10E
	 J17/ZbLmuoOPq/D6ApO4dkO5r3hENjYtnw35RP05rw0325lixc3C0vDo5AmE4ZSDG1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=GodlsmVC;
	arc=none smtp.remote-ip=23.83.223.163
Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F24D606A31C
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F24D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=GodlsmVC
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4F83C4E1A4F;
	Sun, 08 Nov 2026 22:08:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.99.178.124])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 055874E159A;
	Sun, 08 Nov 2026 22:08:14 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Company-Madly: 0ef12ab0739c48c5_1794175698244_4210779280
X-MC-Loop-Signature: 1794175698244:2250503603
X-MC-Ingress-Time: 1794175698244
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.178.124 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:18 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vj2STbz1073;
	Sun,  8 Nov 2026 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175693;
	bh=85TZ9W6WqP0ptKH2NNjLGHkr6ZOrkkbF3RWkxW6SZ7g=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=GodlsmVCQv/UjMYFoSJjZs0kwkNwBLPJJkZRwRymvK+Ly6acwlnOcgI/uTiUrVQm3
	 mwXfDVi7H6IJYtNrfiDHNXeP2+NYIwKHRGlydFk5Wc/PoGowThPvY7MNgISFjfWQuk
	 ZpKCV1Qeh29+xnl4fBqFl9/zwyBulC3WiS2DcBGtqG4oALpIatUevA7pstpFJQqk+I
	 o+oXHFpoEV+rHC9nE5GqH8p+aG12HtrBZzOEOxhNVsFK5rwR86YbZKQLSCL4lnwpR8
	 wWZI14FBZ3l8VCyDFQUq/Jztx56YDv+Wpdqh5b+mABU0WQJvvoGu8dh2IgGrpbT7aw
	 3qyAbY6XmTvIA==
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
Subject: [PATCH v11 10/10] cxl/doc: Update maturity map with BI support
Date: Sun,  8 Nov 2026 14:07:39 -0800
Message-Id: <06a8b82be2447afc0a75f3665852cd25f923ef8e.1794172701.git.dave@stgolabs.net>
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

Add the respective Back-Invalidate info to the maturity map document.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/driver-api/cxl/maturity-map.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index fefd31899229..35097537cf3f 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -63,6 +63,11 @@ in place, but there are several corner cases that are pending closure.
 
   * [0] Decoder target and granularity constraints
 
+* [1] :ref:`Back-Invalidate (HDM-DB) <back-invalidate>`
+
+  * [3] BI topology enable / disable (endpoint, DSP, USP route table, RP)
+  * [3] Firmware-enabled path adoption
+
 * [2] Performance enumeration
 
   * [3] Endpoint CDAT
@@ -170,7 +175,7 @@ Accelerator
 -----------
 
 * [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
-* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
+* [1] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
 * [0] CXL.cache 68b (CXL 2.0)
 * [0] CXL.cache 256b Cache IDs (CXL 3.0)
 
@@ -196,6 +201,15 @@ Details
   hiding some standard registers like PCIe Link Status / Capabilities in
   the CXL RCRB (Root Complex Register Block).
 
+.. _back-invalidate:
+
+* **Back-Invalidate**: HDM-DB lets a device snoop the host over the
+  CXL.mem BISnp channel instead of CXL.cache. The kernel enables BI on
+  every port between a device and its root port, requires 256B Flit
+  mode on the path, adopts paths firmware already enabled, and creates
+  HDM-DB regions under CFMWS windows carrying the Back-Invalidate
+  restriction for Type 3 and Type 2 devices alike.
+
 .. _background-commands:
 
 * **Background commands**: The CXL background command mechanism is
-- 
2.39.5

