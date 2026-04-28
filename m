Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5133D88F5
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366360; cv=none; b=BUPqG7k3ScipHVlklcOZjq3Tk7Bddr0dpBqO0KzjtPj/RQzjnIm8xZNAi8Ek0rhJugUT1+bW/JowwfZdnle7/ejf1OpFA40psf7Wdtq3SvMC7OiDpezciZwIRizfA79Smi23ivNJqN1O2x5YJrs09rfAIOIL8jYDltF4S4cF7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366360; c=relaxed/simple;
	bh=EwDlAeox+pLWJIfRBalnhzrey1T0agG3+31xvcpS+7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXaFqwkYkH2cItr6seYW2BEBeSlf90fVwxUUdUp11+DjsBLiFpfv5vfyOtBr3aLITnO29mR5W8NwoQCJBfF91F9t6i0o0iv1SGnmUjARmOWbygtO9UcQpAM/mwxtxecYoLQlDyoA4cPBCKvNq9pNxgfuYl7noBu/3e8mMdNGFRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CNxU1nz3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CNxU1nz3"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso7596912a91.0
        for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 01:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366358; x=1777971158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiF95cax3V5L6nJjgrGO2oz2uPDfmL3HpmR2wC0cXHA=;
        b=CNxU1nz30MdSvXPHnj0FL6b1umN2/9BtKT7nZ4qUlCiw1n9YNcjAoTwQib3ke+5mlI
         vRznevTeBP8AeNxrW4AJljrkCNh1AeAxt6ulU7HN2pFYEG9sY8sHFTT8bRbeSmrkrhVA
         37hCm3kgMpIvVjlX7MKFYCE2ftrv0ebDKTj364p2fsKBpPsF4zA0ftam4QkEvzQ+nZOM
         sZ+3/ZZ/WL13hIWP4yRyiz+0pRchGoxYto8on+cfYnVtWicf+U1+UwfdMuLxzAGwM4zD
         V3sGUV6D7YP/XAfsOBIL/Mke5fyfkdaVLD78VmCkMTzJBk2wuugrpntya4Za3XObZ7Ah
         HAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366358; x=1777971158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jiF95cax3V5L6nJjgrGO2oz2uPDfmL3HpmR2wC0cXHA=;
        b=UxaIeI60bnlXUBS5VUjxamH6TGYCW6Wjsgs398t3JpqWlabi/f2KHJUFXSJfGZHfpE
         8Kjzj3MAowTx+TkqT0D3WNa5nUtm7ez81hHIiQr0O6sfFAQFjeL/xlhF/6S91gEunFuo
         gGbqhA1xRaFyrckcaX47s2QBtae4KtFN9UzSHICviLfvvlLtDBUAf/DRHiK9cBNdjEko
         G0ang5XOVa9mpDjdbEsKxtsZlWL3G6+mx4mHxQOAW2aEfNmEi2U0SlEjbESuZRALwhSA
         uaR/bJiXBvMxeimrkSrkNI1nK+Xe2v6fyq9lFqNVFJb7ZnzYJ1FClHG7+i+ISPfPZB8b
         moEQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3fM4P3ubZwaaNhyChpRq7wnlnp4/An5qDxKtxtGgHA0RATwuYxXtBywwqs9SlDR0LsOXfiyGbvb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypalZmj4VXwubEv/g/96mTBv9jme6b6WNBi23S+serQ5CLR8C1
	KQUT0chEVLFUgZH6QX6vjAcMKY2NugSpfMRwjNa8nNHD+DV0asgLxxmMJgmgN3iZPfU=
X-Gm-Gg: AeBDiev3jFQkUWR+Xzg5hmzx0xq/7KMeN+DMDiYOturEcmHBiXOV+l69OgTBoMC141J
	wPAHlpMVn9uo1smpT1NyuM5n4/Kl/BR0Xek62uL89I7r2VS0WdG27LJ8G1QLJTPq7C1l3hY/ESC
	ZYqRtbJZQ2FRASJ7GqQ5T9+JPXS2r6Kw1F5kMU9JHHXVMVN8LSQ/IjNXNalfDIzaLnkwT5fY+6g
	y7xkoDbDnZbgh3DtRW9LkcRT6jU5Wq/7LGKx0QvPXsZSXW6/Lq0foz/xdjqj4HH/aGVWEejhM93
	hkN1weFUv+7fHp/yUiH/lYMx3hcC2Y9vG/6tcDm9WmvE7m+vb0WADWZu2BoBGF7xU6rmy0APTsT
	YSb7mq40So82VMsRLzftFofc8gIrmxvqxC5T2UeGtR/Yq9ZslUgylu311Z2cVcQTYw5yNZyse8f
	MCINDSlI5+5JsMCOzI2sUg9YLUnKNHmgRy7FLE8Kp1s/sOMQnrIGH4P08=
X-Received: by 2002:a17:90b:554d:b0:35d:a380:6d1a with SMTP id 98e67ed59e1d1-36491f89850mr2386051a91.2.1777366358483;
        Tue, 28 Apr 2026 01:52:38 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:38 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH v2 2/3] drivers/base/memory: fix memory block reference leak in poison accounting
Date: Tue, 28 Apr 2026 16:52:18 +0800
Message-Id: <20260428085219.1316047-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428085219.1316047-1-songmuchun@bytedance.com>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblk_nr_poison_inc() and memblk_nr_poison_sub() look up a memory
block via find_memory_block_by_id(), which acquires a reference to the
memory block device.

Both helpers use the returned memory block without dropping that
reference, leaking the device reference on each successful lookup. Drop
the reference after updating nr_hwpoison.

Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1->v2:
- Add Reviewed-by from Miaohe.
- Add device_hotplug_lock in the next patch.
---
 drivers/base/memory.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index f806a683b767..6981b55d582a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -1230,8 +1230,10 @@ void memblk_nr_poison_inc(unsigned long pfn)
 	const unsigned long block_id = pfn_to_block_id(pfn);
 	struct memory_block *mem = find_memory_block_by_id(block_id);
 
-	if (mem)
+	if (mem) {
 		atomic_long_inc(&mem->nr_hwpoison);
+		put_device(&mem->dev);
+	}
 }
 
 void memblk_nr_poison_sub(unsigned long pfn, long i)
@@ -1239,8 +1241,10 @@ void memblk_nr_poison_sub(unsigned long pfn, long i)
 	const unsigned long block_id = pfn_to_block_id(pfn);
 	struct memory_block *mem = find_memory_block_by_id(block_id);
 
-	if (mem)
+	if (mem) {
 		atomic_long_sub(i, &mem->nr_hwpoison);
+		put_device(&mem->dev);
+	}
 }
 
 static unsigned long memblk_nr_poison(struct memory_block *mem)
-- 
2.20.1

