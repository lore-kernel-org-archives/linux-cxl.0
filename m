Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFA37EFFB
	for <linux-cxl@vger.kernel.org>; Mon, 20 Apr 2026 02:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776653787; cv=none; b=tj1GZmds8z4oOTXUKJC18kghBU90gp6HCpTDlubjVu1M3gNIu7F3Kpk+zHni0QxONhdyJlKmzZmk3LNVDhBS82UXxvbV1ozWuI+iRKb3+vHyCiCBx4wjk1a5Abo6EpNW15vBDRWUo5inooqh0B7ii+nJMVUUd1+R9lT488Zjhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776653787; c=relaxed/simple;
	bh=u4OAGjaTLHitOXmOMoh2P98LOLbxyvsz5/hPqsMZVkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nj8oOLK+8a0EUISkuqFyXFOQ4kK9LWHRIfywY1qJ4RQIKrqMit/3loKU6tyaRWOjTmkzoSLREaAHCGcBx4tTeySe4uvN8HkjynMO37pavTPGoBd2Rm8GzRK9nfXAYAzt4Lcfnc0CcP02BS7teOfI3IHVkoYUKSOIzae/wDiFdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b23713eac9so22612377b3.2
        for <linux-cxl@vger.kernel.org>; Sun, 19 Apr 2026 19:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776653785; x=1777258585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+O44+JVKuk80yoA2AZ1Ss5dIsNhIz1HifmT4ZdqZZA=;
        b=SwV2l73+ONPcGw8VY/nvgv3wbg+WJuSrJ/dIWD6vJCBAd5BBFWq+5gBt+tPZ2FJzSu
         qnC3pUdHC3obfiU6fJgw2id2VPnU/Ag8rcj7aJBGaDv3/Q4bY1TfC1iL4B3Gv5Q9jFh5
         HaGhQyNxzjT5BLCYb8/PFIjOSAq6FtXZf+RBQ2ek/paK/ygpiCN7EcQ3E629EDHxk9V3
         dEZDq/Q9ZT+stk9YP6azyZqD/wI81/z0zTZK6FWiVNks4ZZAxZXchknJlfnc3NvH7fPm
         mHMfKkLA2r3vWHTeRQo8mS6MAc5wFHGQW05UyGzeUzseOpkDkQxMpSe6YCmHLN+VZrT2
         kwjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bEaIDobeUTsjDvpHQvGjBB9TemstfmRPiXfwcTzfrcN568fmhi3S3SmqNcrmS1SnLrvxbxl2MmFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJSZqaK1exAELIw4oGjdkGWn4D4F+G5h/xY+3SUlnC0UZmqZm
	OYxnVwGEjduaSw8z2LXldkdavSdeSzTzJzSbG+XVgJjbPAKWHdfHwS3S
X-Gm-Gg: AeBDiesplNLc6WlpLJA+HZUQFkpzsGdsm73pnH8O19NC/Xrcg3aHqaJhDijcZKHrhBa
	Rx7V5UvnZFz1BOGb3kPvU2Ng6czumUW104qCqIEwHwXNTYiG+MQRH3qVEaXXGmcanSQrGTtIP7k
	v8sXG61AyFtWhbGOeRayoTSuGNBTUNSp83nOTvtVH/0lJxEo9lggbhN0j6AM5mBeTpP6hgSIZLz
	Wg9Quy8ST5mJN3zlWJGF99SvmvAtaKnFzuw7AFKxVMpulcCJAc41kK4du0nYvC3gb/HUyMrFRyU
	7OOgKYH2Cc04ORbaeE9bmP8d7mQdR6mvV4FKaAkej0Q/zE/Z3S85R7tc3DFEInRCTTmtzem6wNM
	hfcELT9cjorrKvG72HouygkJAMQHnd6SCfSh8WtttevIBW0BT58D5t2FRv8FT5hIhKVQ5/fWuiN
	YzhLiVubmDjSkZRdj1yHTn
X-Received: by 2002:a05:690c:6e83:b0:7b8:f152:7526 with SMTP id 00721157ae682-7b9ecffb58fmr114883037b3.42.1776653785003;
        Sun, 19 Apr 2026 19:56:25 -0700 (PDT)
Received: from tofu.. ([128.210.0.165])
        by smtp.googlemail.com with ESMTPSA id 00721157ae682-7b9ee8be8e4sm38961957b3.14.2026.04.19.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 19:56:23 -0700 (PDT)
