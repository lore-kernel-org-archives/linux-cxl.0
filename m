Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E03B3BF0
	for <linux-cxl@vger.kernel.org>; Mon, 11 May 2026 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489008; cv=none; b=hCu0D8eVkE+LNkIvkh5481uggrqlqkJhr3wdaZn61VYM2k9NSyCUWBsLIDGh+I56Ur793KfQgLjXeIiDHdGKuOlJZ8W+06FM7w9GEfbe18S7Dx4kj4Jojx6o46xVzu2W9HsCfLy5L8bS62epUD5QDaAAeqgzXz2CYOlShmd+9J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489008; c=relaxed/simple;
	bh=abKRP8Hq8LvHYhe2eiwHeT7AAr7qOth4sC+8vuMIMJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RKd43PqfeTvczhcX2x/V2qiV6P6t7+WNKbBFaIfP0nsvfwWJ0SEEJKRTwZx/CWb0OPCHtCj/fS6hXuNZ9Jca7Dqtc7pCn8MfhhPAIwK+fHX0KCXBd6j3oPzFdx/RiVX/A5fL6U0vstR16cBC5AzMtroj04/XioKPtTgFsenfPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NUsGpqSi; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NUsGpqSi"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ba856db1c0so27412715ad.3
        for <linux-cxl@vger.kernel.org>; Mon, 11 May 2026 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1778489004; x=1779093804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSVJMcCRDCZ65VHh5kS3ZBwZuxCk7Ny7ZgL99/YO4W8=;
        b=NUsGpqSiNFlouxky6VXPNvL1lTf8f68QbRzRxIC/vkeejuzAfBGVd0pACRO5Q0tHKx
         aDoZSUhuYl9tzi0aStzi4G97aRzBJ8DOhudUu0wfcHr+ZZdnb845sQdVX55inPbOLD+7
         SQlUrISWYbRpYJQ0bFFCqWYY27zPPgC0ZyQXg7ek2oIvjZWlDsBkfR7mZaYXHNhrpV5v
         03//hG+AEvbp3T36OpJ3leKnBL6mnZ4PfBGTvpBNAbBfL1GDtsMOXs0pHVI0Yr2vGpYR
         zcWPEHDY7Z+4ks2dpOjWAxpkUTIQjRrshlKWhnf7MNrd9+TI2+d7FuHRdy6lNJ+LpNcm
         NWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489004; x=1779093804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSVJMcCRDCZ65VHh5kS3ZBwZuxCk7Ny7ZgL99/YO4W8=;
        b=pL+OFG0zKAQu9T6DMIXVNuJM5l6cAIWpzNcd/JdJJQoHvBJJeQXDz+kWmg7i6Vqc1I
         tF4r6g3JH9Biw6X3LJ3TLtJXWylahRwCo98hOU930gkcFTWnZUSrcqQ6GlSXs6xgrkk/
         SyTDiumn4+Ypvsp1DnlfkqMB6D3BhpdApTaQATcy18UG/gtRp1+5pIjJPK3VufqG5UIt
         bC0XYDpfVFpacq3c+e29qFyFQGPuTbYuiih+Etchk9eSnO9mQk4MbxvGfrPVWCibGz60
         pV2bTL/k1UpEZ1POzD9z0Qx+HmvnTPHvbJRD7gPoPSZZqJ/bC/NLoKfI1ayd09tTOgIQ
         hHtg==
X-Forwarded-Encrypted: i=1; AFNElJ/epYPRs2pKg/UHcofQJGMAbrQ/1IhKgVxURBI5zBlLVQupv5oV+97Ml0cvWGkPOAdfybtgy/+jjrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ku8wo2XVicGv/zXthMSVckxaJekawNX7gF+VYR2POpxuouCh
	xOT/rp9kocDtx3fXiH8E33BmONGz9qaOj6S8x8ZlpAoj4ZiNOUQwKBzuG5S/jOYWWiI=
X-Gm-Gg: Acq92OGhW4SUllVTnten1KvGR5uoz4nYeaaVRaZpI9Joe03DAJroIqiXlDLtBKyn5t1
	lPg2O9mln4qtT04dCurLNmj8TqldRXmDmCUmPKLylva/q8ujV0u8K/AYwjJCDAhR5iJTCg8w/LC
	amr0PQIeVaodGtHpE4iWnhtQwBJzB149pUfij1jA5dhtfGXXxyKHix5ZHEenPo0pwgl2ZkfybTX
	NXGylWS+tujIUldTXGpe+GM5UoqilfOabjrNRN9oEGaP1/PRKn/pBEUVkSoIOw3GQONM/wPiiR0
	2B4Ds+cUi8OBAZw+ZDLfSFB00F1nv+tRHQMwn4YD/YcyXl/j2jdN6rF9coPZJEeDj+X9lY/aZwN
	i0fW2aNlz9vTknfW8lplyjJOcwttkfw5r5ylCBYeiMr+4p9Ys2hkmFtBCgpLs/dUC/7WYGj4rKh
	zIyA7/h4WpiVv7BREvIu/yl1M8r12Az3gSTbzpkkgHKFS/pNLDPcxrLw==
X-Received: by 2002:a17:903:1aae:b0:2b7:88f9:9c3d with SMTP id d9443c01a7336-2bc7a9a0d0emr95547205ad.12.1778489004370;
        Mon, 11 May 2026 01:43:24 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35bcfsm94125535ad.38.2026.05.11.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:43:23 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: muchun.song@linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/memory_hotplug: Factor out altmap freeing checks
Date: Mon, 11 May 2026 16:43:07 +0800
Message-Id: <20260511084307.1827127-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a small helper to centralize altmap freeing after verifying that all
vmemmap pages were released. This keeps the check consistent between the
normal teardown path and the memory hotplug error paths.

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memory_hotplug.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 462d8dcd636d..af5489f03771 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1403,6 +1403,12 @@ bool mhp_supports_memmap_on_memory(void)
 }
 EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
 
+static void altmap_free(struct vmem_altmap *altmap)
+{
+	WARN_ONCE(altmap->alloc, "Altmap not fully unmapped");
+	kfree(altmap);
+}
+
 static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 {
 	unsigned long memblock_size = memory_block_size_bytes();
@@ -1427,12 +1433,8 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 		put_device(&mem->dev);
 
 		remove_memory_block_devices(cur_start, memblock_size);
-
 		arch_remove_memory(cur_start, memblock_size, altmap, NULL);
-
-		/* Verify that all vmemmap pages have actually been freed. */
-		WARN(altmap->alloc, "Altmap not fully unmapped");
-		kfree(altmap);
+		altmap_free(altmap);
 	}
 }
 
@@ -1463,7 +1465,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 		/* call arch's memory hotadd */
 		ret = arch_add_memory(nid, cur_start, memblock_size, &params);
 		if (ret < 0) {
-			kfree(params.altmap);
+			altmap_free(params.altmap);
 			goto out;
 		}
 
@@ -1472,7 +1474,7 @@ static int create_altmaps_and_memory_blocks(int nid, struct memory_group *group,
 						  params.altmap, group);
 		if (ret) {
 			arch_remove_memory(cur_start, memblock_size, params.altmap, NULL);
-			kfree(params.altmap);
+			altmap_free(params.altmap);
 			goto out;
 		}
 	}

base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
-- 
2.20.1

