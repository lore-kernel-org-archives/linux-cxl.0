Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4881A0B15
	for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770837753; cv=none; b=VsZuUMd3DKgeU0gSrGGxZ5LlAdK88bIHrMo7GyoIoIjGPJVE9txAk3Nr9f7IY3ZK6nU2ldNxtQL5qH8FXbaIAHkpjF+x1guKUN8LXd8PjEvwrbqT9WshaRmolKKCvVC17cUdphvHcQp0kSKC0aXNoERvIGg9wP3zezGRKoOCJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770837753; c=relaxed/simple;
	bh=9Te3tVF8EbHZIAqK6h0Dj+48LpQELfN2CsN7MrfrtdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qc8zRBJnn++uYEVgOp9EcLil8MOOfkx2volJmsikKlvRCDnncGI2cAHJ6d7FmGOJJ9JIV2YHmn1ZjKWof1Zxr9WM5lWVq5TzIFPT9Fudvw23keAHe7K4XMMgRIUxZHcXbURm+aE7fzAr9G97im+fXCqp/0gOMGUABIJQ0I292Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r+3G/rjr; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r+3G/rjr"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c6aaf3cd62so242920985a.3
        for <linux-cxl@vger.kernel.org>; Wed, 11 Feb 2026 11:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1770837751; x=1771442551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Qrkm0xHZfdh5m7EEO8P+Gmz0n24Ql08TrziBspIQ1s=;
        b=r+3G/rjraVUl1n7Gu3qVXxhvre7+yZas/DRVhtaItTQ8QE1bRlbAoWuqHHqtHrj/YF
         l9IM/+lkwNfnPLnKXpD8DkfCKjDctWMysZ8uCew9fBI7TSucAbXaKQDeFpLZZ3wOBSlg
         s0NA18O6IbanEX9QjnISWrtA9g5R6cDCNU8YcrAlxcwK9sk3bXs1naFFknI607IlIFXp
         EiwWyKDK6x2vZUYj/tkfVDaTWt6UCtWVX+zJ12oTnxfntDyoGuYEeQnl7VgH5ufZDqYm
         aXeF2jr/y6Y6aAlWATI969B3TmQxb4TJn8y2c8MiCyytbOXOmmG8/cgns+oXIKXA7xhb
         Dofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770837751; x=1771442551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Qrkm0xHZfdh5m7EEO8P+Gmz0n24Ql08TrziBspIQ1s=;
        b=QKkthz4CHZWeHPk/ZZrZaLZkOQHklGeSLgxqGh7P1QgoIuKE7HcOkT60lj0N1l+NaW
         i66pjNtaHuJJgbtIZBWC3LinSPpAXI3xuuS2fGuWxwI3+H+Lv3c5ZOQRl3wt1N1LCnJS
         sT3sEcbQEVps0pU0j5K+KJVvwjo6r4/JCV5cnb/ioJyDyHj8fVFTjYV5Mt/tSY0/9YNx
         vp34TXSkQk5ClGEAcMbmT0NbI15CRqskFeNbYa99D0YVLwAAiBN9pXXyAKORnyzMiyw4
         P7VSGePuYJSEoWBNFsXy9//kXWU+lNbGSE2M/rkQVA2A7hBfBwyUNXn6PTjf3E3xIxzY
         COEg==
X-Gm-Message-State: AOJu0YzP43Kiv1YGByBjvvjpDBhPmKCC8bBdW4Bfy8ybIRhkPogeWCNh
	uBb7RnRr6B0DWY4edp3E/oqFmBa6JSt7VkPurx58wvsFIrVAoZh3U1DplYcYsAc7O+AqzXGXpAZ
	dgV4m
X-Gm-Gg: AZuq6aKrmUtYkf4DekZoppSUBeOFV8CnX8EZ3jnLjrBFlGS5nH2CCO8mnXLbzPkCrhj
	HXNpKKMOttbz4qr5jXsoz9LbkdHBLUdAGDACSNYLgtX9PciIvo6L+9UpRUTQnIK7A/8u0hwMiQ8
	HznmTA+Wl3ZLYW0mttMcQJjjo/8kMCVsHGW7vIGY/7FjaNJGEumEKkMy3pugnAfm+mPZ8xaGpjA
	QiWeA0WSiEsoE/nFD3Gmw6xnYsCC6sC4wFjI+ukuyfpRxtvMdx997zNZYzprsKJ3SvUK+Gj9TVX
	Mt/YC9si4MdtnhpYmCyLeRofxBoWpt7N4/dZjgxd7GYkzCSBWK5hLkfrb+lOn+53q7BFDOXZ7uR
	rnfAj3EmArVtmCKtJk24xQ4BIwItO8FGmEXwt9Zv8v35jAf3xxhkIXCUIyy9B61SsmfY+ILnl5+
	VwepcuoHz8m1eZ7dILMOZ205S/BfVo3n1MQofugMawrnrx1+CatGTkEaX9LPJK7u7hxIsEQTNE5
	v7AmUSEn6BZrRNdCpiNHp+tzA==
X-Received: by 2002:a05:620a:40d0:b0:8c9:fb14:1ab8 with SMTP id af79cd13be357-8cb3303e2cbmr49394085a.8.1770837750605;
        Wed, 11 Feb 2026 11:22:30 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdb19b6sm21897376d6.40.2026.02.11.11.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 11:22:29 -0800 (PST)
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
Subject: [PATCH v3] cxl/memdev: fix deadlock in cxl_memdev_autoremove() on attach failure
Date: Wed, 11 Feb 2026 14:22:27 -0500
Message-ID: <20260211192228.2148713-1-gourry@gourry.net>
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

This path is reached when a driver uses the @attach parameter to
devm_cxl_add_memdev() and the CXL topology fails to enumerate (e.g.
DVSEC range registers decode outside platform-defined CXL ranges,
causing the endpoint port probe to fail).

Add cxl_memdev_attach_failed() to set the scope of the check correctly.

Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/memdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index af3d0cc65138..25ca4443e4f7 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1089,10 +1089,8 @@ static int cxlmd_add(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
 DEFINE_FREE(put_cxlmd, struct cxl_memdev *,
 	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
-static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
+static bool cxl_memdev_attach_failed(struct cxl_memdev *cxlmd)
 {
-	int rc;
-
 	/*
 	 * If @attach is provided fail if the driver is not attached upon
 	 * return. Note that failure here could be the result of a race to
@@ -1100,7 +1098,14 @@ static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
 	 * succeeded and then cxl_mem unbound before the lock is acquired.
 	 */
 	guard(device)(&cxlmd->dev);
-	if (cxlmd->attach && !cxlmd->dev.driver) {
+	return (cxlmd->attach && !cxlmd->dev.driver);
+}
+
+static struct cxl_memdev *cxl_memdev_autoremove(struct cxl_memdev *cxlmd)
+{
+	int rc;
+
+	if (cxl_memdev_attach_failed(cxlmd)) {
 		cxl_memdev_unregister(cxlmd);
 		return ERR_PTR(-ENXIO);
 	}
-- 
2.53.0

