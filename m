Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD9934D4CB
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 20:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770842540; cv=none; b=Qll7NWMi2rAOqQSKWSTFyHOLK93zInhzgoK1l/hqVdtokI1rWRRkoB8IGgx4iQR7W+ischbF4UnZRG4JRCVT/8Zmo0tQyOcQEteXcm85JBr1j7BD/RoykWPyCjqzQhgir40JfwuXQIdGdE0z7Y8XnKwIKuRtK9wufTaDq/sWBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770842540; c=relaxed/simple;
	bh=68gV8Gi8YJje3HgGHLLs6Vw7fYde7NjlI0jC39zIQkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2EpVD4tkSO94nHYtmrS4H8QTix7/bzfN2mtH8k9bO8+44a5XK2nBYneiDMXI0kltsoLGbGZGoHaTNRVtP+DrKT2nxzqD09SZoOPpHJnHfr14B39ZAd1wmSR701DaObxcBE472HAMFg5+bTGUt39nRtfPiYSmmIsYHK7SD0W8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uJdbPfaG; arc=none smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uJdbPfaG"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c52c67f64cso628772685a.0
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 12:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770842538; x=1771447338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo4E78wtZDcFrMggw4PKgwdVgknKzbaZZjHKt3D2+6A=;
        b=uJdbPfaGuodW/9SNbEEXAnU124XmhA12Grv1PNyvgJpGOwOBNkFzINmtJOwmaf39Tg
         QEWPzeiXIS3HNmKfWIfE7Lyr+Sm+/JdUrzD8joeP6VugTLERlwQd3pQldszMOw5yXy8h
         mYeFzNzLP91fir3X0kw57BeGnzwBfzhVgYDkMT4G3tZmG2ncoSmxTkGqZ4QooPmGBCWS
         cvfHSH9m2ZnnyDRKDYzyZB770yyF35nDSKF7mjtXBfxjNoEQSphELI5cf8axH78E7eKH
         c8+ohrXaXlgOYwgz8wWBrqM1sRsc6+51RCFAebvh7TKEhIaa+KDmfK/YLOUHh69tZ6o7
         QD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770842538; x=1771447338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bo4E78wtZDcFrMggw4PKgwdVgknKzbaZZjHKt3D2+6A=;
        b=XqL9h5cExG/S3Rp5MMZ3wIP+qdsQn6L2VGd7zAGE7TbWDMnbNVYHgd/l+sbbXE+/q1
         bFQaRGXSvu+t9BJLfsjji+s6h1nyUYY9g6UyRxLtWRBbu2YUd/3XXMvTlPbXWpdCSg5A
         Z7t7k/PFPFgODhG2kZfSavcPu0uTHUcvfn7j6pGj6gFpe6GQVX9rpfs4rd66UHttNqOy
         ozNmzmtA5erbFNA1jFoqoozv8NQrk0gIJLrz+W/zOJF4c9ohTXl8YD9auXgNoKTcvq5O
         gnO0iveSCDBSy0ewGIWxeeZet6Kw/qlmIyabhGu8zmhEybjAeeg4k+PDCkb+Ej6qvCsP
         x4iQ==
X-Gm-Message-State: AOJu0YzUV5a/vchNTwgOqm2dO/j+Iak7Szxg3NIUAEyLyJqxgct+mmAi
	j9kQHhnyq0IsAHnIhCY0l5MAV9eHQon8+4OX/A1D3L+8d8aLZYahWRYQA7NYPOQEl/rd5l+H/pv
	fc3Qr
X-Gm-Gg: AZuq6aLVF+WH25MF2KJ9oQU0q9ve4RbVpBklmUDNve6mB+REbwWo/QqbqljcPWrtS68
	zRkOzQd59hJnfLWJ80bv+eethy7D2yzsxHuaPmI3sl4l/Jk+tFytljaaq0rIvxc4ocn6dA1uHHf
	ezTx8mKL8yFTAWIv8UCbk9jJjOqAh1wWseBqF+rKY9yh3Pm1s1YM3lBL9hMzOfHyiZfPo3xZxTN
	LA77mS7TG0R4ndq/FWoOYVXVLLrNbA8LQloQjKoY3Eo7p2JVQBXUeBdWiRnj5ZbPYU0Ss2U8L55
	CUF9deGbS4RUUaig9z12+bvCPJhWY4wPJCYIeoC2QyUvhiRg21oagEnu44u38feO874uwTx7EgE
	FZMoMYwujcdCSziOSyxoL/3RDDga8ZcCfh/bZ9EZUdUa68XrqwjAm5WdYhmFLuHY6KgkC0kOsPh
	A3V6iqAerjHyy+5qePB7xuOShccTs+htcZLgrYTezLgyPsret8xm4/9Kgd3We4zNyriTeytgrcj
	Pbh4jO8wUf0ghSrFnL4pF0esg==
X-Received: by 2002:a05:622a:1207:b0:501:b1d8:6376 with SMTP id d75a77b69052e-50691c7df39mr11461951cf.76.1770842537773;
        Wed, 11 Feb 2026 12:42:17 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506847d77cesm20173591cf.3.2026.02.11.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 12:42:17 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v3 3/3] cxl/core: use cleanup.h for devm_cxl_add_dax_region
Date: Wed, 11 Feb 2026 15:42:06 -0500
Message-ID: <20260211204206.2171525-4-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260211204206.2171525-1-gourry@gourry.net>
References: <20260211204206.2171525-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup the gotos in the function.

No functional change intended.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region_dax.c | 21 ++++++++-------------
 drivers/cxl/cxl.h             |  1 +
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
index c8dd2bd1d9b9..49907c6c7620 100644
--- a/drivers/cxl/core/region_dax.c
+++ b/drivers/cxl/core/region_dax.c
@@ -81,29 +81,24 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 
 int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
-	struct cxl_dax_region *cxlr_dax;
-	struct device *dev;
+	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) = NULL;
 	int rc;
 
 	cxlr_dax = cxl_dax_region_alloc(cxlr);
 	if (IS_ERR(cxlr_dax))
 		return PTR_ERR(cxlr_dax);
 
-	dev = &cxlr_dax->dev;
-	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
+	rc = dev_set_name(&cxlr_dax->dev, "dax_region%d", cxlr->id);
 	if (rc)
-		goto err;
+		return rc;
 
-	rc = device_add(dev);
+	rc = device_add(&cxlr_dax->dev);
 	if (rc)
-		goto err;
+		return rc;
 
-	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
-		dev_name(dev));
+	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(cxlr_dax->dev.parent),
+		dev_name(&cxlr_dax->dev));
 
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
-					cxlr_dax);
-err:
-	put_device(dev);
-	return rc;
+					no_free_ptr(cxlr_dax));
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 04c673e7cdb0..0b59008ea45a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -803,6 +803,7 @@ DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
-- 
2.47.3

