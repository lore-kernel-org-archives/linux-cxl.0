Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5BE45C3A8
	for <linux-cxl@vger.kernel.org>; Thu,  8 Jan 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867389; cv=none; b=bFqNJ2Pn93p5HT3a6ELlQhyEqI9w8onYApnq8I9239H+dZuLEG1xGj/Tha2GD3mu8E6c/ct0xnJx0stoKvDvKIjWytbVJxPL7XwWzqqVtn8BaZDC7qRrj0IK8Vs6+TCnQhIL/j0AFIQpKFetJni5TApiON7oD5lkkc8yZLomVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867389; c=relaxed/simple;
	bh=uwpd6A8/JJiZRPsY0eYWPt+toE8mJr3sa3KvHSB6r6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ27gY6fMapHccyxa7MwgcpQIpoNMuF6p3l7McTvo1rDnmeky7fu0fNzhBJVkUmNexZ18wKG+XSaFHxO54m4QQ1So3bPtR2WwE0iPy02aTWgpchMtYsbCA8DqTDX5/osfvLDslLvxNoBH4Qq+uDX14/8rO4XVX7rD3nZF+Zb/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l11mSy+8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l11mSy+8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b80fed1505so2181479b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Jan 2026 02:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767867384; x=1768472184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10vzVgMW/SIAVZiREFQWpaxB2zwT+8w8TEXAc8bNZjs=;
        b=l11mSy+8FndsHMTJYiiwv0cFca+qGjx5Wv55/cQ6brh+s4Z9Vf14PURhVRZMtQY90U
         Wl5vXcoyPAN+QN1hgXYrF2fwVQuEGK5f0ggqcEXEsHjhxrvye3VSblwE1TWFoZzJC6Ho
         3mGLoEPNE9tBjBXOod7v6lUKSmp10bX4Y6627VnG9kaUmKrYcmKAuSkevgZLaYf9po/w
         kOJDmDP1ZiWgqDkNC52UV0VOz6U5zz7tYUL0bOAhOoiSxZM4Cbq37OZmMRqDcOukzmOy
         bct6DIy7DFcKZnEeN/c2gWBgnmrVjNn+2EUzLt7m5Cuet/xAeKcfN8zUPQ4j1G4XXqHg
         XIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867384; x=1768472184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10vzVgMW/SIAVZiREFQWpaxB2zwT+8w8TEXAc8bNZjs=;
        b=JjUMcD/axZ+BbWLpe61rpoo33GXm0+BiRtnzroFx/FW66yJRYl+s8fHPsz9dd20uY0
         qGAmY9sqKycufCRRifwJI3rw2tJ3xXg3O6ocyyybc18TLXGF34V3QzL3rfECj99z8gAI
         7cY2/7bLssps7YojWjT/34f/XBlpJHm5feDt+xMJHp6UlwvCIG0rWsC/4ZvtXRy9dfdp
         oIKxE9GstasUFic8Jl8toKDeyFUlZ6QvC45fWkwWMS1P3KSTJz5rgePAjpkWJeKOLYfk
         OQnKMMUsQPxcYh4KnucNABrLXAqwa6F/JWykTAz3mDZ9iDKp68ufNbj9GLzym3SYyr5h
         a13A==
X-Gm-Message-State: AOJu0YyHFlDRKNuLGy42/AnORWQnexLi1gAk9uLWTpQswU7AliSJjhaS
	BnJAP8BnanSqZ7zHAy5Gy2SLoDkaukTO8yivVBNgVlEAoLCzW/XPrhsm
