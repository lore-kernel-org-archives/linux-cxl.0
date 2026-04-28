Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62493D6CA4
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366356; cv=none; b=Labdc4hmwyE8M38kFwC040Y+VV1O3JxU6cl61YqhgAncCy419qGvkg9uwJdz2SBQNRs5cwEZ3fklaMdYLRYIW4lMyoGmWrew1GL/DMf+PWf+B4UzTgq2p2LYvlJLgllfzeKk3D5Z5kviX2Ti4amO/vtMd7AsRrYLYO04q7H0SCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366356; c=relaxed/simple;
	bh=nQdEySHsup5tuoqx9Fwrf6ki6sgYhd+krQ8jAeZzU/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BtYAQiFK8rcKWabeGo3bYDHedEFE/16ERyivqYkUaQZRDRuuoCwJZY8AfrlH05ar8sJ2N41EQOWptEMbhrhkdwFe9hG9lrMR5ANxpJWFCjMfzyXda6vBRrEnl7cqsV6HAmEX8XfLUqjZknfXuNyQMfc4R96bR+E6Wd3oyWNAeqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZhMhEMoZ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZhMhEMoZ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so9559988a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777366354; x=1777971154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3RZ85zZRMSfm4V5G/nYn9e3XYF7QD6vD8DovC4NkGE=;
        b=ZhMhEMoZpXGeT1eEF0IiDMGFFkclzuLEBXmEf9xow3hHvQ/5GgU6w7i0aQn4GFtdg8
         P3Tq4MpNHo7UifWcffZ6oN4D4hjoIz7JE0C+mBUoxLQ4RqoVgNGV2ouegSp0Ta1dUEv9
         jvrn3bg0nWGkL5zj6JXOcPn5cH2kGF8nmSBJ3PlLPYx3SeoPVNtwLdsmhljFFMHMMlJS
         R9vx/HjWLE0Dit1FYoFh6KQ6cEagFxm7VYqktZWa/XKV9flyjxT9WVQajlhCyxeXG3dy
         nxVS0b2b2EVLH0kkFooA+ShjKnx+ttccMZP6/PFjAT1sTy8kq/leFHmcaPXcotFXZhkV
         /i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366354; x=1777971154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g3RZ85zZRMSfm4V5G/nYn9e3XYF7QD6vD8DovC4NkGE=;
        b=hdZoiTfuKeYPbjS+FkRh1+qnEy4h+WkmK9mhmMzlt/nEeYfDFagnShX52/mM23QNEZ
         bDWNBs/WofXzJ47NoUcJAOcLLKDhiMJVHtV8BHrPVzmuNk5gblssPXZrUWy9XPoy4161
         OzDbxivJqjLbGqhOHINSHGZ7/jsc47MQzx/u7QO/kaDP/c16cqCCVpB8zeAeNAvXpIVL
         E4cLWe5v7JOBFhnvLcfW7GirotLlAk9YFWFmRaHu90zLYIAZnpSOuoN3C0ngigqcqnIi
         DaJdN95lTVWrMV8iIsMQb6gyJ5ksKJnXQbfQt33ZPQ9j8WFqO3hlwcuivfVb3zgru2IG
         9AcA==
X-Forwarded-Encrypted: i=1; AFNElJ/KFDTOSFJOtH5URunbAHEMBWJdY8+L9FMo2HHdAVL0/ejPIK4pIhXBfmgK0vDO/MKy0O+YVqv33Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqS/zGG0yBC45b5yNDfB3F603DVFJEy5BUYB7pkA+EbaGefA7
	bCBmTReh8EeqTxmcD7hT8AcTajCxyyW2cTg2ZeNR0HBPvqzOFksAzKRdiWy56oT38Sc=
X-Gm-Gg: AeBDiet2/K8HsKb1ObohkjNAVAvl0t3iJ3V1U81mGkKS1J23ucgHQXb7Mm5p/2wDKnM
	6gW7JBi23gR/cxO2lETA8FEYy9j4EnniDlU8o65Sjhj/gWY+yuq602VtIQiS7fEhxtl38As1q5J
	T968lokY5W3zcgqArYz2PlbT15Stddc7aTtMz3x1XUx2/le9WFaQ5nyVhdNEuBtEvehhRvWC0+f
	TBIrf7ZBXpzNy5BMUHXcWEUqoY7CUyaF4B0EdBWBMlU5UaXvdp+yJQQhTDi6dPmoXZIuutPH8jM
	HvtXKtNgUpeKZexAyS0RSTrV5jzlCEL9z5LMDFTtcIqGdcreys5/EGu8nMYMR/weT1qjvlDbZfW
	IvwXNFCMUJxbCDGRbN7lxQCvY2FFUQXRNYyeYXp1oMegpTQeSJ/Gk8Axa28OqmKFvGsYljhQulc
	l/i0vmiBqJdSIjkU2+FA0aVdPG/YNZVe+T98sr91l04pU5EjMKUyyHfrQ=
X-Received: by 2002:a17:90b:3510:b0:35f:b5df:463 with SMTP id 98e67ed59e1d1-364920a5111mr2319506a91.14.1777366354012;
        Tue, 28 Apr 2026 01:52:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364902e7debsm2889080a91.15.2026.04.28.01.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:52:33 -0700 (PDT)
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
Subject: [PATCH v2 1/3] mm/memory_hotplug: fix memory block reference leak on remove
Date: Tue, 28 Apr 2026 16:52:17 +0800
Message-Id: <20260428085219.1316047-2-songmuchun@bytedance.com>
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

remove_memory_blocks_and_altmaps() looks up each memory block with
find_memory_block(), which acquires a reference to the memory block
device.

That reference is never dropped on this path, resulting in a leaked
device reference when removing memory blocks and their altmaps. Drop
the reference after retrieving mem->altmap and clearing mem->altmap,
before removing the memory block device.

Fixes: 6b8f0798b85a ("mm/memory_hotplug: split memmap_on_memory requests across memblocks")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v1->v2:
- Add Acked-by from Oscar.
- I didn't add memory_block_get_by_id/memory_block_put because this
  is a pure bugfix series. I will send that separate cleanup after
  the bugfixes have been merged.
---
 mm/memory_hotplug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a943ec57c85..40c7915dabe0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1422,6 +1422,8 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
+		/* drop the ref. we got via find_memory_block() */
+		put_device(&mem->dev);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 
-- 
2.20.1

