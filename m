Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0A23D434
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 22:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868351; cv=none; b=rm9nm4ZAogHub1yY8BgI4/AaAv7PGYiUvgw+WmJZHqQub6BiUEbozGh/q7PNjW6LAKURV93kBFY7fAyTbyt32Ilkbhe7Yn3+UJsep6f+auqaYaoDBwhc5KEY3VQG1rUfemfKFULPQFtiNGQ+X45YQpxUWSMz6gYNNaGB9j7/LmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868351; c=relaxed/simple;
	bh=NI/VCBA4V00Ps24Jg1XYDOYEuE9C/bHGB4RLm7NSawQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtnRWGr1tZBHYdI6RSvNLU5+VLWcEaHzEStEjY4W/gdH7HN9OrL6J3pPwohuGXbzpWnEABSJ7ADJB2KFn6oQeL1d7GIKsMwnXlAPeNhQFELKocyDckasHrv3RDv7UiLGxMrtVxOQES9CRXQvQR+Kh9OOsnfBfQsDRfXS9DEc61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=m8EdZ7Ew; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="m8EdZ7Ew"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6d8e8cb8605so28604046d6.0
        for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 14:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1733868348; x=1734473148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oErJky2BLU9Af7jLve7daZWId/j12r2NaH/TqvsN93M=;
        b=m8EdZ7EwwcXdGFXJXBPI3dPzzacCNllhO+NMPLSyh0+DKq+Zjt7msnsbUWzoYSkOvP
         L0oRB2iMcGWMfxsVumcowsaaep8TuDD240Ecdzqln+A0sb4I58NdhJZ0d2dyBiuYUl/J
         MrKRwv8zRYHgDRT3Ba0qs+D7/ClCKODnQM6UGtiDKEyJc5t5x/XmKdlNqnCX2pdE/KVK
         0T7EaG6Hih5Hw+oTwTqAcIlh8kE44AsThVAX5wqGx74C879aCxLJGv8BMLM2Ll75cbSU
         6oww03NqRYHfMtn2Qc/j+yyBGZsrYnmi7n7Xzoq4/lrolbXu15ZiAdWLXSGJDcZ3yQX1
         /a9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733868348; x=1734473148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oErJky2BLU9Af7jLve7daZWId/j12r2NaH/TqvsN93M=;
        b=q8ao3s4XoTyWar9Ec5RTov+5oTDRyiM20OPyJIadv2Q7Yh5cR8hb8VuKX40bauNJVc
         vEy+/F3doE3/W0nrA6EBxuwjPp2bAR11fTJt/zbPfnACqzfrJLV8kvL2IGpGw+kQNMI4
         L9tXrDXDrCLinHRJuMoEZpRVlKFsdgY6BT7lKJ+MjF3jTa1Grb6efvjFNa3LpY93R8Xg
         Ms5O/5x7g3HIUpaEnsdbk+UhDmbbn4iFvcDCikS3Ebw74lKap6H8mMhsdpbD+/KxSF+R
         JEBHiAJ6mJR53urHrgEPN6vGTCNxBgu+3RNk3Kocj3zl7YaCypsU0oNDUOwX1p7hSEdL
         HmpA==
X-Gm-Message-State: AOJu0YwDpM8FvYEZJehiU0mAwvcO7cdXevP/wvpZ2nZ2kDxSfH1pAwti
	K2f0Wed6B6IpNUYELHtDZvzdJrxudpwE+CsUoDj/F9ze/hkCPvV0GsG9LL9hktA=
X-Gm-Gg: ASbGncvB2GekWWB3jPdGXFHlK7s/DazZl86BJmgJ8IPLinolBIt9Yf+BvldH+SrcYCG
	lP4gMLy8FOen1Oi9Cr3Gb48otk1/xOhSjFYC00dL00qDVf1NkXJbY9eM531FnPf+qa6e7DHofAN
	pVFtUjknzuyyZchRRB8IEO9o6b8zZIaIKXvAVh6F5k6p0q+G2XlmM9d2YZq0pF6ZeVayhP/p+im
	Qs3/UPKCbLG1TXNc2v5aE46+aMisC8IbCMsXVrLdr7/W+ngNw/y+lwZWz1gAhG1W/Wy9RpbcbnS
	DIaGPwJggkzAWlD4q26wxSQnvd0j4vXg7CTvv2w=
X-Google-Smtp-Source: AGHT+IENYQ0oAKQ+kT8P0UCH8ySBpUYpnMabT5K76y4L5ld+Nf2r6CwojmMzmHyhvdr+kBpYd1jW3w==
X-Received: by 2002:a05:6214:2682:b0:6d4:254f:1c8e with SMTP id 6a1803df08f44-6d934b7cc2amr10515796d6.37.1733868348294;
        Tue, 10 Dec 2024 14:05:48 -0800 (PST)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8eeb132e1sm49707756d6.35.2024.12.10.14.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 14:05:47 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	ira.weiny@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	osalvador@suse.de,
	Fan Ni <fan.ni@samsung.com>
Subject: [PATCH v7 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 10 Dec 2024 17:05:16 -0500
Message-ID: <20241210220517.3744-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210220517.3744-1-gourry@gourry.net>
References: <20241210220517.3744-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with hotplug may provide an advisement value on what the
memblock size should be.  Probe this value when the rest of the
configuration values are considered.

The new heuristic is as follows

1) set_memory_block_size_order value if already set (cmdline param)
2) minimum block size if memory is less than large block limit
3) if no hotplug advice: Max block size if system is bare-metal,
   otherwise use end of memory alignment.
4) if hotplug advice: lesser of advice and end of memory alignment.

Convert to cpu_feature_enabled() while at it.[1]

[1] https://lore.kernel.org/all/20241031103401.GBZyNdGQ-ZyXKyzC_z@fat_crate.local/

Suggested-by: Borislav Petkov <bp@alien8.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
---
 arch/x86/mm/init_64.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 01ea7c6df303..58ace82874eb 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1462,16 +1462,21 @@ static unsigned long probe_memory_block_size(void)
 	}
 
 	/*
-	 * Use max block size to minimize overhead on bare metal, where
-	 * alignment for memory hotplug isn't a concern.
+	 * When hotplug alignment is not a concern, maximize blocksize
+	 * to minimize overhead. Otherwise, align to the lesser of advice
+	 * alignment and end of memory alignment.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+	bz = memory_block_advised_max_size();
+	if (!bz) {
 		bz = MAX_BLOCK_SIZE;
-		goto done;
+		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else {
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 	}
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0

