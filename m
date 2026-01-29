Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2EC35C198
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720696; cv=none; b=csFwUfu7JGxnreSvQk1IsY2/t9AdHhnmf11b0vLszQ3/TjzC0rac+HyPd41ICvY7MkYNSDC27C+JDcyXMbFUfpWHVkkRCxifnTvnRQEqpgFVOlUP7wg1HrvpA3QbZfv364z784nBUnxl1rkBAqvncU9YcnigBvSFYfeuEPF6zxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720696; c=relaxed/simple;
	bh=V3jcetw4D8mN0UQEcroE5IaVeGXsJTloPdOskFdLl70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkx0mCaPAsvdxbD1/6IvqigpUtu9EOTvNmRVIilLpF66lzkQT/Q1OGSZYTC7wWKIY2cdgnKWwGTU6wsKs4P9xzj2EnjoU6uhnjbgwxVE9cMcSnH31TKMRmj0bdUn9LSbc/nT0ZNuyklwswedkETczjL28ZIq6/MnihcePwrgsCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qC+QQ2Bf; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qC+QQ2Bf"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8c52f15c5b3so140033085a.3
        for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769720691; x=1770325491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFORCx/4rWXlwM5MWzZ4y2ZhtVTmicaaxzmL4W2ym48=;
        b=qC+QQ2BfI5LPjX/qao3rzwQhsN2mA3Hl5tspU/p8ra1TKa08jShwmEd13jhZBGrJLT
         dC9WoER48g/QzZ3u68huExwm8c/iX4Qq/q9AuqFSw0t+22UY+4bKmw/8vYVjL59dU0hq
         sgMPKidtkVAzGkUvSQOMERNFdcHFdtglcIPWxebfBSvbHamvffoUJdJmm0CBarsOPh7u
         VzuZwq5W502DJxVv33LFq2/tGFxwwI2FAe3JRIMwS5D1i9qk1vLoTdTJjOFaAbl1NFEx
         z+a2EBi/qNQ1pO14qLwlKxAL9x+zGT7QEPcCUe3V3NxbVbx2OlchfR695JYBppJUGp0Z
         vMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769720691; x=1770325491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jFORCx/4rWXlwM5MWzZ4y2ZhtVTmicaaxzmL4W2ym48=;
        b=MSCDGxP5zwo2Lmwfr2QH/zBgD+9myMvwZg1iYgVBN2jwDS7kwkIOA5hSSmGW61ccua
         a90F3XMw6kFpAEe4w0sinFrcROPgNuaMFfu+OkzLmkCsDKeH/EZoLe+Ly+svqutXw0nB
         KlcxW1aw1msKpAYWs2KGo+08J4DzbO8tFBOdy1yZtabfj1Dgux682Sw+DhoDGZ6b2//o
         79L6/DV5ypgvxd8pSsL7AKjYS+vpUy0Ujtw4z/ccJTlGBG6TRDzOQ4Mjwn4gksA3zgKy
         eImK/jDo+uJS5XRm9rbZgpVL/dCUKQznCvGUxSvozY6j5DrmkM8YzecxIXAstfZJedpX
         S3mw==
X-Gm-Message-State: AOJu0Yy2DyTinD2yAOUcSv8IK/DU8lVZlLfY4snDAXYOeJI5jjIdBbLj
	A4M5m1+UEXdXpatVecOjn9UqQ5hEhRzfOE97YeIGac3RsjZKXSsjNsajk+lItVaxyqQ=
X-Gm-Gg: AZuq6aKlbo5xxkUbtQ5iMALj3Mud47wb7D7txTVrTrKVTEu+1g5L/1Us4IXAyTOyjG4
	SdeYDf0Q4c/q8xeOe8okBsbkBQRN9EJ4TIS3proNt8Z9m3o/KyefjjdEeobPUF9v8u/5HBuaro3
	jdVYpPsTfyO7JEiFcuhbCEll62S9EpKAzss4tQVGaiUtlpECG+eh32Hx6LSyEbG74FWYwM4HqpN
	9Y38PuPI8fnOxF/jwzu69BOCJDQiVCnuRtwtN4joVEhUZJgKQIIKeLv0jIjmhbcsE4J+GEyz/Ii
	s9pFmYc3x+pd7MZVSXR5/hzx3IYw1LGB5hGeS2J3BUQrCszNp+HT3WQ8/MdA1/OcMM6xJ9+c2ym
	t5XyUdK9XpTXsXbyVc1mmt7yOtY58xbjv9Yoj7WG5Dn8AcoD9wSg0opPAVBle+bQeMBIva6C0LF
	wcMoCkUkan019bdh9w1JQ5Y8VNM9eLemxSkzvs7JpAS/yWKCM0jKqI+Zk0XjihgLvZ6XU0gcSCO
	00=
X-Received: by 2002:a05:620a:298d:b0:8c5:391f:1db7 with SMTP id af79cd13be357-8c9eb3119c3mr144724885a.64.1769720690713;
        Thu, 29 Jan 2026 13:04:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c71b859eaesm282041685a.46.2026.01.29.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 13:04:50 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz,
	terry.bowman@amd.com,
	john@jagalactic.com,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: [PATCH 1/9] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Thu, 29 Jan 2026 16:04:34 -0500
Message-ID: <20260129210442.3951412-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129210442.3951412-1-gourry@gourry.net>
References: <20260129210442.3951412-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify online_memory_block() to accept the online type through its arg
parameter rather than calling mhp_get_default_online_type() internally.
This prepares for allowing callers to specify explicit online types.

Update the caller in add_memory_resource() to pass the default online
type via a local variable.

No functional change.

Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bc805029da51..87796b617d9e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1337,7 +1337,9 @@ static int check_hotplug_memory_range(u64 start, u64 size)
 
 static int online_memory_block(struct memory_block *mem, void *arg)
 {
-	mem->online_type = mhp_get_default_online_type();
+	int *online_type = arg;
+
+	mem->online_type = *online_type;
 	return device_online(&mem->dev);
 }
 
@@ -1578,8 +1580,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		merge_system_ram_resource(res);
 
 	/* online pages if requested */
-	if (mhp_get_default_online_type() != MMOP_OFFLINE)
-		walk_memory_blocks(start, size, NULL, online_memory_block);
+	if (mhp_get_default_online_type() != MMOP_OFFLINE) {
+		int online_type = mhp_get_default_online_type();
+
+		walk_memory_blocks(start, size, &online_type,
+				   online_memory_block);
+	}
 
 	return ret;
 error:
-- 
2.52.0

