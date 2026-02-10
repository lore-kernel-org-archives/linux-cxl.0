Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744F2EB847
	for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738206; cv=none; b=tN2uJrBc/TEa3nlq0CmxBpkvNJurhRNm6jyQmvUYdMJoo5GZEoxADoQFRZiR1q6DDd1Eo3tarShO+XYsFhH9g04ovoN9aUVPPkXGYieOpu3kF94XoUWNxxqAr4cir8zKBfQKnTfHoT0+8I2R/6Ryj5pEpz5zIxS1ieOJXSShtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738206; c=relaxed/simple;
	bh=wOR2nmEk2IOriT4/LftK2zJ6ppRZIzmlrGyp9OklFuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkSTWbbfS09hnDZukT0+ay0yaF4O65dsC8F3Mas9GX/R+JroXGoFJgLDi8rGRLvLj+IRjBtvIFd4g0TMvnSBujBrgNyhaWWn9E5lEgZl2+zN4mk6P4hhazTdfklwp8t4Tep952wgQ5LGRxASutvRqg4a2eNlzqKjHPMG64FfANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DtZJ+iqV; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DtZJ+iqV"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-896f9397ecdso10503886d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 10 Feb 2026 07:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770738204; x=1771343004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoJZrSjCiUuXH3ZlZRBV9LhTTJWjcyDlBywhmcp5Aag=;
        b=DtZJ+iqVd5Ccu/Re1ULsWfPaHAuJbgn7DPzy18J2xxO1tfvniKsL0TFJT4ibOOZR1i
         +mAEEvYXwAhE07W/QbCtPCiYz7BVttO27Gs00yxcNuVGkQ8ZYtcMLFDcPbJc7VgpNaa/
         mw07YxykVkr6IUavSa5Ccgl1aUpJ414saqA7ElgAzbC02D4Yr9+ew3OT5+cJm8oZwTcy
         G0Gg2IJPKYckbDNfnhzrYaFs0Bv4e2giM5hgp6sFnudIRy5jmygCfbiSs6q2kNIvoWXY
         CprtMarbIFS0NCm0Vxe0DkHqqXaAhDFcao7OmH2cEc40izaxNmhD+UNgHJQm7/kipM1w
         EYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770738204; x=1771343004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoJZrSjCiUuXH3ZlZRBV9LhTTJWjcyDlBywhmcp5Aag=;
        b=VteMKX0M/NFG3gjEtZ4p+aV2Jkx+VBAMOxpym+bbi2+TY13vICpWija3Q1cZLqNQrC
         RXGsCuH9tkzexwOvroXpet4WHSzjQDX6cCZEQ0MmLQ8UcdKJIZfMT8k4XYltC+aA9FW0
         KCYs5zjG8wA4KTN71LLnWV5Xgvf8jtz5UIsduPnqbHXED3qpafxJ0E1h/sFs3KVQCkJr
         ab6aRd4PYGq8QAXW9uB+wom/0C1ROMV7Gt8GGGhfy8SiLPbu8q8AFdwwsV5f0DEVTNyg
         ss4O1H5Y1o7cDIvFPNE5yYme8R5YpEdhvokvDYyYm0Wczw8+wGmK/51X+QN8j1ptjkjv
         khYQ==
X-Gm-Message-State: AOJu0YwsXAbt5/fxQ7+pyzqR8xEldxxbyfxbFb7/XkRRUELEw3+WUsmh
	ztAhRIozBBsaJm6g3W2sAGi+9kwWWOcPsQqLutKLP7sZB68dFaV3GEPWgCqa64MYIu3MmxFIx5V
	mG8uU
X-Gm-Gg: AZuq6aJB5mFm/0w75YePx++J+xHL7G5/bEse9w1dffF5zHbIxe2jOA4+aNmjMP/Ld6S
	EHP1+xEd55TS0+XRoUWPVFfhAULVJtoL8Ka/E+Rnsk/YiKT9MC8LoumomGMzFZ4Bo2iHLODWtTG
	FpGiJWzvr1B9fk9FIQyoFjncoXTyAFXvsFIsqyY2OHFmFObqndLa/PDvRM+Om1d5P8f9NClaGIb
	5/VwDuyODLuUDtj9CA3dqxVVkhAABWUDY2putpZFB6QkJyxyC7BYjJHR1JJvoW7PuyEadCNvIJK
	W8N68rM4uIzc5BlbMDJ1uVlUoz6eze0Mkl0YS82rki7lbU98FwXrnlAvEP9PDaTsHiU5vB1BP1O
	uIJV8K7JjYMNaGyk6GSKnhwQdaZIYaOuSXY+f8aGsxQCzVBH4yZvH1m6KK5/lwvFl9LPd5s+6AN
	fGrkMx3PhO29aqIkE5vNAGlTSKl6MW+1Jq4RVGpBxK07fGSRkwsoUkc6Kp6gwIquEWS91bzSUWS
	GhTOdVvzNex4xI=
X-Received: by 2002:ad4:4091:0:b0:895:48b9:4fd2 with SMTP id 6a1803df08f44-89548b953c8mr133265566d6.70.1770738204180;
        Tue, 10 Feb 2026 07:43:24 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cafa3bf628sm1097682285a.48.2026.02.10.07.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:43:23 -0800 (PST)
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
Subject: [PATCH] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on attach failure
Date: Tue, 10 Feb 2026 10:43:20 -0500
Message-ID: <20260210154320.1748223-1-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_memdev_autoremove() takes device_lock(&cxlmd->dev) via guard(device)
and then calls cxl_memdev_unregister() when the attach callback was
provided but cxl_mem_probe() failed to bind.

cxl_memdev_unregister() calls
  cdev_device_del()
    device_del()
      bus_remove_device()
        device_release_driver()

which also takes device_lock(), deadlocking the calling thread.

This path is reached when a driver uses the @attach parameter to
devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
DVSEC range registers decode outside platform-defined CXL ranges,
causing the endpoint port probe to fail).

Fix by using scoped_guard() and breaking out of the guard scope before
calling cxl_memdev_unregister(), so device_lock() is released first.

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/memdev.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index af3d0cc65138..c0de767b24fb 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1098,19 +1098,22 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
 	 * return. Note that failure here could be the result of a race to
 	 * teardown the CXL port topology. I.e. cxl_mem_probe() could have
 	 * succeeded and then cxl_mem unbound before the lock is acquired.
+	 *
+	 * Check under device_lock but unregister outside of it, as
+	 * cxl_memdev_unregister() will also take the device lock.
 	 */
-	guard(device)(&cxlmd->dev);
-	if (cxlmd->attach && !cxlmd->dev.driver) {
-		cxl_memdev_unregister(cxlmd);
-		return ERR_PTR(-ENXIO);
+	scoped_guard(device, &cxlmd->dev) {
+		if (cxlmd->attach && !cxlmd->dev.driver)
+			break;
+
+		rc = devm_add_action_or_reset(cxlmd->cxlds->dev,
+					      cxl_memdev_unregister, cxlmd);
+		if (rc)
+			return ERR_PTR(rc);
+		return cxlmd;
 	}
-
-	rc = devm_add_action_or_reset(cxlmd->cxlds->dev, cxl_memdev_unregister,
-				      cxlmd);
-	if (rc)
-		return ERR_PTR(rc);
-
-	return cxlmd;
+	cxl_memdev_unregister(cxlmd);
+	return ERR_PTR(-ENXIO);
 }
 
 /*
-- 
2.53.0

