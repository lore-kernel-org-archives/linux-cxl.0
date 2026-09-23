Received: from bisque.elm.relay.mailchannels.net (bisque.elm.relay.mailchannels.net [23.83.212.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3651B4F09
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.212.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125192; cv=none; b=Awaah6Py1JdzFDByoLT6Ib4D6lXGZnHjEfYa/v2iZzDAQcuwVlPNb3z3XoE0XjWv/Qw1XsFT6BmQTC1Gp5qM39a1C8Y8pHjnUOmN3iOHNCIHsqa2behxFSzwuvjicG3V9lTOUzblFR+HUz9kMjWWrSQjqKZjfi1a5b5MmEBKCqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125192; c=relaxed/simple;
	bh=XP4EbRL9LVJCDrYsvEAhlcwBy+VZErCsQTIt1BEZLJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/pxK0toWol7NIh8UU4fnzp6JJuavIEZ3tkHpRI/qm/m0skvhtZdP7QGlnQJujUbt6CJjLMfpIeOxoMdFiSoM4Xjegzc5gpVcNjMDdYSATlHb+ybob2VZ6tE84/N+oSZttFdUrlwyvxhrK4OSH9L66K0+ximhZGJcHRK8ouvr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=n6ATzxF7; arc=none smtp.client-ip=23.83.212.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="n6ATzxF7"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2C2CB8C29C8;
	Wed, 23 Sep 2026 00:44:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a240.dreamhost.com (100-99-242-205.trex-nlb.outbound.svc.cluster.local [100.99.242.205])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D36398C2D70;
	Wed, 23 Sep 2026 00:44:13 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Unite-Average: 2ab851975bf2ee5a_1790124253966_1023705055
X-MC-Loop-Signature: 1790124253966:871661400
X-MC-Ingress-Time: 1790124253966
Received: from pdx1-sub0-mail-a240.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.242.205 (trex/8.0.2);
	Wed, 23 Sep 2026 00:44:13 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a240.dreamhost.com (Postfix) with ESMTPSA id 4hqJBP0wGTz103Q;
	Tue, 22 Sep 2026 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790124253;
	bh=MvnFwKHbJlXh2/RqBfZtu117YtoEz3p4ihCm7uQoRl8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=n6ATzxF7dknZycWU2Bm9Q0koBftjRQethFS/XcEmBpXTJNgUmkLQ1blKoUe1QQXoe
	 vevbqwzqZbVh63IGMDiy02XzXu46FcF2tRJv+EK5yzKGy79X9bSj0ljzXflBmiMZFb
	 BCze/9uPk/mxZc74QSrMEysUwsWuYA6/E3U7IRRiW4Cx7jNrvd03ShDl27unneGaUh
	 VFrErFBdAPms7pExgZ19VXSAUeWDD+LTE2X4Be7olXdZ0aryl646EMOQMW/Ryk8fc0
	 vqkknBHcjgIkejyNN3F9llePF40OpzIR/5QM78igPztGOdHlBFj5kGWzCD9HmJOFeP
	 jtMNmi/awQpuA==
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
Subject: [PATCH v9 10/10] cxl/doc: Update maturity map with BI support
Date: Tue, 22 Sep 2026 17:43:25 -0700
Message-Id: <8d84cdb26c176226070377f8fdd66fc6af5ace6c.1790103847.git.dave@stgolabs.net>
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

Add the respective Back-Invalidate info to the maturity map document.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/driver-api/cxl/maturity-map.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index 282c1102dd81..0b857476cb47 100644
--- a/Documentation/driver-api/cxl/maturity-map.rst
+++ b/Documentation/driver-api/cxl/maturity-map.rst
@@ -63,6 +63,11 @@ in place, but there are several corner cases that are pending closure.
 
   * [0] Decoder target and granularity constraints
 
+* [1] :ref:`Back-Invalidate (HDM-DB) <back-invalidate>`
+
+  * [3] BI topology enable / disable (endpoint, DSP, USP route table, RP)
+  * [2] Firmware-enabled path adoption
+
 * [2] Performance enumeration
 
   * [3] Endpoint CDAT
@@ -166,7 +171,7 @@ Accelerator
 -----------
 
 * [0] Accelerator memory enumeration HDM-D (CXL 1.1/2.0 Type-2)
-* [0] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
+* [1] Accelerator memory enumeration HDM-DB (CXL 3.0 Type-2)
 * [0] CXL.cache 68b (CXL 2.0)
 * [0] CXL.cache 256b Cache IDs (CXL 3.0)
 
@@ -192,6 +197,15 @@ Details
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

