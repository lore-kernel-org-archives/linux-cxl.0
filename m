Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794106856;
	b=BGdGri0AJaMJ6Cuarzy25+DFnlUAOgpWBTJbSInaaYR5p+BZfc68iBpiTUBH5fvuyfBj
	 wTTf3Cq8MBpA6c4YIVldN6iLLzdQ2xVrenvllt+mWLEeTxWpEARx/q3B0Exfv9V+Tm7DF
	 J3h4L3ArY2LkBLiZXCvZB1IMGXUlUFnc1svcBcVZ5qwoafSXn5Doq9IHzXastcaqtr9Z3
	 WIHMQRbhAgIhWw8oTNPTAOpRQERdvt8wRZCkukzQh/Fxw1LLqVqXTaoi5f3fBqXUteh0m
	 EK635+ytjNXI1Hg7WoDT2LmZNtncL7TlX5Zp4VtL/2/R9NqP0otaTnNi/4WZV8UK3fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794106856;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=oV9FUG6VESiIfJwch77l0Tjfsp36eT+2bRCqqkXn6FY=;
	b=4FA0EutmPTUFQ1XSgujLKOh2aaTd38ixmUNj9LB6JBKPjbIjUAgCOKzkuAD0rKHayKWp
	 d72HqNc30+6X1zw+es37Nds03heBOcmjGBDdndcoV93+1QpMmupADLTOGvfODec04zUqM
	 3XoPqUvMRxmz7ivK138Sy8Nog5NvuHX3piWfbcnTBwpi7XgvU3xlHXvDj4u5dw9GpUdPf
	 fr2zz/HlYlsH1fEi1CLZ8rFNYod7npeU2vjP0Fba9bMQUwoSPprofjPgSxhkOSXwTm4gG
	 ItZyykfRVRUXQAQ61us1RkkhCzl1SazOmUgUnYMzY9KsYGkXmFsdqk1pscjtKuoo5+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=la42Wdo6;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50A606A31D
	for <linux-cxl@vger.kernel.org>; Sun,  8 Nov 2026 03:00:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD50A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=la42Wdo6
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso67141a12.2
        for <linux-cxl@vger.kernel.org>; Sat, 07 Nov 2026 19:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794106855; x=1794711655; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oV9FUG6VESiIfJwch77l0Tjfsp36eT+2bRCqqkXn6FY=;
        b=la42Wdo60aEv9noJX4RYkrzhWR92noa/K6+aiBlTYklVvFHpGLAE6uS7o1dbj6NJ4Z
         I//CK2o0Gs3vv8DEuPf7hNJUJFwjW6tUwuoQsMT7j82RJ6dFarJjDfmkIKJFZ1ivOwrk
         01luqCDLXt+SaupEkqGupxKY29BH2wXMYUkyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794106855; x=1794711655;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oV9FUG6VESiIfJwch77l0Tjfsp36eT+2bRCqqkXn6FY=;
        b=lVEa3OayST8vDZhmrDSqAzJv+9G26DQc3kQLx+eM0kmnDML0hLyz0h1k29YP6og7B9
         3U5Lw7Y5FjJvmQshcphRmV1cqDkUEQCGaJW9bo6YQOoY+UycuzrvC6Y5KMIOMTAOsw+G
         bbXcK0G8llp02yoCmgJVAeRIG6nSwO+3z6GZd7r8SYstYDxXj46cWhjWqUCFnqB/zPRI
         J76vBNruWECYcdIKouVTgyJYvNK072h2AWDiEi9BFcbgPSUb5gQh0SGVKLcE4skvNHV9
         w3oN2OwX2uze7TkvS8KRl2ZWBcBtc4tWym8MyQ/8xsyA7KqOVebfjNh5G6OwkJRRr9S8
         79hQ==
