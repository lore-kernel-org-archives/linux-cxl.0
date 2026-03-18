Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA5E38F249;
	Wed, 18 Mar 2026 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773823605; cv=none; b=aaRs3y5PC5WbDRRla9Pz1rZlU3mFwLowI7ZrUKMiRM60JZqvWzNb99mxZgLXa0JatZZpWBgooSm3RUtiQQoiLBc/g4GX2b76O9xBZVvz0R745lqTrhiiBS1XOGRETdoxxZNu8zpjYQ33AA0v3wU/7EGUTDU6zLlUXb8i9PTHiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773823605; c=relaxed/simple;
	bh=97R5iiUeYEFXhLUOgsr6q++vnxznhURgis+UaBmAhKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioUyFJigGaV2p1g3A/wu7INPglCvKAK+0W4eFsmZz8baVUc61Cg/gaqAZspRrmBv27UkxXrjQ94vq9V9PlLJ7PLLnwD1P9itj6wjnkUWVSneF2eOi9iynIBCpAP4kAeWkI/j7eI+uvXX+lRrfPKenJHGoDueCCPGFYff5dgroI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKx3Dple; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKx3Dple"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F57DC19421;
	Wed, 18 Mar 2026 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773823604;
	bh=97R5iiUeYEFXhLUOgsr6q++vnxznhURgis+UaBmAhKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nKx3Dple/UoXmU9B44vuRKg2n12J+xrWeUdndz0FP9ot45QHACTNWVhtOPqpIHR4Q
	 UZliJ7Mwz0qTfwIhZYbbsvQ7xuM+Y8jLzVWW1gSfECkgRRsxFT/sEfmTzuV/AmklhB
	 A7/6CtDq49lJUettu1l2iCN+5BjoQECxl2buIvifyFncxbcP8+KVJsr0e5LmPxYvl1
	 qbMW6++oMyj6zHy1z13PtOJY964ZEjXRZVRGsfQkHhVDrjV0q7ZJGtVLFE+VzE09hF
	 hh2GAdPXFrt2tzCLKdysF9TMkIgH7NZv51t8kmITAl9G+iiRCm23Eu3xGxobx6vwaM
	 im6GwepqMujxA==
Date: Wed, 18 Mar 2026 10:46:38 +0200
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
Subject: Re: [PATCH 10/14] mm: prepare to move subsection_map_init() to
 mm/sparse-vmemmap.c
Message-ID: <abpmbj8mCZjt6NxB@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-11-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-11-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:48PM +0100, David Hildenbrand (Arm) wrote:
> We want to move subsection_map_init() to mm/sparse-vmemmap.c.
> 
> To prepare for getting rid of subsection_map_init() in mm/sparse.c
> completely, use a static inline function for !CONFIG_SPARSEMEM_VMEMMAP.
> 
> While at it, move the declaration to internal.h and rename it to
> "sparse_init_subsection_map()".

Do we really need to rename it?

Maybe add a "global renaming patch on top, like

s/clear_subsection_map/subsection_map_clear/
s/fill_subsection_map/subsection_map_fill/

etc
 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mmzone.h |  3 ---
>  mm/internal.h          | 12 ++++++++++++
>  mm/mm_init.c           |  2 +-
>  mm/sparse.c            |  6 +-----
>  4 files changed, 14 insertions(+), 9 deletions(-)

-- 
Sincerely yours,
Mike.
