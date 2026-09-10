Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07239449C;
	Thu, 10 Sep 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048229; cv=none; b=BwhL3U6I8sMmiB3p8YvBTjntn+QnDOtayzILZGonD/ms8mLROli008c4kR4wl9RRZjgvXMy7GA8c3Q5psMbpIhtG8rr/shWqemsWj9AQKDl2qGwYUL8fbTIev3rdFFYdkLckwPFg+GfWh78A0UBHT7zQATBvSg0oF1kJyl7oUiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048229; c=relaxed/simple;
	bh=sTAz9s5rDNCGxP4afPYYy8ehalD4xPRPKsuW+0kPK+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3nDLplYep2vRjpSMKrGL7qd62mnasmN9mvkgIjZlYAzkN+qC/Db3u34z5+8VO7RXW2Bm7w/dM/IyfH6YM53l7GoiAnbVxU8zcYeCBnqhIvCwZeDNyZYYSLburgXOOcwfSvF75PeKhDuZKngL86NpQLBsomnSiI5N5cX6Qvro3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFQAUfDL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFQAUfDL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30A51F000FF;
	Thu, 10 Sep 2026 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789048226;
	bh=Huo9AavKgYJyC3DyOPGYv+hq7OnKaq51C1pcQHDpq5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EFQAUfDL152OTzyxXY1pgmtZj7CbgwEMnNX/gqqxzgzLdXEVOxmenctBi0IwLcnqW
	 dCBbbAMIgVwl8kmKBXwnsnDlV2hB8j4ttJ0g6Qtji1BL8YryHQeypajmRJd9xppbKn
	 QFChUqMFxP/VZgqX+jPrIPN8SJrlngJSLgW5U8fBZKNy4yRjd31fRhcAi7jDTc1ejc
	 nCf59edQlTsjNUlQez2McBcAepMIS/bokIJsA844y2K7Xvy/ssNrJpP+6TrXvqv3FL
	 7mkfUO1Uy8ohog5YCziweZ4RU3Vta/vJbUHr2Zs7OnImdA2vkhSUiwqu9ygkBQNdYZ
	 uf9Xz1DQ0QNcw==
Date: Thu, 10 Sep 2026 14:50:16 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/12] mm/sparse: remove pfn_in_present_section()
Message-ID: <aqK1g2AuXCFjAq7p@gremlin>
References: <20260909-b4-sparsemem_cleanups-v1-0-008fc8d579fe@kernel.org>
 <20260909-b4-sparsemem_cleanups-v1-7-008fc8d579fe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-b4-sparsemem_cleanups-v1-7-008fc8d579fe@kernel.org>

On Wed, Sep 09, 2026 at 03:33:00PM +0200, David Hildenbrand (Arm) wrote:
> Unused, let's remove it.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/mmzone.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 19296e8ef44f8..e0fac344f6ac2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -2315,13 +2315,6 @@ static inline unsigned long next_valid_pfn(unsigned long pfn, unsigned long end_
>
>  #endif
>
> -static inline int pfn_in_present_section(unsigned long pfn)
> -{
> -	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> -		return 0;
> -	return present_section(__pfn_to_section(pfn));
> -}
> -
>  static inline unsigned long next_present_section_nr(unsigned long section_nr)
>  {
>  	while (++section_nr <= __highest_used_section_nr) {
> @@ -2351,9 +2344,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
>  #else
>  #define pfn_to_nid(pfn)		(0)
>  #endif
> -
> -#else
> -#define pfn_in_present_section pfn_valid
>  #endif /* CONFIG_SPARSEMEM */
>
>  /*
>
> --
> 2.43.0
>

--
Cheers, Lorenzo
