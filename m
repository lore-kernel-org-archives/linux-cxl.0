Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236832;
	b=j/LJcB8Q4lq5QG5ULXHr3JAY86RajPSm1znJfQinxzmi7DPoO/AoPvmJh4/Sn8FviiY3
	 uTZjqimYbbxJPqB+avqfxUiP4yBO2iSB0hqdg0300CSCrvNXyLdIKzyaaDYJLTyh5/qG+
	 DhHZCrDQlQDBbu54JfTjMRUC8XfyhXD7LNVaCCDaidqRkNur0EvAI+jHk/pwLMV0/k2PX
	 NNsC2+hf3NzB5Zy97fLqEXgApRqNAcLVf8Vj/NCM1hwUTKM7hQocgWjH+BGEXi+21514J
	 yxHZzDxogQKgMJXp22BtEzVQFW0XAR6J+d9++Mnzl1v3OzNrLk/5IJRECAYiAmSUk/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
	b=DLnTqytD79QUzJztQ9va5pYhKx7vvSfE7ixq2oaY+2m+Lb/Hhn4IW4klJbYkhQth/iTw
	 p/f8JLUkfF6PY0eUvhBAzrVexVBKlVNLdHCRZawq0yci0IEDbA7vfhps+bS/Hh3C0iLHg
	 Shodkz4I/nM6Z/poSO2H8SCB2RbsSNpTOABi+riuhw8ceZX2c3U//vpgvwUwjfVxQSTb4
	 s1CpgJ28BVXSEFNjTM9IV4hWK4uaV9C0hcNRZdVM8dNvRMqkt4+kUPhLXkIfiebVkLsWc
	 WksGRvLGQ5gRtiFNkyBsKHsFiiN6pJh7sfthtCLNpLlJ2dcWbIRPtdEnLOvrtXuBXZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="X0XY/GAi";
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16651606A31C
	for <linux-cxl@vger.kernel.org>; Thu, 29 Oct 2026 01:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16651606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=X0XY/GAi
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b4a13789b0so328117a12.0
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793236830; x=1793841630; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=X0XY/GAiMek/vFbkNlCS++xCJPhcJpRxEM4fx1Ljjv6aCGTfMX2iHg06Cuvz3jbJ3x
         Q0dDwGr1BIBMf5kqCtqsb5bfcPFaFZlUqEnSi6skik2W1J4zJ5GeZ5elYQvrlDRe91e/
         CP3Ywj3kmY6/6N/XufcgSAxLlc+irLxiHwNEWl3k5M1t7aKrd+VArviVR+LRPwX+IZPm
         GpA3SbXg+reoCoke8l+SC4GaT3nXvce2SqP/adtt8ITzlbRj4F9bRx8OgSUJIJiobyeZ
         u80Of7gLVfSgCHHisozRXuwKcVBjIh2eid1AKfwHBlqSo1BxKhOy27h+nd0r4z6VpL4i
         tJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236830; x=1793841630;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=FZQCS5F+JYMmEL0FCIolLArIL6gu7eBmuDXgCHUdTvqAOFnF+he6bcDWTwctd2AAXn
         kUYdq3ogDz5E01M8JoDw5tzAf4wFMMwzQWfP3MerXjIz5u4VhVD8J9Bm4BqhCyYrTCa1
         ldOEczTP2hRWjJvjetbN9R/9eEhauzMTz4IYiisCOSnNoVuVitFobMd5R5mWHkwePoJ+
         LyO7Akiu7zwOtaLZyPfLlTwXtB+KYeOC+vrV+9N0yJCZ1+hbfN7iOqwhiZwD2A2ny/m1
         Jl1L2XI2XwDekD9NcHs5/HIry2A9/Q19uOkzuwQOJC7sikFfiuWrC0fH9//hYKhT4Tkd
         bllg==
X-Forwarded-Encrypted: i=1; AKwUvBxrxPFXTiphfdFsRFLv1Fd4JOxN62rOKCtK5TCuegvEnaswdU3QEMkuRn1wKpCbHG5EqNqwp259ypY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1/0Vw+s3xJiegZZSuZWEufJVXC6FI8DRIqdEZhml53H2kECWo
	Cihjlo6bjaahECY9yyOenIHOs3xz7ehzcbmDDNG5IUHhpNOUylYuJB49C0xtypitVCc=
X-Gm-Gg: AYBFou277bun7Bd2jwq4I7lK0plFzGGcevb8YQ97wsN1lfSWMTSs1xpx8F3tjjjeiZd
	FsTp4uHF/DFFNbXL0Y1npsCRPNGpaKghlhGqsIvhjQOcb804uzg00P6sqfmFFaA86vwxl8SpF0l
	y8gWQuPwiBbcG6f+thdYnSh9lE7FzsDan3vesgKDvuAHIouxaqhigbZiquMdt+RnUj1X+ewr3R+
	L/kSam3f2l0+bG7gnC9VGXK+niIe5YIbEEoYCKWQ7i0u1jlqAawyEgY2wRpVAQBlD3DMcq4uSFl
	0VJAFYYXqPcFKZSFv9P/U5UHfO/wFs2vlOT1KS9lxV0yD+aNkQB35umBLQj8BPH7nRaeW97zER0
	O+tuEa3em2DUe0uqiOitdYuz/6TgpzPtG+f1rpSNNQDzxhvZFIGVsaG68Z81bFGT3DhPRknRQCH
	nsEe58vkmheUCZAUS1rjEXe0xlK/HFJF5NMu/nSEAC2d88i2lLO1tFqCqr/hXKkp5wVrEzATa4+
	6i3qZ1c6WZCDpVXFjmhPTU1hbX4IOdqkVnvtvRRZ0SE7MfRDCzPIvIkU7sBj6L1MU0yCOjC1ade
	CXVj5KdyUqsCZp4UxTTK
X-Received: by 2002:a05:6402:c507:10b0:6b4:8d8e:c5c9 with SMTP id 4fb4d7f45d1cf-6b4b0b82678mr569270a12.4.1793236830233;
        Wed, 28 Oct 2026 18:20:30 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm671275666b.43.2026.10.28.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:20:29 -0700 (PDT)
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
Subject: Re: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:20:27 -0700
Message-Id: <179323682749.453251.17316394789253085295.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
> page table, and takes the PMD lock and the PTE lock to remove it.
> 
> In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
> page table. The pmd_same() check is supposed to handle this, but it is
> only done with CONFIG_SPLIT_PTE_PTLOCKS.
> 
> Fix it by performing the check unconditionally.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
