Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794641745;
	b=5X4sY2YjnR6/nvVrQEJ2Y9GSvS9wVMZv41owemMjXJC6fpWZ+hjejelQceyv2Og9EZJm
	 3jS8Bcd+s5ASzf3mx8LM+0mUgjfSRi/ipy0D2YKr7xd/iiHYZArt8ojDG1MWzv5/73ebz
	 xpMdXV0GXrQcNXt35nvml6R38GRWTK+gzwgerylSNAvr6E5Yx6xxmXx2IN9gkdW/BQeZU
	 r6h84qFAyM4eiOZGxFsYNt6bfzEanNtzfL+zXR9f2kfEq6DKfbpNzPRhRvrGnM0eoRzzQ
	 NjnsMTOJvtD7FKA9SUZ9lb7VFPYQOmxs0suP707PKjmq0b4WjxgjA0l+eVOmQKeTP5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794641745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cahiVRSoQzf74nfMrEDmS6N07dyHDuJ9YLLjX1noXVU=;
	b=IUaah/IVxyaSJdD4GJnekRIXkJyRHpkHftOXjUIgkM/A3VCYXZnN5dk1iU1Qr4CibUDv
	 ZDFEqhQtY7B6l7Lj+CkLJms+jDUR/Yvfmpy73IA+RgloeikHC6s8WNTIHH1lI5TXlmdjo
	 l8GpbZ5wAvb8TdsGkd0uTzqymG2zgedmiTPTA38aCsI3i1TXNl7gqstcL6AhKWh6U3jMf
	 UOXt4pyMFnXOQk6uxT+GkXcjzove9uM9HTvK9FY+E+Hd2W1Ty1WsEWWMMnykpMcKLDL45
	 H8ojhXGHViyyzEekza8U2rvf6yaNADsQmTO31kMnlIgpiJgI9MaMDuPhy6F9ewNk8fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tHUmCCnA;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07284606A329
	for <linux-cxl@vger.kernel.org>; Sat, 14 Nov 2026 07:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07284606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=tHUmCCnA
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9495e8ae23aso100658285a.2
        for <linux-cxl@vger.kernel.org>; Fri, 13 Nov 2026 23:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794641744; x=1795246544; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cahiVRSoQzf74nfMrEDmS6N07dyHDuJ9YLLjX1noXVU=;
        b=tHUmCCnAIOlSRqPnope6qy/HDBmtp05h3zARNLDDt9oEoYBK05I02mM4Dw+hbkYgdM
         f4q28vLTW7w5KLZKYy+AaL2CQNavoO0Dc9VGMbNZQ3XD5RwHiJmKuu0IzhfyJFzILKwY
         BdGBfcw3Lb0Ms2if9Hwkz4C+9J4YGzhvMGbsk75XJUNWKlIf9iP5iC02SbnLkyzg3u/5
         awiLZJgw54s9niTJeCDEGZcU4MRbaRIAQA7ljcJtGkQhUIVx9SN1VNe/hVQ26D8SEEG7
         60MxCibY6twX5qPfiIQQepeDxTC+YSSHGHtaKj+175U0ZtrLK2c+vNLU0aHXL9kxu2gW
         gjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794641744; x=1795246544;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cahiVRSoQzf74nfMrEDmS6N07dyHDuJ9YLLjX1noXVU=;
        b=rQrSxujsewQv1dz+/eMb8liC9TmYwVA901Q7E9A8pXLDvIfRQcQwOqP6d93zeW8XVF
         KItF33dkcP5zF2lNsrbDD9Aj0/dVrvRXdN47QrLtX+6+FRJHx/K6zKSyDNbIK2NHejB9
         R65lPFJx3YHGBIFrca34u+D1szudjK/sdCVKxOi3ixda88qGQMM5HrQPFBTh/XdObmZg
         3Pzd5Y0ZK+1bgsOeu9rLJu66EOg0oyOcQW+5rKGAXSK623jxx9MRVyQMOXRMOmXfOr1g
         0e+6hRQARxL0xcnaOWUXL3/QuD4dy6+OvLEv3xO3sjWSVGl5OK2pNXFkpPlgKurDqrPO
         Y/jQ==
X-Forwarded-Encrypted: i=1; AL+hErEUOGaTI6WbekaQDORz+1MTohJNYOQTvrmTL6vkdqMj1F2bcwxOexCzIZtNYOAWIGa6lq2DdwfOM2g=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B+YGXgj5+c5zE7Jn2+hcT/XemhwR9W1m103nhZ/urcT8O16NS
	gDB8nzKU7hJDt9IlKDwC+T/pD3+58xtsilLqs3eExbYRcOazPWt8BSycgbN/2Qbgibk=
