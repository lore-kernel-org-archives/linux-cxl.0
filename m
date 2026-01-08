Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276045BD69
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867379; cv=none; b=EpRJA4hVTuJYOHP7s86MlUjKVKeNU4tN88ZqQqMoU4mzPZ9IMKHey8/6fJqLoBPt01PQE5q6tntmcUjVz26AcZs97MpfshNKPCDPuoRLPeROWVlOmbaDyIu2wittMYhMU/8PaW/IeHqj6z3HY9aOSf1d1X48N5/eCHNL94upfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867379; c=relaxed/simple;
	bh=C1V3X/dIwbZSU2wcmqaFJRp2n010NQA4JleQOiipEis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpSQjPaYv9SaVxqFnT338J43SMR6f/CMxOjPF+KBAy8ePCjvDQN8MUVAq/12to+jnw2kRdYprJ/MauvMgRW8fpvLObssxat6MfPIciiGD2p9DO+93le8bSITa6D1mzeZBcg7MjgWUdE8h9OMK/7ELSJDJ3dkPKUAfmEFwtoG1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mepr88hG; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mepr88hG"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0ac29fca1so23495275ad.2
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 02:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867374; x=1768472174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dfFwLlC3N0TVxIzNvzK+kY/3KKp6vwFx6CZlJtWeVto=;
        b=Mepr88hGf1kvXfnV9MPvjy+VOB6ANrjyyatRFLEYkSQTsJ69djALQlx6cSPGMnYfAa
         OBIdVYquXqUDmMb/90m/OAemHJCxqf0Woav5NAfTUNmUJfCYvAp7nWWsy2TLM/V6EMp9
         bMh5vJbrMUyeVMIMR+MCrbXxRYpTfrankfZtKpQiN/HMM3yNHWjIP/LLxx6nPMaqFgNl
         pfRdWmDvuygnviOaXulQszp9tPSVj69YUQu1sNks0vCzRi3Cob8j64jOycQRECaCw/0t
         x8QKcDa64rBCwODwS+yVQM04chtx1rl82CKcaHmauVged95r1L5PpmP3eoOMXS1Dmx5L
         yHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867374; x=1768472174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfFwLlC3N0TVxIzNvzK+kY/3KKp6vwFx6CZlJtWeVto=;
        b=DgwsvPzmfST8eJMXQ+n8/OP6F5hwNVa9UGlLIkL1oUfY+6ZuhrShbh/OXQKkZcD3Au
         FAWMZJE3vY+tnC0+rAqQH7Fg0BItsNcOuIZqhXAvlpiU4xn+MUw34lEo2ZSYailefGes
         +OGZLCHRp5NtfGXUyWJiHFs1MvYzHun/OS9G9kJxcqY7nam8zW1EqPPiJJFgeHot5Vad
         A98qMkMczwGQGqzsQ+Kbpq2KZQXqPu6KdrtTpsKTmoKFHwp65IFG9MOzLbI8QE3Of+ud
         RRLVcrmvSSab0EHZ6fgnPpzOaThOi+jn2z/KEcpP42RLTeQQVWcVzQtIi0ntlNUs7Wmk
         tLQg==
X-Gm-Message-State: AOJu0YwUZc0IeR6yw9I793OZeVHqzX+tHFm0ooogcXRhYN4lD4MCDHsQ
	KUtdE4ugUzsD9Bd8Ri4c0dzIwZaEafzClNptynXweF5dRsBoSlsa3nB/ksvkbw==
X-Gm-Gg: AY/fxX79xZsF+cyEPkgXpYMpj+GyPipbKmcTWnidA3Xb6vaEQzt12D9EWijs2wRoNkG
	GkkAckAuSJlTjBw03w0KNkfiIYVT5s7kzEBUQLnclztP6rsygCtl4QhF0anJawaeOA6gEahDFOi
	2tvEo5qTU17+xeHP/Stb2OOMdL+wubnSET17JQhAdvxh9cJSdU268XSfwEGUF4+KnlZ6/9+085o
	zv9B1q8etB90Ccw+i3B5b50Ouik7U069rj0qHM2jB9mqQZ9JXLpjPSKUU/Qct1iSgPrPB9gz4u0
	QKNnPvEqd5jZBUnRoi6NekCr3EH0GSMBZpT6siw+OACfAjCXnIqCECIi/TMgXXh/umaTWtU/Dcs
	v7pDPvu2XCwqi64v96h3UhGV1jHNMs72VAIlzCnbUsGW+BP7FJnbdnHS2kEPwrZ9c3AoFPtZQYl
	F3XC83Qk9tZpDTK712bLuAa17f
X-Google-Smtp-Source: AGHT+IGox+E55AcnFF0JcQGHkGkBa2XTHv5X/Fo9zj4DPlIf6vmy/GfrU6ehPXT8j2mvIbbMcz5iqA==
X-Received: by 2002:a17:902:daca:b0:295:8dbb:b3cd with SMTP id d9443c01a7336-2a3ee460c5cmr45231575ad.27.1767867374481;
        Thu, 08 Jan 2026 02:16:14 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8352:dfa:3b18:eb4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c49299sm73785245ad.42.2026.01.08.02.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:16:13 -0800 (PST)
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
	surenb@google.com,
	bingjiao@google.com
Subject: [PATCH v3 0/3] mm: fix oom-killer not being invoked when demotion is enabled
Date: Thu,  8 Jan 2026 19:15:32 +0900
Message-ID: <20260108101535.50696-1-akinobu.mita@gmail.com>
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

v3:
- rebase to linux-next (next-20260108), where demotion target has changed
  from node id to node mask.

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
 mm/vmscan.c                         | 16 ++++++++++++++-
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/mm/numa_emulation.rst

-- 
2.43.0

