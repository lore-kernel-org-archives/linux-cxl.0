Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8901E31353B
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576979; cv=none; b=X6La0lPbRKpGOThCXS9cLtqbsw+lThZpf66N1cu+gnfArUslwvPSmS+AcwBiZ5nSKAf69HAhZ+DYKTwsZ+tOW9UeN7NXhFdz826Oly030N+vngfifeWjwyVVvWThA10o2u6XE/XyJK9dSsscOp6PptAVZkA84Bl45XNqC+F6Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576979; c=relaxed/simple;
	bh=zg2VKuwFsN6029euqX1jn+gIisP3yKnPstGsmq0VUEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6Rxf4CMhwHmDnz5P3ZUBStIO+v+0sJqM8sGKTV7Btz9tqbPI7gH58jfRRcNt6W6n6qfAejchiHXP2FRhcD3JxLePSlMS/edbjU4ku2wWP0Nq9VjFqpdsoTYNwu08vd8GmGpMW64A8EzbFFGPwdij4GhgyPqoYc8VnmZjAf4QH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=abV6A38w; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="abV6A38w"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b268fba9aso14952481cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 19:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1774576977; x=1775181777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PihiyqdH9fgSKKz89FjkxG4uYpkRrGrjVrq6arvX1sY=;
        b=abV6A38wFRK8jjwEjo6u6Dys0TfULUO1y0ITjwTuI4dpKwkqeqtfAlzRKzCyq43k9p
         83hGbtVBc6DL8jJwadwgmwhB19vn0BoehY69OqwzXYnWOKbb8AbEeWb03GtDKOEXetxQ
         0L9NlE/UITgoW5V7Jjf6tROWy1OjzHdKk5wX/B4bDOh1Gn0o6IodF+Qspg3+/FRI3wgC
         33za/j5XtinBJqiI7KgXPecfkWhS/zmuoNu7UF4pVvFoDFO93ohqwAqUdEZDHRGAStfX
         GerBohgwfkzIqTkWWVQRF923NaY4MfmjzeSFsFBCkyC+hyylrcupFdEnSb+xZMjsY4x7
         cnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774576977; x=1775181777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PihiyqdH9fgSKKz89FjkxG4uYpkRrGrjVrq6arvX1sY=;
        b=hGKLZq35Zpd2XX+WDRPdEkrgzRtPvOihl2hu+Phgb6WAofCxNyy5ewE/J/Kw+/EW/5
         kaXxdFWI2/ONuntANCOoB3PVP1ERi6lCM0PT66PVTGIv1Z1NUNQafpWh12mLdxWiIHxv
         PaXCuGGnBOS9tY2bTgYqGK1Nt8UrOtInf4+4hPK7OwsIgCapAiuKPlIxGq+QRaiT/OUV
         8QEqtnt7Tn9YQ3Mt/SuEcn4n3MY0okvNiRbk5tEWiOAmDWR0qTZp5vqjIy/pHXDtzdEM
         LTZqL/oi7Rmle2C0j26PfH0c3Osr2kXQbkmK5qMYoL6finOGGAoBnN6e8q6jSeCKp165
         sCOg==
X-Gm-Message-State: AOJu0YygVvxBjSf+pHNum84OpEm0MrzRmpaPjflanoBrMacLpRjujEbM
	/pNV8qBjbA4g/gN8DxBKEFLEIgOzqc2Wbifj/zSFwSt3q6+r2YKe8/McX2UrSShZ7i9/VGOkPZC
	KLHY+
X-Gm-Gg: ATEYQzwCiUlaZ/al18mScGkd8Gh+l+XUD2lcLm2nDOFSFvuTz+6s28kjZEQniPiPuV0
	5REb00eFlTBY+3Lzo5jeuQxh4QGg3XS8Iq3KPUYUxYz4JXDbwWcvMcIRYK4ihT3IJTeEhPJQ5TD
	uM2Ssma/hswU5zhYTRarxR8CQ7JwaqeZUXvdW4FSX0y7adPxL1K26P/XoVSKIZovAPcyxFxAFHz
	a3h1cKyAAUdRNehIULvEhFJvg07NgNXNL66JNfp/Ih98t2MW1d46R13dQ5Btu3Zvik+81DsX2fx
	LSB0GtylQkWaApJvPVBpXPLHsMEO023rye6SSFXzLYenqlCGp0uKnqA19ghAigY62cE78Mik350
	FUve8kkZ5snClCFJIp4doJYG8a2KSGI/nxyvz5sNevwinZ3aaywwkfuaSHkCIBYWzHifjFzvduI
	MsvKVTeTc+HcnYK5jPfXGPKCtqOKeUn5rWu/o=
X-Received: by 2002:ac8:5fc7:0:b0:50b:36af:56a6 with SMTP id d75a77b69052e-50ba383ebf5mr12273061cf.15.1774576977214;
        Thu, 26 Mar 2026 19:02:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([63.116.149.204])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b923c0fc1sm39158901cf.27.2026.03.26.19.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 19:02:56 -0700 (PDT)
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
Subject: [PATCH v5 3/3] cxl/core: use cleanup.h for devm_cxl_add_dax_region
Date: Thu, 26 Mar 2026 22:02:03 -0400
Message-ID: <20260327020203.876122-4-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327020203.876122-1-gourry@gourry.net>
References: <20260327020203.876122-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup the gotos in the function.  No functional change.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region_dax.c | 13 +++++--------
 drivers/cxl/cxl.h             |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
index fe367759ac69..de04f78f6ad8 100644
--- a/drivers/cxl/core/region_dax.c
+++ b/drivers/cxl/core/region_dax.c
@@ -81,29 +81,26 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 
 int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
-	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
 	int rc;
 
-	cxlr_dax = cxl_dax_region_alloc(cxlr);
+	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) =
+		cxl_dax_region_alloc(cxlr);
 	if (IS_ERR(cxlr_dax))
 		return PTR_ERR(cxlr_dax);
 
 	dev = &cxlr_dax->dev;
 	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
 	if (rc)
-		goto err;
+		return rc;
 
 	rc = device_add(dev);
 	if (rc)
-		goto err;
+		return rc;
 
 	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
 		dev_name(dev));
 
 	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
-					cxlr_dax);
-err:
-	put_device(dev);
-	return rc;
+					no_free_ptr(cxlr_dax));
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f08be12e0e53..249a2f5ffc7b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -712,6 +712,7 @@ DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
-- 
2.53.0

