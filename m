Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.218.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794008540;
	b=jgRMxJZU5NP2YQkDnmDQUuD0NtmFyCGMRNBCGCF+z0mvf4HFeYrUlLsNCgvyNObLoznF
	 Uj5lVQVSbh6WzYtoYC6OzQhv2kvcz5FsF4fASDv7p45sSFW+cT55o+0JhX3qa6rFrJvYb
	 70O9H9Ac01IKeBN77znOrMA7tRo57YxNHyA7D7iGCGXmByXDcgEQDoeyB1f7dflXCc6hA
	 UcHnPFAUXY191IDFdit2Xvy1PZ/vV99s1um6ssNKp0I7/AHdJ/nvSA2mwD5++g2C00ajM
	 f4vo0D/IQ6q0axCSWvxHjisd1fhlKXFSr2y9DCB77EqllEDuIYKhc+5StwTMG3NRLiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794008540;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Shade-Madly:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OFh/9coUNwINxcXZFdjBtndKV7PqV8JZlOM/7A5hDxw=;
	b=di4fXU102ROvEPCcx5K5DGJiEyHw3PEJUO+lmXoPZQxdx4uq6Vz3WrxqKlKKL5sCcg0i
	 uL0nRkLVptyvCgUOs24eadIHiwGrxuUy0VJzv1rmTLfOL0SNgYlOoiF8J8yglwOEJGVf0
	 tklYbMesAU+uhowlDv9YHlq3GoLgV8MBh2y1aR6h93t31kKTlLkF9lT9ZZ+BV7aBCyEMM
	 sXHldQBIMgEeVuiXKEP6Iu4LXtszJxwsPbb93aCcWrzLNIDakLipBApN8gjemq32Lw5C8
	 uAnIZ2HF3tQkTVK7TN2pATbTU11X8ouL+77CLR1Io2/+75gwli+/CbujO/4Ned9LM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=iL8IYgbU;
	arc=none smtp.remote-ip=23.83.218.254
Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5710606A326
	for <linux-cxl@vger.kernel.org>; Fri,  6 Nov 2026 23:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5710606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=iL8IYgbU
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D5F7C161A19;
	Fri, 06 Nov 2026 23:42:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-99-204-139.trex-nlb.outbound.svc.cluster.local [100.99.204.139])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6D7D1161A69;
	Fri, 06 Nov 2026 23:42:09 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shade-Madly: 27964a1b3c1db32c_1794008531475_274588706
X-MC-Loop-Signature: 1794008531475:82235951
X-MC-Ingress-Time: 1794008531474
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.204.139 (trex/8.0.2);
	Fri, 06 Nov 2026 23:42:11 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [172.56.210.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4jLwh02NfPz105H;
	Fri,  6 Nov 2026 15:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794008529;
	bh=OFh/9coUNwINxcXZFdjBtndKV7PqV8JZlOM/7A5hDxw=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=iL8IYgbU0c0hhXBItkG2R4iWGEY+qNmfB3W1nHzUpoyt9gpwx1c9O7lJ8QLJJrR2b
	 N2sYBz21sPDirY/fywz9UBxInRUpvMTvCYgZcS0/howPyDQbTC1PvMFpzJ2nI1eRdh
	 aDoRFDJ9nFmpP2Qh2IWQtmR1qEkpH0s2BVFRBD2MxDl1wyve3RezQC0aJcq46A/frG
	 g3AoInIxAypW7uNcq3hn6qAhWaoEz9U5UikoiAlUVCe72TfPV2abFKX+PYmUk+ssHc
	 ja8gnzsQUP6TZ6FQfW7o76rjZqIepZ83b+2CO6lMYhP8Tu01Jy63lKnQMqxYnsszoY
	 HhN/O5lh//53Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	icheng@nvidia.com,
	ming.li@zohomail.com,
	benjamin.cheatham@amd.com,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v2] cxl/acpi: Drop the root decoder target_type assignment
Date: Fri,  6 Nov 2026 15:42:00 -0800
Message-Id: <20261106234200.2656245-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
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

A root decoder's target_type is never consumed. The field is
already initialized to CXL_DECODER_HOSTONLYMEM by cxl_decoder_init().
Drop the redundant assignment, which only suggests the root decoder's
type matters.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes in v2:
 - regenerate the patch, fixing hunk header

 drivers/cxl/acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index b7ce6b59c680..740e229e1c4c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -443,7 +443,6 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 
 	cxld = &cxlrd->cxlsd.cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
-- 
2.39.5

