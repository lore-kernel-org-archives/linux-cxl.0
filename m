Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931E44A3EF
	for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724746; cv=none; b=SXRkbDbZEYqrIrAyLKg4BcDVSnxJpZl4a9WmYEOGj2C/WPRbnFSdqoFkuqPX0uwpnWuNCso/tmyxBUsdQjnk0/vhsaKYZr5dp/2wN5Ugymlt8RjPUDsWkIBYs8KYytN7FvkYvHD+mUHKe8uQ+MWKg0V70N/9BYlg+ui9T2nAZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724746; c=relaxed/simple;
	bh=jF1efb+ZrlgHhorgaaDDjAX1MA7rXrB1bO2VMnF5pJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nXyXepRmdW3Gx61uqGAFcvwMLUv73iU3u7pro/yHIM+UeOwK9aF02SqsqtBnMqldT7R9tfYRr/2QLzLJ/QtlEhIFJKFXRg6+gVRfM8j1eu7KgzMknRNvhqOUZf4lF6wqG7HqeGr1vrVX6Rg3cEiZt84useZgHPaOsYBu7T+t4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8wCzL/T; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8wCzL/T"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-3a8c118e711so830776a91.0
        for <linux-cxl@vger.kernel.org>; Sun, 11 Oct 2026 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791724741; x=1792329541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sEBEPrTg9k6NVyRZZeBkgKa7OkmMhAqWYWxj4Tiunk0=;
        b=T8wCzL/T/tbkeOKxz7MVuK00OlLlcpn/GAg5WA/ncXYfhyqtCHN/T0cdeQ9ZyaoPxO
         PVa24skpArrZwnUky+0T05s/zuBtPnzcRu6yVo3WdB2eEieI2Qgh3VzF2SzsHfldCP5Z
         Ofy9H0ViDSVWER5hXXO9Hwjxu9SFUMWpCStjYv3qAb0IkUE75oSZ+lnipbwHOGT605EJ
         zLryBm9/LV12MQuWBkSp+XlhuLJzsL4Q+bnI63qIRxuv3Nx1kMJkjZHM1FxOVnVy2wag
         cheNUccZ0psqmq8etTBpyMOLNKuQP40EWCZk9OwTuqkcQK8CzUKa7cOXQBHthqS1ASL2
         faxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791724741; x=1792329541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sEBEPrTg9k6NVyRZZeBkgKa7OkmMhAqWYWxj4Tiunk0=;
        b=vmcb7EdBTfimmaxBGWSGObodx0jLrRxdi7q22LjRoTl9qUdwUlDXLLPqeeZE8Dnm4W
         oZIEJXap3lIp7NhGstEdKjeJB4WbL8G0iZn4tCE4UOUf7wDzh8iw7Tg8+acr+ZZM1hG7
         l6xhNZLZdiP4p54Ht6ZPYQ4qIxgn0t206Li/G05JzBAIwc3LOI1cUSoD5v/3isHf1AeB
         MOCFxKnu2WPl38hoxVqmzMwNIDYj5Wy858GjkeXMV4FAOpVlVObimtNOLPcOhDt0pSiv
         VeuEGcVqu49bbdZLJn0ZNiWK3dbi+v+u/m2sI/2wkr/wpc0OaqBnmsMh293XyP5v6mWl
         PY5Q==
X-Forwarded-Encrypted: i=1; AKwUvBx0Fuq5UJrcvkYUyp1+egFQnwevwudZiLEt36cPas8FM7VWL6L3UAvIzhr7fC13jBXEJ+vtlq85CLs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy1pgzslH9CJ/zcWlPZLSoE9fXupv6VyOHF1QvasDuKqVgQiYO
	N1azTSUjZpViZlBpA8Om1G2j7a6MFEKzbutc8QcaObe10H5Mi59BKdQd
X-Gm-Gg: AYBFou2r7Y2PmvK9u4TzFuD5aB87yesL//OWhx6LEDw/DOZmLWzrW0pHtjB/eVc3ams
	HtqUoyABjB9/dO3TUzOMdGTwgshL5rneZUcZyM51YKo6RYbUWO3Qf/1Dh7+bGD3deeMELYP2R/9
	cGqNyis4vst3o+9b/g+mpF2xLsb5hvBEs3dkv4g5XxtkHv37bmcp1extelsqndDgpy5mM3OQSgj
	PRu9MhxbEpAIGymcUD0r6tdWyPPMMtH2ZA/123I5y4ChXhssDnyNAWRQkR+eTpTs0RLZZ/EIfwn
	Ese5JkrxmX9Xc6oY/73mi3PEbtioMGzRvkUFISvHcheiA0k6ARlq3RGnLqFjS/iXWTjjSYsMdXY
	Dz4Adox3ISSN9KSc5q/76KTi6Ua7Ndp3zIXZgKfa2+JTdLzOYG8tN07yefmyKYFNeYy+NevK/1D
	Je1Mw25HtI1CBVgtIlMhfzqxnZAMFuajLBeyJ1N5zGBPdvaTizCyd3Tyu5Oj7wsJvlsIyuBpBZk
	8Sf2wiXHVEp4BQCAVC8aEjInOGK56ZxXQXvJSi53sRnL5mcdmVCtsCaK7lT
X-Received: by 2002:a17:90b:5845:b0:3ab:c80:936c with SMTP id 98e67ed59e1d1-3ab3a98f7ebmr5720767a91.33.1791724741527;
        Sun, 11 Oct 2026 06:19:01 -0700 (PDT)
Received: from localhost (ec2-13-231-150-91.ap-northeast-1.compute.amazonaws.com. [13.231.150.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab338676besm7158093a91.1.2026.10.11.06.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:19:01 -0700 (PDT)
From: jianyungao89@gmail.com
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev (open list:DEVICE DIRECT ACCESS (DAX)),
	linux-cxl@vger.kernel.org (open list:DEVICE DIRECT ACCESS (DAX))
Subject: [PATCH] dax: fix mapping_store() returning 0 instead of error code
Date: Sun, 11 Oct 2026 21:18:57 +0800
Message-Id: <20261011131857.30481-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianyun Gao <jianyungao89@gmail.com>

When the region driver is not loaded, mapping_store() returns rc
which is 0 at that point, instead of an error code. Set it to
-ENXIO to match the equivalent check in size_store().

Fixes: 9567da0b408a ("device-dax: Introduce bus + driver model")
Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b809e1a264af..262f97b5e7aa 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1192,7 +1192,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 		return rc;
 	if (!dax_region->dev->driver) {
 		up_write(&dax_region_rwsem);
-		return rc;
+		return -ENXIO;
 	}
 	rc = down_write_killable(&dax_dev_rwsem);
 	if (rc) {
-- 
2.34.1

