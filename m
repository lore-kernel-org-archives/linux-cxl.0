Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794884356;
	b=jzqz+hNEmKro6N1JG2SWoEntqZMNhW2zFf8LyVic+aSJBZo7QGKLPwAjE5FDg/2YFu0r
	 gbq8qJgVD6EPYI/Mg9IZOCgiogiViLQzUTL7kqsPCi3JJmsY0CnlOJb7vzEFhAxYHASUk
	 Hw1lCM80EhkAesg0I8K8CbNCCXtmH9TEkYUeZK4ynybc2pVF54NN16dvZc+1MW0Mg3j46
	 nEVnZHP2f/I16/Y0r7aYOMTPHWm44qHHCCUKTmb9DdW+gz5LJvoIf+J25QrIuPGfGL8xF
	 y9e4yQzF7vZwHPDL6Pbv30axtVTY3R3QM/spxiwGDDGcP136ilbqzN11qy4l7z7mvdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884356;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=85ZfaL/b1CxAVL1txoIzqI2DFT6VrG9Gm4gJ0pWpPGc=;
	b=oZgb9J1HrIrBz5pDw0sNaVduDA8BsAxuWRyWb6Bm8c61pOpKhB6mskrSsqBbHSJ827AN
	 47NKe8UqtodBn/ziQP7r832UzL6MpXJQITYUAMYHo0xGxauovp7ILDsW13F9kqCP3Guwi
	 wxDnoNrGCOLphN3lAJHdn4M6bBZFQjpI8bFoUqj1NGFCUPV9styFaXp3lQTvgVuxROLLV
	 WCJ+9ayZD90INTAJErvbKOr3U5sY2+DcUc2oISfRcxdGBTc2qxAaaQoSK0IByQg4HH0Md
	 NMx3h7f0ypnCAL0K3fktbablRE8k1YITRY5xWDNt6v6gsr8+rLI2qxFyKtl8GZjmsTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRAayYG6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBFA606A31C;
	Tue, 17 Nov 2026 02:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRAayYG6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794884356;
	b=LjByDSCi1pc5jWsbbia5SvI8HCXOK2PNUQ7oZ0MwsNzCQ1Pr9BjNHWZ2SeZRQsgqPr9b
	 s5hi5ugUGz+3FDc+iigxtkLrwmxq191XAwJ+i8fAPxs5F5loI6izTfnEzM24miGat69y0
	 F2aSAPA0rJEbp3yMkrg4kuuekiAwHtIR+mJ7gQscTIQvRJdO26OfKXmLfDW428G6za+C8
	 xQq+CKCDUBRuEea8rF0zlPBSfQS1V5mBiUyMjji3UsQ5jIHW4PoHaSSwRJ2jm76wkc+Tx
	 LbWw+tkODytC/lmtENQ7LcnNnBdBgiBVS1tjQfQKbnMXUtzf4uSGiVNTazvzkQBewdw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794884356;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=85ZfaL/b1CxAVL1txoIzqI2DFT6VrG9Gm4gJ0pWpPGc=;
	b=eqYKL2527oYMPSdxf6/8iHMVuQZujyLFl1qt2mopMMhVHLQoXR2dFYa90tR7uYGf0EBH
	 uf2n2Na/lkbTU3WHNSXxtdLS85Iw13PzAXl2YnIR4D4sONRiCtkTYHokgDrELnJe1+x2K
	 +554gc/Tsu/qHj7zTuAQtDPj9Egn9Azt25NBfwZIbSse6Qli/2Tm/0bFL86tCLWYRVzJI
	 xrHXxva8sTa5Lg793oF14FF0GylRZtcqLfADt/Bad5j0NZSaQ4+vlPeuuKuvQlI4+ZCtw
	 mLlPD1olsZfIdh8xFU7iZlVxcjofaTeaobiC0sB3TrYJODRLuUg9TgpuVPwe+zzC8Gw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A09E81F000C6;
	Tue, 17 Nov 2026 02:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884356;
	bh=85ZfaL/b1CxAVL1txoIzqI2DFT6VrG9Gm4gJ0pWpPGc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=TRAayYG6MPHu6v83ZNp4lET3RDipNFCPuUgT1ieq0bf8z3nOBEKg1IkvEBpkjkyu9
	 VeOjCx6UPxr6Ce7vILFeYjSzqjLTGaSe/SjMt5HaB83AMLUj8M6C3wVkHGmWzeu98h
	 5ThT5ex2c2jVvYoNir1tOk20kolNTQUCPqZ+XFz4z1vnIE1zlGYqLS9NwgnecVpbxO
	 AmyEtlMDJBs+auLguxbXqAz8zjkFZFi1fTJTfDpplQ/N6v2cp1bKTA6/sBqf3tFM43
	 qCjOU6Snb7FUNHHrpmiBc9t+V3uszi56i+0OvWeFKa/izPGJiBOtXvXQEL83S8PimL
	 DrJXNSKzLWDlg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 015724A691;
	Tue, 17 Nov 2026 02:59:14 +0000 (UTC)
