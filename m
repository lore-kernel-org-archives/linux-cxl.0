Received: from one.firstfloor.org (one.firstfloor.org [65.21.254.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1558466B44;
	Mon, 29 Jun 2026 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.254.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782752060; cv=none; b=isMxTDobMZrIY0teriW3RWEz/9tf9eCCxu0OkZPXac3W9bqpqC+NTZoW22SBKrlIIumJ9zv76QWvKEuoJIAMYukJaXq4NHKYKTOqVqlmTZkvcVrTeRlDsjn/BRuc3nb2c8yBd9aPPC/nyGFZ+g8WSByzswljNj5VuYbI2ONvr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782752060; c=relaxed/simple;
	bh=1+OvXKBSJrqCTEswr/10x1x3PFYbvXrrARRRWu8wQWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+3wSV5k+nMdsiZhhXN4vBl11Tlz6kevVCVIqNZokuak/ms/up+o+e6x+nvNsPxgq7oveW8sOksSAzoiKkAavPgU9kLgQHrOdkgHA48l6N2A0OFiU9cHc/vPZQqFdKZ79dLNi7GZowjKN83wM4KYKXGdXSy2sVgnkEL49dz4BvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org; spf=pass smtp.mailfrom=firstfloor.org; dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b=hoWtijM2; arc=none smtp.client-ip=65.21.254.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=firstfloor.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="hoWtijM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
	s=mail; t=1782752056;
	bh=1+OvXKBSJrqCTEswr/10x1x3PFYbvXrrARRRWu8wQWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoWtijM2AqSbBKMUTZCq6bVkMzzvKzt5LOopBP1s7dAvMu2N3+HakILYwnzl8+PTo
	 +c3Cmh256PoUfNEjUDL35me5A6xvVF8ay7UTiSdT7LmpKCS0ndfTBXyVjUiG3TtRvK
	 4ayK3EgxLineaOIqccO9Xquu2luPFw9fRsywBdnQ=
Received: by one.firstfloor.org (Postfix, from userid 503)
	id 3D29B5EAB0; Mon, 29 Jun 2026 18:54:16 +0200 (CEST)
Date: Mon, 29 Jun 2026 09:54:16 -0700
From: Andi Kleen <andi@firstfloor.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <akKjOG6iFhGNTFYC@firstfloor.org>
References: <cover.1782676497.git.mst@redhat.com>
 <akHUboUaYi-OJHFu@firstfloor.org>
 <20260629033608-mutt-send-email-mst@kernel.org>
 <20260629043417-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629043417-mutt-send-email-mst@kernel.org>

> However, this was a basic test, when allocating 4k pages. With 2M hugepages:
> 
>                                    insns/iter    cycles/iter
>      -------------------------------------------------------
>        base                       20758 +/- 12.5   191208 +/-1946.6
>        rcu                        20785 +/-  3.7   197108 +/- 132.1
>        atomic                     20727 +/-  6.4   204591 +/- 160.2
> 
>        rcu vs base                  +27 (+0.13%)     +5900 (+3.09%)
>        atomic vs base               -31 (-0.15%)    +13383 (+7.00%)
> 
> and even with THP:
> 
>                                    insns/iter    cycles/iter
>      -------------------------------------------------------
>        base                       27220 +/-  2.8   192151 +/- 483.3
>        rcu                        27248 +/- 30.1   194159 +/-2746.6
>        atomic                     27186 +/-  3.2   200526 +/- 746.2
> 
>        rcu vs base                  +28 (+0.10%)     +2008 (+1.04%)
>        atomic vs base               -34 (-0.12%)     +8374 (+4.36%)
> 
> 
> needs more thought.

Well the alternative is to not bother with RCU, but just wait a bit and
check if the bit stuck and repeat if needed. While that could in theory
livelock it is extremely unlikely (especially if you add a bit of randomization 
to the sleep)

-Andi
