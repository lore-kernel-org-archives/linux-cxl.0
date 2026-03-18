Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403414D719;
	Wed, 18 Mar 2026 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820321; cv=none; b=hGqkm/ZfBuJekLAsHCsqhw4JhC0kQwm9oS1tWz9sBp44sSr0DNcELKsVUMMOH8VqDh1JvqmV93U97KeBv6lFbtrpcQp1ozGRjVKP8hx78lbD7gVbW4O2c4JBMgWXBm0QgYwC+Y/a/wTlHgw3m8wz67zQs67t/liEcREbsSedcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820321; c=relaxed/simple;
	bh=6YXJGpN/05ciWRewmyb6r+eM6RpAt346T43GsTHL1l0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AA+9xjNju7XiPb2NmseG6wOybjqyEhdkKHJjqWp3WUS2aZe2MiGjd9htaI8ZIhSI2pKxX7us7jzpJ3iQZe3xtBciAnpQWcaQAIYyEHqs4KaMGZ8j8Yo+POAwKN2CTaO6P7dXPe5yLBe11A2b/+0UI23Ddq/wpprWKUaM0ZUdcTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7siPfEp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7siPfEp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EE6C19421;
	Wed, 18 Mar 2026 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820320;
	bh=6YXJGpN/05ciWRewmyb6r+eM6RpAt346T43GsTHL1l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7siPfEp1dmzCHK1SuAPFV/Ernz2/GEx2Z6EQTxtVJlCUd3kvGvtPQTagNt/hvXIM
	 dGFhvKAAEIPYEuBrZrrzCXPO/NGZlvcROJGXxUuLppJKQ870T9qsQWl+NlOM5oRomX
	 +X1BnwHYBBeZVTydEK0L+diJ4VlSMfVGQ8s1B18BOKhgWlBhiFTZktJKvDaUc2Ps4a
	 XSGigvBdp47Q/KVexhBsCZ7RO4btnFGwsGTerU5lXep5NbqyrloXrxVt3TsWXK6K+f
	 rHH2DhB2c7v7usKbwdOTuoviy7UCHhX4KoMyguwv4mDByNs4ObUpEux2xleleQkUHx
	 /wE7v1D76ggkQ==
Date: Wed, 18 Mar 2026 09:51:52 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 01/14] mm/memory_hotplug: remove for_each_valid_pfn()
 usage
Message-ID: <abpZmD9zVtctGaGH@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-2-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-2-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:39PM +0100, David Hildenbrand (Arm) wrote:
> When offlining memory, we know that the memory range has no holes.
> Checking for valid pfns is not required.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memory_hotplug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 86d3faf50453..3495d94587e7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1746,7 +1746,7 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>  {
>  	unsigned long pfn;
>  
> -	for_each_valid_pfn(pfn, start, end) {
> +	for (pfn = start; pfn < end; pfn++) {
>  		struct page *page;
>  		struct folio *folio;
>  
> @@ -1791,7 +1791,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
>  
> -	for_each_valid_pfn(pfn, start_pfn, end_pfn) {
> +	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>  		struct page *page;
>  
>  		page = pfn_to_page(pfn);
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
