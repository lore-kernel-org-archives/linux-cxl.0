Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AC1DFD84
	for <linux-cxl@vger.kernel.org>; Tue,  8 Oct 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396054; cv=none; b=TNLqo+SPzrTIa03nLKp/hZOLFViWlsv5LaQCtyoZ1ytj4L1vJGxgLpgBlu7zLihzJiBKTT3YXJ2kta5xu/gefvmdrKqi/DI/fT4EopPVTWZh1mFXwepOiYkHQemHmX0ev6p8ecwcECkHs5F7eEEjsCqDH4mvlT3e+3oh2PNpbUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396054; c=relaxed/simple;
	bh=D9ssUjGQ6h7QeJF1IwpdOtgRJ/SdyRy/lVBrG03bkKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2uJoy6tMabM1O0e3MhRxspw2dkudSDlWbANvt+mieDVTTct8i/P0Xt7vyKKKTUxEJeqxf1lxdZKMvHTgYFBCFGGbkNbsM/eSMzR+WolP9UUOexTEIpOiPoYBcIDLEjqFqrAxQa8kt034n8owhsfydWm8SNagp3pn3jF79+ySBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=StN/9/9V; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="StN/9/9V"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cbc7c77c99so249436d6.3
        for <linux-cxl@vger.kernel.org>; Tue, 08 Oct 2024 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728396052; x=1729000852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOmfBB2o+BmwtYmn6lEeWqW0gfRN00aP7+NLXlUlw00=;
        b=StN/9/9VHUbqA+DqeHGKDKHwt6Tsn/zsnYDAfaM8fwy3k1NlJIgr/Q9LzY0ZoRNyXq
         +uMPnOBFTgKREJeABH/Ls/dKUkbsRLvsp5u57mnOTSd+WmANTIwUJSU9/cwt8/TkUEm9
         8UBlw8NHNliC/5UQPovW+V33uUdJ73g04pTLC85V0HkT2KBIkxOEhEDFU50ataaOHFYB
         B/rkDpnpdrAUUCPx5rQYvweU2utBM9qTOcXJayRmh1aH+lQD2RcDsC5/b/0apCqRf8TB
         elOmMdTbePZRr8x8/8cxOv6EVP5RwnMzsKreKWtQcwlL6E49h/krnxfDcw847ZB2UP/m
         JtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396052; x=1729000852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOmfBB2o+BmwtYmn6lEeWqW0gfRN00aP7+NLXlUlw00=;
        b=Z/F5z0ppvWZanl+vrumTFb+G9LAzB+wf1sMegoNuUgoTKgRjy4JEF8wSx3/540S6Mv
         0Fl4ssfGol1w+j2esDbtM9ps6TRoIeVWrRzt5+JPvNLNAsohaUhmykFLphGHHlpoba5q
         kscST7CN439c05ov38cqcOnG+nw3HrWyj8SgHXR8JbMl7hfc1E1ec0tMSDS4E8MHHmtH
         ekM1QlU2DzDF9D73c6NIQD8w09RuxOaHvinKCoX/O5wsYa27PAXJqla5ir4HOn6kAk5i
         ZDhkToIRGy6hAlIn9p7gyXpImFNR9TT+bfsr8FDECAhq+19QS/UkBBh2BY4+jlLhrsF8
         rUqQ==
X-Gm-Message-State: AOJu0YxOYncJewlKATpUF/sFb9Kr2+Ogz981TWJlV5bWJHf/sBIYPtAW
	nrYUyh3oCC1nC0sZp8Ko+IXnkNC8120BKqfVcr4d7TJ4nFpOZz8AMonlLNDnHTKl/nUq1LRxJNc
	V
X-Google-Smtp-Source: AGHT+IHe1DIW8UN+mP+xqS2Oh3mXbQusW6tw3/R+BVrHed7J8ntdmkY9QJ5q2+XDvRLblwgEqMcXNQ==
X-Received: by 2002:a05:6214:3b85:b0:6cb:c745:4f44 with SMTP id 6a1803df08f44-6cbc745517dmr10453496d6.26.1728396051760;
        Tue, 08 Oct 2024 07:00:51 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc78650efsm698396d6.39.2024.10.08.07.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:00:50 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	david@redhat.com,
	osalvador@suse.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	alison.schofield@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	lenb@kernel.org,
	dave.jiang@intel.com,
	ira.weiny@intel.com
Subject: [PATCH 2/3] x86/mm: if memblock size is adjusted, update the cached value
Date: Tue,  8 Oct 2024 00:43:54 -0400
Message-ID: <20241008044355.4325-3-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008044355.4325-1-gourry@gourry.net>
References: <20241008044355.4325-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing CFMWS, we need to know the currently registered memory
block size to avoid accidentally adjusting the size upward. Querying
the size causes it to be cached in a static global.  Update the static
global if the value is subsequently updated.

Print a warning that this has occurred for debugging purposes if
the memory block size is changed at an unexpected time (post-init).

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 arch/x86/mm/init_64.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 6086f99449fa..733dfa899232 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1424,6 +1424,7 @@ void mark_rodata_ro(void)
 
 /* Adjustable memory block size */
 static unsigned long set_memory_block_size;
+static unsigned long memory_block_size_probed;
 int set_memory_block_size_order(unsigned int order)
 {
 	unsigned long size = 1UL << order;
@@ -1432,6 +1433,19 @@ int set_memory_block_size_order(unsigned int order)
 		return -EINVAL;
 
 	set_memory_block_size = size;
+
+	/*
+	 * If the block size has already been probed, we need to change it.
+	 * This can happen during ACPI/CFMWS parsing, since it needs to
+	 * probe the system for the existing block size to avoid increasing
+	 * the block size if lower memory happens to be misaligned
+	 */
+	if (memory_block_size_probed) {
+		memory_block_size_probed = size;
+		pr_warn("x86/mm: Memory block size changed: %ldMB\n",
+			size >> 20);
+	}
+
 	return 0;
 }
 
@@ -1471,7 +1485,6 @@ static unsigned long probe_memory_block_size(void)
 	return bz;
 }
 
-static unsigned long memory_block_size_probed;
 unsigned long memory_block_size_bytes(void)
 {
 	if (!memory_block_size_probed)
-- 
2.43.0

