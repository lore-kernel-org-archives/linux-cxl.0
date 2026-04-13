Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE703CD8DE
	for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088604; cv=none; b=UJ74TMUwoOD7td/Ika6EANWmvggFB80JuponeSGGPbdRWUG0pHCci8QxmgJ1vVoZkL60ARY/JmOakww1901YiDxeOcDb6BbxGUWtBLFNUxmx/q+bDIO0y27NWbW0/htrKysN//v3tH7JwjW3tzxbs3aRRvoWW7mhMvTjnS2lTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088604; c=relaxed/simple;
	bh=Hpvv+IN2EELEEcnD5YwW84ys/b/L7dP7YW1BRzo/t8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F9QDNXgFpgIFOCcTfizu14un2fFMENFLrmHvGmR/Okr38C1Yj+Yj6+2SS5MTyZqv2ubewwFSSsp/8slR2eGQILT6gaAIS7POOcaYQglJB4gVOo23SpaBuM2uNH89Q/8ratGiFgjWAvmBmRMGFTB8JObxI+PZFmxbAtl0PVnH1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVhPRJuD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVhPRJuD"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so133074a91.0
        for <linux-cxl@vger.kernel.org>; Mon, 13 Apr 2026 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776088602; x=1776693402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IwI7fhoIYuDnAceYOXsnx6dLQgMpnwbjObgo8mwaSj4=;
        b=kVhPRJuDq7yFzsHSk2U9Vb5efnwz6LzIgQSv9kE4LTe1GsvjMdpKz89Hg2pDWkHXdA
         sTTYSQBzdsv8N8HXDedTb7q159RjfBKKZ+cI/rKMSZFhIUpEnPYkL9G8CU4arhq7KEg+
         dZc7njBroO+FiLHvMYTi8tldCTI8JZ1aShsHXodD52bzww56ToamtqpCbd9dG1AXTa9m
         dDhTwzF6veIMjzpK6rhqDnIRMglcz7bLvOYijIXdZSVFcpOhk539mR4qS5BzQ/tqrWoS
         g5Pwi8W85anYs6EdOymUqRBLNFH443TSmQ+xkDrBSM+CBlcA9x86Osg0OVa88qZ7EdHR
         28JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776088602; x=1776693402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwI7fhoIYuDnAceYOXsnx6dLQgMpnwbjObgo8mwaSj4=;
        b=MY25fa44OskFGVCtnjiWbGDLRGzqWzOa9pS9h9AIIQ6ZKLPFwqNxLytX4OebRClYxi
         vhmVsd0uQmeOWkwuVb1OvukF4uKnXyqFrad6Np1fqNPUuYrlMn2eY7c8QACh+QSExnBn
         GaCbZNm0KShyyT24a9AhzL9RCwWrfqa4N2S46+yF9uG5Uv0cEaHJJdAOaDbllX4mOAJH
         7QFVOW2rJ9C6Zer8Pe8o//tzvDpls/GMntS/PDqLq6uMvresgFlKuV3E6RqFfZ9d/J+J
         rLezJS61U3mh4g8s2vhTu9A6T+2JzebPw1rD1KhxJQbojhs/vJbnL2TK4/1N4dtQDyX5
         xuUA==
X-Forwarded-Encrypted: i=1; AFNElJ+vhWRiOaffsnOPyDoyvC2N9b0y6Q1Ldrir3k2XRXrtb5EosC/8zfUW0OqMVVfDMYmxbtzEIxUKqkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvW79ZqBKbypLHedTMfTh8bHM3acxVmk4xzXCyEO/YFNpkBq0
	XFRZaY/X+0tI0kO9ePO8gPRwTJuDgjPv9dDxeVMuHdCj3bTHWFaC4Bx8
X-Gm-Gg: AeBDievB/khhQJ+SsXqd12X0gF0j9QJRr++YYzlyKYb7xVzz10W9Ezlp1za1pYlT1re
	ImxKaVNtUR3Jvl08z+EtOI0vRM5vN7V57UM22tIy4pA3dFX69+BW+QO+L66SnjLxzE7RlUxZ2Ou
	MFc8n5s4+wzdnwUOFKJZ9G/PQw5fHo/jucUi1o+2SHlfe2lk6hKbFWs9Kq42AXe6fsYcL4+bUBE
	xtUhQ9cWJ03PFKoA2lslBbYZu3F8mplb4nEtKkgTYuH3DcJUkWnfRyXuztYpY49t9D4l0TJqI9P
	unepk++/jD371OBfNFLvZA2xhlkVAL7smHiaN/mIStJoki0+F9Yp3jX7y/H7N2cXsDdzGv4TK9b
	E6FJzHakkgUqfeepOE2IXfgI77vF6kCkfUt1RH7FO2hvQaXp6U0M7A1Zi5vo5Ig7x6+K5cBh5m4
	O3sGhNxhbRb63NVmzq+foDluHm4B8pxWI=
X-Received: by 2002:a17:902:b698:b0:2b2:aa93:cc5f with SMTP id d9443c01a7336-2b2d597609dmr100423715ad.10.1776088602230;
        Mon, 13 Apr 2026 06:56:42 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b468273ccfsm12585665ad.43.2026.04.13.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:56:41 -0700 (PDT)
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
Subject: [PATCH v3] device-dax: Fix refcount leak in __devm_create_dev_dax() error path
Date: Mon, 13 Apr 2026 21:56:25 +0800
Message-ID: <20260413135625.2890908-1-lgs201920130244@gmail.com>
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

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by assigning dev->type before device_initialize(), so the
release callback is available, use put_device() in the
post-initialization error paths, and keep dev_dax range cleanup explicit
since it is not handled by dev_dax_release().

Fixes: c2f3011ee697f ("device-dax: add an allocation interface for device-dax instances")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

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