From: Junho Cha via B4 Relay <devnull+junho.cha.xcena.com@kernel.org>
Date: Tue, 17 Nov 2026 11:59:15 +0900
Subject: [PATCH] cxl/region: Fix self-deadlock when
 cxl_memdev_attach_region() fails
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261117-junhomax-fix-cxl-attach-region-deadlock-v1-1-f373a135edd2@xcena.com>
X-B4-Tracking: v=1; b=H4sIAALD+2oC/yWNwQ6CMBBEf4Xs2Y20Cib+ivGwXRZaxELaYpoQ/
 t2ixzeZebNBlOAkwr3aIMjHRTf7AupUAVvyg6DrCoOudauUuuC4eju/KWPvMnKekFIithhkKFP
 shLpp5hf2XNNVN/1Ntw0U2xKkLH5Pj+ef42pG4XToj4ahKGgCebZHVNxnLznBvn8BNzLMoqYAA
 AA=
X-Change-ID: 20261113-junhomax-fix-cxl-attach-region-deadlock-fc0a425f7265
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, 
 Li Ming <ming.li@zohomail.com>, Alejandro Lucero <alucerop@amd.com>, 
 Richard Cheng <icheng@nvidia.com>, linux-kernel@vger.kernel.org, 
 Junho Cha <junho.cha@xcena.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794884354; l=5381;
 i=junho.cha@xcena.com; s=20261113; h=from:subject:message-id;
 bh=JPQrZdtVE5CtcBfCoa+/THfa0h+zu/tnz7b6oc1BUAw=;
 b=zwSYPM2z6GeOO7Xu1G64jVherJ9VbxyCl+Li3hwyhYX7SBrDoVxLkhKzczwqc3DBFTIkVUOHA
 IwjE5CHUHWqD984omNVmosUHehE2GBf8f8OTl4abp8JXUIaVtjRTYcn
X-Developer-Key: i=junho.cha@xcena.com; a=ed25519;
 pk=OkFm4PnuJSze1AVqDdvnpHO7nnDQIheH2qYwg2a6Dyc=
X-Endpoint-Received: by B4 Relay for junho.cha@xcena.com/20261113 with
 auth_id=1507
X-Original-From: Junho Cha <junho.cha@xcena.com>
Reply-To: junho.cha@xcena.com
Content-Transfer-Encoding: 7bit

From: Junho Cha <junho.cha@xcena.com>

cxl_memdev_attach_region() holds cxl_rwsem.region for read while it
registers endpoint_unregister_region() with devm_add_action_or_reset().
If registering the action fails, devm_add_action_or_reset() runs the
action at once, which reaches cxl_decoder_detach() through
unregister_region() and detach_target():

  cxl_memdev_attach_region()
    down_read(&cxl_rwsem.region)
    devm_add_action_or_reset()          /* fails with -ENOMEM */
      endpoint_unregister_region()
        unregister_region()
          detach_target()
            cxl_decoder_detach()
              down_write_killable(&cxl_rwsem.region)

The task then waits for a write lock while holding the same rwsem for
read, and never makes progress.  Before it hangs, lockdep also reports
a circular dependency: endpoint_unregister_region() takes
cxlrd->regions_lock under cxl_rwsem.dpa, while cxl_add_to_region()
takes cxlrd->regions_lock before both rwsems.

Hold cxl_rwsem.region and cxl_rwsem.dpa only while finding and
validating the region, take the region reference and the HPA range
under them, and register the action after dropping them.  The endpoint
device lock stays held across the registration, as before.

