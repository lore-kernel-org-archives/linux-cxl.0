Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7580255F52
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775871656; cv=none; b=h7yh4rcAUMyhhWojVN7VIYukQlL/RSI4KgFm57huTKYdtPe1MAjaYiIx+RNvnvHPEv8ltOjFn4ZYv4XJeTIGP8xUx+09t0X4n5opSMVTObkS4YHWjrfojRMbslsiXCHuIMDy+0VOCoi5MibMNir7QGSiYdEhaDH9xbbvzsvoCes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775871656; c=relaxed/simple;
	bh=Yrovm2W4HvUxjvyO5OMV/pAO7C2Vj3ndU76ragSNoYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtiLahk7rpG6sI7o56SJtO0qtno301xa+IWXo2musSifh9SBFwYjTqrRHqC7AlGcsC4D3OoqhwdLK7WNnuglj85YlBtbgFo9IClNjHT2SuRg9X44KYqM9O0hJMDlBtPgkm/btaibLTQuR2wWTXw2XsMQBKcP2FrW9Dtj5aQyXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsNLkTju; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsNLkTju"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7947cf097c1so24700587b3.2
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775871654; x=1776476454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkMB30O2K7mBi4rhngs75NqsM2ZIGJlfscuqpJKDko8=;
        b=FsNLkTjuPoNV74Pj6lnqw+/GaMcZmkkLaZMjWQKu1MfV1ckbronBqLH6s+SI0ra5ll
         64acxIG12k4bnwsVXjKALzmBfdTT3rjPjrdHIJLq4ZjYKaB9HLylr1ljp/4ZcRw9XLOT
         1M21wnGCi0xsL/0qYufUb1nU6q5tvirdOVn6ICJEOSu9ybAvMOw1oyEXC3VZrqS6fpJr
         T0QmZfB3I2WuZrj0UcXTIxou96vu4hW6miG8txBBaVFSjGV4HjI1xPFJWSIRo/nblGTl
         EJhSpovivL1EvS610JWYMiP93MzzD92g20SVP/p8fH0wFaMczTxGIl1TU4mM0CVyc3mi
         ybEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775871654; x=1776476454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OkMB30O2K7mBi4rhngs75NqsM2ZIGJlfscuqpJKDko8=;
        b=BSOcVu5JPY1UQ/Ba41LdfIS5iBCe67sJMqoXEn5jaNC/E3s3tThfZMW6D5DMU8oCMz
         HWjRgIuLOf9ICdr2eFmYsatL+OGu7hup5rMQDO33YK1woc5HziILBMB7OB/Vwa2Gx/8J
         yVqz73l8HCvhHrMLT1Fcxktt/4JNlaGp4dtXitrofn91RKb3+xd3xTuP9sdoBa4/y+3V
         g8WqaIt+PTXkYIQ5kmNoWBEXn82YxScaz1cTnoDDEYaimzsBfE3rhN3R4rHl7I8J/BIb
         S9MkHcShGko/YhxzrMVLxw6bgfYsjArTU+wfhlJbfriPtFtuNIAlby1Od493s+pJ8s6c
         q0qQ==
X-Gm-Message-State: AOJu0YxfNs/nWccdutPa/UV+NnfCJWvsrNErbJ09uHbzyZxgY92ge8vU
	R42Ak+FIIvsAHn4IafXaBo+mtJ6915hcPg2t0rdp6MsyDrH03foRFwWrK236rg==
X-Gm-Gg: AeBDieuf6rT8brRGmNUYcMO8uCoFFmmXNiWc9n5GpT6P5ccmi8EeFlMuaEshNxRm/Fj
	7Uk3RNbyy/cetn0nH5SNmsNuFwE4eEIlOXH+M2iBzX+KpxOoUkTCczStFenr0XLoZdcEy41pTZv
	GHlmD1dGnA8J8e3Jo2zARoSx/5qj0c4GlxprJEdJHDT1QiyQVINRLghnEd2i7qdpi1Vgb3Xask8
	P8eBbcMZ1OWs3m3tQM45PKOYk9Ar01Sw8rLTkexmr2phu1d6XynpfwyIzWbZYV6yGNz2BOPF1Za
	3ZFNPEDQuB1Drw+/dzlwtoyiCUsdehoeJJ9TpS2rSJQBycpJMBKvkfAguGiNFmx7OQvJJZk1NuZ
	pUrgIc8c+MyQ5b7dRJX6KxmEjDM7x5jKvByEI8jlrqTLIBm+bIAvHF9zmWqwd2RbOhBCw/LwjtK
	eRGdPBwMOSyBdMBOzpMnnDZ2OSyFPhg7RxTkwkMRXDbA==
X-Received: by 2002:a05:690c:48c8:b0:7a2:a8dd:1660 with SMTP id 00721157ae682-7af72924107mr63243097b3.54.1775871653820;
        Fri, 10 Apr 2026 18:40:53 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa06595sm21690547b3.40.2026.04.10.18.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:40:53 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: john@groves.net,
	dave.jiang@intel.com,
	gourry@gourry.net,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 20/20] dax/bus.c: make DC regions driver type DAXDRV_DEVICE_TYPE
Date: Fri, 10 Apr 2026 18:23:15 -0700
Message-ID: <20260411013958.47422-21-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411013958.47422-1-anisa.su@samsung.com>
References: <20260411013958.47422-1-anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change DC region driver type from DAXDRV_KMEM_TYPE to DAXDRV_DEVICE_TYPE
so it can be bound to fsdev driver

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/dax/bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 2ada38fa7dca..a9b25046d845 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -71,7 +71,8 @@ static int dax_match_type(const struct dax_device_driver *dax_drv, struct device
 	enum dax_driver_type type = DAXDRV_DEVICE_TYPE;
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
-	if (dev_dax->region->res.flags & IORESOURCE_DAX_KMEM)
+	if (dev_dax->region->res.flags & IORESOURCE_DAX_KMEM &&
+	    !(dev_dax->region->res.flags & IORESOURCE_DAX_SPARSE_CAP))
 		type = DAXDRV_KMEM_TYPE;
 
 	if (dax_drv->type == type)
-- 
2.43.0

