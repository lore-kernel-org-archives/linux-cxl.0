Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DC30F949
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297638; cv=none; b=Tt4VVvJX3x3BIaRVSm2Oio1FJSCPZOlDO9fkOiIMJmngD74Ta8iaiw5CE6Pa2BwQrfdt8VuRPKEV/gv9Crpq95dzEemHzSi+tMHR3weHSl4xtGvE/Z/2wtG5Or8WhPFGaYxFABNm+K1vNJpeFbRXFThE6fpbeDTB0lrij73Gxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297638; c=relaxed/simple;
	bh=GI1lKCop0k3azNeySc9/TU2klwIfVqv3k6MByu3j4RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaPjffFAq58Jp29w5nhB3CT8EF9yuiUAE8k193OwAcwU/5OBQgHlrAWz2CeCsRw/gtR16NOVO6eSa+Pq93o0fvLEb/VyeUBKUw/HM83Qjfmbc3bJLoFco0XDAv8gHkQPZ60T+CIJpuM7uCoRAyJ1/Qw89yHmxU1BhZWheHUHP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqBpK3HZ; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqBpK3HZ"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f822b2df7aso99976591cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768297636; x=1768902436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5kwq28ArtsUeWAWQkRHAJMD/obs9sOzlfds4wEk8PI=;
        b=kqBpK3HZz9PHStdY1uw2g7vhYyVxcgVK87095AMTS5KDK8q4mlNOWJQA7eTHn++CMZ
         D91r9zohe8jltpQ5/ZuZTy2R/dPa1am5rC38CZvMiI8qmbXhaohJjf0puhGRULl5JV5w
         A+p/1Dz1Uf1XXC0/d6K8J9MTj1K5dcW2p1Bo3MTniQ7lFaZiMkfRLvt6Y77Fkcxc1Y89
         ii2mtT/CE5Q6G2JBqpg0yV9LIU5eoozfsqPhkNHDuUb9QbbuAgeCwPvA9l+r867eD/PP
         dQWGo1DdO1hGnUkcqUR4T1GVl195gI4eCzr01ovPkKgfedfk8QJEAYtTGOetJ0H/3lMB
         u5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768297636; x=1768902436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5kwq28ArtsUeWAWQkRHAJMD/obs9sOzlfds4wEk8PI=;
        b=bcrgL7h+bDmitpFKsk1eB44DTr//ZeiYZYeFdfIoM3sDWgo/vtNjL6aAybtgRCx8cl
         HB6hXktjObmMhKRM3jLNMYemdmVSwFZ20Mtiy9420mfwpt/Jvw1kixNPgOM6ZM6FJX+g
         npIkeGgbs0CTfJMX0XW2JIA4dpGIgL3u+BCJY2Jjh64dZAmRYPfwmd2qQabuqRbqOFug
         /3BxZ29n5trINY39Gbxq2DAnfngd2jHa9Y4/ZZ8iOkrX0uURwcRFJpxdzzu7B+GsxCwR
         Croi0xwzLpHAzI7zW91n+GzQXFE4OxdjQisPZEdnfx6nFuv//+kg8PWBT/w3ZqZt4d6c
         ZPZA==
X-Gm-Message-State: AOJu0Yyga4T2+BKG+1CgFXnphwnZ4kAsPjZWXro2HqGHmfKVHXt4KWEQ
	Ei8OilStGEH5dhk6aDWu5npLqfmqKU3K5t9OG6F1YAZjKCh9SN/jxOTeoTXiTw==
X-Gm-Gg: AY/fxX78ymRdwpP/XH4Zew915uTgq1tmEPgeSaWIoKBhtbsNllcxcml59mEGObY8P+X
	Q0WkVWbKSBDebPNCFC/N+HM5nOhRjJY19N3F1srYCVb2pLZQWzpaKdTdTh9DhT5H+Pin06uFCJ2
	VV5gzhLQQZ4IyginSCBSVKy2rpdBZii5/n6IqO1lvc0rZjuzn20mw1YuylHT+Hccw27vU15+ltg
	t8li6H+4CXAl1T74Fp1R/gfOz7MwR401dzOSpuylfD+qHcdr2aq8aTd7D8oeGms+EIffK6vmssF
	Db7NqGLlLbBtcpM45zsePp5Nq65jszLc0TVajm75dDL2XFjG6ZtoY54iqRZR37hgW8+7veDb0h7
	YNOU68Bkme6f48ouwaMc9OGw6p+gmkfWKwWV6G9q450Eb7Glt3839RQaa9vL5Ip/xm46o/DretJ
	Ur4GznUSCopZlxwjsS5iHY2zzBbA==
X-Google-Smtp-Source: AGHT+IFBVrtk5u4rKzzBFDXzEra8FkgmNs+pG1NptAdeAUj8xnck47+E/LevyB+t2O7vXfNt+W6mJg==
X-Received: by 2002:a17:90b:528e:b0:349:5b1b:78bf with SMTP id 98e67ed59e1d1-34f68d0bc85mr20289632a91.23.1768292123859;
        Tue, 13 Jan 2026 00:15:23 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:180a:3788:c683:2f64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350ff05492dsm657199a91.3.2026.01.13.00.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:15:23 -0800 (PST)
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
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bingjiao@google.com,
	jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: [PATCH v4 0/3] mm: fix oom-killer not being invoked when demotion is enabled
Date: Tue, 13 Jan 2026 17:14:50 +0900
Message-ID: <20260113081453.8293-1-akinobu.mita@gmail.com>
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

v4:
- remove unnecessary include of linux/node.h, suggested by Jonathan Cameron
- include linux/notifier.h for the notifier_block, suggested by Jonathan Cameron
- typo in abstruct distance value in the commit log and document
- add information about supported architectures in numa_emulation.rst
- add a code comment in can_demote()

v3: https://lore.kernel.org/linux-mm/20260108101535.50696-1-akinobu.mita@gmail.com/T
- rebase to linux-next (next-20260108), where demotion target has changed
  from node id to node mask.

v2: https://lore.kernel.org/linux-mm/20251222004834.10539-1-akinobu.mita@gmail.com/T
- fix the explanation about cmdline parameter in the commit log
- add document for NUMA emulation
- describe reproducibility with !mglru in the commit log
- removed unnecessary consideration for scan control when checking demotion_nid watermarks

v1: https://lore.kernel.org/linux-mm/20251208094028.214949-1-akinobu.mita@gmail.com/T/

original report:
- https://lore.kernel.org/lkml/20251022135735.246203-1-akinobu.mita@gmail.com/T

Akinobu Mita (3):
  mm: memory-tiers, numa_emu: enable to create memory tiers using fake
    numa nodes
  mm: numa_emu: add document for NUMA emulation
  mm/vmscan: don't demote if there is not enough free memory in the
    lower memory tier

 Documentation/mm/index.rst          |  1 +
 Documentation/mm/numa_emulation.rst | 31 +++++++++++++++++++++++++++++
 mm/numa_emulation.c                 | 26 ++++++++++++++++++++++++
 mm/vmscan.c                         | 17 +++++++++++++++-
 4 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/mm/numa_emulation.rst

-- 
2.43.0