Reproduced with cxl_test (type2_test=1) by failing the devres
allocation through failslab, with the stack filter limited to
cxl_memdev_attach_region().  Without this patch the probing kworker
hangs in cxl_decoder_detach().  With it, the cxl_mem probe fails with
-ENOMEM and lockdep stays quiet.

Fixes: d8dcb0b74b04 ("cxl/region: Introduce devm_cxl_probe_mem()")
Signed-off-by: Junho Cha <junho.cha@xcena.com>
---
Dave pointed at this reset path while reviewing the Type2 multipf
series [1]. This is a standalone fix for the existing code that keeps
the region teardown when registering the action fails.

[1] https://lore.kernel.org/linux-cxl/6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com/
---
 drivers/cxl/core/region.c | 73 +++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4cd9bb5dfd61..b7471a3aca12 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -4424,55 +4424,66 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
 	struct cxl_port *endpoint = cxlmd->endpoint;
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_region *cxlr;
+	struct range hpa_range;
 	int rc;
 
 	/* hold endpoint lock to setup autoremove of the region */
 	guard(device)(&endpoint->dev);
 	if (!endpoint->dev.driver)
 		return -ENXIO;
-	guard(rwsem_read)(&cxl_rwsem.region);
-	guard(rwsem_read)(&cxl_rwsem.dpa);
 
-	/*
-	 * TODO auto-instantiate a region, for now assume this will find an
-	 * auto-region
-	 */
-	struct device *dev __free(put_device) =
-		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
+	scoped_guard(rwsem_read, &cxl_rwsem.region) {
+		guard(rwsem_read)(&cxl_rwsem.dpa);
 
-	if (!dev) {
-		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
-			dev_name(&cxlmd->dev));
-		return -ENXIO;
-	}
+		/*
+		 * TODO auto-instantiate a region, for now assume this will
+		 * find an auto-region
+		 */
+		struct device *dev __free(put_device) =
+			device_find_child(&endpoint->dev, NULL,
+					  first_mapped_decoder);
+
+		if (!dev) {
+			dev_dbg(cxlmd->cxlds->dev,
+				"no region found for memdev %s\n",
+				dev_name(&cxlmd->dev));
+			return -ENXIO;
+		}
 
-	cxled = to_cxl_endpoint_decoder(dev);
-	cxlr = cxled->cxld.region;
+		cxled = to_cxl_endpoint_decoder(dev);
+		cxlr = cxled->cxld.region;
 
-	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
-		dev_dbg(cxlmd->cxlds->dev,
-			"region %s not committed for memdev %s\n",
-			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
-		return -ENXIO;
-	}
+		if (cxlr->params.state < CXL_CONFIG_COMMIT) {
+			dev_dbg(cxlmd->cxlds->dev,
+				"region %s not committed for memdev %s\n",
+				dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
+			return -ENXIO;
+		}
 
-	if (cxlr->params.nr_targets > 1) {
-		dev_dbg(cxlmd->cxlds->dev,
-			"Only attach to local non-interleaved region\n");
-		return -ENXIO;
+		if (cxlr->params.nr_targets > 1) {
+			dev_dbg(cxlmd->cxlds->dev,
+				"Only attach to local non-interleaved region\n");
+			return -ENXIO;
+		}
+
+		/* Only teardown regions that pass validation */
+		get_device(&cxlr->dev);
+		hpa_range = (struct range) {
+			.start = cxlr->params.res->start,
+			.end = cxlr->params.res->end,
+		};
 	}
 
-	/* Only teardown regions that pass validation, ignore the rest */
-	get_device(&cxlr->dev);
+	/*
+	 * On failure the action runs immediately and detaching the region
+	 * takes cxl_rwsem.region for write, so add it without the rwsem held.
+	 */
 	rc = devm_add_action_or_reset(&endpoint->dev,
 				      endpoint_unregister_region, cxlr);
 	if (rc)
 		return rc;
 
-	attach->hpa_range = (struct range) {
-		.start = cxlr->params.res->start,
-		.end = cxlr->params.res->end,
-	};
+	attach->hpa_range = hpa_range;
 	return 0;
 }
 EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");

---
base-commit: 2101c39473a06ee551a8cb4d549a1112aed324ad
change-id: 20261113-junhomax-fix-cxl-attach-region-deadlock-fc0a425f7265

Best regards,
--  
Junho Cha <junho.cha@xcena.com>


