Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C697B42AA9
	for <linux-cxl@vger.kernel.org>; Sat, 11 Apr 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775869936; cv=none; b=um4x2rVXyolx/SD0RWqPY5Ko+o2lZnMn4AmKfjw9SSeqig1ktJkKUv7X5GUwsstSPA7ZIlvju/UB+vhy5yZje5aPDF7TarjbKl1Gbez1mUEDZplkv+t31ni5cUDG8OEeflh0Ilrih4hBzmCQ+RYWGMyQAqpvqKTvuLv36jgOGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775869936; c=relaxed/simple;
	bh=AJEUUMw3oIjJF3tkNoxr0cFB+ZVdJ9rWYhf0qZxc1cE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7SjzTGqF7Unala8Ik2gixatKJlB6aAkMMeqFDd+1tQy/VFFA9vNhVxM1b6zJbQGffDxfDxeDIe34M4P5vDu7JYR8tsd4aT5qX+C67ikAMcEsZc3jp5RNtqBAXJHfzXsAJWkC3aMo+4PpBGBofoggHU0G1UkXeqoEj95Vbuj8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIEIj39m; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIEIj39m"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a7109f568so31424617b3.1
        for <linux-cxl@vger.kernel.org>; Fri, 10 Apr 2026 18:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775869934; x=1776474734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vupGDYrqe0WmuAYP7Dynvtd/GqZqLnXOb/VFQj7pXOU=;
        b=TIEIj39m8rpQpx/zSSJQQQVLiuQ/uScqAzqBs+6TGt+kXyrmXisEOGS/zqgNCZCEPt
         /RKPn44xf52Is4erWdpinkwshlzVADBLLrN+rouz/vuT7nzE8Dwg/SlQTPHhuuwnAUaW
         fDZHYSmubPMd+P9dQ/sJT5H6RLx2v/fJMmv48Jb8ugnwAzAqJ6i7K2NcL9PiuESxNjz9
         Ja4Mfq2AcudwWF3EF1kb2hgW7IP8H0WC+PU1uurQMGn9OjvvuwUGfjNXwqEOD4oe4IBx
         j7o/d2qUYssFpq7EESMOdFZfll9JMyCZPQcA/AAgHdm+dJNDBay023t2rCJRmD65Jhvb
         jTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775869934; x=1776474734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vupGDYrqe0WmuAYP7Dynvtd/GqZqLnXOb/VFQj7pXOU=;
        b=SdcGoEk1MB4BMar5kp4q3PEs2LStmy4qFfhtimmtbZTMkA1AIsFTVZvYg66UoLwEJU
         y4y6w9qx/ELxrGP6OpPFIGa3KnWK1wm1MYe7KVt6dNcehzB66xUn7h8bZxeBIM/vxo1u
         xxrNrozf0wd0cQXPxIV+Bg4B/RTv5Z048rpU5gaNxRNzGQp28lT8vZvWxHfdRXsM9Tb4
         p6ZfuLMpEQnchRHhySocYY/uNdtfJZ0DNp4tqvQOKv3nxX5J1I40Q8QOAXcrGHZ/RXLZ
         MiS6t3xmu5W2b7TwgADWsCcGt79uCuR5F6EYWL/6P1ZLppNJ+uY+i+NKjot5ZPtgI1gi
         EzXw==
X-Forwarded-Encrypted: i=1; AJvYcCXDtDFPvFOqPqYCCiiZEhQXjygzEtHODOXj5xcip87LuOvjkjW6IIxN2le9IpL0y/ZMgG9y6A1bKQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aiPYsmcGOT8Xn2tj63ZCWBnK2Hg8pnbxqYZUTMXwy6AXieji
	y5Xzv/AjfHdJuvp/TyalgOE+s/ZRAYATudR9s1poyqthVEl7TsDtnW4y
X-Gm-Gg: AeBDiesX9zmaSmseIMg2RCH4LYyr29j+w+05zHvBPM5Ap0qtTJ3wikr3lvZ0YWZVo49
	L5EbxgXx06MfpyazKOK96lUOLha/EZ1vwJRHmyTmEFbai8Tids42uhnG1Lwi3SD4fmaLYmkxOpG
	m5T4mEwvBlrpS077w7c2IXpCc1+VDh4gtGFdjRiRoDwaU9yUgCz0hN4mlg5UtzH1Yxxx7ORc7OO
	AxthIwC/Hbb9ZCTSZwuZe1fkkyQfopeimsKtdlFzXXyzY5Um0z0euyA0G5DnHYtQXvXuuZm4owC
	pdJfgXVigVnxOnl5aqgH+aIFIyzWkgyHKXe94Vj8XRoiFYdpHs9ENfL3JuqQorQzVb66AjXJC59
	3nzt3zVQnKFR6JwFIDL+yb8xGR1YuT4IuIOm9Sjwk3lD/St6kLyGjFgkLqBc6oWgkIrqWJcUoWj
	aXDOBhl7Z6IDsZ8p0R0W9NVu5Va+LkAy3DXayHatId6Q==
X-Received: by 2002:a05:690c:6e11:b0:7a1:6e8:d905 with SMTP id 00721157ae682-7af71478399mr59108827b3.29.1775869933728;
        Fri, 10 Apr 2026 18:12:13 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3cfcba46sm21645737b3.16.2026.04.10.18.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 18:12:13 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: dave.jiang@intel.com,
	gourry@gourry.net
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org,
	Anisa Su <anisa.su@samsung.com>
Subject: [PATCH] cxl/core/region_dax.c: fix missing assignment in cxl_dax_region_alloc()
Date: Fri, 10 Apr 2026 18:11:36 -0700
Message-ID: <20260411011137.43545-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxlr->cxlr_dax assignment was dropped during refactor.

Fixes: d747cf98f091 cxl/core/region: move dax region device logic into
region_dax.c
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/cxl/core/region_dax.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
index de04f78f6ad8..068690d02c8c 100644
--- a/drivers/cxl/core/region_dax.c
+++ b/drivers/cxl/core/region_dax.c
@@ -62,6 +62,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 
 	dev = &cxlr_dax->dev;
 	cxlr_dax->cxlr = cxlr;
+	cxlr->cxlr_dax = cxlr_dax;
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
 	device_set_pm_not_required(dev);
-- 
2.43.0

