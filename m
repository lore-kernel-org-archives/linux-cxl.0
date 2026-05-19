Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B813AFD1D
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203425; cv=none; b=cYXlwLyYuXFBcgNqnqpZur3Zbtnte8s2fgwmrUS4oAAZxaqma7FqH/XKtd3SFMSowvZTCsBjSR/EG56hS5rjZJvy6mgBPtGjb1aBlF8s8DWdQxKZkDhyyeY1/Xb/7+n5HIZvkT06RSAY9fVrsYC6asierEgXshoxSM0W9ky0VUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203425; c=relaxed/simple;
	bh=XGcc2JVzH99KOlr4mv66ep9fGd0a2+n6kDv1XuMSCDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXYbjlvJAgB/AAEI6aiXGfpx+nJdlr2ylrwzwej4iFGWU2Kd3kpnnpUPlb61kRCaV0IOqvzCI2Zvk6IEva2481tdjZmRGikHWh7P0E+5RDlmlTuvIvseaSInx6AA3EbTqPeCJM/KZhDXpq1AZhcq0dCSNjerHu5IwnalclihlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1F4C+vB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1F4C+vB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b941cd869cso22245015ad.1
        for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779203419; x=1779808219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNsRRNdoq/mh7bkgCE6Fn2FhIJG533x7ld3bg4XFCu8=;
        b=g1F4C+vByBZc3uB6bBk0PC8Ci3W9cwsaCxmeCbaaOU5I3uYxfjq2fpCJhUS0rzVEKl
         ogS9QVh+czg0OWJkplZRwuaY8tCGY+lDWbKmKp++aoYSCF8pipNxLzW1j6fQx1zNeggf
         PuhADEoDVFTcadtm8eUEICAuL42czVhJlRqGEHyykqPsNnPdosF0Wgk7kSTy9tJbmKf+
         SPD79BKcWFxf2P7GuWWMCYYsZSmLaq0gTStj1S06EdIyahxWnCG5g0yO07NtFeU+ef24
         rZ1kbM2IdAMcV6fWmND1HcWjSG2q34a4gk/LTJGYwPAlekIV8iqTz8FksErhiWfWHrPH
         t6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203419; x=1779808219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNsRRNdoq/mh7bkgCE6Fn2FhIJG533x7ld3bg4XFCu8=;
        b=Mwm6o9TAeIAq4r6PacVzaAkR/JQ+ktN0MlK9DiCnZxICv28kNZwyynpOzVbceKwy86
         yJzgVRBZx+iHwVoytAeAnZnNqQE+90CVc7w/OseZpnpyXvQi9TlqyimY/LBU9bgGfOyH
         dKvQrTuN0eIdctt1I8B/valdVCP1s5J/Lp+k4f9YFXBENSzsZi+0wJRtAmBNX+1B9y4I
         mBp0SjH5GqCTusHTk3RLukDjMHApof4QBeb5mEzz4JaLNrkje3m4CS9LxOmK58Vtd8Wg
         5vS8GW5ruehXw4PtBSL7yO+TnLgXbmxlogZpLMCiKC+l/5Pv23Sb9SGBnrqyFlfyO4vZ
         x9HQ==
X-Forwarded-Encrypted: i=1; AFNElJ/a/Yzbu060QHCH8dJzzfe75InR5VJeax70Q7Gc4xNPTg7SDkz7Yy1YzMSq/kF2DJtddBD+Cedt6Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwggH1frIPP2yff8F8D33+jctmOU0JhrU3rursTtWWs27EN6QPm
	9m4+E60TPtBS0RVtjEykFF0sahUGhkT4SJbnXPHeVW5qQVqIOz9i0tve