X-Forwarded-Encrypted: i=1; AL+hErF6hy8Rth540yzKQGFoM/HfX9Nlwdkd3T+Lp2KZKIMkQdNb6BDwD/5wEZughjlCEoh6q9A4yHg6ETQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GecWJq96uTd9pGVgblJoC+8aCwLtMWnCpaZK8jjZTheppyths
	tRsxRy0U95PorS0mWe9t5J1DOJ+cLpalPRsX+MvFpJkm66t5pYblvEGAK4yjAuUKm+w=
X-Gm-Gg: AYBFou3YZhjoPQEF/oFxk8Ne7qh36J58vHX27DlcC5Wp26J1dwN1jW2AI3hoMj9P181
	pRp5ECmnY8OjOTc86AZRJL/tem4Y1YJCukcWSCVftGEf/mCfRpaXR88KPxsPoxaS4SMNjOSZM9R
	v1f4bKAZ3Mr/EvTfht1aiZ6eW3hB4HH2LsZB8hVVqArJ612wx2DhB5mmsWOn/HbGEQENAtr1YCv
	lhhJa95RclDPtV0SFIc0R6+or40iuGq5TJm3j/OKFl+Req6pJsiJGRfe88wxK2rGKQ4dW6/figa
	SEV40pGvrwTlg8fJEzPACcAPpw2PzPx7K8q6b47rxDE9Zm3kvq8Ai64Sdj+USHdKFjhBMh2eR8+
	6lNLKbTI1LJpK0VrhlrDVAVAmBJ3vUnwC3sFGt2s/X7q98xjGNHigCUDWYEo2DpZnKMo3wccSM/
	vOF0gjE4j4cupUsnlI3JJEsj+yUEDCSWY2KB8US+BiAbsFG6wWhl1SUuNOXAaXCjahuIIooLtVv
	KsGBwtAB3RP/fIJlgpchqAx511fDZHEXCGZ4E40eLOr1Yv4FeLoC+AyPpXQN8hEHuUn6Xg6wcq8
	aeakG+J0gbomQG4Hi+Lp1R0ijgPxexeNH5eLfIelizqXbSjIe2f+j6O/g8TBGJ52KR6JxFTktN+
	WVkrbvBNQTumJypWBR8L472ZrNE+eJGxXVbodHgPKO8GFpEbMNJMeYR65zAtN1mglDU6p0QUQYP
	rySLVCLBhW0Gu3tekQInXX10KdtEYkAYKig7DLWZ5GCMtNpmRyeHqG
X-Received: by 2002:a17:90b:39c4:b0:3ab:e588:c29b with SMTP id 98e67ed59e1d1-3b12d0f9293mr422730a91.5.1794106854935;
        Sat, 07 Nov 2026 19:00:54 -0800 (PST)
Received: from localhost ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b127891fa4sm1216393a91.4.2026.11.07.19.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 19:00:54 -0800 (PST)
Date: Sat, 7 Nov 2026 19:00:52 -0800
From: Chris Down <chris@chrisdown.name>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] x86/mm: Tear down the direct map when memory hot add fails
Message-ID: <au_l5MRyDbYfsUVe@chrisdown.name>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

arch_add_memory() sets up the direct map before calling add_pages().
If add_pages() fails, the range stays mapped and any page tables
allocated for it are leaked. A later hot add can reuse the stale
mapping.

Remove the direct mapping on failure.

Fixes: 45e0b78b0532 ("[PATCH] hot-add-mem x86_64: use CONFIG_MEMORY_HOTPLUG_RESERVE")
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 arch/x86/mm/init_64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8b6d86fb5a42..846cb34b38dd 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -989,15 +989,23 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	return ret;
 }
 
+static void __meminit kernel_physical_mapping_remove(unsigned long start,
+						     unsigned long end);
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int ret;
 
 	init_memory_mapping(start, start + size, params->pgprot);
 
-	return add_pages(nid, start_pfn, nr_pages, params);
+	ret = add_pages(nid, start_pfn, nr_pages, params);
+	if (ret)
+		kernel_physical_mapping_remove(start, start + size);
+
+	return ret;
 }
 
 static void __meminit free_pagetable(struct page *page)

base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
