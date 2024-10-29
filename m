Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4EF1DF967
	for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 20:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730233249; cv=none; b=a+nIpYuFverdWdJN83zxGC8906JC3J3tPhFGkZDLHouUtdmUyJLa+asHRI5M7osNlcW/c5AJQ5QTpaD3TiTr+COVnd/agygYizNSDLJSQA5dpCSf6D8ec/7A0lnRnY2soJs8LFl/WkXu3KkV1ZuiNtMjekB3S5FO6TaSoFDL7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730233249; c=relaxed/simple;
	bh=vp/pABtvn+LXH3AXLSvAztLHPBydYo64dCzxrhZlQjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjEojBui7OeeveZAI8qyvEwt9IsSPYHn8BzmHxTBItMSqmbGt/shd7lyPg9uRPQa0/E6FGJwKa5kZTLQGHwHjUIvXfH+FsFkpd7/kADwbs8vIjAMOrW9anDbyuiGzoS6CZHsXqooGZqHbOeJ3BkJXGD+5ZugrhQjm+tGl0U6t08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ny86Fd8Q; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ny86Fd8Q"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e291f1d659aso6469129276.3
        for <linux-cxl@vger.kernel.org>; Tue, 29 Oct 2024 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730233246; x=1730838046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLCkoovWy+4BTP/Blm5LQHaaqE7ZHx2x3Kcfu38vCw4=;
        b=ny86Fd8QvtRORo3sA0fckv7mqlt3eK7f3AvAa9o5Kpe/ZiN4ojjYXfF1KmT3CPZT73
         mVJTONfIDIPzw3Y0ObR6sc12Ie9nPHeNVyC+NE+mJBWh8zJN51Z95WENFKcy0R9ZhSMF
         9s38Zji0gCdtP8JVsGPBMQrVf6+1OY+tus0Q535p78rG5eUZiwptV3CfNZ18nnUATkgL
         p2x2N4/0pnH1YazRl0lkgDTNn7MGqe3fHXlLKXsm6LO3r1il+mn7U38AnVlWLhmBB2FY
         7n1vV5GoE5d/k+UdkQoj2ZtWy2qfUAIaI7DDget8u7Akym8sgi5X/hKgyvLmX0fBMQQ4
         zl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730233246; x=1730838046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLCkoovWy+4BTP/Blm5LQHaaqE7ZHx2x3Kcfu38vCw4=;
        b=tG8Nm2iT9cNvBtEFJRjBQX9AnK5O5glLC4TOc6qb2v10080MlLoyyWY/7iGouC+Bq/
         TXxMo91nw8xpAsDvWd37NHfn2cvL1Ej8MPQhuox8hA6locWdB7aswiqPPfh1vtiSMNhQ
         ludGmqj/o87OWDphujFfYDrAagKprQwxbecbGUvCLmVfdxfFZbvkVWe0Jfv8umwOzA/G
         lzzYC6Ek1k/KYgSfu7doESn+RoVOSPcXIi73LnuJRkHIOc5tjtdKpMfy4nk8QnsMgP2w
         R4KCdztTq3o80jWGCHv065sVllddx8aQwifBQMLBhIcZRp9C4sEDfjbekvgOuQIUDfnt
         yJjA==
X-Gm-Message-State: AOJu0YytOxsD74H8IdI7+j+REYBcSZpjzcMPlfLFT/C3F4yTVq1TFQW7
	ZFEoz0ueX5EhvtZWhsWVYtRXF3sB+DGeNPO59hzARU57XUZfVRxdptsfEkrkKGs=
X-Google-Smtp-Source: AGHT+IHrVUT2Y/bn1A2eEhZ3B/4Cio2x63OgV+iZejuf4OHZLNTMyIcoastoD+p+X+Hd1T8kconCzQ==
X-Received: by 2002:a05:6902:102c:b0:e30:c8db:34cd with SMTP id 3f1490d57ef6-e30c8db3652mr2549661276.3.1730233246317;
        Tue, 29 Oct 2024 13:20:46 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798bd8bdsm45071796d6.54.2024.10.29.13.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:20:46 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	rrichter@amd.com,
	Terry.Bowman@amd.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	gourry@gourry.net,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rafael@kernel.org,
	lenb@kernel.org,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	rppt@kernel.org
Subject: [PATCH v4 2/3] x86: probe memory block size advisement value during mm init
Date: Tue, 29 Oct 2024 16:20:40 -0400
Message-ID: <20241029202041.25334-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029202041.25334-1-gourry@gourry.net>
References: <20241029202041.25334-1-gourry@gourry.net>
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

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/init_64.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index ff253648706f..01876629f21f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1452,16 +1452,20 @@ static unsigned long probe_memory_block_size(void)
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
-	}
+		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
+			goto done;
+	} else
+		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
 
 	/* Find the largest allowed block size that aligns to memory end */
-	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
+	for (; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
 			break;
 	}
-- 
2.43.0

