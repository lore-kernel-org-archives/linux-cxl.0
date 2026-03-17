Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02902D5940;
	Tue, 17 Mar 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767963; cv=none; b=QeeNMBJ0ZrQj71L5dIdOYKW6SQ1aZbu+KWYlCru+aWYVHWYOiE/1svua3xoMdRo4Q7CFFXN5xLs+dHERFAmwnKyucwW6zgx73c4/K1wXtNEryBXDhDt8hbN7Iv3xVLT+D5esszkaGIRyt9uPBx3MedEHwWhIRlFWo7dW+V3Tk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767963; c=relaxed/simple;
	bh=PZU9tIsV6USqDXcrCGfFETY9fHYZa8i3ji2a+gAm3wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhtkKALLQYMeXssXLjON7ZeGZGnQEX2uMfsPWZEntuqdP1kICOrXUlhtlJnTYpMeHnRKNupZgFylH0wogZGBvzwNLCMQmfXsWoi/Qeu9MhslADjeuIMsMtaorNQ/EPmTiTozB17YHWNU+m19tHgovnpkd2lgd2ZnOs+wimxPT8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5WyPkLM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5WyPkLM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CC0C19424;
	Tue, 17 Mar 2026 17:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773767963;
	bh=PZU9tIsV6USqDXcrCGfFETY9fHYZa8i3ji2a+gAm3wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5WyPkLMO1HCGbefwv10wnKMCkgsNH8nVFdIV3GCV409M/70k3QhHQOyTAjY6o538
	 67kZCxkIwAmtNA+CcqrRGl6dUW2wLIcDduAgeBK1hrlg7gJ496np2ia49V+YHcgJmk
	 rObd6MzsHdZW6neDxMVATVncFHYtGwp2YjQDe2q6dzKWQJB1VsH4bvkGLzFHdbRLI2
	 pyDdoFL03r5daL6+xqSvUBYITG/zg7s4BXoM877USEa63iaCVvrt8zu9ryyjRiz6d/
	 SczeerRphx/Qc8u66mDg/wRx7ufs2NHombOEu0YvSluvS5DgPLstfZfTlBO86VULOO
	 K3Givrrw/s34w==
Date: Tue, 17 Mar 2026 17:19:18 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Oscar Salvador <osalvador@suse.de>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 01/14] mm/memory_hotplug: remove for_each_valid_pfn()
 usage
Message-ID: <caacd86d-4c92-4a8f-b0ef-a152d2cc09cd@lucifer.local>
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

Holey Cow! LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

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
