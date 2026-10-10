Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A8353A8C
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649304; cv=none; b=UE/8Er7u82J6eOeEmVOGKMByel6t0FT+Ti/yw27r7kmiDMq5K6FH96DBE8FEm4UPay7gIk+zx1KJQkXNgK0heBaSZvcejKeJ9Pw6R9De/3XYjUumK6i9F2IOUoKC4T5cnW0dKyD9c8HA+EFHR2HAT9fQCHmuDWXiyZPTqUq9FOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649304; c=relaxed/simple;
	bh=y4C4vQTdn2bxnFX2RYOiAcm5lbpDJJqJCWsVTjoUgQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwbMYI7rVgH9sWSaCEgR7a2F9+SiZNbNc64VVoYBIr5EKEm8/faWlJrQETaFQuENCPCrNLNxClrls3j7ITvQYo/UFzzZjd7ZB0Lp+1FR1M9x6vu3L+qW7v7BFy1aKC/Yqxw+Orbes5/CnMegEc4yjuptF0JFtJe1A90gTWaPYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U93DCDd6; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U93DCDd6"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-141395927feso1175636c88.0
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791649303; x=1792254103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8PWS9Qoyo16uTAXAyqsyaf8MZtKTZdCptpC3zTJnlA=;
        b=U93DCDd6gWTRgRM7M4qpukAa/Se8UN7e5Ts7rlpldcxZAe2qLVzZlG/WiC00gKxxNE
         rPwZyVd+1Vv5GwGr3aIHm0cBxs1lfJYP+P0a6rX8K6kzRvboymptDpCEFssrrdSyK4Fo
         9OGPqKBI1CO9N7HPh4jPcCxyl+JaMhgvdsYrkA+l8stw88nfEdwi4KL4C1wReOPgsI9z
         noQtaphHYA/orc/LtzwnpHiPIG3e1Pjg3Vj4JMbZSicZfNxrqLuPHxb+huz78i0lYS0p
         OzE8wiKSQ+u/fp3JtyvZvt/JHWMn6BqYOaZv4vZ2BNMTcHGVVNphbWG33ItCf/rQSN10
         ntoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791649303; x=1792254103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8PWS9Qoyo16uTAXAyqsyaf8MZtKTZdCptpC3zTJnlA=;
        b=DQZOxgainFYpKKD8fQ6kjiEWgckHB9ugMZ3K8w1nuASrum0o8lICrKrETnWt768Gsx
         PTrMn3im7IYcaJ8NRtk4SWgRIBHlpnb8MJ3LKsQ+x6D7L8S4bRkxZunsdxmX3PxCDSGj
         8PasxwoIUkJsK+KgtG7cNtAdPzzFZufyfofgQnok6TZBamPNKKLHqpPL4dMKEciqtxQS
         KaslV/jw4NV7W4XxoGM9HaehtQo73l8JuOqbTRX2/J9ZyZ/VVofzyOeD2wR9LgusdwGj
         hE10QYsRYaxY6YYEsoFrRq4gNldLCnKzf8jd1q0VbIsup75oH41vzrXoTiIFFIZ4RKVe
         YL5Q==
X-Forwarded-Encrypted: i=1; AKwUvByjvtLxVb7rt/LZxyJtr2WNk+3KVrQRSCdR4s/RYoFpBvNuCdbSwSPza+/yeXaEsEb5HTJ7Vp3kHyA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAtqYb4sexgw/v7SIJsCDg8Xeij5KV3WdvhaXCI4G6e4RYK5h1
	/pUAahULDX6Zp9GzZFv6IcQ6SVlRhaYLmMStct/4/z9/UasLQGiRKLHD
