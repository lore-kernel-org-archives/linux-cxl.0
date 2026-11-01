Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793570349;
	b=gDNo7hLn/DiLTZSBPzVBZbAMr9PUnapccUMVXvrlkcgpULMpG5QG7ujwTuNDBZX+TgqW
	 Mu/EerL+qA7WOh6G7W7fO2qzRpy3nXnhWCJqXsxL5pXXVrYcA4oAOkTO8vwBcNzEwa8sE
	 YiC73EejsHCXkYOKjqvj8UPod6uOJDg1n0JsHMGcvV4rUeybYRASvcUk62p0ZSPU3kLI1
	 SvQemd2B65tHj7pS3ULK3TvgZ7f3T6Elkz8ncwn3I5f3zgaDToz/6ipCSvEKlwuZ9ytJ+
	 7N/ibS31L7CGLKhpXKUegiufsULG+CEVBnNRlaOtFzmsMIOXQa4VmH9NnowKksLKycA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793570349;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Minister-Lettuce:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Y5bLy9cWtZrHqCC7d1Sd6AHALZ+cQxw5XhuZ1ZcCHoo=;
	b=3/tnUE7PvlUm+R8XkWyI1L+6uFJHcLKmpc9UHjO60zC8y+wyFVOhFk0hetPDphGC/a1T
	 kKZOyok/p/XdQg9SSMbQ7e+gUR0QSUk3Yu6q40NqgtTCg2K+RiKpFodRF6gN4sYHvvwfn
	 RlvU4gY715TXhirCbjOMCz+lqej9+SLt1m49p9qBlcNgOqQ6nnP3nP8u52r+4bLy7vG9/
	 FgpaCdNkBqPtFWnNwZsJ5dzM42x8W0RNbbgaWvHtbWc5MjX7lXmOkJRRZy11ZYAiV67ww
	 BbJyxpfhJ3nD5zOMLgBBxu15XJslK+sSrxcgswEmODmfgoGa/foiuxH5kKGuaEA0BfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=i3PvseeH;
	arc=none smtp.remote-ip=23.83.222.37
Received: from cockroach.ash.relay.mailchannels.net (cockroach.ash.relay.mailchannels.net [23.83.222.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E314606A324
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 21:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E314606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=i3PvseeH
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1275E160DBA;
	Sun, 01 Nov 2026 21:51:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.99.196.24])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D7628160FC5;
	Sun, 01 Nov 2026 21:51:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Minister-Lettuce: 7d4abc033816e835_1793569880990_575010710
X-MC-Loop-Signature: 1793569880990:3158753045
X-MC-Ingress-Time: 1793569880990
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.196.24 (trex/8.0.2);
	Sun, 01 Nov 2026 21:51:20 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4jHpSS1TB0z103v;
	Sun,  1 Nov 2026 13:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793569880;
	bh=Y5bLy9cWtZrHqCC7d1Sd6AHALZ+cQxw5XhuZ1ZcCHoo=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=i3PvseeHue8gKQtHW2GuyhqubG32P9u0T1Ds1UHR6sdsBwsS+8yhNuaLs1bbfY2gw
	 CTOdEIbCLv8W4ABcrFVIIb3/BWcLazbZfUy4V/6DGzmbQeNn3CWaz3meOZnE6a6TYj
	 zi05J/rbL2ZmKCEvEndehtmSIhX3fh0Dw3CouKit0uZpXCcnCCJ/SHXVyOGT0Ileg2
	 /QDVkGOrk+DCQ/k+tmeVcyC+T709kaPD431KfeHqK1avLHZVJblrhL6q3pp0NkkRA7
	 jlE8UFEr4tY5aY+qzawFPWplKt6NIDSc4rcMbPcaXLVc+QmJPY5zXwUOzXFMPwy+CU
	 Yk5g6mcsuTpqA==
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
Subject: [PATCH v10 10/10] cxl/doc: Update maturity map with BI support
Date: Sun,  1 Nov 2026 13:51:07 -0800
Message-Id: <5d42459e66e66721716eea78e355df3e8554f6b9.1793567979.git.dave@stgolabs.net>
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

Add the respective Back-Invalidate info to the maturity map document.

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/driver-api/cxl/maturity-map.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
index fefd31899229..6e8d6ec5bdfb 100644
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

