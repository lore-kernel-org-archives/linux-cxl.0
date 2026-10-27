Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072574;
	b=2B+z5obBpDXD9xI/D6rgrwFdor+WRytiKyAjpLWh2ht/+BRahI7yqrRN1/6eIYOTVu3H
	 x9P7b2fF9QPwNVgnHkH6bgsbx+qx1MF19m9jJpJHZTNnnWpXLL9ht7whIxVYXtVHo5/Bg
	 Yj7hBCF+/1vO7c4MtJ5TfsxWT+F4k/292gjhZ3gqi+nSTLpNrfg3QMo/s0ObY7a3XBSdt
	 52NNBT+66BxWyZoizj++6Y4LNTOEQRnLpkZzuoLF0ERyhYFpuSEcx7VrQrTMoSTyuVS3r
	 qrMvCQLOVs7cuUXN3oJtQKJvreUNhNt+obniSYXkafxxDdyIPCjfWYMoPY0wLQ/sPgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
	b=PBAnLoAfD39ixA+ps4YIbaHEz1qfSmgv+4DIDHx8i+0sf7AnTQOlb0+8IQ07gyCX8TTP
	 Coo25R5sL2oa/zcbegHNB6xye3WzYJmtmjz2Qfa9Nc3MhAF2S9pvzmNUwiCSLemSPOxUl
	 na44yKYCDmNh6dFLpIHl95brUHE5k3ujaZuZ6mD6YCrQX6E95cuW1ckmWdQAs3m+OOumu
	 FyJSFNHzr7BzcreJ829kugBd+aoEDK+spSDrhoAAz4zF0AuDvgR7kFIkhRcQOcmwSElpr
	 g9KZB3StugxhrgfWUUsy/BH+8LO//E1ueXiXz+etcyPNE4vj5GyCLxTj5HqIabXeecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA220606A328
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 03:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA220606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=TP6Wb0G9
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so5321153a12.2
        for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072572; x=1793677372; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=TP6Wb0G9zLDqWuDXb4AhwPpwuHlSKdtp7vOXpYDf7eGm1a80xAQ1Kk7a3BAwdBSgbf
         7jIsPCCAndPaIyaXMt1h9L+v3YN04he2Yn/CRRvHVdHgoUlgLlSgwa9hE7a1amSX74cH
         Kwjdvwabbe16pgNJqcLstwt0irlt7+SuIDQSlFjPA8tQknv+O8lFGJzh6gB7RDu1kMgs
         b7Ioo0qZ28U44QqcJ5fTkQnZXkb4QTONZ/A3yzR+1a7MYD/SYCY6zoTd6EcwzJuhItLH
         0B0L6IlHYe4/Vnwr07ZM2/roJJBr1DR/QdSECM7/FpaBVLw/yoke4fT7pykNvEVAzfsJ
         pBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072572; x=1793677372;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AmNHif0hEkmbwEeTcZrwdr+/HB8qgSmoybIARXFX10=;
        b=PO0ktW/NtVvfd712Xy7xR33xc4AWuAwGVCcajzRI6OilrplHXC8tsS5Barw7lhDzj5
         McPrAruwE5M/QDgMRzpNMpGlX0Vb/Pto9BNrbKDiLRBGBNVmvyiLx8oj6HY30ZwYZ7CL
         WJfAz9dVWHaDD+J6/DidFrx835RhtMMF9gHxEfPLkDht34ZHiG82vzJg1kCfQx2blSqZ
         BY9duqYUnjr2Jd42KYcK7ItZdNyXuxNIcAkN+QA4B0R0yBCRCGbxiancSjs4ZPcK6V+Z
         pKwXtuA35BfO5MLUA9iBbN5yJH37s0cpKJvosbKbgRkLxAc06txYNaqSxAuhknTdJSpg
         ytzg==
X-Forwarded-Encrypted: i=1; AKwUvBxNjpCkzIPTG4Z3XsfShRayOHbjpU9LjOC+O/HumdJWpyal5qozPqvYaxr2rH6TDsNKCfViC4tv6wM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWgPH5UFh/4tDMakmp6Whv5U76/pfY9OuDbYOqv9vwDN4Vevt+
	KfyH6tnv4xqyKFBarV/0DjWfd4i6iiIHfWyauG4U7s/kaMLbx6eJHCuqaclHuf+hUig=
X-Gm-Gg: AYBFou0JWec4RyI87sgtS9WQp87Q1dVU+S65MmOHNQfSm3cZcAipy7U27Fbs9z0eULY
	UzhfR62/eXQD4A4VFa3mXqKfj/q88Nc7LNDrzzo1yLoHk5EA208w3/4WFVsxMtOWY7KFqE4RZut
	sz4F9IyUCZ+HlE3Iglk4guaunFnWB89Ogmtx8A3uIto33A9GXpwAmeTT6R5A8URHH2bvMKQp/bI
	CA9MkCut5i6TMhr6zfOZKrgL5D3hBFM2h76sQJcYiR0EUSD+/ebeq0p2W6U1UxD+Ge5xSlkQ4Ju
	6M26jvhDRZAquyJ10/ke2JSngpQenjUtCX0ooAUOA5pAV7vYao+zUuRdy7JUG+Rd9gSsKnFIxh4
	xTwrkk+PYM78OTP2fpJn/Z9786EXE8tylP1OYF9E59ntmb9FlLeCC/oEQHySJ6lzt/ySgnqwKix
	jQVHSnQVBMuZizQ9I/aI+imTLNGlXFdPgoOPD/fnOVTmOHGz7R5cQH7EXYI2e8X89/5Vs/Wil1N
	fRgEyVv2SSCTMA7lEKejoW74opQsZKuGNcs09SXofOD4gPKwfCTpe+OFhnCHv015ZRc
X-Received: by 2002:a17:907:96a4:b0:c42:102f:15d7 with SMTP id a640c23a62f3a-c46bdbf000fmr901757066b.10.1793072572116;
        Mon, 26 Oct 2026 20:42:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4a::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649997sm382056866b.42.2026.10.26.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:42:50 -0700 (PDT)
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
Subject: Re: [PATCH 28/46] mm/mmu_notifier: set ->mm only after mmgrab()
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-28-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:42:49 -0700
Message-Id: <179307256988.1171062.17835586018092384558.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Radeon uses a non-NULL notifier->mm to decide whether to call
> mmu_interval_notifier_remove() when freeing a buffer object.
> __mmu_interval_notifier_insert() sets ->mm before validating the range,
> so a wrapping userptr range can leave ->mm set after insertion fails.
> Cleanup then tries to remove an unregistered notifier for which no mm
> reference was acquired.
> 
> Set ->mm only after mmgrab(), once insertion can no longer fail. While
> we could fix radeon's code instead, setting ->mm on success only makes
> the code more robust.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 3506ff69c3ec ("drm/radeon: use mmu_interval_notifier_insert")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