X-Gm-Gg: AYBFou0QEU0nTDXlfy4zZfZHf2jw7Vx8bW/aBrJGGv/kUahAgsn0aWubRpvvA5nDDy0
	K2rQBaMGbqfQg+c2IATOdRhp6fu2oBI2E/Iolm7vBvbevonBkbOLPUG/jtsXvpWmdsBryjR9uXQ
	ufe8zSd1DdBpsvzLIbXDWaC5fPImpMLxS+3EmooJJNFcLI0i09fhQM+LudAoJCctnXDZIlWSlGT
	0Q+a/BkTBdGgxH9F9995vAhQzwM/kX15nPVL7X0WGWbz0J+ZPlS25kwfcXHBlbwrHNKlXahNdcL
	E1E4qVpZtb81NGMQbxUiFdhIAPmIjS82E1CJ6znlPirHKztdcv2rNEvSwStciy1oXCSU1wpvxbe
	D4QxvZxclB/gSaqOAtcluyaWKRLWxdH3/NlhPOgu3FCB79CAKiyUVq18OWzMX/W+UkbJ4h05CVI
	pUMZz/1s2nTaRtpbyCD1HsEb0Zr4CJzHoqV5puTVz1qNTH49s6jgtbyE93CjRkfF3DojtRHdqeR
	XiJDRkbeNN7T1i36w==
X-Received: by 2002:a05:701b:291c:b0:141:4951:f150 with SMTP id a92af1059eb24-16a5ea5d6famr6277251c88.18.1791649302496;
        Sat, 10 Oct 2026 09:21:42 -0700 (PDT)
Received: from acer-nitro-anv15-41.. ([115.96.176.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm15778622c88.14.2026.10.10.09.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:21:42 -0700 (PDT)
From: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Breno Leitao <leitao@debian.org>
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
Subject: [RFC PATCH 4/5] mm/page_alloc: Keep pre-online poison out of the buddy allocator
Date: Sat, 10 Oct 2026 21:50:12 +0530
Message-ID: <20261010162017.62506-5-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
References: <20261010162017.62506-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inherited-poison path checks initialized blocks before releasing
them to the buddy allocator. CXL device poison discovered before
hot-added memory is onlined is recorded separately in the pre-online
poison registry.

Extend __free_pages_core() to send a block to free_poisoned_block() when
it intersects either poison source. In free_poisoned_block(), withhold a
page when its PFN is registered as pre-online poison or its physical
address is present in the inherited-poison table.

Pages identified by either source continue through
hwpoison_boot_page(), while clean pages are released through
accept_and_free_block().

Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
---
 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cca67a2702a4..57843df01b2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -33,6 +33,7 @@
 #include <linux/cpuset.h>
 #include <linux/folio_batch.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-failure.h>
 #include <linux/nodemask.h>
 #include <linux/vmstat.h>
 #include <linux/fault-inject.h>
@@ -1601,12 +1602,14 @@ static void __meminit free_poisoned_block(struct page *page, unsigned int order,
 					  enum meminit_context context)
 {
 	unsigned long i, nr_pages = 1UL << order;
+	unsigned long pfn = page_to_pfn(page);
 
 	for (i = 0; i < nr_pages; i++) {
 		struct page *p = page + i;
 		phys_addr_t phys = page_to_phys(p);
 
-		if (range_contains_poisoned_memory(phys, PAGE_SIZE)) {
+		if (range_contains_poisoned_memory(phys, PAGE_SIZE) ||
+		    preonline_hwpoison_contains(pfn + i)) {
 			hwpoison_boot_page(p, context);
 			continue;
 		}
@@ -1652,7 +1655,8 @@ void __meminit __free_pages_core(struct page *page, unsigned int order,
 
 	/* First: a block parked by __free_unaccepted() never returns here. */
 	if (range_contains_poisoned_memory(page_to_phys(page),
-					   PAGE_SIZE << order)) {
+					   PAGE_SIZE << order) ||
+	    preonline_hwpoison_intersects(page_to_pfn(page), nr_pages)) {
 		free_poisoned_block(page, order, context);
 		return;
 	}
-- 
2.43.0

