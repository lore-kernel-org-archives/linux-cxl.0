Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FB2E62A9;
	Fri, 17 Jul 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784283286; cv=none; b=FwvUf/Rk8p1a7sS/gjnYt0WnGcz2pEGvpUFsXTfbDQFnm93/RSAYjvsaP9C/sr9ZS14Tki+E3K7bY/UUvlY+4r+45wxy//kzoCUfWx5YHXrxOY9BgzGQ47t6ZNmYhAIgaUMQ+jil2eHqVBkdL0cbhMMFQCQBo+hwe86NArkWdtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784283286; c=relaxed/simple;
	bh=052OwKUJH39MP82Dql8W8+wvic7EK/0wgC2Ar7HG6dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6wDrzhax+REzjXex5mFAPvUFdglCto+smauCRu0uvEspHjIrChw+aGtkXtk57UaSyYMbBxO1uJrQFDp/IRHeBumI3oZdvB2WNvpGfPLy2p7/fO9Xz8OWdnox3o1iZ6iPoOmbaYYblXmGXX+cGFYgkRSEGV3MZK+Loy+sXXEnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Mo+4dA83; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Mo+4dA83"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784283272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HN8DVK/53P10/O7YFi+DjGcyeRgpFH2mYcka/ASgu1I=;
	b=Mo+4dA83pcmSAKBCAoQWbl9gMKD/l8LUqQbHC5a/rN8mnIaRkHEqso8Jz/4U68kgx+KQlwV2sbGxR/vRkx3XpNHFFQtyLEUZuP35bQrAntlD4zLJPC15eKJLJATpfRainYlo/Ogf8IW7qjD0gCucXOS8m1nk7QweMWQyZ4guNSw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X7H4Mt7_1784283269;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X7H4Mt7_1784283269 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 18:14:30 +0800
Message-ID: <17af25f6-20d2-483c-b9a1-5c89525dd65f@linux.alibaba.com>
Date: Fri, 17 Jul 2026 18:14:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/migrate: exclude hugetlb folios from
 MTHP_STAT_NR_ANON accounting
To: Nico Pache <npache@redhat.com>, Barry Song <baohua@kernel.org>,
 David Hildenbrand <david@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: ljs@kernel.org, willy@infradead.org, Zi Yan <ziy@nvidia.com>,
 Oscar Salvador <osalvador@suse.de>, Andrew Morton
 <akpm@linux-foundation.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>
References: <20260717064502.1980173-1-npache@redhat.com>
 <20260717064502.1980173-3-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260717064502.1980173-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/17/26 2:45 PM, Nico Pache wrote:
> __folio_migrate_mapping() increments MTHP_STAT_NR_ANON for the
> destination folio when `folio_test_anon(folio) && folio_test_large(folio)`
> is true. However, hugetlb folios satisfy both conditions despite having a
> completely separate accounting system — they use hugetlb_add_anon_rmap()
> which does not touch mTHP stats, and their free path also bypasses the
> mTHP decrement in __free_pages_prepare().
> 
> This causes MTHP_STAT_NR_ANON to be incremented on each hugetlb
> migration without a corresponding decrement, permanently inflating the
> nr_anon counter.
> 
> Add a !folio_test_hugetlb() check to __folio_migrate_mapping() so that
> only actual mTHP folios are counted.
> 
> Fixes: 5d65c8d758f2 ("mm: count the number of anonymous THPs per size")
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Co-developed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
