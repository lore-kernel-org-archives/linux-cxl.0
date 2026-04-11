Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3260F38550C
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775919468; cv=none; b=iQdvhIj8mRGeYSBNNTQvvMMHFIDs8+lB4Ua7X0uG4xiXQSYrDjYzDnEursfOEnB4aLRjHGqMr9+O6fsvl76uRFZWDlJJfFQ0+CfBRaGKx0iTacvYBgX881BvFCVWVZ/3ifksmZP/NT7iF8S7Q01GcdFp8IOODoQxuFFeVnZDQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775919468; c=relaxed/simple;
	bh=KZhRFKvZZu8iovP22IupFjT2Gu6PJku17dMapEr38Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d435z8rziEbj0yYxqGgdda5mW0nKk278n4mDu5QZlg8lBWT+Akv33TA4IUkRD2GX1pawfUJJCM5YjM+tO3D26PWGE/ilwIu4MssljGPb+Wn9veil8hEcR88vYZqPwJ580S0nMt/Ha4RTytBg6ht+8ABgfYnXuFFb373niDF5phg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxOOdkdv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxOOdkdv"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82735a41920so1047817b3a.2
        for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775919466; x=1776524266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=scV4iKj0YWAH3OkdMKrFOu3wLw5+cHFeHwRQSwEoBmA=;
        b=FxOOdkdve58Tby+e8jYdTl6X4UzhHSMJdvMfc+j7NiNGA7tc0Ok1E4yCg+GQoqwDVb
         j38i5WvtCpcFE5KAxKZo2sKBeMtjINJWI0CumWC1PLWcdDhwYYy1OsIKlPNDuihER32P
         7YQ9WVdjwJv+rEtCAj6gXuAnmZpQjXv2sjRzVSIdBd5fvRN5OGGL0NGZj9Q+9KGIULGz
         qTBEEue+p4h5/IEukpdnKmzngBw8H5yp40puDPKAH48fqRG/4XmfAJ5ykVaQwENfydJL
         8CVAnRHLYPPe0UtOoZXGulKyNihKScf464x1NujLvg6MXYTwReK3B7ewTxYbC+kXumsv
         3LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775919466; x=1776524266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scV4iKj0YWAH3OkdMKrFOu3wLw5+cHFeHwRQSwEoBmA=;
        b=c0Qp5PIx2VyC+fv7BiQodIJ55jFfYU0Vo8jsJ9J8qhWbvleTyyRqANibaibyiUBh9q
         I5MfqrIQq98ptajmzGE/UA4EJ8mApuRyum2Gz/5hRo/+Bat1eRFekP5ZNWIeIM7SZS/w
         VpA91+whSQC7f4QC/8Nq9/ONLthWpiUd5sRmrg9nZANhPMZ7A+HpniKhFTVFaftXawux
         Ab3Gyyi+7lJkX5Fl4ovhw26HumEYOE1d1BupNEp6Q8yA5dpZ6huAlJr+TL34UxhMxaE1
         yT2sIFf7+TzZ2Gz0f4eRBHwZKzskMX2l8m7SX3xJdySTA8YP3WhNfXDpEInAj4dugQ4P
         0F3w==
X-Forwarded-Encrypted: i=1; AJvYcCUaj2sRBZJuHVPPsz36p9u7jnq12zMl1FE2p2Yho6JFFDWckYtPPJ46CLdg/sZEzAVCZHeZ0qOdR9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvBwr+KLgUyDUpxlCVuiQELeGkJKOakEPtt5kWN41RNYTgenS
	7MTFRoKNd5F2xx8WNOVJl8LuQM08KKOmCzDrvnKiijLzNNkrxZrSG0l3
X-Gm-Gg: AeBDiet9dZ3Lw3JWJqGyU4DFT/OzXOmizCUPjdqaYTq0n3LtRE30hDiKd2bOe4hQf5V
	a2QU8sQbjZNYiXiXY4OMBRkGPGqzo6+yLNK5uum0x4LbXhdaXNocq2OB5eeINCkS/UgGE6LZens
	APzUKIpjPVn/fUsLFUfqar4E41d4WFI3tvwD8IrcHz6yPJpVu1HQ5E/J250RCsgJ9qc4XEh222L
	MFU/H53cNtBnwHRO7sXzA+nD0SrmDJ81NvJQI+zGSSSl4du4YYwdlJ1t5gSlEdA5TXH0+4oYoWw
	vm9byV1WddERxKog4R0Rx6Kbjv3v0Sn1OYDIHlQaqQmg/VIVLVqrOXlOk1qmyTDonoScpBPPTmE
	TIkCM8xbm1trs7cAkeZD+BQ040kNBWcFAaD+03EyNu7EZ3bjCOGB+kMGI3jG4e7jd8FxPW4g8Y5
	+7beUe5L4L6J4+yJU=
X-Received: by 2002:a05:6a00:6702:b0:82f:1a0b:eb30 with SMTP id d2e1a72fcca58-82f1a0bf063mr3058573b3a.11.1775919466368;
        Sat, 11 Apr 2026 07:57:46 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b17fcsm5949399b3a.33.2026.04.11.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:57:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] device-dax: Fix refcount leak in __devm_create_dev_dax() error path
Date: Sat, 11 Apr 2026 22:57:26 +0800
Message-ID: <20260411145726.2299438-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After device_initialize(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In __devm_create_dev_dax(), several failure paths after
device_initialize() free dev_dax directly instead of releasing the
device reference with put_device(). This bypasses the normal device
lifetime rules and may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

Fix this by assigning dev->type before device_initialize(), so the
release callback is available for put_device(), and use put_device() in
the post-initialization error paths. Keep dev_dax range cleanup explicit
in the error path.

Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dax/bus.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..8753115cd371 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1453,6 +1453,7 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	}
 
 	dev = &dev_dax->dev;
+	dev->type = &dev_dax_type;
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
@@ -1499,7 +1500,6 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	dev->devt = inode->i_rdev;
 	dev->bus = &dax_bus_type;
 	dev->parent = parent;
-	dev->type = &dev_dax_type;
 
 	rc = device_add(dev);
 	if (rc) {
@@ -1523,14 +1523,21 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 
 err_alloc_dax:
 	kfree(dev_dax->pgmap);
+	dev_dax->pgmap = NULL;
+
 err_pgmap:
 	free_dev_dax_ranges(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
+
 err_range:
-	free_dev_dax_id(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
+
 err_id:
 	kfree(dev_dax);
-
 	return ERR_PTR(rc);
+
 }
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
-- 
2.43.0

