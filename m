Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.209.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793569889;
	b=upUcHjpvj5qx5jFsKrh9/FYCYxrGeyUHjrVTKvOOLiw0Ognq7lodLgaTeCSQpX4YrP6m
	 e2+f2Q6uzM/9ntpgKoD0LH69QccuXffz3FssFq8Jk8CFgw6VmwTYDiDftIatDfvxYnHvf
	 w7dJz/wJnCVJGkS5Sh22jSvkfCo3IQQ9GCyC2n0SMVQhPxZU8EMIhx7El+spi4QhAedq6
	 QSBkDaom1W22wqLzYxP/KgachG0lwFfWDm9vXyz0nz0B+gSONY6u5gpREOit27tsP7uSH
	 6FpPiZSsZQCI8W312fWABWxWeEeMnMRd6tEnHcWX7nEJt7NHKaA5sYwKFdubrGaoQ4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793569889;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Abaft-Desert:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3hd5Ke8HSbyyENcM6rnE6zEjr58TBYicjPgmuNjRIRg=;
	b=EvWyKUex+B1/C+W3vQua2sqcZulHiblUpm2TXJIMWd5O7NVpQFFXeULfUCUorJqPzhhB
	 fXVaW89YrcnPXBe3QBOB0672rdg+JiSgyYYoFhVG8k4HwI9PLkuatxmF693B+1fRaF/UN
	 XC9f3xz/VkV6/uBIymbNPegN8trRGHql5Oi1qcG2+0XhFJ63Nu9WKJ+lG0jQ8ntzfLccn
	 57gai8c3fSkj+Q0Z4AZQcjarUdq5zgJ+sQJN89RFqcYZXs9NaGvyLOI7bmGp/sBKDltDF
	 V5H8UYOyZfBjpSTwHKB2lJYVJ+B4eZGmAaRGt6nfGy9g27PvBOpSia2LZB00bf+cRrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=pr1QwTfv;
	arc=none smtp.remote-ip=23.83.209.81
Received: from hedgehog.birch.relay.mailchannels.net (hedgehog.birch.relay.mailchannels.net [23.83.209.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D073606A327
	for <linux-cxl@vger.kernel.org>; Sun,  1 Nov 2026 21:51:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D073606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=pr1QwTfv
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 81295160ECF;
	Sun, 01 Nov 2026 21:51:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.99.188.64])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 29D75160D6B;
	Sun, 01 Nov 2026 21:51:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Desert: 618378284e333ef5_1793569882434_3812681581
X-MC-Loop-Signature: 1793569882434:4055085241
X-MC-Ingress-Time: 1793569882433
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.188.64 (trex/8.0.2);
	Sun, 01 Nov 2026 21:51:22 +0000
Received: from offworld.tailf5af7a.ts.net (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4jHpSP3YHpz103t;
	Sun,  1 Nov 2026 13:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793569878;
	bh=3hd5Ke8HSbyyENcM6rnE6zEjr58TBYicjPgmuNjRIRg=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pr1QwTfvorWy/2FFzqc1m0LpyjBz4e2x8PeE4zcRnQTNXc8dzA6Fw+jrvrnDRznE5
	 3DW5X7pWtGzCfbaVc5C+XI3ira2zlVAk2rcrToYpLgnSCinSLszCFAY97M+W5HFbHk
	 7Dc6UBfqzVEGwkFT2WiHpCVDwhmdiRMJG12wIGl8iBc5L9uUisboCpfZWZxJTgopod
	 8ZzSiRZAn+enb1ZYOXm6iEO0Et1WCMOguuSUwyhNotLrfXXJ3Sl5kx8Kw4nyKDYqsp
	 AGVn65qeLcJT90gyoGRIaNNqcDdqkMp9ZMwv1t722dCWQLGcP5OrJSX/aVEa43Y2xv
	 2MdbcJ4zw3dfg==
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
Subject: [PATCH v10 06/10] cxl/region: Log the coherency model at region creation
Date: Sun,  1 Nov 2026 13:51:03 -0800
Message-Id: <f10b7f706906e6e2eef2c080f856039af50e00de.1793567979.git.dave@stgolabs.net>
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
index d369c98824ac..06a0e9bb892f 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1863,6 +1863,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
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
@@ -2864,8 +2871,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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

