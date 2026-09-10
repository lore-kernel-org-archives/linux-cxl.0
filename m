Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060F35AC01;
	Thu, 10 Sep 2026 07:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026989; cv=none; b=qvnMhwGmTPBMRF2FRMhIDR660bflxOjxsySZxcVvqDlayCnbu3uZV7Llw8jUj9NjE8uEbNI5sNU73Ug/kluO78zpLjo/vcqxvpGhxI8ORkAheT9bqcIJ/uDzOYGGTzK6HrCnIgYyC0SaxwemgoX/juqr5H21+7JPaqIYuJfPE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026989; c=relaxed/simple;
	bh=EMBp4Doo+oDMrJSXQ4mhY8YBlFdm4sKqNPqkYNZJ9rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdIglDYhgWfLVNhD6ktdFmeJvHOZyX6CSsBU/VA8XZ60eCtacS7Q7gkaZICw4RDQmxw9Wl4K6MgZ1fXdrBMsPks9xbInGAfQADEza7J0ls6MEkh+0DcN9EaibEd4wkFCy97Z1muQNOqHbAohaEqbhjx+sTwi0N4UQuzW1XKgHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDi8kUuo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDi8kUuo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13BA1F000FF;
	Thu, 10 Sep 2026 07:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026988;
	bh=BQQcusQ9LLT4yN0vtE2+JJfBAM0whRembcwi5uPMBmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UDi8kUuoLd3sQBFJGPIWCqcoyztj2LTiq9VJbAroJS0NmrWzlX881kEKj/grf85aD
	 +iFSIOSNfcbhy3RVHR7B48/NMY+1sQNN8ceb8gy99B3IgdUR4q6rQoNiKgy/V/oR4y
	 IcrtbvcrheHdS/YlR1R9Ro7LmulIoPjpSMZdb2rjWIBYgKwC7c915RPLwMJxcTsicl
	 iulfu5rif6jCCo7NCp4ZGfR9WkDxd/Gq44sL7rA8DWe3cYda/Vq+rKC4j93AxOuJGf
	 I70H/S0fguNXRnW8yk92n+a4QZgcvHR9wkwZ+V09rj+g/x/JqT/bPLYUa+vK1YkvwQ
	 EZXJMANGawwbQ==
Date: Thu, 10 Sep 2026 09:56:18 +0200
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
Subject: Re: [PATCH 06/12] mm/sparse: rename __highest_present_section_nr to
 __highest_used_section_nr
Message-ID: <aqJiouyfI716msmO@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-6-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-6-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:32:59PM +0200, David Hildenbrand (Arm) wrote:
> In preparation for getting rid of SECTION_MARKED_PRESENT, rename
> __highest_present_section_nr and clarify the comment.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
