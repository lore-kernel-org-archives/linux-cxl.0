Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794175702;
	b=411nZK32qtBqHQqIO/vqFlwYHi+fG2rJ5jQXBd1dLrw/B2sEPrKsvpqeWSmRFC6KLOxf
	 EOKzhaqp9FcI7wSlGFwXpZedt+QEcgr+n/bzHaLejkSrNVtg8w4+3mf70S2lBLir4zSTO
	 vb8s8+xO3RoKOAP5flcxoyNVLye7An6IZs5MgbAm4Flssh1bcu+/dTHGLYEn1C0UPG1eX
	 ooOKVLBHNonmGZ5rbWOMNoAh0kXBVWxXi1JTVanJGBSUY5w6P56d/7utxShS5PvZFaTKL
	 FCUJieqCYRWhQyPU71uEB/eSA3Zr2iMoyyUXp1jrQXp7EF9u/mjSQQrNZZ+q/VrT1vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794175702;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Troubled-Decisive:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mTxf0K3HwvL5ZPXX59jxwsgkSz8GHPtQ7KiYv+PSqOc=;
	b=GlNu6xbZXz/VTcf/FA0wOJnNDKIjGS/zeXUKvLqPMHmcjjRRKumdsj8vRL/f0u5Xy2P0
	 3aLyK/QfGemsSsDlcZi7kJGXZt9YwjTqmN2elcYcwtcm5uwOKxSJNaLFkQSPPuF5V9U1c
	 /YtHWY3LOFDBGLl+A1pthPjf57QX+DsCirs0oCd4mS4xHjoTtkscunuQMOBNprKUDquW5
	 2uEcPDkUioUiqkSS+Cppigque7yhv5B0GCl3uRJlzFE9Rau9tf3Jaf96hgiLKL0ZnY5tI
	 3zdINRByr+QpoXJgmXFhpUI1WiOooR7cPLp1nUHr1HLjUpVX0/Wl+W4cWJPJ+FZCyTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b="TXM2/CrU";
	arc=none smtp.remote-ip=23.83.209.24
Received: from buffalo.birch.relay.mailchannels.net (buffalo.birch.relay.mailchannels.net [23.83.209.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C759606A31C
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 22:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C759606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=TXM2/CrU
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6DA7E400C44;
	Sun, 08 Nov 2026 22:08:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.99.176.144])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2BF40400FE6;
	Sun, 08 Nov 2026 22:08:11 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Decisive: 4955a01a6aeb5942_1794175695367_1719662796
X-MC-Loop-Signature: 1794175695367:445865712
X-MC-Ingress-Time: 1794175695367
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.176.144 (trex/8.0.2);
	Sun, 08 Nov 2026 22:08:15 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4jN6Vf2yYTzyr8;
	Sun,  8 Nov 2026 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1794175691;
	bh=mTxf0K3HwvL5ZPXX59jxwsgkSz8GHPtQ7KiYv+PSqOc=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=TXM2/CrUWnpEYzPT1Unqs8oy+gq4MDebpQYRv6t9wuSTGi41vY9GhIEWGK7roEmxH
	 yCX0ThQCpCviRTr0VBRfpLyii9v/01krhwuElAx5Jpmxr75SOOfGaHI4FO8fs205gM
	 LZ8L+41/tnXNkOgdLizbs4ZZIhUEJimN/a7JWkenyYgVkXnuo86r4inwgkxap7N6By
	 6efAIBpvKhkZyTPdkRNPXNwXOmECMEkNGWvwhRGxf55e2pc74IYuKSUbZo4fJf+DsC
	 dV7g2NtyEt8vWm5teVxCdCuNsF9ecQNrGcwso0K6+S+x7ZKj6hJFSDOue8dqI/Ym9/
	 mMYK7nhxh2mTQ==
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
Subject: [PATCH v11 06/10] cxl/region: Log the coherency model at region creation
Date: Sun,  8 Nov 2026 14:07:35 -0800
Message-Id: <14eca21bb727ebe0d8e361067bfba06a8d982b1d.1794172701.git.dave@stgolabs.net>
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

Region assembly emits plenty of debug information - resources,
interleave geometry, target placement - but not the coherency model
the region operates in.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/region.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d7f605beaa49..545e0e3331d0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1864,6 +1864,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	return rc;
 }
 
+static const char *cxl_coherency_name(enum cxl_decoder_type type, bool bi)
+{
+	if (type == CXL_DECODER_HOSTONLYMEM)
+		return "HDM-H";
+	return bi ? "HDM-DB" : "HDM-D";
+}
+
 static int cxl_region_attach_auto(struct cxl_region *cxlr,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -2866,8 +2873,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(rc);
 	}
 
-	dev_dbg(port->uport_dev, "%s: created %s\n",
-		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
+	dev_dbg(port->uport_dev, "%s: created %s %s\n",
+		dev_name(&cxlrd->cxlsd.cxld.dev),
+		cxl_coherency_name(cxlr->type, cxl_root_decoder_is_bi(cxlrd)),
+		dev_name(dev));
 	return cxlr;
 err:
 	put_device(dev);
-- 
2.39.5

