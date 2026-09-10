Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC548595A;
	Thu, 10 Sep 2026 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044386; cv=none; b=sOnCEIZBq6ZEIwnJ2ZLsnU3/iXPPnpyun+liXFXxpxN89a+yaXjk+of5PBTabr3JfRBxFn3zpenCgAs63Mk0eT9d3cxVLUelWLEPP2O3pNXiyEJDsGB64l0coO5VIsN7b6FbkzyoIR7degTpKPHH4fBhNyMmRL8CpFilhe2s9qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044386; c=relaxed/simple;
	bh=8EZb3r8H8dUDMD6H4SHZogeM4mSFaEw61hFyUnHQ1pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNSMqhevaNtsADyg4IJKLNpXcTkRShjxqOfA7TN3oJ3oqX9J5r0GS/iOwe7isVfmB+MdXMoPP7iPxu+dp0s8PdHAIhD+55aym44oOBC/dgsyUTiEpDDkIVJ/RFNmmb6WaAoOYZcg/AxzMZY04gYyvE5Jcve+4agnl+bFkydKEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSPF5uW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSPF5uW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EAC1F000FF;
	Thu, 10 Sep 2026 12:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044384;
	bh=Vc2ebuT/gZxQ583woO22IdxSOoPW7spjcm0Yx2PCB4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GSPF5uW/jcetUtIMNlVS4/iiup4wv+LENAgeuSiC0KorUy8ccvESxDyXvOEp0X+51
	 6ND97+J1Io5nJ+0fBkKkegM1k5CibfNyzbOnAJKOcwNZhFkwMk+GRYApqbVR5/GYA8
	 GEUg0nIBTWaeD0tY2uc54tVIUd8pIvKL4YwWS56gCVgU+PGswvwwn53c3vmsPhcbOF
	 ZJK8shPRYJAsonv3ggksT2wXlIF8ScpSNsIsXOMxKfDeH8vsu8aClNyNFQ4vnLqez1
	 Esjj7cHNaRCnXFV8zu6a1ui8wCRl3unnyaoBLDRQ6GojQgX/DMwaVVHgIX0O21Ffcz
	 8Dl+MwahL95Hg==
Date: Thu, 10 Sep 2026 14:46:13 +0200
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
Subject: Re: [PATCH 11/12] fs/proc/page: clarify comment in get_max_dump_pfn()
Message-ID: <aqKmlYJDu7au3yWk@localhost.localdomain>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-11-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-11-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:04PM +0200, David Hildenbrand (Arm) wrote:
> pfn_to_online_page() will only succeed on some PFNs within the same
> section, not necessarily all. Let's make that clearer.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
