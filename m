Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3AB2D97BB
	for <linux-cxl@vger.kernel.org>; Sun, 12 Apr 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775977228; cv=none; b=Xy2ENahhhaSGeHc2Jf4CjhHy1Ml30hFrWeBmaAC1uXmJumncxEzu2nXkR6SChGoeon/1wQyYVpO2XPzKuiRF8GJNMxM8G3ElcAgmRNbIRFlDsIGuNiwuBICVHEUm5N5cdnbFQA3pnCDHo1zJCMa7le6LS3KOTHx84TQ6lSW79WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775977228; c=relaxed/simple;
	bh=ad9MM76H3qA9Zm7zGQguyywPJdrDLgkSlTE6M7PNjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s6KqNDBYkjTqJ5k9PgMSrof+ig+1R8RoMKGnlyzlVX3u89Qq/Y58bDYLE3Nkj9pH4oIDw2Q9TFcZTwUXqHm16HZQZ/UEVdb+5X3jKdjnBsAOXPKT1rJcUptjQG3/2RFzO+IDqjPC1ycnTyIRayRlpIfLPqb2aB9Svks3BD7zmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNNX7YR9; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNNX7YR9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab232cc803so16702175ad.3
        for <linux-cxl@vger.kernel.org>; Sun, 12 Apr 2026 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775977227; x=1776582027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=agxSRs+wZOd7cJK+5GqSX8xmNcbffxfyow5lUhwJHXU=;
        b=oNNX7YR9IPcu207GZOVOH819GKWCkaYSmt+x5IImzjdLVOPfj1uDvPgjgjzxZuZWTh
         uKXQgS/9DJfWm4+xHt2uXJAQahLX1IE3U1D0VxOVGH6d2irweI7lM/wI0wcjmtSUaamw
         vXMKv27PHOv4CsbThvUs9jbo0lQgoM2Uc17gU92QuaX0huFExhO0OwakxcBhYwVGIMLo
         EZzdNDu6Fa+uzu/DHbojGNZsUKydAlplHA85rwuqOBZAKoVtSM//MsAiw0emoFv+yi5t
         6XdOp5RoprEWA/Fo+PRCdbQBGj6Y2pluARYB57oxJ96JBIyIjnYb8uPyRIQXeAONjG4S
         cs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775977227; x=1776582027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agxSRs+wZOd7cJK+5GqSX8xmNcbffxfyow5lUhwJHXU=;
        b=VClT9rFGEwMbesYzFUfxi0MGbI/SjYt/1wK3DTQ1Rl1sFQ8PTrdsT81evsSEBcwC83
         nU3eraTK/qwbRUBk/l25mEjviP4FTzN/iwShHFXXNqjJhoJ7/S6CAkHHSgQPkFqefJiu
         b0ztSmD50BAhJK7ybz76ZGqu1mP0UKIs0i/+bV4FfmPEHcZbgkFJLzMn9ObCiZOQnDPW
         yti542UidwsrQo232vP3B8gNpQ/YWpry0BH5fEifHzwcQI6MHloW11x6CrP25Mo4dEpY
         AxRqzhfrSQgP8MuM97l3YKlsMpZi2DuHMzx0WLiOpSpNITJFUPnM4wZ9iru1io1RbwN6
         +ZQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+V/ZsfsowGs/gFb6kWbeyPKE8KkD2Bq9f0SlpLFjGnCiAaSGokWUKXHMY0EazWiv8vSJosqWYXkPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtZSctAQZUYnXJ/Tv3yKP15dbqQ9wYJtYk/LiRVvbSe9mD4BpB
	/O/396KsOQxzdRjT/J1MU5qgE/50rLaAvwQKLIE3/VNr76hObtApc0Jq
X-Gm-Gg: AeBDiesu9bETnVhQxDXCth64F9QkUEIyQgGGwYuymGz3PhkQUSNV1PPk6eXQ9VbAD7A
	MgA2Wom1aLl5LsXJ028Rz6n/nsONugyZpfKynqreJvQtngnBstSAGLn8KQFjmdR3GU2NL25ISOm
	Qq0TZ61Yw6gfxxkDyDDt8J8N1Wt37tp4a25k3dOzRStTxqM/MidCLKKJ32W3KlfJE5ln5n7PBin
	oZC5PHqLz4mHo8xgsUWUKjczvq/7kw8pi6BzSt37OZhaYfTCmdzZ0XfM2WQzUfHNGujRkeAonG4
	H2DwjlvQs9dz8zgg1gSCLHF1u7hwSwmexlw2WYoye3XhtvaNedX047RKfXjp2VeeGMz9WwKe+ji
	xgwEStAxCwq9Z2j09zYq/ii+IP9V6uxpMp289F11jPkhd5jKAl/oq9MSfCbhhDwT55ecEpq+vAf
	mSORyJcCXRNTGHETpZLL9Z
X-Received: by 2002:a17:903:b8e:b0:2b2:647b:a744 with SMTP id d9443c01a7336-2b2d5a584d8mr101853925ad.24.1775977222380;
        Sun, 12 Apr 2026 00:00:22 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45c217ba6sm1798355ad.36.2026.04.12.00.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 00:00:22 -0700 (PDT)
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
Subject: [PATCH v2] device-dax: Fix refcount leak in __devm_create_dev_dax() error path
Date: Sun, 12 Apr 2026 15:00:10 +0800
Message-ID: <20260412070010.2402830-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After device_initialize(), the embedded struct device in dev_dax is
expected to be released through the device core with put_device().

In __devm_create_dev_dax(), several failure paths after
device_initialize() free dev_dax directly instead of dropping the device
reference, which bypasses the normal device core lifetime handling and
leaks the reference held on the embedded struct device.

Fix this by assigning dev->type before device_initialize(), so the
release callback is available, use put_device() in the
post-initialization error paths, and keep dev_dax range cleanup explicit
since it is not handled by dev_dax_release().

Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - clarify the commit message around the device reference leak
  - drop the unsupported use-after-free claim
  - set dev->type before device_initialize() so put_device() can use the
    release callback on post-init failures
  - simplify the post-initialization error paths to use explicit range
    cleanup plus put_device()

 drivers/dax/bus.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..2d92674d0d6e 100644
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
@@ -1522,14 +1522,13 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 	return dev_dax;
 
 err_alloc_dax:
-	kfree(dev_dax->pgmap);
 err_pgmap:
 	free_dev_dax_ranges(dev_dax);
 err_range:
-	free_dev_dax_id(dev_dax);
+	put_device(dev);
+	return ERR_PTR(rc);
 err_id:
 	kfree(dev_dax);
-
 	return ERR_PTR(rc);
 }
 
-- 
2.43.0

