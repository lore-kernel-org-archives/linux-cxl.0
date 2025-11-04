Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864C18D636
	for <linux-cxl@vger.kernel.org>; Tue,  4 Nov 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762216796; cv=none; b=NDbhnVC6Y4ACHvtrMhnIfyZvKwyMjWqwNm9WRoS2KWdknK1AwVdWQHW3ZmDRyzoHTyY4USonlCr02MUrVGFaDR+84MYbFXbOUnAlRLCb/31mWsHHRu5ZfaTirXw6qKEgaF0T0yb6dCYg8q827jTSexhUdhbO+Vtq4A9HQIV+qP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762216796; c=relaxed/simple;
	bh=iW93nzX0z9zZaTNYKnzw3iwZ7cMIZimkgtTMI3k4PDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvDOc6EyWdDjZnoLmtuGywCYKkCjNplV6IRe+oabVSiORTrqxcOHDfxtbgGNY0MtEtqHJDb6t/3+GT2aiXWPsE1+5ozdJsG9AAtmt52vkkcC5yk6LEzfd1z6+hjrRbqXJ7UdCR0pb3lZI4tev5/tTUzlFnIn/xwyzoUFWHe87O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6T8Bx66; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6T8Bx66"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78118e163e5so4853622b3a.0
        for <linux-cxl@vger.kernel.org>; Mon, 03 Nov 2025 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762216794; x=1762821594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iam28yxbxtTcQIZpnqIWn4zgf5SETAhbeipE7iPuLHg=;
        b=B6T8Bx66YAf7UEFd4y1SLti4GZEEgNMtaB+qQ14iayZoXimw+/s1/tPicRSCrzC/KH
         tVpWQgYTZ9xy1v8BdePglAxrOFl0ey1TdQBCNnXvkqw6JkaVYuJGCIbxARvYVUeQn2cc
         +Y9bQVkhefKVGslc/xLFgBOMbKjLxcbBN0Kdpvv2eA2jEG47eRGpjZRkynWz75GMZPCi
         4d+//s3c8o/WhggT91M5FmHCFe4y6BRNbdfyVTp67BtWRyiLK/3y8ibPuVl1qCaRsgSB
         zmA8INzIBGQR2N8Pj9dH5H5RxcF49nrLLh2PRJSJ/Lcz2WLeggJ+j75DTlMIyOmHDzt8
         yPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762216794; x=1762821594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iam28yxbxtTcQIZpnqIWn4zgf5SETAhbeipE7iPuLHg=;
        b=LhQIhFSOD8kmfsIFvxXFsH9UWwC5ci0eC2tK1mZLu1fTbxWoyK+LokLqaG48n7GNXK
         fppMITCxpNGS6Efbm9NMB6DpfdOB4WcQziCwrGRHSPrJwnrRPJZ+KBNB64UWbbmVJ3xN
         9H0RCcEoSvdIufWOqfHSITqPqXoPVkSIO6lqnkZznrq5LhEaPNZLq3mFMei2l3Obm+YO
         ed780GIsba8Xh9yKvmNv4taYGOe242yeuVPM+pz14VkMMKpTo/nc8o0UYr4XFQf/xvVk
         iZZjJOX7+oAAWa07sPIQEu73KJ/hS7/5gPuevsUr/lAkvUxGqXJzSRijEi4ZbJmc2De6
         I5kA==
X-Gm-Message-State: AOJu0YylRaUVOj0YrtfupL0wyoZt9CEnoHy0eCTjpJIVDE4v+iLtzkuu
	lml65hr1mvSlv6HFgi1R/ftT8mdCm7A8hzWh1xenBUK9pRsp6OZu5F/L
