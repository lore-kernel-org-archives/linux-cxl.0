Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93BF3314C3
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 23:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.214.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790120360; cv=none; b=mRmVqLEIYWdcUYdGPMxAON1q/hdDhz7et24CDqfFPU5tOyh5yO8Amh2M1lDX7IZeujq7zXbchkuoxsJA2p3CDNhTTyjUqhCyeNPLlA0IvK6gsvY94tw8sJVmruIaVPZSEqJVY2SOM8UTMW49eIzbFaqEXVIZU05FLSTxsbEnIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790120360; c=relaxed/simple;
	bh=2cScUnfvc58w32ITwRWqGXVBL5t+JVC78Albajuv8tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NN97NxRGqtNPnvihGvG8wgW04rQj0H5UNOiY59bRenKNhe6rAv3DFeCjP420nxZcP5qXgSmPrDyeNIfquDmScVlvULumKPePE10UfxNqYWlkc9CT5VlIaSR7gilGv+XIfQ+9FQQ/6xvkRAx44wdDOEISF8z9VEFOnCsP7vjycjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lY8nE7Mp; arc=none smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lY8nE7Mp"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 855657E2501;
	Tue, 22 Sep 2026 23:39:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a228.dreamhost.com (100-99-163-208.trex-nlb.outbound.svc.cluster.local [100.99.163.208])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3B7C27E1E92;
	Tue, 22 Sep 2026 23:39:04 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Soft-Tart: 5eb6aff8620f7ddf_1790120348462_1289809703
X-MC-Loop-Signature: 1790120348462:2439221834
X-MC-Ingress-Time: 1790120348462
Received: from pdx1-sub0-mail-a228.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.163.208 (trex/8.0.2);
	Tue, 22 Sep 2026 23:39:08 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a228.dreamhost.com (Postfix) with ESMTPSA id 4hqGlC39PRzNw;
	Tue, 22 Sep 2026 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790120344;
	bh=TTokXhGNPcP3lib0rKk16h8R7Et4YTdKmZzEtFktRb8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=lY8nE7MpaZvJoOX8HYjbO+weAqSe59nzk+EHDeYy31JHWFGB7VZDrv6pvzoh8F4En
	 061150ks5MZgvkmetltYm1pEAkAfMEbGiHVLiS9w+qTeKOkAtoAWfICnI5++J4VTs6
	 LZg/EB+HywLrEbEHdKp9ns/9rFwj3N8U0uIkakOR3ijkjCFLmNknQwH6EJk8E+Wg0/
	 FwD6RtaQnmEeTZgczLLe41UKCWmr1zZqTW4Tvz8VXCLHy1tBtHNUaNbWnyApOqA9Nt
	 bWXuYEhLwji5PAqYiRttHPzmWFXlcEJ0KMJoxkjdBXhiv6t8OCM6NE+8XuuPDckn0V
	 VgrGNg5mBKekA==
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
Subject: [PATCH v9 06/10] cxl/region: Log the coherency model at region creation
Date: Tue, 22 Sep 2026 16:38:43 -0700
Message-Id: <6b9283af30fd1347f346f9c7a011d6b1663f2e2e.1790103847.git.dave@stgolabs.net>
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

Region assembly emits plenty of debug information - resources,
interleave geometry, target placement - but not the coherency model
the region operates in.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/region.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0a204aea64b5..f322a8a4a66d 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1861,6 +1861,13 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
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
@@ -2823,8 +2830,10 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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

