Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224777;
	b=W3JCuQMtkjSs8AuBG/6S5cd06LssXjJ+6266s0VzdzHyJ6eCehdJ5wT7OpS6lgatXRLA
	 yULzEIav2rAJsT7rgb6CmbjcAVqk1PQUXKtsjIbFG+t2w/jdIuSkBROfVYUTKxLI3CHty
	 KibDJNWuQOqY6jaMY6P8owSRuUF+jhMayYDIGHgpNaHXuepz0hkMLt2RiG+9TNr8ou0vv
	 CuohKsmAtn+S4L8axiHrW8EomknF/+d53m+YXHDjlJBO62MtVq5dRzCNTIOw3oQmcaVnp
	 m00BDhT8grQ0RAZYSHX5z3PMRRIho7rC9IhEo96sa61VynkPenR88m/CfF1lmBdCZ7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
	b=e3cQ7ZtbSOV+ZF7mze8uVq7iUbAc3YUbR73PTAkxn4RM0e/StfDIjH3I+xX5w8RWW49i
	 ihwmMjYdvT7xauAXdwiC7yg7tqMHBk5+fw0tAUQPgqyBHbbWZTvUHb4trrDYIDraGwVQK
	 JYGQjsbRrXfUG18xkFf6oePtoBu43kWnmC85nnMBy3+s127C0Wk5ivT+EgELHe8L+B8aI
	 TYkKX1K8SzKiiKyLClo9uq7KvFgAgWIK42jjWyQxDJFy/o5NlZDrKqPxlzJPELXMwBh7Q
	 JJp1D+x5bgg08RnVCxohz2MUdUXCNpfjqj2gQtmaV1ERfP3CcMi24shQYUIX7Nh38Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JJljicIu;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9A606A31F
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 21:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE9A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JJljicIu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93ece7a73b9so157220585a.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 14:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793224775; x=1793829575; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=JJljicIuNc8c1hKynJqXX/VZCOPYs7Y9HJoAynJywjHK2yeTMkC3bqqzE7PEcLPD6A
         4HUuY3A6DGxK7k1KKDC3MjMltOvH2hnz5xHVGlKqKRs2wvllOMfex65kCIfA/Ud5ZuJY
         5CfIY42O8zl11oDwhrhAEk7nqJzdWGVX+xLfyMp3qho/XLR80ZGzg/jLaxW+lirQ+1XX
         0ZSSG6g37QoKqss/2s/69JJbOxfL25oWhGjX4HpEVH8sq12RNIiNqdxzuwAkEH0g/dEW
         gRXP/wSgQ2RAH+S68n6oHVT5kviIDSSPQ6GOz7LUsIw2+RU3+WY/zX965JVoT66OLw+E
         mMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224775; x=1793829575;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=H5Ef9uLK/PzgmkOcVNLKvOYozTbxDsD+OdWrsnsSkXFLd0FrDLV8sMZ4HLhMzSlgau
         WLiQL6oB84SWy6dy8heXJn/3LBrNixbDsZAbiqXCmAYW66Dzwz/a8x4+Nqm54DPEgmaR
         iiHv3KWLuaLHpI/QfSbBfQ1GlhObF0KaIgYFZZTahyK/8wATqGGrwt3dli4WQxrbnWNs
         +d5xAbwxW9UCYb2TK/It98n4Ibt6KUaijMDtIPwpBQSeXFQnG4s8OXSmI/mRgF5+Ys5A
         WK6MEUdo/S56412+/x5U5R/f7mNaz5KB3qAOtlGS6Ny8SzoVmzzAah/GJfwk9CAjPMex
         0XsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwry/76m3qFUoeQDuW1f/oPanKNaGui8VWPcvTtJDu7y3hqZjTO2fZebxQf1z8/Eh8k3d07mDScFsI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPY7/w0QSs0rffDDT79UYPIa7Quhtj88Wmk60aLAASYcDGmTo+
	TD7QDNyLGlaaSX+gP5N7+3wqbz4ytPjHNamSps/LejK/JbT71/Dv+YzEmTl6t59fbuk=
X-Gm-Gg: AYBFou2Boj1xxEiUvPhKLRFcDZXJvWU/OHOHDThRc7P6yTh2et3i06WJrstKvI5QGRh
	R0+VfjKuw/h7N3ncewarsTCGnHmveETV6Kz/SPzmLxG4HLSbheYzS+qsQ/FJFtf+OdEcrS5e+8i
	Q06ArqlkvFG4sA1i5SdfHjBWdXFV/XR+l0wFY0YdxEeeKJ1Ui2sFIOwbZYinuFD6V8+s0L/cv+w
	i59crRcyr08Do5yvudFSaUnLPsbDg+d/3c2/LUm/cR6MdlkRU/V17kAPrO4USqThHBOr/fmAo11
	8wBq3A1L3BY2760xDHokCLY99wCUnIr0mQ3BOwjk6TKzPH+MwKHyd6E4YmAFpxIfgJjVn8febWz
	VpVjdF42BM3MJb0KKVy76UuJ9g34vid9UsL1yNqCY7TEoZfdwUFyejR230CQBDERWlZePNJGmw3
	RV7iD12BsLJwG6HrlUgwmxsuXtg29Z87UFKqZlH1GtDTCqRpITJIC4WJdgSLhu2tjlXyq7wT13J
	rwcb7+QgfKNOtIl+NVRsHhX6Z/TEVmW8QgZP6BiQzft9EXsq0xoNCM/k+mcP6yE5owzVl7i08gN
	BAD5IdFatrbh4F0XL7pdGfU4qZnmtRNlScJ2rvMZjfQMxn9pK6ZDN4BexvHeScJUM9Eoby2OXFm
	v
X-Received: by 2002:a05:620a:460f:b0:93e:ce12:aadd with SMTP id af79cd13be357-94408db358bmr587757585a.58.1793224775119;
        Wed, 28 Oct 2026 14:59:35 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078ba99sm1374978985a.32.2026.10.28.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:59:34 -0700 (PDT)
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
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 17:59:33 -0400
Message-Id: <179322477323.1935969.10540673116963281867.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> If ZONE_DEVICE memory shares a memory section with ordinary memory, the
> section is online and the pfns of the device are valid.
> pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
> the pfn belongs to a dev_pagemap.
> 
> get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
> memunmap_pages() kills the reference first, waits until all pages are
> idle, and then removes the memmap. During all that time the function
> finds nothing, and pfn_to_online_page() hands out the struct pages of the
> device as if they were online memory. A pfn walker reads them while they
> are poisoned and freed.
> 
> The entry in pgmap_array is only deleted after the pages have been
> removed. Look at that instead of trying to get a reference.
> 
> This is probably not worth CCing stable.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

More zone device pfn-walk brittleness :\

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

