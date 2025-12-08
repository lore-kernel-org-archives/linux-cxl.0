Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B687313E13
	for <linux-cxl@vger.kernel.org>; Mon,  8 Dec 2025 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186886; cv=none; b=fLXxLFrQNWur2SFkHF/+lsslMhgBdVIkxkrt8P0aWl+rLFthFqB7aADIsbX9jB0KZZwMgd+xTHb+YiyR1+0iSLWiBbAsFl3rrn8ky4JK4MTXkXuAWJdS/iGpONheSHnCtSQQNBB1/H4JidnRW5fjuCr/ASE3B5JFEmyVvfssMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186886; c=relaxed/simple;
	bh=UNuYO5mx9EJp3oJF/BMIjfwDQ6F6CgDJxyYgjNzptuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNIeDAL41SILE4EfKh4Cmpk0QPbIir2DER6CNL9BkE6dh5i9gY13/pJK3FqJPMbgvs7v3OQAyUBUWJtuplBoUD/WM+7qF6sRPQBhn7zkf4Nl8XWPQIJbVYRPWelNVJQ0wiUsyHFBuq1VrDrbRfneH//5jgo9TG0oD7Oc+n2VboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cV3trop0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cV3trop0"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7c66822dd6dso3522174b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 08 Dec 2025 01:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765186885; x=1765791685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrNXZOKlxgRO0yUuW29s8gJG7z3xY0PKnm9mYNQSi3I=;
        b=cV3trop0PWww59zoB7ZTA41BN60SCU5QLNh8CYRZt0xcSzNMTnSg5RRIfJYJNbl9eC
         BTG9n6fnUil+s8HhKjhnbrk5eg9jVztMuPLJKJ80Ff9A4m5UErmEoRilPMaMiFVMJMAY
         ljsiK0U0JS3qiQPDAeMYCrbGAchuaan17vEWsTThGpLRSU0qSJjmOKWB9rdJQC61hEro
         P128i+U2l1XV5kQgedkt2s+fjxLUQCIdmdZuwxPesM9Jtw+wQQGUhjZL1i4oByx8Mk29
         5E9C4vaXSwkDkvxEoY/aWS6gOWyMdecmA6Pwu1wW09MiiV3RekAGOicRgPEi5e3UTf9H
         Tjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765186885; x=1765791685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YrNXZOKlxgRO0yUuW29s8gJG7z3xY0PKnm9mYNQSi3I=;
        b=lqP0vyYK3dpzDiDnfqDr6YD5CzKnb+cls/nCelQrBQMooGhAYmumcjhvVOSaCoA5MK
         UL8PLtJOc+DUQ1N1wmL+lWPvPGVGHdI0BExWUG1hrqJO5+ZvHhYiGpimv/YoRpyZHegG
         kPBL6JCsr8lbRHNxKFWEpn9QPBTav8+pwllzfltfShwEb0inTHBcrG7mW5XhwaggClvJ
         82wiacHw65g3nHeygAzFCuiRwbGslTB4DS0JPICWhiQ11cK/yzWHImWhpKmCQ3rr8/bi
         o7KWqq0wxb09QliAwzpifn+JizXC0a2XJCgOZWjvOoNds7OyJAmGJY8Rg4y9WaYmcznZ
         bGKQ==
X-Gm-Message-State: AOJu0YzTsqRYHS0QVoOlOCUFTWfxWADRnZ0rGAB5tmdk0zPeLC+IRT1d
	DvSGqcUvwVbbMBj6d1Fwu5mjuaeEEjd569nsrGt0s+DU35DKxZIJQ6ON
X-Gm-Gg: ASbGncu6B8rjs9GySvK7l2sxfFoz+TLvIHM862HhVM5sShB0/bOhCJ01tsSSZXDw3xH
	S8qOtmf4jIJIHLMC6U5BnOw70oFNM+xp+poMPoW8Aef2SSuDwVbW7D6DtZNdaV+pIAUcSwopN3P
	OiyFBr0I10tRddXtRg8AD4vd12X59IZN2ac/VUGcDLq3stVHOBueh0oKNATjL1d6l1mYJnN6otB
	1m66xWjayx+mCbItNXELlEYrlfYRuiwI3gyGiFQWXjheAZKYDCoDORDYSjyUOWBEF60v5vAVhyM
	2tLGD38U7QsYwRZFxiUmABYaha2aEWuEDL2tQMLii26B4J/6CFysH3BYh7N+N0Ia1Luj53FBxL0
	/fanAVfx4bkJW/otBDShdE2Lbi0LE2nI5An6AvJu8YJNUgye2JNlV8RvXroSqhAvL/hqDw2qlNj
	a+Oh4rmbdKygK0smi6uK2TBeZr
X-Google-Smtp-Source: AGHT+IH2gvj0cqj4kadasbx5J6Um1ertdus7jcEuIr+SD+BFGC8ZCznhCkpFOtQ4+kihzfBZfZN8nQ==
X-Received: by 2002:a05:6a20:a109:b0:366:14b0:4af9 with SMTP id adf61e73a8af0-36614b052b9mr7799200637.32.1765186884634;
        Mon, 08 Dec 2025 01:41:24 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:e251:d9f:c2ef:caf4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf6a36bbc60sm11675279a12.36.2025.12.08.01.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 01:41:24 -0800 (PST)
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
Subject: [PATCH 1/2] mm: memory-tiers, numa_emu: enable to create memory tiers using fake numa nodes
Date: Mon,  8 Dec 2025 18:40:27 +0900
Message-ID: <20251208094028.214949-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208094028.214949-1-akinobu.mita@gmail.com>
References: <20251208094028.214949-1-akinobu.mita@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes it possible to create memory tiers using fake numa nodes
generated by numa emulation.

The new "numa_emulation.adistance" kernel parameter allows you to set the
abstract distance for each NUMA node.

For example, if the system is booted with the parameters
"numa=fake=2 numa_emulation.adistance=576,704", it will configure memory
tiers with node0 having the default DRAM adistance value and node1 having
a lower adistance value.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
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

