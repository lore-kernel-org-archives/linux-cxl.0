Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30393218AB9
	for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214717; cv=none; b=sU4OH752qz91tClZCSuwS8RxmYx5RqN6X1mcvS/mIg6G/UzAA2BXmvKne2LHh6axi1c4fhzNiPdFomH7+hyp8CkTBZ7V44sF4bDL/K4OvuqxhBX001cwJdLLVvjDbA8nKnSFJCpT+kv5d+SG9EoajUJfAP0eeWDxvJ3aEGWL2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214717; c=relaxed/simple;
	bh=G65XguRFTm7zXcup5EUJgGsyJNI1Wz/tFU4uJ30YpbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DnuPVI5kA7M6w7cGFzZniXo2dvwbSzMbjiaqnV7WNmQW3m1c1BLWuMyRwK+OAg2roqVxz1y3S0iQKpbuAbxQqqhCmoiCCvTGukd9GxrdLAdmPKS8cDvJKEs/kRhacp/BfabP/5FpvEEC3dmXlqWr6wrzN+0w0aVXKr2uyREcde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dvsEkto2; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dvsEkto2"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so4196309b3a.3
        for <linux-cxl@vger.kernel.org>; Sun, 26 Apr 2026 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777214713; x=1777819513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OiFyBmC7gClh7pyL8uPE736qSNuG55EW852NdgZNRz4=;
        b=dvsEkto27OfbYJLDAIeOEeWXLn0Xmr0p3Qrs7DhBQSdrAAQlc/StsHuMWvLho/Bu06
         +o6Ip0rx8pFqs80YDXHKaR49ZE+2WLyAt0KlwtQyj3Q6boTMxIv7luP/Rc2mU7uM1lv8
         LpF5OiCMxEUMKIDETF8lIT4fPuTU7EbgZa/lI+ORnjPMSHBJL6rhBLTa1p2jdb/gE2gN
         qYvWlCWL6p+OG1ewSm6CTyRbGcCfikSgqCEUQtLhJx9/TQ2e2VKdu5ozRRsIf3NefE/5
         8i2K4lOmJF7ASlm5HVhl2KIjBTTv4d0+/iTR25dvnfpFrIHsRAL3z4bwUMlSEX8DgbQn
         4JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214713; x=1777819513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiFyBmC7gClh7pyL8uPE736qSNuG55EW852NdgZNRz4=;
        b=lxcv+oByArdMasiwsakadg5H/Jc0fdjKVI8NUzCorqUV/QwOHYFf+CycpAZ6GhNHp5
         6r8g2eRUjvuymZdXB5p/mEzKxlqhcEWcpABSZXfG1flxnR5G8Yo8rFfVjD++bMqfUPfD
         6TTXwEY/FIN3D5vHsgXI6B4Y3XeoEAUpj5N7yPul8KnABhmEYIJD0truxGz4vPfeFHN8
         GS6H2Lcwaq6sajZ5kWk7xBxXZ7nuMKMPjenO80x/93O+Yqexb92BbR6/n/mT3YwY/7CF
         065R92V5+DSMf2VSqNG5kIo0l4KLT4Gn6OJNoRZIL8VjlvWqqwsxjV3AVbu5A0u1jReE
         iQDg==
X-Forwarded-Encrypted: i=1; AFNElJ/S79UFMKcDdAOS6Zii+4nXIdfqlVllS2O6H9PucqdSHw7Zc8zbgFrJ/8FQr9w2AWXAkQnpK30vLWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfaW2FBuB9V+98gGpC6No3w6v4hfjLjqeVacydScuWhquZXC1O
	q34RFotatASdrt+1/F9+BLwl90TXxxs1sg1I3pFX5zb/ol8MKB2vj0Ngg1MgoI9/5QY=
X-Gm-Gg: AeBDieuPmeCENlfl1IE3F53TFtl/1UzUwXdUFr/P7qFZcysiV/z43tCGpoQVVlZqrqN
	sAcQ+KhKZOdxNoyoSts869XfZUiBSX1rfEPZrMWQ4VgJfboCUMkRn2C8vzYmd1MoZBZiZLn4qDx
	AWlPsGXbs5CBAaIaaptPIFIcZ+xT6Btn9vWSkcAjqcP4UEUhgcb0o/r1evqVsHyo5Q9eA94RWe3
	v8NVKFj06rhMWshbpSS5I5nAoe/hm/sOteY5TLAhyyOhYBa4q8F97Uy2u/csDKeShGX4bJBiMqy
	5MYK7+cEbTIxZMY2LJ2Smdum9XCM4rh7BL9kRzbAUGdK/j7AwO6ZlxDFMNcTppMaGiyFl+TBPPR
	3gNza01Uq7JUPBAH5iyyLpTiAkoqNVJN6Y+OI7IqRZV9eN8/7fPFlSS33GiiZlHdMvulCY4TJrk
	PCetyyWJh5eLMZB2MBIn0goyhoU6XO
X-Received: by 2002:a05:6a20:1b17:b0:39c:241:65a3 with SMTP id adf61e73a8af0-3a08d68777fmr31746742637.1.1777214712721;
        Sun, 26 Apr 2026 07:45:12 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::349])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm22340550a12.24.2026.04.26.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:45:12 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: muchun.song@linux.dev,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/memory_hotplug: fix memory block reference leak on remove
Date: Sun, 26 Apr 2026 22:44:46 +0800
Message-Id: <20260426144447.817722-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
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
---
 mm/memory_hotplug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 2a943ec57c85..4426abb05655 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1422,6 +1422,7 @@ static void remove_memory_blocks_and_altmaps(u64 start, u64 size)
 
 		altmap = mem->altmap;
 		mem->altmap = NULL;
+		put_device(&mem->dev);
 
 		remove_memory_block_devices(cur_start, memblock_size);
 

base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
-- 
2.20.1

