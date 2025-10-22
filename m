Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7E347FF6
	for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141488; cv=none; b=u2+cgEcurTpawOGwzOlOZlWQn7BmBINYqaUpoOFLLS1dp4Jvu4UPfsOdsf5QtEv1ltTY6pjBNWFLxfmZUGaZuDQ/V+z/cDi7lv5irfZTUg0kJZxmQorrYfN1Wr33CBNEKQwZi5j23KWZXbPXqJhfTQRCFTjCqCQFP+RBSYRwkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141488; c=relaxed/simple;
	bh=HMs7QIS8TCQOly4UaNFuNAYRbyo2O/QzWPLtffXnMJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pBFjBBaDun7vEONPEl6ldD0D0USGTUdiFcGHX06p8xMhEcnIfYwymEI96g6SBNkvkMtIsK5qIu2SsgYgLMg2GP63N2fY+m/oQmC7VpQViyJUtvHGcD5Z3XXfY7pTyF6sfibRbbYOCT2PM4hWPHtzVEOnnKNBWWxs9T1cAEEv8S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYvcZECL; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYvcZECL"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-782e93932ffso6004361b3a.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Oct 2025 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761141485; x=1761746285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp0mM9JFdY1qcqdgJXC1k4Ghi8aDtWlI8grf4712vk4=;
        b=OYvcZECLGqNFSs8QD54Uym6Gd+qkOITbf2oo8bzNztMfY8ytAKxnjMwXivjnsENHUI
         q/h4u1ucb5Fg1OmBDM2Nc6WmoVWag/sYSsSi+IdaYFtbKBjX09Cau1JAuENlxL/NtAgB
         FcttGa6Sa8DRw+IMdI4Hb0lo3ZhwaR+pfTIL1XS3skUGXfYdR4KeB1InwVlkKWli3vw/
         WcU7oS0EaaxFzVGLYFh3DqCr7Le74dD8h23g/GttChcLT80+H0K5lysi2i8GShKR4jtw
         dqPF9l8rXTESx9HlRh5ZAbjDHy6SEOIaiA0bpq0goieFLDPexq/hN5dKOT4QCz47I6e2
         FGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761141485; x=1761746285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp0mM9JFdY1qcqdgJXC1k4Ghi8aDtWlI8grf4712vk4=;
        b=Wj37u/dfZ3LHyspPEzG0UyWtAs1NuRb5HvZr4pWqcrI1K5rM7V7Uar+fK0BPOeaqtF
         FygKx5HjcC8JlvUBds+/OOr+ilwnpV72YFFMoi82D/sqSI161lHtKVoBtqojvgWwenzc
         nEXkvTlnTAoWK2FcBaUfVzX5sAs5R03pQkyl/1EtxkdcfiaBqCcQNdDpuRMByHk7Jsag
         taOieUrl0BXQ9DGN9L2NJdrcJSO6/DZy4ea9WDf/p0uIGEUMbZKpFSzYAfSa0ia3sOcC
         0TAmn79uwGeHBGUHmYxDFcOQvjRKtZ/NOsI1ovr+NsmiRizqiCe70XPtiNCeyVBinipg
         D8Yw==
X-Gm-Message-State: AOJu0Yx1nHOgqj89quuqVmf86uaW9fH78Kzru1wjCq1RmbTvP4dl76Pu
	Gq2cuVH+o4B4xTP54T0J4hauV07tH9fXkKK57HUKRWKsyuOziIeci4Uv
X-Gm-Gg: ASbGncu6LUBFMw7qXizvrbFu4yixveBnpVTyx7xsDShYjykm42s0DXIDg6C7Q0g0+F1
	4+G5YELvcrleyiTukvuUH4/o8sBDXZrYquOVGVliX3WVbJwMDNRxcyZApiM8vhWGishywWN/l5t
	20vJIbnlh6ckFP3i6R0MSA5cMqKIvlbcOt/cEDiIKDLWNGnoJLc8jWSB+lR/BImUN28FbTQIcrd
	NS+A72FEQ5qSvxrrtOtYKjWCbK5MGvqi629QfVxIUhEqw3ZE4trOErbJ1AH7T5FOA84wDYJb7/f
	nA4oFmPQCX+DpEqOo2TfCkpQ+NlEZVGo8fXaIaIvXll9Nns2dy5Rn10j+PmzmBBtCWbZ9qObw+2
	jItzHRCDKRNzaO/KtfVOCYf54QcbXQx9rsbJIEa5+xfVev9R+UqQAivja6BLZTaQvQ/Ehpc4Slj
	7/UIRuCJV4LD8xs9c=
