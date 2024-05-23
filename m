Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839B28366
	for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 17:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486540; cv=none; b=XHAxVjbSodqBypcL8ZG9adn+kH2VHsJFowXqMmooXLY99wO5AAffqEKyj8kYcKG0SwevoOjzihSicaX0yquyMCHD93rhu1nl2q5hQ+HsEsMgbA+nKt6lYh4XdTy9QdVMfSbbdpyGOnZ4cPCGSYhdc720BNJNOyRM4Q/JBCdj4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486540; c=relaxed/simple;
	bh=MRighS+XedUXzKbXruD24yequ1WGhrzmQJRHfzF7f/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImzrcKEkGPR80aqqtfAa2Bi8sizcSW2PsLPLrflosjS4tnpq/4cYk5x8SR5vvRRjBCIfc4SxkSQueE61VDPhNAM9ntDx8fQRXkbIm4d/K6hyI+wzUKyTHF2NP7dOI7DwpX2zBbgm3oIjTrCfuiaS1pG9G8jzZRdyr1Ki5d/Ngtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RYR7c7/V; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYR7c7/V"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f3423646b7so7580505ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 23 May 2024 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716486539; x=1717091339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D139+frhgjL58RCnIBHCYwz5taylsc59BAUfUMuPBhQ=;
        b=RYR7c7/VTVKgZ+609DVZalVTKhEfoDUb5LBtn/6QLgiBzmIOpFq9sXLgY4LO12MJXa
         MnC0xFS6TMahHm1YhipcJowpQ7uVozNnCgBNGZP+IP1swoYpIPiakrJQNGADlOpRRvvc
         C3JRjEYa5B8DYAy8RoFSJ2GwjN5jDHMJ2SrutUfymiQLNruZ7kHzwkY7viD6AEwowi2p
         TSpCSK9v9QGK6JywbuPwgsdn4v7/Itm8qkBCxoJt5rIKPG7RVNb2036k63UGy8j9+cP/
         5CXrcMuytm0DdngXwNZnvkcjdi5i3wLbSI89cF8lafyFgh6+HO8Hxtbc8RmBy+blHx35
         ZU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486539; x=1717091339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D139+frhgjL58RCnIBHCYwz5taylsc59BAUfUMuPBhQ=;
        b=pG0o0JPu9Ko9cJpMuuwfXP9r9mS38xVbIUIv6cKQoaV7q/SR5mOETC/NqszK3Ti6+1
         y+pmOba7h3pEXF1KJ+9WLtwvbiN27g6m4GZz8bqcM6OTjiRADoiPyE91m9gaP5IVPxNj
         9Rkfu9mhe3M/4JAZeTSNtby2QWb0hLkCMDXjawa7j1xROXoS4oDE6i6DiHH8fSLM9x/U
         HvzrR/wsAIWMkFQH7BJJVFWLtO47GB9lGEl+AqK+ndGkXXmNCyIllJa4Go4crHSLBnJZ
         bu3Fx0MM/1Ek5xL9OjzaxueunexWTvt9D2kLbknQ8BoLA6wNzI7Kl70PgjBBhEdJ5Upt
         uzUw==
X-Forwarded-Encrypted: i=1; AJvYcCWdKEwVTQWNOLk4+OHMsOjt2Fb597AckExe2B0E6wFd32kQ6Veb0p0DBb0+J5tuVssh97MCY0zjzrujekhACak+C0RZ3OnTtulM
X-Gm-Message-State: AOJu0YzYQ4GndWBhqRx6lpPe68WyOwXjb3je/fQ6yeKzRVP0KYPJdUUV
	DouIpXLIoIrzwYbK3fDYn+LSUSgLpL8aD0b3Ec0z7M+ZDanqko3i
X-Google-Smtp-Source: AGHT+IHiNCVNxjjampo2HbEfeyUB2Cd/CBAs9YMqeP8IBwx0S3SCvP90fhFvR7g+v85vjkr5piZi6g==
X-Received: by 2002:a17:902:dac7:b0:1f3:51f3:9d74 with SMTP id d9443c01a7336-1f4486bd915mr775795ad.11.1716486538793;
        Thu, 23 May 2024 10:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:646:8f03:9fee:4f9e:216e:ed5a:642d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c137e7esm253436265ad.257.2024.05.23.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:48:58 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org,
	gregory.price@memverge.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	nmtadam.samsung@gmail.com,
	nifan.cxl@gmail.com,
	jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com,
	wj28.lee@gmail.com,
	armbru@redhat.com,
	mst@redhat.com,
	Fan Ni <fan.ni@samsung.com>,
	Svetly Todorov <svetly.todorov@memverge.com>
Subject: [PATCH v8 13/14] hw/cxl/cxl-mailbox-utils: Add superset extent release mailbox support
Date: Thu, 23 May 2024 10:44:53 -0700
Message-ID: <20240523174651.1089554-14-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523174651.1089554-1-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fan Ni <fan.ni@samsung.com>

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by accepted extent(s) in the device, the release can be
performed.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 045bce8f74..ec8949ce7b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (range_contains(&range, dpa + len - 1)) {
                         len2 = ent_start_dpa + ent_len - dpa - len;
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now. We will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        dpa = ent_start_dpa + ent_len;
                     }
                     len_done = ent_len - len1 - len2;
 
@@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
                     break;
                 }
             }
-            if (len) {
-                ret = CXL_MBOX_INVALID_PA;
-                goto free_and_exit;
-            }
         }
     }
 free_and_exit:
-- 
2.43.0

