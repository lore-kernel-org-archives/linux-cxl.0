Received: from iguana.tulip.relay.mailchannels.net (iguana.tulip.relay.mailchannels.net [23.83.218.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497E2BDC1C
	for <linux-cxl@vger.kernel.org>; Wed,  9 Sep 2026 17:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973425; cv=none; b=fFWSLX2QQsARParOPWoPWAIDgeL9a5Ix6cYlOrnuZyigLsY6stkDazw9I6vEGgOl2d5ZvbDQpPANC+2FjLubJJltyZEDeg37f70fWQ4VashflrVNKuJelQFBzWK1xG6IR91VJCrzIGq5qlPExqZALdsgicnA4/r3g8Y5Hpf789o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973425; c=relaxed/simple;
	bh=cbCHvIX2gWmrlut41+2xo9VbpBiO4/ZO+kJpjQIn8rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFdMU0fJ2SAs6zFp3oLZ80cDcj1BlCix9FWZ1vScywjn5lxuIqdhbjKKdavV+Xj240WLWUlgFQ6e2aF05BiUjMmFg2SM85OahJewWTxfnKs8sZIpVvgTQOnrDTCfaw7LTrB2Z3Nrrbp6nfn44MVAl4JO7Gc+T7UjC0vuISyr9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=WuT4wrOs; arc=none smtp.client-ip=23.83.218.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="WuT4wrOs"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4F3907E2622;
	Wed, 09 Sep 2026 17:03:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (100-96-170-102.trex-nlb.outbound.svc.cluster.local [100.96.170.102])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1D4497E0535;
	Wed, 09 Sep 2026 17:03:35 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Continue: 661a372779c28011_1788973415211_1431491025
X-MC-Loop-Signature: 1788973415211:581800596
X-MC-Ingress-Time: 1788973415211
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.170.102 (trex/8.0.2);
	Wed, 09 Sep 2026 17:03:35 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4hg6Zt3d58z1Z;
	Wed,  9 Sep 2026 10:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788973414;
	bh=cadbRqPnF+sII9/gFs+xvmqDlNZ+McQEEYaOl/Gbpug=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=WuT4wrOst2VSPj64kc0YnpHjkXDKwyEjggATv4YL6k99MeUy+S8FbqIljrN1psYqH
	 AGJRuWSa1HN6vDhm8RFLdGOz9sJXfucC9FLuA/tU3VbSEhw4NW4CNDK1m4RvDS9RoB
	 VU8hmnzxsoQc9Q5hDD8yp0KHOHTI7N3cp85PPRcO4SwJjJj3ytWi/Z4AY9tE0cBy6t
	 GhJjmyWjToaTqh7AcgjbeuvUoQ9TEb8Zh+ZQ6P9IKvKiUZJbK48cSZqAC1mmOClG45
	 n6bD8b/S4lNZOX+guiq5ysqzMgSpyftTVE8UlV+d7FexsMdz1pyrmzrlUSYC+6gwE2
	 lpelduYki3lIQ==
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
Subject: [PATCH v8 10/10] cxl/doc: Update maturity map with BI support
Date: Wed,  9 Sep 2026 10:03:02 -0700
Message-Id: <20260909170302.1550680-11-dave@stgolabs.net>
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

Add the respective Back-Invalidate info to the maturity map document.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/driver-api/cxl/maturity-map.rst | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 282c1102dd81..878fd8723685 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -63,6 +63,12 @@ in place, but there are several corner cases that are pending closure.
 
   * [0] Decoder target and granularity constraints
 
+* [1] :ref:`Back-Invalidate (HDM-DB) <back-invalidate>`
+
+  * [3] BI topology enable / disable (endpoint, DSP, USP route table, RP)
+  * [2] Firmware-enabled path adoption
+  * [0] MLD / PBR switches (BI-ID carrying an LD-ID)
+
 * [2] Performance enumeration
 
   * [3] Endpoint CDAT
@@ -166,7 +172,7 @@ Accelerator
 -----------
 
 * [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
-* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
+* [1] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
 * [0] CXL.cache 68b (CXL 2.0)
 * [0] CXL.cache 256b Cache IDs (CXL 3.0)
 
@@ -192,6 +198,15 @@ Details
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