From: Sungwoo Kim <iam@sung-woo.kim>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ben Widawsky <bwidawsk@kernel.org>
Cc: Dave Tian <daveti@purdue.edu>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] cxl/hdm: fix a warning in devm_remove_action()
Date: Sun, 19 Apr 2026 22:55:47 -0400
Message-ID: <20260420025547.1704692-2-iam@sung-woo.kim>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following race scenario, devm_remove_action() can be called
before devm_add_action(), triggering a warning because there is no
action to remove.

To fix this, __cxl_dpa_reserve() performs devm_add_action(). This
extends the critical section that embraces cxled->dpa_res = res and
devm_add_action(), so cxl_dpa_free() cannot observe dpa_res without
the devres action.

Also, renamed __cxl_dpa_reserve() to __devm_cxl_dpa_reserve().

task 1:
cxl_dpa_alloc()
  __cxl_dpa_alloc()
    guard(&cxl_rwsem.dpa)
    cxled->dpa_res = res;  ...(1)
  devm_add_action()        ...(4)

task 2:
cxl_dpa_free()
  guard(&cxl_rwsem.dpa)
  if (!cxled->dpa_res)     ...(2) pass, due to (1)
    return 0;
  devm_cxl_dpa_release()
    devm_remove_action()   ...(3) warning, no action is added yet

Splat:

WARNING: ./include/linux/device/devres.h:160 at devm_remove_action include/linux/device/devres.h:160 [inline], CPU#0: syz.1.6464/25993
WARNING: ./include/linux/device/devres.h:160 at devm_cxl_dpa_release drivers/cxl/core/hdm.c:290 [inline], CPU#0: syz.1.6464/25993
WARNING: ./include/linux/device/devres.h:160 at cxl_dpa_free+0x2a4/0x320 drivers/cxl/core/hdm.c:572, CPU#0: syz.1.6464/25993

Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
---
V2: https://lore.kernel.org/linux-cxl/CAJNyHpL-fyDnEJv2bxKNjBAzxHZ9HmKTu72MzcVhWiFrDRKzpw@mail.gmail.com/
V2->V3:
- Fixed a potential deadlock in V2.
- Renamed __cxl_dpa_reserve() to __devm_cxl_dpa_reserve().

 drivers/cxl/core/hdm.c | 43 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0c80b76a5f9b..0492a878a065 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -336,7 +336,7 @@ static int request_skip(struct cxl_dev_state *cxlds,
 	return -EBUSY;
 }
 
-static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+static int __devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			     resource_size_t base, resource_size_t len,
 			     resource_size_t skipped)
 {
@@ -408,7 +408,19 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
-	return 0;
+
+	/*
+	 * Perform devres registration while holding cxl_rwsem.dpa so
+	 * cxl_dpa_free() cannot observe dpa_res without a matching devres
+	 * action.
+	 * Also, invoke the release action with the unlocked __cxl_dpa_release()
+	 * since cxl_dpa_release() acquires the the cxl_rwsem.dpa.
+	 */
+	rc = devm_add_action(&port->dev, cxl_dpa_release, cxled);
+	if (rc) {
+		__cxl_dpa_release(cxled);
+	}
+	return rc;
 }
 
 static int add_dpa_res(struct device *dev, struct resource *parent,
@@ -499,16 +511,8 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				resource_size_t base, resource_size_t len,
 				resource_size_t skipped)
 {
-	struct cxl_port *port = cxled_to_port(cxled);
-	int rc;
-
-	scoped_guard(rwsem_write, &cxl_rwsem.dpa)
-		rc = __cxl_dpa_reserve(cxled, base, len, skipped);
-
-	if (rc)
-		return rc;
-
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	return __devm_cxl_dpa_reserve(cxled, base, len, skipped);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_dpa_reserve, "CXL");
 
@@ -606,7 +610,8 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	struct resource *p, *last;
 	int part;
 
-	guard(rwsem_write)(&cxl_rwsem.dpa);
+	lockdep_assert_held_write(&cxl_rwsem.dpa);
+
 	if (cxled->cxld.region) {
 		dev_dbg(dev, "decoder attached to %s\n",
 			dev_name(&cxled->cxld.region->dev));
@@ -664,19 +669,13 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 		return -ENOSPC;
 	}
 
-	return __cxl_dpa_reserve(cxled, start, size, skip);
+	return __devm_cxl_dpa_reserve(cxled, start, size, skip);
 }
 
 int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
-	struct cxl_port *port = cxled_to_port(cxled);
-	int rc;
-
-	rc = __cxl_dpa_alloc(cxled, size);
-	if (rc)
-		return rc;
-
-	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+	guard(rwsem_write)(&cxl_rwsem.dpa);
+	return __cxl_dpa_alloc(cxled, size);
 }
 
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
-- 
2.47.3

