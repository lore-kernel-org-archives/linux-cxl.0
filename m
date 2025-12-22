Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609B19CCF5
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 00:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364558; cv=none; b=Qkr+CFF0Gi1iw1KA5tLoeFGCwBB+r4AutPjKJ6vM+EtHr8wDBwlXR2cpGmnNZNwlDplwlR8vpcNVNllDi20EXu+05AYUF7YbU8M5Nm1eGvlC5Qc8sTz9NZOOMjAWZKgQZ5XGaUHU2xrjN1+M30cE/75m3GQXQvGxm0aNgKImvoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364558; c=relaxed/simple;
	bh=CH91PuAY67MGZZ03vEoPlphtK2px+k3b9iDcs5qtFpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qq10zFH6OQet5L+yoXgRQiPgAAutu3tCf6iGbv8uFiqLM3X//lmKPiV+B9CmRdYpGxl7czi4CiT6liozWbczYon/LQBh7Kl6825cABF1dbOwNk79j+46eEoc4nIRC1YuslOeMR6TEe4dg27JiC1GyT88vAz1I7vAnebbYR1GeCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgIHRyCI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgIHRyCI"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34b75f7a134so2599605a91.0
        for <linux-cxl@vger.kernel.org>; Sun, 21 Dec 2025 16:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364556; x=1766969356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/vB6kAvgJ/UHgjs8UorfX5aUFI87Lf5p0yAYqtg4bPI=;
        b=jgIHRyCI44KQ6OueOfuHb9KIfvfLgdwn0IjiHwtSG3vlD1q+/OTHGgTL1sOwBFcEUv
         T4kRe9J2nzT2hKM5awkFs3H623RGaoLPG52EpoBInjZlmL7BjLoMkJGbFp8mKhWVFkH0
         2ah+XgzQmpfgeX8egb1VohkZILTqPjlOnjB4AYm+fNqMYPZQKeZ6sJeigwU5icJT70s3
         O0ReMkGx8lMRfEQyXo3yUOBeS1LOePcRFNG9ICxwJS69s1GVf/h/7461e6YG6zawmDyJ
         j0JO9GlYHwfeW1RDVa4KKrZULi56u+THAItbqabwAltKkmWDYSf/9g/GFPwfMaVnQ7wZ
         HR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364556; x=1766969356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vB6kAvgJ/UHgjs8UorfX5aUFI87Lf5p0yAYqtg4bPI=;
        b=jKUV8ydFXAeLVHiZBaYwYevsiSZ/kZE1r3AEb2bmabVLOZwDdIKCoS2bmz0w3HQAJs
         V3J519dOgAbcGA89152Bnsi8M34cI75k60w2edoWKncu4oC+a0txeVe8aPvTRs3R/fOb
         tNnW+nGtADr5f8DC+Eiatxvcwhp75VlvqWpIMIe9ezSw7JFU47Vd6QYAstQtb7F2C8du
         nSipPu7neS8F6BUsy1W9LRnU9sUW+DP9r2Gc22U5LeYdmfBJbAEUC/qVnb34JB308Ija
         zvrKUjVhYwlx13piZfA7GDgLRR6SNRjupqqFj9l2gicqnVPnQQUxdPKBA1DPp3RbVq6Y
         7z4g==
X-Gm-Message-State: AOJu0YyZZpZIzYJQfPzWUGqJJbe+VS4siF+0qeAW0huAPjOsmRWSL3lM
	O0Pg2vibpcydh+ivambvigxcMdj1EcsRjpzopScDEy8m8bUtWRjjXI0a
X-Gm-Gg: AY/fxX7jLmfWiYOyrJzjAEPWwasCl/R1suPncSI4Z+tWwEKskQQNp94/pnqmLyDwgUE
	VvhRIEIIkXSL3LTrj8l+kXUTx9N4MSpxVkwm12bbu4BkjIODNXQIz1LoMzKRNzNDnqt1sgh3ZDH
	pJHV50yR5ald0lDPPzxcVOt9f8JRNSxayBC4ecGMKgfQjCpdzy0b3iHsace/Z/IsVVn8iI91Vrz
	G7fvo/Hnks8eRqU8F7QUqX1lB+nEosK6T0NIisjhQNa3k+IqrlKefuK/zCvpkq0SDX0gBhmfhqZ
	9+Gstpi/jjyTzqYsMmOUjua1LzNSlTWbyfHZ6VwiJ92VkzgDWJj8nCl9t/DhJ1CLFlH3IgaHjMN
	Vtq7mXtGetMUt8GMNdAGKoFoE8TegKumqdv8ztf+rGI903IBPuLK8+EMR0+5CmxuLFH6PRNErEe
	j+abe1Z6Cb7hcDFuTQzj39sxDlhA==
X-Google-Smtp-Source: AGHT+IGweoLET5YnyZ2EKzJERfarS6dgnQ6cYugjO07yPKpn2IvtkOU/1jaFMgk4W8d4nO0djWxJzA==
X-Received: by 2002:a17:90b:51c8:b0:340:bb64:c5e with SMTP id 98e67ed59e1d1-34e9212a206mr8487470a91.14.1766364555876;
        Sun, 21 Dec 2025 16:49:15 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:df7d:b611:ffaf:6d45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm7461832a12.4.2025.12.21.16.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 16:49:15 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	mhocko@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com
Subject: [PATCH v2 0/3] mm: fix oom-killer not being invoked when demotion is enabled
Date: Mon, 22 Dec 2025 09:48:31 +0900
Message-ID: <20251222004834.10539-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with multiple memory-tiers consisting of DRAM and CXL memory,
the OOM killer is not invoked properly.

This patchset includes a fix for the issue and an enhancement that makes
the issue reproducible with numa emulation.

v2:
- fix the explanation about cmdline parameter in the commit log
- add document for NUMA emulation
- describe reproducibility with !mglru in the commit log
- removed unnecessary consideration for scan control when checking demotion_nid watermarks

v1:
- https://lore.kernel.org/linux-mm/20251208094028.214949-1-akinobu.mita@gmail.com/T/

original report:
- https://lore.kernel.org/lkml/20251022135735.246203-1-akinobu.mita@gmail.com/T

Akinobu Mita (3):
  mm: memory-tiers, numa_emu: enable to create memory tiers using fake
    numa nodes
  mm: numa_emu: add document for NUMA emulation
  mm/vmscan: don't demote if there is not enough free memory in the
    lower memory tier

 Documentation/mm/index.rst          |  1 +
 Documentation/mm/numa_emulation.rst | 30 +++++++++++++++++++++++++++++
 mm/numa_emulation.c                 | 26 +++++++++++++++++++++++++
 mm/vmscan.c                         | 13 ++++++++++++-
 4 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/mm/numa_emulation.rst

-- 
2.43.0

