Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8095230FF06
	for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292131; cv=none; b=fT2BdgIEUI5FRQKooob5n/Elf9wZsYGqzO1ZDCU6KDS+Vsgz1TVwp+5qAVsGIvrXbR8H/kDOOG7nnshrnCmbf4/qMcxf8BQ7b9c3jhNwY5QjBf5WgVO5F3LZttunCzTSoKptgD9jNVRHeRfsuFUaObz4EuH9emSY0aUDhth6T3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292131; c=relaxed/simple;
	bh=eUfMDALs3oQGUoNDnjd6BXOv9jf2PYXIXtYjEOUdMWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWOAxNh6KqlYdEL8jlKzicqvTexopqqlihxbm8v2WgS0LxQs7wiih4wndu/MjX3TxuaY8Q08jLBiF8+hCNuzI2K2MZ7UCiWsXyYhW6vLrCyBHVVrvhGaAKjHKE7yBInBh0eUwYp86LQkgMguY7aqDpx/gVC9i32bUAokI4d0b2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyN8i23A; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyN8i23A"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so5254963a91.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jan 2026 00:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768292130; x=1768896930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwTnQsuEWMmzKeRtMHdsKcZZ3Am1ZXUylBtZW2knjDQ=;
        b=VyN8i23AloqYp0gSyrI+vUwcHa4eMdWQHy/uUYsuS3qYXoletVPJxWWpWhQ9/i4MVZ
         2kFR/oxG7IwrwFvuTVW6Dd+bLP6ohpdrrtidR/t55Sip2zwv+mxhUX+M0VLfmavY7cKo
         0T7zlf623+NNLcbcVvC/C1sWt1RhLqVh+GS3RoC6cEwsgqdz2ZnM3wksTgD99n+AOxU9
         CgCTsUe4ZWY3E8xcSWv4Iav9m9FTAAMRc3k24U4LayQ27sTSfyrdy5EoB5LIVySC+nXS
         9WO01iSqpp+x4/ROIGkTE7lZquRiV2fw5ltMK8EQQ+q3stFs5PJ22WHQeWZnelH10Kiu
         TKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768292130; x=1768896930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PwTnQsuEWMmzKeRtMHdsKcZZ3Am1ZXUylBtZW2knjDQ=;
        b=KIEhQ4cuC3BsQ6WMqgFCxysV8aLGZ2Ep3JYaG0fAKPKcRgcKR6JbWTkrQndvz8k4kd
         8Ik+Xkou6mG3t2B0Ijc8nyegiIMIon6NWxvLmC8lP/270wO5L+tKg8FkhhVtn/QEYFSg
         8vvNXCsl85DgBrPQi5L+OXhY573JCXS6NNt10okMBjcdKQl31LA4B8uLf4mgtmbZqgWh
         TgPGEDCihB4FijKge4lpgX1DMrsSbCUqhT128jCdrBxQO9EdJBBSoXLj7d+8WInemXRp
         zajkLjzzjxRInC10n5pSapU8m0RvXwxld3DrliW+d0SkM97Z1fxgvGpK1ePQSd2jRnzI
         sfQg==
X-Gm-Message-State: AOJu0YwlJdn4SLWft2P0hSpLLG5OEI6SXhzeeZuv2fraLv/DcEpmhVHe
	EN4PayOWYdEdm3cNBbf+Dgcmbkeq4kU2rROIHMosorlJnOJm0pJhNFUI
X-Gm-Gg: AY/fxX4IWqE/+KjSXf59tN20xRfsq3QOt2SGEWPNjRbii6UQjeUVud6YMcPB4bhdqKx
	sOU8FBH00TbuO9HEBiOWCPL291VXDZXeHn15H9W1pOeE9YeRAx4Ec1eh82eJV/kAqBiIl8ij50L
	sjy+1UjjmHtpjk880aTe0UfehVgZaxkF46kPFmzsdEv0ZAYpQkgMkTUB2Z7V62qsLu8s67tVQvM
	bfrRlaOJ+D0t1gNOqIAUPXvT3ATN+Fj01SowzI6cC+iszJ1EyCMWH6RCOv60RrBL3h3042TBsBW
	b7FL6MQRoboe7Nun72mkilmomPMVzBMEPfT3DtQXBn6UuE0Pf1XM2oj6QIiTpV8l6Tb7D2QOvtR
	ZmvDTYr6R7oPKBywRzHEJQam6sJy5MMCfufxolh2Bw8F70hqTHActb/wgHYbIPAipul65iFLZAZ
	zQPVphkx5VOqKels0wqvaP5ZF8IA==
X-Google-Smtp-Source: AGHT+IGyoLWqkhk6HNGdCwYOoM3jG2DoR/KQRVZcJr9YqWUTu1tHClglXbICbAvlyxhP0k0QSxD03g==
X-Received: by 2002:a17:90b:3941:b0:34c:253d:581d with SMTP id 98e67ed59e1d1-34f68c4cc61mr17622637a91.9.1768292129845;
        Tue, 13 Jan 2026 00:15:29 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:180a:3788:c683:2f64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350ff05492dsm657199a91.3.2026.01.13.00.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:15:29 -0800 (PST)
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
Subject: [PATCH v4 1/3] mm: memory-tiers, numa_emu: enable to create memory tiers using fake numa nodes
Date: Tue, 13 Jan 2026 17:14:51 +0900
Message-ID: <20260113081453.8293-2-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113081453.8293-1-akinobu.mita@gmail.com>
References: <20260113081453.8293-1-akinobu.mita@gmail.com>
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
Here, the abstract distances of node0 and node1 are set to 576 and 704,
respectively.

Each memory tier covers an abstract distance chunk size of 128.  Thus,
nodes with abstract distances between 512 and 639 are classified into the
same memory tier, and nodes with abstract distances between 640 and 767
are classified into the next slower memory tier.

The abstract distance of fake nodes not specified in the parameter will be
the default DRAM abstract distance of 576.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
v4:
- remove unnecessary include of linux/node.h, suggested by Jonathan Cameron
- include linux/notifier.h for the notifier_block, suggested by Jonathan Cameron
- typo in abstruct distance value in the commit log

v2:
- fix the explanation about cmdline parameter in the commit log

 mm/numa_emulation.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 703c8fa05048..2d05e61570cc 100644
--- a/mm/numa_emulation.c
+++ b/mm/numa_emulation.c
@@ -6,6 +6,9 @@
 #include <linux/errno.h>
 #include <linux/topology.h>
 #include <linux/memblock.h>
+#include <linux/memory-tiers.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
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

