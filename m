Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031036C9CE;
	Wed, 18 Mar 2026 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820437; cv=none; b=mxVLzllQs50SMtqfArMasumRmW6VgbOMunFMqxcfoGXDQlmnrbBtuENpW6irmDt/hBKtHin8ui6skjMeP72fR0ER2ToVCZTVDm4qKq25dESe8DzVlQu1NuYTTkWP1q0YZt/oWKNjkTTMS3EqRKCQhNFNBfY96TNCYIthyv/+Vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820437; c=relaxed/simple;
	bh=QOTn4h9c0XtF8yhxZi704PPjn7nl6uZFa/xNu70MWAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+7QNGaXhmtJn3yhwT93LDPKft0fak2SN9HwbuVhg22ioC3lSjH9Hdvus1F1mVzDr1Ir4EejG1jnLCBOrBsqLVuDCvo7GY4QrENbcxoyjvBOT6LFz41gFy173GiGVpkL8GM7ozsuvAfdKIVcukcKPKFUO7+4zwWyTU1TYaqOHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpzsE4Wy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpzsE4Wy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E9AC2BCB1;
	Wed, 18 Mar 2026 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773820437;
	bh=QOTn4h9c0XtF8yhxZi704PPjn7nl6uZFa/xNu70MWAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpzsE4WyRNLn+Xvhih2ZXL2M+GOXeLOut/S5fo1SIWKaLYBhjbpw7jqc5ebwA35DN
	 g21uDWcZ57UKgXMUUXZEf30l4NjtC1dHQlHrJYcSk7QQFl/owbH+1IBU6JV2YuXEsk
	 CJuOYC2Gx6v5yPWqGulyZlSa1CulmoQvRtK7eH4c4GNo5mxsGAJsz+7EkqzYSqw3ow
	 K3oLBK2fhoIDz88IXQz2iZfbmU56gksb1VZMP7wZqhOlHUEl+z4RTlbVEKpjAX/EtV
	 fmsz1j/MaoDN3rzrHIVeVp5HvTFAr3aL1GyotmG7VzafM6YkKXHcs4hZrRkERWGmAf
	 RykQd2M5dNznA==
Date: Wed, 18 Mar 2026 09:53:48 +0200
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
Subject: Re: [PATCH 02/14] mm/sparse: remove WARN_ONs from
 (online|offline)_mem_sections()
Message-ID: <abpaDCXit9cadpJh@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-3-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-3-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:40PM +0100, David Hildenbrand (Arm) wrote:
> We do not allow offlining of memory with memory holes, and always
> hotplug memory without holes.
> 
> Consequently, we cannot end up onlining or offlining memory sections that
> have holes (including invalid sections). That's also why these
> WARN_ONs never fired.
> 
> Let's remove the WARN_ONs along with the TODO regarding double-checking.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/sparse.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index dfabe554adf8..93252112860e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -638,13 +638,8 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
> -		struct mem_section *ms;
> -
> -		/* onlining code should never touch invalid ranges */
> -		if (WARN_ON(!valid_section_nr(section_nr)))
> -			continue;
> +		struct mem_section *ms = __nr_to_section(section_nr);
>  
> -		ms = __nr_to_section(section_nr);
>  		ms->section_mem_map |= SECTION_IS_ONLINE;
>  	}
>  }
> @@ -656,16 +651,8 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
>  		unsigned long section_nr = pfn_to_section_nr(pfn);
> -		struct mem_section *ms;
> +		struct mem_section *ms = __nr_to_section(section_nr);
>  
> -		/*
> -		 * TODO this needs some double checking. Offlining code makes
> -		 * sure to check pfn_valid but those checks might be just bogus
> -		 */
> -		if (WARN_ON(!valid_section_nr(section_nr)))
> -			continue;
> -
> -		ms = __nr_to_section(section_nr);
>  		ms->section_mem_map &= ~SECTION_IS_ONLINE;
>  	}
>  }
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
