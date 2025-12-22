Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFD821B918
	for <linux-cxl@vger.kernel.org>; Mon, 22 Dec 2025 00:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766364563; cv=none; b=jsDnbI7FWvPy/T/ibkMDvV9cfjqQUGAT9e3WZ91fdQnu9X34ffHSFXn/jZ1rsfbbg6ytRoQjRY47Y1OQNSKPSi53PX1qps5M3fm52rQX+qze6sgnt013nfKNSlfOycDyKIGGcrHmt4LVBlIyl3jqmHxvdv4CsqHaOaEwg1mGqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766364563; c=relaxed/simple;
	bh=uwpd6A8/JJiZRPsY0eYWPt+toE8mJr3sa3KvHSB6r6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYa9BPmfRRdM5eROSeRNnuLGsIUC4Atn4CS1VU0UNhQqkHFXQG4MdbGegBX2HnEB7jzezDWkUzOtzvR5rrBuuylgQdS6GZIhM4od/B2lEsxm0GYUagYuxh3ONbWeXiKcCRFsr/wRZlHaXKZd120maNC7AojmGqLCY5x9o6OwRfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+9wf30e; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+9wf30e"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso2228709a91.1
        for <linux-cxl@vger.kernel.org>; Sun, 21 Dec 2025 16:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766364560; x=1766969360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10vzVgMW/SIAVZiREFQWpaxB2zwT+8w8TEXAc8bNZjs=;
        b=G+9wf30e62Idhr6Dn/aKSNfTzIWCDzQro2Jf9UhazyYGS3tTXR9EvrhauwstQik2WC
         Xgh1HM7UocOfslvN2ehoa/lSrYbt8se94R4pfJKKpchde8P2RULiddxFMOr95CQ5Pc9Z
         uajyii3PabRXlryf28vGVRkxY7BO1bJ8Aa96MBNGVH5MiOF6px9WOG3g1Cd0wv0ht/lZ
         YmrysSv//47lcX4IoYjzIZ9kCPWZnFBirSbvCG+ksGxvWYRzCRlHrZuzijhe2vNfGi3W
         WZ3HB8Y7bfuZcAkpKflMiQiXPclZXIwNzADyES7uzNj7dvVb9mCC4gNWCBxKbVAu1pRw
         rYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766364560; x=1766969360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10vzVgMW/SIAVZiREFQWpaxB2zwT+8w8TEXAc8bNZjs=;
        b=QOpB2omtk963rvY3l8KjgD0IBGha0ks3vwpGTWxMeXiiu42ad3jK8fsMICQsVUc1aN
         aNbm9HPDexPS14/7k++xjYX30E/JZ+58gKcPAMqfCnNkY40Oc0t2/EnHS/+p290p95vh
         Ce3uyK20w0Tw0Wt4kDC7DHpAuyCdWaXSJTsDJNwfcvS5CekVR1aJA5LzzscMxhqIfSeo
         uaDFf5x7f275U+4SBYz+8V1+fAly0RFF/2K9+8WEo4I9z3ZrZQd5s5MbHlAZBcBMRw7b
         zpoJaN1/LMsJUDij8nBLhHJDMM9nDvGy9au1h87i62fpG7qGchYfGKnEdZnbWYEKTmAg
         zM0g==
X-Gm-Message-State: AOJu0YyayRoEeFFvI0YLfKP96OtVY183D8sxZpb57+NoT0G9IJaZ7KXs
	L4x2V+3ftq3u+ELc4gJ2SeboWrUVzCE3gGzlttSynry0D/uY2arVSU7E
X-Gm-Gg: AY/fxX7a7B/9Wf2W86s9VZOlI531hnWUpzMyyVMv46n6rEgpHnjhBLPjK2AesGhIrOZ
	BIyil62Aox/GvYRIpGhXvzTOLQWHpCSVv1NtR+Zx9M4CMew8k73SdrVA+cSSodJ/3i9Xs/ZOzlW
	EWvnBJDAW/HrGruT6RFnmvybQojPG/duPT5aiVmtJkTOw7PMXfZPafYDxDLIcII8uwdQuJ8blV1
	ViKouaMi+Ygoc7A8QAc/fMyrL1jt/wBeTOHml8Sx8+Rv4P7ouGbU/EMfYj0oUy3HQduEH5sZl4N
	gqegYZjnxp/EB+9/ZDAuVkaAOrmHvhUjvi7JJvxyROyBhSWozACREgw/H7AaJ6bQCUlJ3rqO7gw
	c5ELvWEt4Em1c8J/dR7Aiz6eC9MG4f2lGGJvtStsftdl4oe22OeNFUUZpMO4wzyzlWIi8MsVJvV
	/bu+buMGFBLhuVCFYa8QFwm4zy6g==
X-Google-Smtp-Source: AGHT+IGJcxUPthsfQvfgIvDDUW9++z5bU5TtJMiOACtXv5gVSZp4E6tKXbai45W4KorvPXSKizQXDQ==
X-Received: by 2002:a17:90b:3c4d:b0:340:6b6f:4bbf with SMTP id 98e67ed59e1d1-34e71e6a525mr11996986a91.18.1766364560272;
        Sun, 21 Dec 2025 16:49:20 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:df7d:b611:ffaf:6d45])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e79620bd3sm7461832a12.4.2025.12.21.16.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 16:49:19 -0800 (PST)
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
Subject: [PATCH v2 1/3] mm: memory-tiers, numa_emu: enable to create memory tiers using fake numa nodes
Date: Mon, 22 Dec 2025 09:48:32 +0900
Message-ID: <20251222004834.10539-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222004834.10539-1-akinobu.mita@gmail.com>
References: <20251222004834.10539-1-akinobu.mita@gmail.com>
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

