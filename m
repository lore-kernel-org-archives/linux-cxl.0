Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48439B97B;
	Thu, 10 Sep 2026 08:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029240; cv=none; b=VAir1qc5Y9CMPZpoxw3/tPwQWfgsT8pQR2UbO+MoCcocq3zDivM/wlrq8zLQlDF8Yi3wqc7Pg3cQN++wJW9b7kc8zBgS0p+ONjZBTRs6Fu4xWAFvKcHlODAyEtn7yDYlA9dQpvaBjUbcsteKrK2E2fI9y0YY8iFsHWmOKtznvPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029240; c=relaxed/simple;
	bh=boajKtpJSSsvTCcjGW9fP/zFWBeiC+tyHKsXcd8ZiIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+BMjEYeN24pVUnHpFhArYbzM3meDr+W0OJCjyMwojf7+WtQ67M7uk4sUZ+ymfISlKIAzizfh22Ov2FuQU3OelKveth1oA3FgQYWk3JFVPcwHPp6LPW3SDTLnT09OsVn4RvfZyH1PuinAZUHkM4c/OanrVouFxxtcHwMKfrICvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CazkhZSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CazkhZSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8C81F000FF;
	Thu, 10 Sep 2026 08:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789029239;
	bh=htWrCuWloy0NONsft45RDstF/ATea72DavKG8+QtMK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CazkhZSvT+O0NgogGiXHI0lYcotwsei+QChUnDurF+HYFaqB31jqAAsP+ioj1RnJa
	 slgoF+ChAAr/n4Lv1nBu2JaW3o+ffaESC4PwPQHVefTX1rJX0ZIIobfByVZPcIh8yU
	 cx/VjCtD++UBLeRhzdko4P4UG+Pz1IlPG0jvfelVuUSkAqdjNHPkX4ImE2iLnVR4zh
	 ECN3fzt4IyI8LStfLku08boRFArVqEJj1jo7jmqw3U74L2Mq2EXSNraAwkdMbliJHb
	 jqTXTw4P0h0kyaFkuFMztWx28m4l1WJ72RCkKhiHM7UOl5XVdmfYEX46V1wJWF6/8J
	 lsV+jOV4QvQfw==
Date: Thu, 10 Sep 2026 10:33:50 +0200
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
Subject: Re: [PATCH 08/12] mm/sparse: move __highest_used_section_nr handling
Message-ID: <aqJrblWch-lajp3k@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:01PM +0200, David Hildenbrand (Arm) wrote:
> Let's move it to sparse_init_one_section(). However, to keep early
> boot processing working, we also have to initialize it in
> sparse_sections_init().
> 
> Should we use READ_ONCE/WRITE_ONCE with __highest_used_section_nr?
> Probably, something for another day.

What is the worry there?

sparse_init_one_section() calls should run sequentally due to the memhotplug
lock, so there should not be parallel updates there?
 

-- 
Oscar Salvador
SUSE Labs