X-Gm-Gg: Acq92OHM90q938JwGMWbkYfWagHyEyGqgz9fHyzQmYn0GG9Wk0CFW67RDo94Wl99/1b
	EjcY4wj65TNW8B24xW1A7UwamHXY8f/TETO1U7Swcwh8KXJZz9Q4ipxbQOeJTmJ5l1YT4Z2D4n5
	y7rpNwvlOTMDtGps9d1Up8ZkhFFg/rJN1DdjAJ1jUvsTmeV9mgdleLXWOAykXRt1Pea7q6xygVe
	RFJkywHvzisfPpSbSlD9BPbKqz270hTqlj1UkpTrXdfem30ZeYu851HguUusVl8ugFDavum/Pi9
	7iStWJ8PaCWb4vU+X3poLZlVIV915nOxHHwYVMQW/sH/F2CKJBqCjwMUm1bErZ9jEKH/8h50+8f
	sLtvbRsOi51ju3+YB4ubI8yv5ajVy9Sjg1x3kUDuyCOdQ+owfW8t97rqCb7sjfq7ESPqq2V+Kvc
	gYBX+WPqgLUqNN866bRI+lXh2bPN/iGKN3BGeXbVGan89sAYAi1e+tbe1x
X-Received: by 2002:a17:903:90e:b0:2bd:e452:a484 with SMTP id d9443c01a7336-2bde452a535mr99470535ad.33.1779203419298;
        Tue, 19 May 2026 08:10:19 -0700 (PDT)
Received: from arter97-x1 ([58.124.177.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11ce67sm193784595ad.74.2026.05.19.08.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:18 -0700 (PDT)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-mm@kvack.org
Cc: Juhyung Park <qkrwngud825@gmail.com>,
	stable@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <djbw@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: [PATCH] x86/mm: fix vmemmap leak on memory hot-remove
Date: Wed, 20 May 2026 00:10:08 +0900
Message-ID: <20260519151008.1399226-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_pagetable() is called via free_hugepage_table() with
get_order(PMD_SIZE) = 9 to free the 2 MB vmemmap PMD leaves that back
struct page arrays on x86_64. After commit bf9e4e30f353 ("x86/mm: use
pagetable_free()"), it goes through pagetable_free() instead of
__free_pages(), and pagetable_free() ultimately calls
__free_pages(page, compound_order()) which ignores the explicit order
argument and infers it from the page's compound metadata.

The vmemmap PMD chunks are allocated by vmemmap_alloc_block() using
alloc_pages_node() without __GFP_COMP, so PG_head is not set and
compound_order() returns 0. Only the first of 512 pages of each PMD
chunk is returned to the buddy allocator on hot-remove; the remaining
511 pages stay allocated and become unreachable. Generalized: roughly
16 MB leaked per GB of hot-removed memory per cycle.

The leak affects every memory hot-remove path on x86_64 when
memmap_on_memory=N (the default), including dax_kmem, virtio-mem,
balloon drivers, ACPI memory hotplug, and direct sysfs offline+remove.
memmap_on_memory=Y avoids it because free_hugepage_table() then takes
the altmap branch and does not call free_pagetable().

Reproduced with CXL memory toggled through DAX in a loop:

  daxctl reconfigure-device --mode=system-ram dax0.0 --force
  daxctl reconfigure-device --mode=devdax    dax0.0 --force

Fixes: bf9e4e30f353 ("x86/mm: use pagetable_free()")
Cc: stable@vger.kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <djbw@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
---
 arch/x86/mm/init_64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index df2261fa4f98..a2301bddb647 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1024,7 +1024,12 @@ static void __meminit free_pagetable(struct page *page, int order)
 		free_reserved_pages(page, nr_pages);
 #endif
 	} else {
-		pagetable_free(page_ptdesc(page));
+		/*
+		 * Use __free_pages() to honor @order: vmemmap PMD leaves
+		 * freed here are not compound pages, so pagetable_free()
+		 * would lose leak 511 of 512 pages per 2 MB chunk.
+		 */
+		__free_pages(page, order);
 	}
 }
 
-- 
2.54.0