X-Gm-Gg: AYBFou32fR6bXRLskJ5mZGU9zrQvruixgFA+TTunfnLCti86Fr4F790HInyWCagEpkd
	n9L8YkuTA2YeOGiDZdyF8ve9D3VCsXdJDry3hlGq/t2VH13B1S9UNTiZMer8w3UahYaY6W5Sg0+
	sF7Gcdl9/T7HFgJWHOrrfc571tfSsNcONWFrztS588SM+GECC3npyI1AO51KmDLEpZX3to4wofA
	r78c8OSWXtYRIHj6gzbXAeP/BY7Ju9K8A0J7FLSka6fcyVDHj5ICUMlpDRg48uhWo1bS/mt/SDL
	RcM/o0YLBDLQG25+zQksMSEq8YEuCHYgqDnXoocwybaH+suN25ez0ibforHlVfaAKMd1WeOeUDg
	zzvUK8wxlob3MkghG//Fbv4dpf1UFdr7CJekYvkL05JOmx3NQgBvkOX3wb2ez9gyXIq7m4yKCrC
	+ozzETK0Snxun1zxpuL7XWMloe1z2q+Wj8LGwI+1GQbBtXW0rDTH4hPqusC7viu+yNpm5TFB/an
	tNr6Rmn9MJuxHLXSxoSZK0w//IvdYAdC1RbP2qMUvYSpxSNSAfOls1ocsPgnm9sfBFQP+wyLPzj
	WCprhVVlr7I9lUgtM5iJkP3Oo69u2aFwZgE/9aFMIN7NyjTnWmrzWuohA3QmyeMOO8BN+xFq1mr
	Ax0GIIBU=
X-Received: by 2002:a05:620a:a00c:b0:949:6193:acc5 with SMTP id af79cd13be357-9496193b1f6mr334016685a.74.1794641743958;
        Fri, 13 Nov 2026 23:35:43 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c803ad1sm357502785a.12.2026.11.13.23.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 23:35:43 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 10/22] mm/khugepaged: restrict collapse to common
 memory
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: sashiko-reviews@lists.linux.dev
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org, 
 kernel-team@meta.com, linux-serial@vger.kernel.org, damon@lists.linux.dev, 
 linux-cxl@vger.kernel.org, akpm@linux-foundation.org, david@kernel.org, 
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
 mhocko@suse.com, corbet@lwn.net, skhan@linuxfoundation.org, 
 rdunlap@infradead.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
 dakr@kernel.org, johan@kernel.org, jirislaby@kernel.org, kasong@tencent.com, 
 qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org, 
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
 baoquan.he@linux.dev, baolin.wang@linux.alibaba.com, yury.norov@gmail.com, 
 linux@rasmusvillemoes.dk, pavel@kernel.org, lenb@kernel.org, 
 hannes@cmpxchg.org, brendan.jackman@linux.dev, ziy@nvidia.com, 
 sj@kernel.org, muchun.song@linux.dev, osalvador@suse.de, 
 nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, 
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org, 
 xu.xin@linux.dev, chengming.zhou@linux.dev, joshua.hahnjy@gmail.com, 
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, matthew.brost@intel.com, 
 byungchul@sk.com, apopple@nvidia.com, rientjes@google.com
In-Reply-To: <sashiko-outbox-214261@kernel.org>
References: <20261114070959.3490008-1-gourry@gourry.net>
 <20261114070959.3490008-11-gourry@gourry.net>
 <sashiko-outbox-214261@kernel.org>
Date: Sat, 14 Nov 2026 02:35:42 -0500
Message-Id: <179464174225.482102.14033958474429517565.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-14 07:21 +0000, sashiko-bot@kernel.org wrote:
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 4bbe319ef86fa..b4bd29f25c145 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> 
> [ ... ]
> 
> > @@ -2741,6 +2741,12 @@ static enum scan_result collapse_scan_file(struct mm_struct *mm,
> >  			break;
> >  		}
> >  
> > +		if (unlikely(!folio_is_common_memory(folio))) {
> > +			result = SCAN_PAGE_NULL;
> > +			failed_pfn = folio_pfn(folio);
> > +			folio_put(folio);
> > +			break;
> > +		}
> >  		node = folio_nid(folio);
> >  		if (collapse_scan_abort(node, cc)) {
> >  			result = SCAN_SCAN_ABORT;
> 
> [Severity: Medium]
> Should collapse_file() also check folio_is_common_memory(folio) after
> locking each folio, matching __collapse_huge_page_isolate()?
> 
> collapse_scan_file() drops its folio reference on each iteration and
> skips missing page-cache indices and swapped-out shmem entries, and
> collapse_single_pmd() drops mmap_read_lock() before calling
> collapse_pmd() -> collapse_file().  Folios that are faulted into holes,
> migrated, or instantiated by shmem_get_folio() or
> page_cache_sync_readahead() on a node outside N_MEMORY_COMMON after the
> pre-scan will still be isolated and collapsed by collapse_file().


Ah, this is technically a pre-mature report, as this is an unreachable
condition at this state in the series.

I do already have this handled in a phase 3 commit where private memory
becomes migratable, but i suppose this check could be moved ahead just
for cleanliness.

--

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index fac314b89a234..7a69d6e9b42bb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2390,6 +2390,12 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
                        goto out_unlock;
                }

+               /* Migration may have moved the folio since the scan. */
+               if (unlikely(!folio_is_common_memory(folio))) {
+                       result = SCAN_PAGE_NULL;
+                       goto out_unlock;
+               }
+
                if (!is_shmem && (folio_test_dirty(folio) ||
                                  folio_test_writeback(folio))) {
                        /*

-- 
~Gregory

