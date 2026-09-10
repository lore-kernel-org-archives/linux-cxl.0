Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB633B3BF0;
	Thu, 10 Sep 2026 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026118; cv=none; b=EEgcCiB6lekGcymoEkieKa7lkzVABveQAI4TNNEiCYq59yo8+8wf3ni7DDjKHlRBEE88yPj6X9/VRu3jGpTEwFQb7R1up/D39QXUOtm9mrswddh7Tdm0W3oiddjJfh2Wm4YAvs8KpeHnQ6l61mAExE1FsiJZFT93u+mz6UrUagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026118; c=relaxed/simple;
	bh=j/d6OcgE5rJ77Wx0IDSq2AYxkxUcglWir0NgAe6FXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yf8V7/Usc7bzjd6hDFHbYeDQlzzdNmt2lAG4FQbmkV3GnBcTAWX8JQeFmpdGC6L5Jny1C/5xqo+KcR4l5TXovgMcUeMOeWKhkuiO4VcsaERPBAoVQpj9kMlsxkZHHSl7xacEM6gwTaxkk6dwzkQlJe+L1GO8qZi+iBZB3GQfuzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIOYMzTo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIOYMzTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C051F000FF;
	Thu, 10 Sep 2026 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026116;
	bh=TbT7FCDQfHZUY/cOHp/j6zzLnPdFInAU5COruL2Igso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QIOYMzToUH9Eo1pbBtMqUelPOTTMjxTyDDzKIPPhuOQWhJEpnHinpGRkvsbbmFzC5
	 T04EinRrba8zrJVSMt12llesgPIZLMUIJjGGGRAmj+klX3RqlCBonljOVbRisDbgjR
	 NuoPsrnqvoSj/k94JpbGGbrvhigd6cYfRGzH+wZYs7t1C9B1QuTDehxo8AnsY6JWrF
	 TMswqFv9OCDVEaJxVEzsxMq0hZQqAtMJ9o1GYkklp/aYggTa0B07H7Uf61GJU6isBJ
	 VbR0zkau5VPRH/2Wyrbh20SVH/lOsy54gDsp1QyLrGdYr1B7fesUujY4ROCjlYAt07
	 XLl7v4cYQfJwQ==
Date: Thu, 10 Sep 2026 09:41:46 +0200
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/12] mm/sparse: rename and cleanup sparse_init_nid()
Message-ID: <aqJfOuoUBQ47L7aD@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-4-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-4-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:57PM +0200, David Hildenbrand (Arm) wrote:
> Let's rename it to "sparse_metadata_init_nid", avoid the "pnum" terminology
> and drop the function comment. Further, rename the "map" variable to
> "mem_map" for consistency with other functions.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Yap, solid cleanup. I cannot remember what pnum was meant to be.

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
