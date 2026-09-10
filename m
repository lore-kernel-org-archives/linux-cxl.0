Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81453485924;
	Thu, 10 Sep 2026 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042568; cv=none; b=Jqp4fAwkw6jYmfmyebiiPOvX7obrUJZgbdhIbV+bv2Qoiv/BEhnLz9/16sGDbPu8zYnlzzkRrnmHCGgYGA8CnjsN6qNHxf1cbvehNwynvvVtSy8OTAfbZ59aW0UQOKZJzGY9zLL69CoLca+uH3LjoS1eny3SjTIkQMx43WC5It4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042568; c=relaxed/simple;
	bh=8337w7/Jd60S2E5ez7imYMouEYiIvgs86bnRen6fVGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdhgsT3hQklu52aI7Bx1GJoKaZAlz00FMrdLfpKq1QlUwIyS0LH7QeERTlDNRq996weOJX1hirOIkKwDS2d4m1fKeiGcWMqqyzUEw1PTC2aJW+vf6jbDbETgJVV8QQAInJg0SV+of0T2qneFX4kvH8MvFSCKS2OzugGo7UlEJUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAwYKaDK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAwYKaDK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3A41F000FF;
	Thu, 10 Sep 2026 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042559;
	bh=1XWeEQAbcBQCpWZCK+9GzqSSfU/QDHQzFWzVzrQZerE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TAwYKaDKW0hTR3gVgSN3rsosHocgxDEN89+NbRlIOOKGsiIjGiLLiQcuDIrTNup1C
	 PMHhjQHz5Zs7E/Oix00PFWiRwKwbdHVyoNFFEhfTT/hYCQJ6kH98AwL7lUNfSgd34o
	 Nf0PMRL+FvDvbC9eXZwwcgHkVVpFWZr5HALVe2HA21h/4kxtbp0VkinyOq9tCA4gIg
	 Eesl1vGtOR1h2yh9AgwFaJ51ZRW/33plu/xlWi7fIkz5aOEXsTATWGjpItFlgzqgd7
	 DLPo0fcBvIjLFiCX1KgDx02Ghu4fAm2K6vxILj+iWYwyut4Wc8awO4bZIA/oOVPJv9
	 /EUR8yt1yMeUQ==
Date: Thu, 10 Sep 2026 14:15:49 +0200
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
Subject: Re: [PATCH 09/12] mm/sparse: remove SECTION_MARKED_PRESENT
Message-ID: <aqKfdTCHbqFmc7FC@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-9-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:02PM +0200, David Hildenbrand (Arm) wrote:
> All present section iterators run before memory hotplug added any
> further memory sections, Therefore, we can simply use the SECTION_IS_EARLY
> flag by setting that flag earlier in sparse_prepare_early_sections().
> 
> Get rid of SECTION_MARKED_PRESENT entirely and rename
> for_each_present_section_nr() to for_each_early_section_nr().
> 
> Also update the gdb script to use the updated value for
> SECTION_IS_EARLY.
> 
> No functional change intended.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
