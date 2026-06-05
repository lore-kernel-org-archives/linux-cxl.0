Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D298F1B78F3
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694363; cv=none; b=E4LJ/CMZCLGk6TrTkxdcoatOlXZLggUSoDhdbM9BEnDnnNIanEdxpSRf6Aqyn8V3EfYzHlv6Zuc/ut593ABc2u+aLq57seehR14zJkAaHpPjICmdLmZ/xUgPZ/OBsTwWA5VYoohEqPE+IZ1nuE6iEwusO0z1Zl26SSyD85s0xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694363; c=relaxed/simple;
	bh=bzVWvGN8pdlnq4o4z+hOySj1+S3a7FDyojT5FT1eDQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AA8lkhYNB/RvF0GsdqyL2u6j3u9ql7EryRDZnlXLiR0vpjKr/93vEf+kQUoHv3AL8SoeBDn1Kt1wsoqNRvv++/aU8e6E5ukMC6q1x1OkeTPzyHGo9SQrxDE8TJyUtZkCh3LK8EiYbEiHvzLLUVsZve7VEY5zeaXhY+LyGirigXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DBqwXdKD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DBqwXdKD"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ce9df4732cso23917506d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 05 Jun 2026 14:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1780694361; x=1781299161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oI6t/rke/+VLpdgjZBrnvU5+vhrLOr9MvTf8Ltd88rk=;
        b=DBqwXdKDGR/NQdBlrfv3MPd9QMBTY2A+Y7akFU/4a3MLfzt2jYu42kU2Qnuicz7GLZ
         8yGSQ+WXFpGMhYrX2rl7rNa2BTWwZONGQnwK5CO700XOZrDMk91Y1lJBO2lgyFqEWtUb
         cveYtRWLmNgnhtM3NfPhwxTpJssojY0fPfbmnd7u2h5o6pED2VhGJENyDw0VCBuK6GRN
         4cd/0Pqzq8OteqjVI5pRhCxRoTi7fwbaG2x1qRANKjurfjRSGxnJa2sDi+AEp9VHg2+H
         /18px/uZKZ97nAl9TUWq3mEkCTuFPBqWmVaB1MRfUz5+tKRob0VPDMQo2Qcxd5h7k6eY
         zChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694361; x=1781299161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oI6t/rke/+VLpdgjZBrnvU5+vhrLOr9MvTf8Ltd88rk=;
        b=Q7dHMM+92jzlhe8Y0cphoq0/qcmZZiQduhiMyzF97+f5vzLVbmeFRG3FAScjelqux/
         DqYzFRSi3cJq9glTu8TFZDpUGvJfbshYMxU9y6Zzdglofq2McGmYVQC621wpXujZUyyu
         Hquh6Or6rR7m2HTdb1IYB5JLey2x5tWXVidPem+BqCTIQCVaCFGbkmpVYSclyvsEX4PB
         RB3IaRKFtu576hy+bDyp74pA2hZvL2Kk+4njAJjmmfrSIIbPdUUeA+BR+KcC1L5cs4ne
         1SFN0/e27XUmcobJtp8BVbO1lq5D1YLSerkQcixxV/G8eYh+OGIhWQeoqJCD3NdtAeIU
         tJRw==
X-Forwarded-Encrypted: i=1; AFNElJ/8LtxL3LhuFoAQVMUp5hZNLNKoQ+FQmwljYkTlVBEqyGwRYjdums0SLzUdsb6TJiQY+3ZkOO/bnnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7RWxL1Wuo73IkBMNiPI2o43Sgfi+jFLvpDph9JRKEurwXqMa
	XhtzvSh53L5UvSrGTbb/4N5+HXzGYBHY/yccsA8DdTjcBmhjNws72smCJl1sTXriJuE=
X-Gm-Gg: Acq92OEikci2QjBprUYlXckcENUvUG8M89swB7syeu6zgacoTvQjWaqGmkiFjhoKWPr
	531qFWVrOmV2GSg+w3rKjjvZZR7ah3tYtF5CNpWMBP6yVErQhN1rVejKLToXcnHxLMPiCd5XogL
	YI6Z+YIvRcH+vR5F8k3zflqcW0fxplIviaiknBnvKKZvUAN/+/OcXTrTULTSWa8JLgmNcO8WFgy
	ZiaBvER6FlakIuAnkKsj97CkJPKyvwjcTaalUoo8UwxigP5um+XDuq4ykSXRyo0J5LRfOcxRH7r
	YOmTuEUwr87TdJKzw/gqVX+8QJ98P54m9/sUVPkN9XVsuICIJPzUjsfe9XZlNTExML7iD5+WPFw
	4OvczEWuo4YoVhriC4VnRAy3xcGc1J8oOYCHl6EGB812HlcVio9nKK3y1616FkJC63FZAOw4Rmx
	ieEKAuCgypj1VZcSaMx8nZBA4FfySWVdndf+2uB+JCwV3xgM6zp4kswxYfM0H9AWBOykUEOvXEq
	yHa/gKkZoO1ZCVMZkOtMmLXCLOq7zrNEQ==
X-Received: by 2002:a05:6214:53c4:b0:8cc:e8f4:1630 with SMTP id 6a1803df08f44-8cee614991fmr103632176d6.30.1780694360689;
        Fri, 05 Jun 2026 14:19:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd277bbcsm90518196d6.49.2026.06.05.14.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 14:19:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	nvdimm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	djbw@kernel.org,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	shuah@kernel.org,
	gourry@gourry.net,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	ira.weiny@intel.com,
	apopple@nvidia.com
Subject: [PATCH v4 3/9] mm/memory_hotplug: export mhp_get_default_online_type
Date: Fri,  5 Jun 2026 22:19:05 +0100
Message-ID: <20260605211911.2160954-4-gourry@gourry.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605211911.2160954-1-gourry@gourry.net>
References: <20260605211911.2160954-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers which may pass hotplug policy down to DAX need MMOP_ symbols
and the mhp_get_default_online_type function for hotplug use cases.

Some drivers (cxl) co-mingle their hotplug and devdax use-cases into
the same driver code, and chose the dax_kmem path as the default driver
path - making it difficult to require hotplug as a predicate to building
the overall driver (it may break other non-hotplug use-cases).

Export mhp_get_default_online_type function to allow these drivers to
build when hotplug is disabled and still use the DAX use case.

In the built-out case we simply return MMOP_OFFLINE as it's
non-destructive.  The internal function can never return -1 either,
so we choose this to allow for defining the function with 'enum mmop'.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h | 2 ++
 mm/memory_hotplug.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7c9d66729c60..f059025f8f8b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -316,6 +316,8 @@ extern struct zone *zone_for_pfn_range(enum mmop online_type,
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
+#else
+static inline enum mmop mhp_get_default_online_type(void) { return MMOP_OFFLINE; }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6833208cc17c..494257054095 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -239,6 +239,7 @@ enum mmop mhp_get_default_online_type(void)
 
 	return mhp_default_online_type;
 }
+EXPORT_SYMBOL_GPL(mhp_get_default_online_type);
 
 void mhp_set_default_online_type(enum mmop online_type)
 {
-- 
2.54.0