X-Gm-Gg: AY/fxX67tp8b+F7jQ3HMcZINX+YSnC04XtzgbvRAOVuFuN4aleR6sSKFUHK9UuB4FhK
	hwqbLGv98P2s+6BC0Mf06MZmbqFkyLs+PvBojWpcIzSX9dUSjwBBbuKvzsuT8uVMVelMC3b4VrK
	qILpMcpALRpP52bHXc71OSDEDfbqMPjPB/AgRrvUHsc5gHvc7lgs0PFoUCxMYjTUeGUoxv0hRgg
	w0sH/QYFLY8N9djAqJ9rSkAUa2/97qHwbAS6Gf+E868sGAMlfI/na4MhOSt4L59i/IXPyt3bjG4
	/6Yk3ClcRfxs9dfzCKnuAweKzwOq5++wScvqTpI0KNsiDGIrUp5pe2V6kzyb89etLy0Og3ZMTEy
	1ss/JYeiucIDJRcaTaxWS5U20UnR5634XPqHJpQr5XWufNGctwyoNPSCiq9lVt+kKSuP8MQ1jJx
	PonH+WxnLS2gHjPbLErEpd89sz
X-Google-Smtp-Source: AGHT+IEZ/zQHkmzZD5tH7EULcvT2Rbbyog8IW+xRrH5RFccnrCaoGMPZL2CJNEUsgMOip+rJXNFPnQ==
X-Received: by 2002:a05:6a21:33a7:b0:366:1953:1d30 with SMTP id adf61e73a8af0-3898f8f54d1mr5334164637.5.1767867383759;
        Thu, 08 Jan 2026 02:16:23 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:8352:dfa:3b18:eb4e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c49299sm73785245ad.42.2026.01.08.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:16:23 -0800 (PST)
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
Subject: [PATCH v3 1/3] mm: memory-tiers, numa_emu: enable to create memory tiers using fake numa nodes
Date: Thu,  8 Jan 2026 19:15:33 +0900
Message-ID: <20260108101535.50696-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108101535.50696-1-akinobu.mita@gmail.com>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes it possible to create memory tiers using fake numa nodes
generated by numa emulation.

The "numa_emulation.adistance=" kernel cmdline option allows you to set
the abstract distance for each NUMA node.

For example, you can create two fake nodes, each in a different memory
tier by booting with "numa=fake=2 numa_emulation.adistance=576,704".
Here, the abstract distances of node0 and node1 are set to 576 and 706,
respectively.

Each memory tier covers an abstract distance chunk size of 128. Thus,
nodes with abstract distances between 512 and 639 are classified into the
same memory tier, and nodes with abstract distances between 640 and 767
are classified into the next slower memory tier.

The abstract distance of fake nodes not specified in the parameter will
be the default DRAM abstract distance of 576.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
v2:
- fix the explanation about cmdline parameter in the commit log

 mm/numa_emulation.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 703c8fa05048..a4266da21344 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -6,6 +6,9 @@
 #include <linux/errno.h>
 #include <linux/topology.h>
 #include <linux/memblock.h>
+#include <linux/memory-tiers.h>
+#include <linux/module.h>
+#include <linux/node.h>
 #include <linux/numa_memblks.h>
 #include <asm/numa.h>
 #include <acpi/acpi_numa.h>
@@ -344,6 +347,27 @@ static int __init setup_emu2phys_nid(int *dfl_phys_nid)
 	return max_emu_nid;
 }
 
+static int adistance[MAX_NUMNODES];
+module_param_array(adistance, int, NULL, 0400);
+MODULE_PARM_DESC(adistance, "Abstract distance values for each NUMA node");
+
+static int emu_calculate_adistance(struct notifier_block *self,
+				unsigned long nid, void *data)
+{
+	if (adistance[nid]) {
+		int *adist = data;
+
+		*adist = adistance[nid];
+		return NOTIFY_STOP;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block emu_adist_nb = {
+	.notifier_call = emu_calculate_adistance,
+	.priority = INT_MIN,
+};
+
 /**
  * numa_emulation - Emulate NUMA nodes
  * @numa_meminfo: NUMA configuration to massage
@@ -532,6 +556,8 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		}
 	}
 
+	register_mt_adistance_algorithm(&emu_adist_nb);
+
 	/* free the copied physical distance table */
 	memblock_free(phys_dist, phys_size);
 	return;
-- 
2.43.0

