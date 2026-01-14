Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221353816E9
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 08:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380766; cv=none; b=CLt/+yXeV/yPuXOwfoK8tek8KFTYjrBWlRwXtRUM04yWiDoUIM69yJtIqBxZY2J280z5M+FN8R1KhGYzVwVEvwcimNmayd8Jst6+f5KZNSG/EHz94eUeNuz/6+eYrbtuPt4djKYfl0EAO4HCji111lEYANKvTBcgdD/9VOVAxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380766; c=relaxed/simple;
	bh=cImdW1I8gYlqyptmlVX3KT4VCZEIXu721DnCa4CHzjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQSAdClAW+FsiPvPfw38cm/8rmsBpVATdblu5cQUHDmUUw+wXdGiHsSEGvD79FywrWmAYlaHaTq3bYX1+G+FUYg/7qd1iMjg0Is6VYB/gfj1UzoqnLTaMNLzFEclgZWfxTD8NeHk7UXMnuprxpPjJIA4DlG5+ja4rXkVU14re/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iPb5fm9s; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iPb5fm9s"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-5014b671367so4672451cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768380756; x=1768985556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDpE5wtoJCiMhRN5zrFeLb7soUJCKnfGA3SqaObqP6g=;
        b=iPb5fm9swWgWO2eh1QPvukxqDkxt1UksMJYNDKPobAEXcz20vYs8GKuCoJdaOB/NGL
         TvpEt5m70mn4S2oL/3boWvKZKl1l9ba75iSTe6+g8DibL4mWNg7c90k1r3X+J2HUEcl9
         Al6eZ2h6zVbpDnYUDxLOfoH6QGjgjWtNTg4oPLFPQ1d7QOWz9onp/dTa5qP5NotdLzXA
         0lzF9NDA+xYvKHtohqCXO4UxlHLdu1qyxkSyoHEfvMZ0McYNoH1h0Ris/5P9vDvu6Bgd
         YNp8ZZ1SHZpYXN8dQJhf4B2DdfFzW+BfmbEiSYCdgYItzy8nIXarx52WpOswAHa5H/W3
         53sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380756; x=1768985556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDpE5wtoJCiMhRN5zrFeLb7soUJCKnfGA3SqaObqP6g=;
        b=Q2fDPj4TrX4eQHQ430KI4vVm+WDifV65/3WICjEaYOlM6n1MiWW9xFj3YkrbM3d61p
         UwkLq7Jx3e9QuOt7jWz01shgjE9D+iIWTWNIR8QJRJIbfOqg6MbJ5cwxa2y7tC3VgD4Z
         mx5qcu1Oml2tRwyeipXpl7gVC656lLYMsJRb/Jyfw4jv3QUZwypQUbyJSIz8CqVhjwOk
         n5PUB1qFyR/uMoi7R2BR81Y6uvTy5YGYvTxQqbnv52ytcMgl8parVN4EzzP7TSlyRENx
         b1gI19EhLTrZiOURgoFT6WhtobKPUa2QUbcMGg0lJgxKcIjnHI09rU41I27U+t616qeF
         qbbg==
X-Gm-Message-State: AOJu0YzqQSf64YhmPBy3RpzCP+hQ2BUihSnr6gWEV3bXxdZ5u1ZWcXX6
	GUWaAxNHr9hXoB6j8D7fSZPoPbp8Pq+ITeYFUekg6LDGcSjGGLIrTKivBwTSHZYV/0s=
X-Gm-Gg: AY/fxX7l34D/N/vdk60umS49ThvNU7hz2Bt+y724ELX9lGjp/a5kmozm7+x56KQnXn2
	aSBkcnyud11Ojdjwy9EElZ2rQaVMlYsuTDdlwEH3b8EAXGewpfV0bEazKUgc7nRHqksT9xqK43V
	vMkKTbZ37gNpxNJPf+xGAi/P0ZzFpFTXKGH+1L88BaJ6boQycChlyWnfBPZCGgwYJBTd9uc0FV+
	jZAaQaINXNSCwp8gs3bRm4ghnyYo0APXT4W3HWSJzvfwFPl3NTjFZ4FFwlBzqSs74kBtXNfVjJ6
	coeB5T5e9sHC7U3Sq4/IJuzZ9hLL6lg3E/UPfPtldBk3TvFbqzY8sPrmyxAk4wUT8EscPI8nSL3
	AG4EQzCWuh4pzttoDcsNuZO8LcA7QW6wGVE1ptEBHy9imlmhUuriogbGjJuowZlU/1UvRZyQb0a
	Ms9uLia2YjKFChkvSX//+Ewotg4bbrzpnxgF1+SX09koo56JsIGQAznRhUrkssFkYPEO01jNCr6
	V9VieHk9OH0cg==
X-Received: by 2002:a05:622a:18a9:b0:4f1:ac9c:9388 with SMTP id d75a77b69052e-50148125e71mr26783181cf.0.1768380756171;
        Wed, 14 Jan 2026 00:52:36 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148df8759sm10131931cf.10.2026.01.14.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:52:35 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	david@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	osalvador@suse.de,
	akpm@linux-foundation.org
Subject: [PATCH 1/8] mm/memory_hotplug: pass online_type to online_memory_block() via arg
Date: Wed, 14 Jan 2026 03:51:53 -0500
Message-ID: <20260114085201.3222597-2-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114085201.3222597-1-gourry@gourry.net>
References: <20260114085201.3222597-1-gourry@gourry.net>
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
type via a local variable. No functional change.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 mm/memory_hotplug.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 389989a28abe..5718556121f0 100644
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

