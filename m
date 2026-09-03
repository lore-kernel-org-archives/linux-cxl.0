Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFC4A3D45
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438120; cv=none; b=tpHDCX0qUhvp7S/AQOewTciPW7rB0zP9SQODnb3RjMis0E2UBuWxZ89RkEA5dl1IvMhnDQ3vixJqtS9cIgiM39d1XYdJK8SL2hqyiRVfwD6Z+BKl3ztcEG12i0WUcGbdyz+1QTgsyvvQ08bkVUZDPJ68sHpvW7y16aMNy2iGyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438120; c=relaxed/simple;
	bh=iUjs+EiXrSNpfuKC5pykyao7Ehz6dcFc1lBNJ06asU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuWU/pCEB4eiNQw5UJlyJx3jj0y3NBqJ6bMIhozOCQ8JQkQheO7vzD7dTs7qxU9ORWJNSwoZo57W0om8UONco/iqlmj2R7So90Y6YHr5bXNlTP4o6Yyr0fMRnBT7uTrPJbYrPBV2wcKH9ZzeNlJU4VLxStizC66SIncQHgwRLLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HM8P+JNe; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HM8P+JNe"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85377c8bc96so2596028b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 03 Sep 2026 05:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788438113; x=1789042913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wCVi0RPQ/1w5scAtdtuQVBMayOKGUht0GU0fLrik4o=;
        b=HM8P+JNeXozKprIxH883rNenR/o9M2W+wBj9fdZuwElwFzOkyitwEx5Mt0YhG5NWRK
         inKZgpUnbZGWPn1WoBGBmEwxh2wIyIRHgsoO1ZOCrl/vitP/SJfYocCbzZaxW+53kM4k
         UEbwW093laLXhGKAuHqmeVPFSqBG1YiqIcrvezNM/yp/xH4euQaRNyixTz1xB84LArZ2
         BpywZzOOmqgKcDYishQLzhNw7qZX62830zj7cETarR3To3nmLmMA/Yo4ZdLbnm6XNFrR
         S2qXTOW0U1pKmPVhapjTTxhNOmNMVHsK1OJAPhMLWlwUrogk5QJYCLwYd92aB41O3gRY
         SJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788438113; x=1789042913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8wCVi0RPQ/1w5scAtdtuQVBMayOKGUht0GU0fLrik4o=;
        b=akBxUNUURlSUQRtO2nWvFEhVXSzzleQpsIdOoocOUW3xrnxOps11jkzxHwMwyIgHjI
         W1EDZ/qhkZeY9VA+VIRmFX0w4g0nhFw3GzcDBdkIz20+3HGVHw8RekQEbO/n6ZerDFeZ
         5wJ5mFXiPn14SB8rx86n6NcL+6c5GtCVhiPJN5j9xfjTQZkbqWXqJepVIec/L0ZyJiPe
         AExP4jBHf3F/ASRR7ronIVwPlUQnfAZanU40YAWYNqVBtxh/Hmq1tXNanlH418fSMT9Y
         wb1PReJ/o1NxANT1yLb/y+14LN/Tgd1hbdxWlAHq6zI1zYYDXL1jQ/Kzh5VnvCJZw5vg
         I6+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwEB7XRS0v5BAUd0D4tJG4zIeuvwkPYZjU9+XmiplTQuk/F9qIisNIpYCUdLke9pT4KIIFnsuH41FY=@vger.kernel.org
X-Gm-Message-State: AFuF++kuUFf80BnlP/DLTX5n4QPiyQeZpAiK+vpZRYwa/pSMllmdJmxf
	NSx5f6g/G8Plg99eP0Ru1UrrDABrUnypUuGMd2KLMQEc+GDG/oKI9rtzt55whkxaLo8=
X-Gm-Gg: AYBFou03koy1mKm6qbbksDx8g72yijWxtq0Pi5tdqnKFRzjRwJKV37hM0Fsnn/9R6Ni
	2d5o1QIEz/gZPwHjOptth4yfLIRQVz1sA7Bo9SMpQE3h+x8vDGxG7LI0c72tftjfnwnK4nvY7yg
	+vYvGVvA9l8VlgsYYQvSZwlvjg4cg8JJwcAl19aaXvx7WCRmhEGlVyvp/0ozKMiix//C+F1SpE9
	ZLtsnIW2Zau2wPHAGR9CYb6tejuvkYwX2O+2lYdnZBJX3NJCUazmXq+Ld0m8spfygHztxCRKpl4
	7/FAXBXr5w8Q2SM1P5vOUI+kIKS584T+XdIC4jhjBdaF7YOl9pzH3Rg/vJCWKYiF3Uk7VbSOJqc
	6PHxVCSisAdRzoU1E7jQ8BASUOB8QOUPjPuXttBl11y1ecCZoHEVseGUCvOu59vMhOcyna5G4kU
	14Dp9YX5Kfg2oWlayJ62UYD9CdxRZeKPQZ+cawuiInuKv1gkaD+CE9IBrAefg8urR54EhyetLPb
	PesIv4Tm1phnnYCknyvky2Otw==
X-Received: by 2002:a05:6a00:e8f:b0:857:72f8:dc91 with SMTP id d2e1a72fcca58-85ed850a6d7mr17640794b3a.18.1788438112769;
        Thu, 03 Sep 2026 05:21:52 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db24f2076sm2868126b3a.4.2026.09.03.05.21.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 05:21:52 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <djbw@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Ira Weiny <iweiny@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	muchun.song@linux.dev
Subject: [PATCH 2/4] nvdimm/pmem: avoid HWPoison flag updates for clean pages
Date: Thu,  3 Sep 2026 20:21:25 +0800
Message-ID: <20260903122128.12264-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903122128.12264-1-songmuchun@bytedance.com>
References: <20260903122128.12264-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pmem_mkpage_present() is called after persistent-memory poison has been
cleared. It only needs to clear PG_hwpoison and undo the MCE nospec state
for PFNs that are still marked poisoned.

For clean PFNs, test_and_clear_pmem_poison() has no semantic effect, but it
still performs an atomic clear operation against struct page flags. That is
unnecessary today and conflicts with the FS-DAX vmemmap optimization added
later in the series, where clean PFNs may be backed by shared read-only
metadata.

Check PageHWPoison() first so only poisoned PFNs update the page state.
Poison recovery keeps the same behavior, while clean PFNs no longer require
writable per-PFN metadata.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/nvdimm/pmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 30a51c365ce8..b14f75daeda7 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -80,7 +80,7 @@ static void pmem_mkpage_present(struct pmem_device *pmem, phys_addr_t offset,
 		 * here since we're in the driver I/O path and
 		 * outstanding I/O requests pin the dev_pagemap.
 		 */
-		if (test_and_clear_pmem_poison(page))
+		if (PageHWPoison(page) && test_and_clear_pmem_poison(page))
 			clear_mce_nospec(pfn);
 	}
 }
-- 
2.54.0

