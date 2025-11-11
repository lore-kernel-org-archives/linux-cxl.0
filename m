Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB17262A
	for <linux-cxl@vger.kernel.org>; Tue, 11 Nov 2025 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822846; cv=none; b=W0mw6APBIiyNlHSPmhtJFvDdW7WwflhSvoKp1CCI7FwxwL7tI3qbrVxstVy7dBykHPVs6rpiiqkF9de0265V+FLqQ7nog5pQa69IYDobs/5rdL5AF5+XgUOTVtkUjlhx6bhS6egptyxAcBctAn8XGWNPh2nlqSCF6ZeZ9EibezA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822846; c=relaxed/simple;
	bh=f+oMxC5qmmdsppFnUbHN3sr50aIBOImrI6V1HFvClKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPNRHL5YBDkPke83lHULHX11sXzPLe6x3qRb0x3NIZZk1sPJ7DDmKfS3z49Gcm4fVe1sdwoSz6k67dFXe1UdsTBOEPVDEJIl8c2MAw7p295NvW8HASQH4SMzPWKVa5kw5V59lfs7Xs1Y6m3aXVL8KBbUj7j0Ju1AtiKRDP0gEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP9bnl4z; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP9bnl4z"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ba488b064cbso2532829a12.1
        for <linux-cxl@vger.kernel.org>; Mon, 10 Nov 2025 17:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762822844; x=1763427644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8DKKG/b2Ml/VevY+oANvvTeILuRGs8NqX1/6ypJaMU=;
        b=AP9bnl4zyLU0x3WDIen49dEdejhXkdervGSedZ5lN7k4pRf81hD9EXtuhMCWdxe7/n
         kHj52UBrTLLY3pV7c/gmTDapGXwrwo+hxwxtJVTAM85KbeNOsr9qrpKlQFrZe0A9qtDg
         fQ3g9WHS7vUa1IS/SwmOPk02fYca9qnA1XSNw/uk5OzxHYLZ90HWaSCRhk9jNR/l98gp
         SQVlkR15pz+Qq9IC3vMkbec+vtH6o90T7B7xFPrKFIw2gT0FisKtEzLnK6nZ+f6Q1ois
         sRIDW5rLDpPy5Qng95lll0QrfVHeL+y4vwpP627at5GhTlGx8G7aJx3VYdkpA88WPljz
         66Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762822844; x=1763427644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8DKKG/b2Ml/VevY+oANvvTeILuRGs8NqX1/6ypJaMU=;
        b=wMc7y3/kMMyadJdRRmiEhFI1GJwHhy4gy5YEIRCf3KxDAENfr6RyoDnn/6JVGv1Int
         x+1YLpwvLMJNlsPUsMzHmLfCsb3dxIF51XrF29hCGRnFp3YIPz5PE3+wlSWMF3G0LdOx
         wYbxBlAi60ctEc7uxLLI2LCmNUh70xjy/HAMnyOT93WkqvIVLpIZkX+LwjaVSXRBzBTj
         r3aTSoeeD8wlvzBmHM63lqmg0/HpKAMV8BxX+GuxhjE0ztReZBrKdZ3/TF4Q+jp/DxBg
         un8vyD+4mo/GzuY/AWW+B/6/oiTOOsNrxP5WLX1T6CfUaTaz+nyxIS+QnClCFIriwpo9
         BeNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpzGSjjX+Kpk+5MW21GZvgOqsSfnkUlHjh07Yu5/KUPtrCb91pleosEhJaV5X1WWI6V4pnc9mr/rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2C0bjfydbrK7Ex3Y6NHwvSq3OS2U/1F5tCCcOoYnqcP1n9Lnt
	GmcNpyFL2vsOUr8jUsUG1SFMSfYr036Q3Abt3fBRKjeHTCfrevVNzReEYIZ7Qw==
X-Gm-Gg: ASbGncuKD3RWVjEVJCzDNPet/34oU/KZDH5MQdKWnnVpLopA0vp9HWMhDg933Oe2N6e
	0bjIIv180ifb4RGrI7SKKXBsQcYx0XUEu4hx5082tM+iNlgp6BKTpw2gJgbz96LMkml4ZFooPx9
	gYD4WW8X6Zx6r4wKsBaubCq8GY0m8oI4EFxjATzSuuZrh6PEO6BaOYsUMGDn/ppmOpnzq3hfUA7
	N0PdzMJFp5IytCpqOYumuF7cumZaLpFyW71C+sgDPfhHjEHh7Z863qWO1LzljDBlQ5KVUqux8U7
	Lew2UJCSwbwE2pBIifkt/PM3SJ1fl71WXmmE14PGNnc8R4wD83o0t7a4l+LP2LIR8QNcbAfkQtD
	XHHwt5kuqr9H+PVF+veflVAYkk4+cXIQrCNXzW8LYXuNzjPrriVFYzjtFK2tj2cc7M37+a2WzuC
	eLwzafLd8HHVLG63XBKJfOzPR8Ng==
X-Google-Smtp-Source: AGHT+IFxgrUWy77gbsunqJhGkWdQe0ZI1d5eQkSH1uE+PZ2zCTXOzCFHVH40iYpbqAAUkEG/NUEFKw==
X-Received: by 2002:a17:903:1103:b0:298:43f4:cc49 with SMTP id d9443c01a7336-29843f4d12emr612625ad.24.1762822843523;
        Mon, 10 Nov 2025 17:00:43 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:d90d:a2eb:35df:9157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1b8csm163515505ad.85.2025.11.10.17.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 17:00:42 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: rppt@kernel.org
Cc: akinobu.mita@gmail.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	dan.j.williams@intel.com
Subject: [PATCH v2] memblock: fix memblock_estimated_nr_free_pages() for soft-reserved memory
Date: Tue, 11 Nov 2025 10:00:10 +0900
Message-ID: <20251111010010.7800-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQo1VjjQw1OZG8nY@kernel.org>
References: <aQo1VjjQw1OZG8nY@kernel.org>
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

This fixes the issue by replacing memblock_reserved_size() with
memblock_reserved_kern_size() that tells how much memory was
reserved from the actual RAM.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
v2: instead of subtracting only the overlapping size,
    replace memblock_reserved_size() with memblock_reserved_kern_size()

 mm/memblock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index c7869860e659..905d06b16348 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1826,7 +1826,8 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
  */
 unsigned long __init memblock_estimated_nr_free_pages(void)
 {
-	return PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
+	return PHYS_PFN(memblock_phys_mem_size() -
+			memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE));
 }
 
 /* lowest address */
-- 
2.43.0

