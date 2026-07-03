Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0154A0C;
	Fri,  3 Jul 2026 03:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783048199; cv=none; b=AEsCkovnEIgA5a7E0U5iJCAKAyhn7N3G2NteDr/ZLAg+AdY/587CPsOHr5PDzRBKrawzHAe0exfUEaPGt2hvVpMIvoSIHrxtdnB5o4yKh0ffyEZsxDawMr3yBaxAtm9c1qF/r1iCnVr/6+GzlISt/ky59ePPUFBM4lmHsetKTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783048199; c=relaxed/simple;
	bh=wKKA1nDwTINfkJ66Ide2xKFEfYWxr5u7cGdTi6Irync=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4TSN8mWrj9cyxuqTLPKIr8Y5rKoWdSiPkuu1msp9QD6mAD/bsNfwL/ArtTlyxW56lXPBaiyOdNO4qNRj/u+gkAuvRiFSOAB3vn80bgI7jFhH3pshNC795Mofb0P9Y6DBONAjApnwWMz7z8atfFL6uc1lmXH35cZ69rUwfxpmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GvZ8vFTm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GvZ8vFTm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783048189; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=U7uolXzW07Pm2e3aGYT6OhAKNBbvwp/mtfuLmB1Lsck=;
	b=GvZ8vFTm3g7xX0nPOUomm8Ct6G3rRThtwddgHakTzShKn6G9g0G7ginZ9GgILKr4AKkfbBJ0LNwWbHcCN04JBLlAHrTieS2CTBY88OANKF193EcfKyKyDVZ/mzquy3xfiynlOJT139P+TFx+TyU/DZ2F/wsWmnf7Xg8Nw1u5ohk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X6HYWUr_1783048187;
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6HYWUr_1783048187 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jul 2026 11:09:47 +0800
Message-ID: <4c67ac7b-e021-4e4c-ae5c-07bfc0fba9c6@linux.alibaba.com>
Date: Fri, 3 Jul 2026 11:09:46 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/migrate: exclude hugetlb folios from
 MTHP_STAT_NR_ANON accounting
To: Nico Pache <npache@redhat.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: ljs@kernel.org, willy@infradead.org, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>
References: <20260702172548.37075-1-npache@redhat.com>
 <20260702172548.37075-3-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260702172548.37075-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/3/26 1:25 AM, Nico Pache wrote:
> __folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the
> destination folio when `folio_test_anon(folio) && folio_test_large(folio)`
> is true. However, hugetlb folios satisfy both conditions despite having a
> completely separate accounting system; they use hugetlb_add_anon_rmap()
> which does not touch mTHP stats, and their free path also bypasses the
> mTHP decrement in __free_pages_prepare().
> 
> This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb
> migration without a corresponding decrement, permanently inflating the
> nr_anon counter.
> 
> Add a !folio_test_hugetlb() check to both places in
> __folio_migrate_mapping() so that only actual mTHP folios are counted.
> 
> Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
> Co-developed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/migrate.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d9b23909d716..9fd50ea25d2d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -590,7 +590,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   		/* No turning back from here */
>   		newfolio->index = folio->index;
>   		newfolio->mapping = folio->mapping;
> -		if (folio_test_anon(folio) && folio_test_large(folio))
> +		if (folio_test_anon(folio) && folio_test_large(folio) &&
> +		    !folio_test_hugetlb(folio))
>   			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);

Yes, anonymous hugetlb mappings can reach here, so this check looks 
reasonable to me.

>   		if (folio_test_swapbacked(folio))
>   			__folio_set_swapbacked(newfolio);
> @@ -623,7 +624,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
>   	 */
>   	newfolio->index = folio->index;
>   	newfolio->mapping = folio->mapping;
> -	if (folio_test_anon(folio) && folio_test_large(folio))
> +	if (folio_test_anon(folio) && folio_test_large(folio) &&
> +	    !folio_test_hugetlb(folio))

If the hugetlb folio has a non-NULL mapping (i.e., it's a shared 
mapping), we should migrate it via 
hugetlbfs_migrate_folio()->migrate_huge_page_move_mapping(). In other 
words, shared hugetlb mappings should not reach this path, so this 
hugetlb check can be dropped. Or am I missing something?

>   		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
>   	folio_ref_add(newfolio, nr); /* add cache reference */
>   	if (folio_test_swapbacked(folio))

