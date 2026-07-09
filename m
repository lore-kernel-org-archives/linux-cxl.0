Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFBB329C60;
	Thu,  9 Jul 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581768; cv=none; b=Q0Q2DKtc8xSRrZP0L/Kn28wp0vt/uxqlYtYW9qrg0PvsVdMpOql+aOXulaMpTH7haKL7dTU8dLrIbUw/u4fBQUu85MTjzrQelFJSr6z2lrbGr0s6vw79gXjsASi6hfQscLs2ry9zYki3Tx6ssbE0As+Lb9YySbNLpjsg+YCjXf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581768; c=relaxed/simple;
	bh=whyxTHf3rV1u4N59GNZmPAapl4ny2YUhdsCEojx5hwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMP8OSH+O8fqFSQkXn+Oqnimr9NaI+NZzz4mNPhMnjN60EfWTcIv5RMBYD9xICtr+KgExSOwWraHDobEQTBv4E22eYcq1Jm+Zp//f4wSq67Yox3TsrR89rIJAE1p8FnR62L4Qa76LCvH2eirZak0mQbb08PyfUcxxRh9ba9Nq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vfkr0ESu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vfkr0ESu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60CE41F000E9;
	Thu,  9 Jul 2026 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783581767;
	bh=/zW25RGaPGwBbxFd+aS9kBW8b47epnczIHFRFBCLAYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vfkr0ESuoATXnPUkdBeq5+55sr7cVzSbt5ClCmVrSnQkJcQlnePuTOPN43DOTmXBB
	 YSlQfUnogVcP5QFkvu6bmLtwBljgujN7UWqTgrsBz/mE/apwSbu1SjJZF9FbAd9uHS
	 YN+nGemmSCwyGDh+062S5GniNn8bNOd+VlJTpc4Ev7w6aZ1qJeLKrrA3kf7DEhJXCs
	 NcIZY28KAhZuKKTdEjThKMco81MwWoZcwhDhzGMSYaZvrTkjXcV/6rn4gWFjtTemEr
	 iQZoNnClbYQXt0PJm8wXnjYh33q++mH230eCtmwWcF0M7UOxqN4QNmZ5IiHWpXSsJK
	 2uv9LvYoeHkhQ==
Date: Thu, 9 Jul 2026 10:22:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>, Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com, kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/3] mm: split a couple of headers from internal.h
Message-ID: <ak9MO-FWjkgr22KL@kernel.org>
References: <20260709-internal-h-v1-0-956d5092782d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709-internal-h-v1-0-956d5092782d@kernel.org>

On Thu, Jul 09, 2026 at 09:41:46AM +0300, Mike Rapoport (Microsoft) wrote:
> mm/internal.h becomes more and more bloated.
> 
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.

Sashiko rightfully pointed to some issues, will send v2 later.
 
> ---
> Mike Rapoport (Microsoft) (3):
>       mm: split out mm_init and memblock declarations from internal.h
>       mm: split out sparse declarations from internal.h
>       mm: split out vmalloc declarations from internal.h
> 
>  MAINTAINERS                        |   3 +
>  kernel/liveupdate/kexec_handover.c |   3 +-
>  mm/cma.c                           |   1 +
>  mm/execmem.c                       |   1 +
>  mm/hugetlb.c                       |   1 +
>  mm/internal.h                      | 183 -------------------------------------
>  mm/kmsan/hooks.c                   |   1 +
>  mm/kmsan/shadow.c                  |   1 +
>  mm/memblock.c                      |   1 +
>  mm/memory_hotplug.c                |   1 +
>  mm/mm_init.c                       |   3 +
>  mm/mm_init.h                       | 120 ++++++++++++++++++++++++
>  mm/page_alloc.c                    |   1 +
>  mm/percpu-vm.c                     |   1 +
>  mm/sparse-vmemmap.c                |   2 +
>  mm/sparse.c                        |   2 +
>  mm/sparse.h                        |  63 +++++++++++++
>  mm/vmalloc.c                       |   1 +
>  mm/vmalloc.h                       |  46 ++++++++++
>  19 files changed, 251 insertions(+), 184 deletions(-)
> ---
> base-commit: 820d5dfede0cd55dcbc89ce96fcfbb11b7c457ba
> change-id: 20260707-internal-h-2efef660381d
> 
> --
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
