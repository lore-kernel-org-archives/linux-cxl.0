Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A55B4BFE90;
	Thu, 10 Sep 2026 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042143; cv=none; b=kpvE8EDRewoWopFxUQ9lvRFM3di/Hfz0FNupYTO98RBldLRgknOgVlMfNjuQnMjGH7pqPg+voKvLIPJsJw+amdn5VMgEFfgJo2ysry7Qi6dwv0PzJY2xLlVJ3y9ZuKYUklQU55FfcPv+AM4NSvfsD/lKvb4osjgv/zLaiEiFp3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042143; c=relaxed/simple;
	bh=+QdmijMIX+OLPq1F9xtXWRLOsn6p6ZPKWz+6/lwS9oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2gCkSHMBqW9PDITLUlutAdF6ssbeldsv930ErsQIBCB/h5ggAwnM0sYAV8EUJEEcfedloKC8Ye7mEA/kTKtPJuPhHGN9k9JiKZrYS79MRsa/bhnvq87j6ZFfaT7GJdP40lQPKEAHV0QF9Uh5WsfbMFxlxg0xSR4VPakI9ZHvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9XvPJax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9XvPJax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17AD1F00893;
	Thu, 10 Sep 2026 12:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789042141;
	bh=h8JhehTldcB3FE9LGKhQNq/e+HX2lvut2PpvhgojHPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R9XvPJaxnWBT/hhlHZmNBez+Xu7yQO9mAv8dduJTjSJl0gZxISR+BHcwPyiidi1F1
	 jRKYzFm5oXjvXRnAP6U2pqltMLSl2J8ZQ9WdTNMfl4z61gvUyOWbzyK3Ub4Mw8QuQ/
	 HFv6DmfgE3cPnMmOo+TKucAGzNXH2GdATJ/t/rZQnGcTM5RCHGS56zOQx045SPfRCx
	 Eh9nVKgokLYia9TMkboW3F9ft5E/ybtN5blbY1wMqkcJStzGzWhQk9A6OS1zAAxuLC
	 C6zxYi09inIeB3Vmv7mraQXhcpNdhDre/6j2qK0OsdoydY771AplJyUt5L0iTDWCpT
	 CjuHp3FDi2xCA==
Date: Thu, 10 Sep 2026 14:08:52 +0200
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
Message-ID: <aqKd1MUgFVHozVWu@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-8-008fc8d579fe@kernel.org>
 <aqJrblWch-lajp3k@localhost.localdomain>
 <c2239ef2-10f4-4c87-a23a-2753f1e18d27@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2239ef2-10f4-4c87-a23a-2753f1e18d27@kernel.org>

On Thu, Sep 10, 2026 at 11:13:18AM +0200, David Hildenbrand (Arm) wrote:
> If you have something consuming __highest_used_section_nr while concurrently
> updating it, you might get torn reads/writes that mess up the value on the
> reader side.
> 
> For example, mm/compaction.c consuming __highest_used_section_nr.

Right, but I guess that if we get a 'wild' value, at least we are
guarded by online_section_nr() performing the right thing?

Not really figthing anything here, just convincing myself :-)

But yes, I guess that we should fix this in case we add more consumers
of __highest_used_section_nr in the future.


-- 
Oscar Salvador
SUSE Labs