X-Google-Smtp-Source: AGHT+IGjLidG7JODwnkAIkbP1GeDN8MYzPHhkFYBEqm9cXg1a5wgXqHHcQ6Qv3vY8mGO1EtlTtwdtQ==
X-Received: by 2002:aa7:888e:0:b0:77f:4f3f:bfda with SMTP id d2e1a72fcca58-7a220b25969mr24268270b3a.31.1761141485168;
        Wed, 22 Oct 2025 06:58:05 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:671f:870c:96dd:31d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15985sm15047365b3a.5.2025.10.22.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:58:04 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-cxl@vger.kernel.org,
	linux-mm@kvack.org,
	akinobu.mita@gmail.com
Subject: oom-killer not invoked on systems with multiple memory-tiers
Date: Wed, 22 Oct 2025 22:57:35 +0900
Message-ID: <20251022135735.246203-1-akinobu.mita@gmail.com>
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

Here's the command to reproduce:

$ stress-ng --oomable -v --memrate 20 --memrate-bytes 10G \
    --memrate-rd-mbs 1 --memrate-wr-mbs 1

The memory usage is the number of workers specified with the --memrate
option multiplied by the buffer size specified with the --memrate-bytes
option, so please adjust it so that it exceeds the total size of the
installed DRAM and CXL memory.

If swap is disabled, you can usually expect the OOM killer to terminate
the stress-ng process when memory usage approaches the installed memory size.

However, if multiple memory-tiers exist (multiple
/sys/devices/virtual/memory_tiering/memory_tier<N> directories exist),
and /sys/kernel/mm/numa/demotion_enabled is true and
/sys/kernel/mm/lru_gen/min_ttl_ms is 0, the OOM killer will not be invoked
and the system will become inoperable.

If /sys/kernel/mm/numa/demotion_enabled is false, or if demotion_enabled
is true but /sys/kernel/mm/lru_gen/min_ttl_ms is set to a non-zero value
such as 1000, the OOM killer will be invoked properly.

This issue can be reproduced using NUMA emulation even on systems with
only DRAM. However, to configure multiple memory-tiers using fake nodes,
you must apply the attached patch.

You can create two-fake memory-tiers by booting a single-node system with
the following boot options:

numa=fake=2
numa_emulation.default_dram=1,0
numa_emulation.read_latency=100,1000
numa_emulation.write_latency=100,1000
numa_emulation.read_bandwidth=100000,10000
numa_emulation.write_bandwidth=100000,10000

---
 mm/numa_emulation.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/mm/numa_emulation.c b/mm/numa_emulation.c
index 703c8fa05048..b1c283b99038 100644
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
@@ -344,6 +347,46 @@ static int __init setup_emu2phys_nid(int *dfl_phys_nid)
 	return max_emu_nid;
 }
 
+static bool default_dram[MAX_NUMNODES];
+module_param_array(default_dram, bool, NULL, 0400);
+
+static unsigned int read_latency[MAX_NUMNODES];
+module_param_array(read_latency, uint, NULL, 0400);
+
+static unsigned int write_latency[MAX_NUMNODES];
+module_param_array(write_latency, uint, NULL, 0400);
+
+static unsigned int read_bandwidth[MAX_NUMNODES];
+module_param_array(read_bandwidth, uint, NULL, 0400);
+
+static unsigned int write_bandwidth[MAX_NUMNODES];
+module_param_array(write_bandwidth, uint, NULL, 0400);
+
+static int emu_calculate_adistance(struct notifier_block *self,
+				unsigned long nid, void *data)
+{
+	struct access_coordinate perf = {
+		.read_bandwidth = read_bandwidth[nid],
+		.write_bandwidth = write_bandwidth[nid],
+		.read_latency = read_latency[nid],
+		.write_latency = write_latency[nid],
+	};
+	int *adist = data;
+
+	if (default_dram[nid])
+		mt_set_default_dram_perf(nid, &perf, "numa_emu");
+
+	if (mt_perf_to_adistance(&perf, adist))
+		return NOTIFY_OK;
+
+	return NOTIFY_STOP;
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
@@ -532,6 +575,8 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		}
 	}
 
+	register_mt_adistance_algorithm(&emu_adist_nb);
+
 	/* free the copied physical distance table */
 	memblock_free(phys_dist, phys_size);
 	return;
-- 
2.43.0

