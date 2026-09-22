Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781945326CD;
	Tue, 22 Sep 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072558; cv=none; b=LRku5kEGB5HxYE3pb/DeT42FksYXSo1hbXiFm0i8IScTBq7nhI/L6z+3LZ3WfxJZ2ouWJgoatirBhvLF6F7rbSz+6AxyRu5K7BgberY5ZJDeIycx5phkA3+kQhHl/xRPxQj2yFApgVj2B+Ev16o4rlsUaGKXQRKYASDT/Wq1x34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072558; c=relaxed/simple;
	bh=R569XAwdmmOiD7erNy5+Hyo0+62FkYyZfHWHrrTjUmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeiE02S7zFrbtBDNjDy/RGQ8xJdVZHUfgdvgqxlGwiniXNllCOmFhaa5n/NtuWY5pfn3IhZqSHCXLwQEmWL0AHe83RXUojl7j8vkIZoVOkjl7ygLYWdUKnGM/77/6WwXDK3P3wqlCXo4Ucl0a56Y73mPx5vOUDTK1vRwgSSKH9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihY+h/wb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihY+h/wb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8A61F000FF;
	Tue, 22 Sep 2026 10:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072553;
	bh=DN0EkF+UVww2zD+JWORW1dS7pehZEzk3ZOGPbCH+2mU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ihY+h/wbIr9rgYOMg9hmVVaut1LOYTuIrifpMlalFf74N6LgXDLXSnn910Zz74fR2
	 LvFYMvp/3j7aVJDQtj/SqNTrpyudQKmeZPHt1ubnVVg+8srIjVkJCENRqEN74MChDf
	 +Ec08GzZgLLY3pq+E3KpbetqEL5kRgkx8VZv+BkAvKLkazMolEzzw3ENwaGK0ZN/tz
	 AQi6pagd6hE+NAy+Eanob4UxWff+yVMYCEpMDHw/ynqWj3Nx7gK6fUJt4gsMZfAspn
	 pRGXUZD2aVt+239kbQMIxpM5SZujE0wc8bFmvhyuw8Cy9lfK9tsbvO5ky7faQZPaM2
	 wFGJ8zpD9PinA==
Message-ID: <53761d0c-e4c2-41c8-89e6-3c9916934c69@kernel.org>
Date: Tue, 22 Sep 2026 12:22:21 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] mm/sparse: move __highest_used_section_nr
 handling
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <20260921-b4-sparsemem_cleanups-v2-0-54d81d65e125@kernel.org>
 <20260921-b4-sparsemem_cleanups-v2-8-54d81d65e125@kernel.org>
 <arIC7BheTHzBnLoq@localhost.localdomain>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <arIC7BheTHzBnLoq@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/22/26 06:24, Oscar Salvador (SUSE) wrote:
> On Mon, Sep 21, 2026 at 09:59:00PM +0200, David Hildenbrand (Arm) wrote:
>> In preparation for removing __section_mark_present(), let's move
>> __highest_used_section_nr handling into its callers. Verify in
>> sparse_init_one_section() that it was properly updated.
>>
>> In sparse_sections_init() we can just set it to the last processed
>> section_nr.
>>
>> No functional change intended.
>>
>> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>
> 
>> ---
> ...
>> --- a/mm/sparse.h
>> +++ b/mm/sparse.h
>> @@ -26,6 +26,7 @@ static inline void sparse_init_one_section(struct mem_section *ms,
>>  	unsigned long coded_mem_map;
>>  
>>  	BUILD_BUG_ON(SECTION_MAP_LAST_BIT > PFN_SECTION_SHIFT);
>> +	VM_WARN_ON_ONCE(section_nr > __highest_used_section_nr);
> 
> I wonder, have we seen this in the wild?

No, it would be highly unexpected (thus VM_WARN_ON_ONCE).

Thanks!

-- 
Cheers,

David
