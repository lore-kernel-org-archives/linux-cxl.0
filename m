Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919528FFCA
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295328; cv=none; b=lhtI4LqNfecfPrKpd2A1k9MYTzq/V/J/5VAJQBrAt1acjFtCJqgAiRiTTGa9HuJRgEKNXgGHer/e+8CfsXO6WG11cZfaArlDY/VxO1YOkPQFE37VtsrqnDINxxkmkgYqA34FKev6BLjh7njAkSAdmICfx+kdF6MAf3riGJeKGFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295328; c=relaxed/simple;
	bh=fZnaZ5GHZcfS9p6y2BQGcaUFH6wu1bBVJJP31QU4XV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BUnsRvWe3qR5iu7wDa+WV87Afq3ePe04Soya9GA9ZqA7vAb/90kTsVEc3NhQGj7LVjmoPikBJyIxdgwbkcXyd/sQyYDnurxeDHCR22JftTXzGhp9qvxcmAnNj0C6ouIEIEwlUc4nkHuLeeakEDtejvdX1p3l9LC5SvEy12QG6vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ffhWo1AD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ffhWo1AD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c554d7dc2aso138477585a.3
        for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 07:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744295325; x=1744900125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QU7b8p5X6+ipaTqnZzEvjAMW+m1ukjkOluS/etWvC10=;
        b=ffhWo1ADPW+NpqceS3kDUHHgVgtfHUB3cKz7WnCAE8Sc6FGPHThLY4tnERR9IeGf1T
         DWdDJN6PRSFQB4+5wYRgMpqcKKjzVkD78B5xpVVOBOa1s+trAkCrqD37xj3Ll610+wss
         wyGO9cFTVKB11PEldMFpnH7nZjLOlez0oP4bQsfpJqG3kW3tCLxhXEBtUlBJFaIVy7Dj
         xvtbbl0EremF1QhFyL/DTjh+4h9NJZxdzJ7TrDtHsY6Blq+fA51b/w1tFQEHID9yQZKd
         IJfDPcB8W0V2DfyRG9WB9fge6SuzntbbnBYxf9X+cMVE6V3Anrq6oaWTUyBGlDGtqBXE
         k2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744295325; x=1744900125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QU7b8p5X6+ipaTqnZzEvjAMW+m1ukjkOluS/etWvC10=;
        b=GQHFT3IZ3zOosCKwjGIy9Dyn8kzivyLFH4FIALF1ODwfJk/jvdw+0Uzv90/ePt58vO
         AR2Ar52bJLJu/k6L9T2WDUrFPCX6QFG8upEnt8i/G4pieh66bu9j3ithEL/9osiwJX9Z
         UtLx8Kyg7x6AVr3MfZgvU7K9Q7hs5n3Dh++kTz+sYxyekDvA6vebo/rbj5HXPux86cIo
         BRvXlK0uzq35As0NUCs4DHCiPcpfQKtRdw3EcIaYZ7Lo/noBs5ide6WrBDtAcj2A0yJZ
         qt/RZ8+zzG9r/nlWfsLQ2GhBi6cX9NUmX+u53LYVBGWFW6j6Md6Xg1fKC1bPdXocvfST
         7i+Q==
X-Gm-Message-State: AOJu0YxkF1T54BUCd5AirT6egcJ57zE2ohfCxBi87z/yEYiaBYsHpkog
	42RLsX4tTx2zMsu8hX0uJOzbDIVwpBDpD9TyFDNXe260KNyIrqKrBP/3N3insJYXfO9q49VyMHK
	1
X-Gm-Gg: ASbGncvZ1Bt008svGIL/B7a3tY7IiGRZcljUXoUvQG8HNAr4aPyH5NFxJRKoAGFxJuo
	GAnXjDhSkiePPuDZwegkIAcZ08K7gEjCBAgLol7gwvX5Bp1wuQTuI3sB1xPMeOSX5ONu96wYbCk
	J6QxmdpIoOAMZTFSsziPndTTz+XMWQ3H4faCEzKGMKY4Y59sWMhpglwB7F12+DB5OnYPaFZeZGD
	Jp9pkNG/XjNxBOBZDFdQIfhTXjSAyoEVFVrgGbSmNigmhdvK7/vkJkUUY8rXSeO1o029A0ns1CS
	TzicpNoTHRczKi/rdTuEKBZbbPJqiYr4wj8RMVtPUCjPGBkEK7qVmDCSkYp20IK1YGUPTN/TAon
	170Xqh1JaRr/WywNFIv6KSw==
X-Google-Smtp-Source: AGHT+IGMVGeMyBaUbWMD2SRNc0LtssAH5A8ndxEkZnyBQsRRtZK83f0qG5vpcQnY38UUX/EqwX1CKA==
X-Received: by 2002:a05:6214:c2a:b0:6e8:fee2:aae4 with SMTP id 6a1803df08f44-6f0e5bd7058mr50446596d6.28.1744295325172;
        Thu, 10 Apr 2025 07:28:45 -0700 (PDT)
Received: from localhost.localdomain (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95f8besm21567896d6.10.2025.04.10.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 07:28:44 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	David Hildenbrand <david@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3] DAX: warn when kmem regions are truncated for memory block alignment.
Date: Thu, 10 Apr 2025 10:28:31 -0400
Message-ID: <20250410142831.217887-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device capacity intended for use as system ram should be aligned to the
architecture-defined memory block size or that capacity will be silently
truncated and capacity stranded.

As hotplug dax memory becomes more prevelant, the memory block size
alignment becomes more important for platform and device vendors to
pay attention to - so this truncation should not be silent.

This issue is particularly relevant for CXL Dynamic Capacity devices,
whose capacity may arrive in spec-aligned but block-misaligned chunks.

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/dax/kmem.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index e97d47f42ee2..584c70a34b52 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -13,6 +13,7 @@
 #include <linux/mman.h>
 #include <linux/memory-tiers.h>
 #include <linux/memory_hotplug.h>
+#include <linux/string_helpers.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -68,7 +69,7 @@ static void kmem_put_memory_types(void)
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
-	unsigned long total_len = 0;
+	unsigned long total_len = 0, orig_len = 0;
 	struct dax_kmem_data *data;
 	struct memory_dev_type *mtype;
 	int i, rc, mapped = 0;
@@ -97,6 +98,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
+		orig_len += range_len(&dev_dax->ranges[i].range);
 		rc = dax_kmem_range(dev_dax, i, &range);
 		if (rc) {
 			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
@@ -109,6 +111,12 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	if (!total_len) {
 		dev_warn(dev, "rejecting DAX region without any memory after alignment\n");
 		return -EINVAL;
+	} else if (total_len != orig_len) {
+		char buf[16];
+
+		string_get_size(orig_len - total_len, 1, STRING_UNITS_2,
+				buf, sizeof(buf));
+		dev_warn(dev, "DAX region truncated by %s due to alignment\n", buf);
 	}
 
 	init_node_memory_type(numa_node, mtype);
-- 
2.49.0