X-Gm-Gg: ASbGncvJuauT+mACWroNde+oF++5eDuGoHhNyU/Yt/HXIl3uFSSTgA/7Y8Hl6fwyXm9
	Z2JtmpYfx3LYYeQzNEzlFJBjNkftDJBHAjmF7EFVrKz3zEPoqrHbdT09GckG/orw2H+jhNU1CsB
	5VHKDESCC+XuW5DJ19M6LknLU643HjK7obHe8f711dyP+SI7mhqaaMa4OYasBSsgQPnpFI47S9R
	RpqiDEVHffCh4IzxlLYSEfUpNBRteNdrLO/3l21Q3f0OPZx9EDZuncqwDMeP9rJmLrTdfaSsRDw
	xOsQOAWBTBELNyyGYhfHDbRlZz9ZSXNSkhyeBIhOHvV/Ls4YOiV83RD6KMtxMmWG4EQxPd25hUA
	lU3fBSKv+R//XhMAaDdNcxZLk/2lY7AHD2wuFs2OvtwPTugf30pcHDVkxQ8/O16215efPQFxfri
	iz77ttp9Oe4nwZvt6pv6wFYGrLkA==
X-Google-Smtp-Source: AGHT+IFJbftbMdXgKxfl5nxnplvx3Z6+G0scrRMZ2oVSB3QoWsoHMMWseKqIUdRWNIb6rfsyQvsVRA==
X-Received: by 2002:a05:6a21:6d8d:b0:2cb:519b:33fe with SMTP id adf61e73a8af0-34e2a1a60bemr1475870637.21.1762216793733;
        Mon, 03 Nov 2025 16:39:53 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:30f4:78b7:7acf:47d9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd634081dsm666661b3a.58.2025.11.03.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:39:52 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: akinobu.mita@gmail.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH] memblock: fix memblock_estimated_nr_free_pages() for soft-reserved memory
Date: Tue,  4 Nov 2025 09:39:21 +0900
Message-ID: <20251104003921.9707-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memblock_estimated_nr_free_pages() returns the difference between the total
size of the "memory" memblock type and the "reserved" memblock type.

The "soft-reserved" memory regions are added to the "reserved" memblock
type, but not to the "memory" memblock type. Therefore,
memblock_estimated_nr_free_pages() may return a smaller value than
expected, or if it underflows, an extremely large value.

/proc/sys/kernel/threads-max is determined by the value of
memblock_estimated_nr_free_pages().  This issue was discovered on machines
with CXL memory because kernel.threads-max was either smaller than expected
or extremely large for the installed DRAM size.

This fixes the issue by improving the accuracy of
memblock_estimated_nr_free_pages() by subtracting only the overlapping size
of regions with "memory" and "reserved" memblock types.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 mm/memblock.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index e23e16618e9b..af014fa10a44 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1812,6 +1812,22 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
 	return total;
 }
 
+static phys_addr_t __init memblock_addrs_overlap_size(phys_addr_t base1, phys_addr_t size1,
+		phys_addr_t base2, phys_addr_t size2)
+{
+	phys_addr_t start, end;
+
+	if (!memblock_addrs_overlap(base1, size1, base2, size2))
+		return 0;
+
+	memblock_cap_size(base1, &size1);
+	memblock_cap_size(base2, &size2);
+	start = max(base1, base2);
+	end = min(base1 + size1, base2 + size2);
+
+	return end - start;
+}
+
 /**
  * memblock_estimated_nr_free_pages - return estimated number of free pages
  * from memblock point of view
@@ -1826,7 +1842,22 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
  */
 unsigned long __init memblock_estimated_nr_free_pages(void)
 {
-	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+	int memory_idx, reserved_idx;
+	struct memblock_type *memory_type = &memblock.memory;
+	struct memblock_type *reserved_type = &memblock.reserved;
+	struct memblock_region *memory_region, *reserved_region;
+	phys_addr_t phys_mem_size = 0;
+
+	for_each_memblock_type(memory_idx, memory_type, memory_region) {
+		phys_mem_size += memory_region->size;
+		for_each_memblock_type(reserved_idx, reserved_type, reserved_region) {
+			phys_mem_size -= memblock_addrs_overlap_size(memory_region->base,
+					memory_region->size, reserved_region->base,
+					reserved_region->size);
+		}
+	}
+
+	return PHYS_PFN(phys_mem_size);
 }
 
 /* lowest address */
-- 
2.43.0

