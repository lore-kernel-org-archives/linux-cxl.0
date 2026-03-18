Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A238550C;
	Wed, 18 Mar 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824282; cv=none; b=nmfAkoX/A80U//0FvhnoILMAfyxfWV1blobokt2h9HdY/CDRbZ0acQTVPlbSlOWsSaLKfq+5LjUpmP1GGY3EctbVriKKBw79uUmZJo/3/ZzZKvJyujyAVnOMqc0dQjTjBwdJq3LI/H77x8iqGQMlaf/9U6YZoDlCDtbY+PzhmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824282; c=relaxed/simple;
	bh=cqTfs9ElgfRveSlxZtaNdRLx2AsMn35zzyPDr2hcR/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8CL193E3Pdfl5rUbHzd6+c8PiiXjCbi/AZLY5oamFT8ngWN8xz7QolXLmSVa8XCZFHjyYwAboON9ozU7M/4On9HMxbbMM7eUcUMkJjTPr9bHTujkvNF28Qat31yrpLo8ovgBSc96b/o6zxB+UKrE70UshF+QwNc8i4muvfjBvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eakVPsLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eakVPsLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEDDC19421;
	Wed, 18 Mar 2026 08:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773824281;
	bh=cqTfs9ElgfRveSlxZtaNdRLx2AsMn35zzyPDr2hcR/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eakVPsLYp5el2mWPyBvzY0WUc83/+uOe/m/8v548qC21LkZWapg7XgSypswYJI8Hh
	 CHbCh1t281ADJsSgnCsC9+I00J6O/pTfcBDBl9ChRl5QmvUT60a4i0nJmX9xN5Sn2/
	 7kOcojkNOnyt1Ico9ukYkw59zKbx/ImeJGeekNOSmEm9JSYNFkc4JGVpoXsU0carqR
	 lDWJqBnVxxdpNjCowh3sa6J2nwt3tEOQuJ/jQMHJKeW6VfQEhT4vTBGzOUjVeWTAas
	 /0IQcgVnjsb4uM2bEMIU9ruagatDrVdaJJhiPYm4/uPgLnDhYRt1hkO/YxBW93buIg
	 FtPQWCzULrf8Q==
Date: Wed, 18 Mar 2026 10:57:54 +0200
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
Subject: Re: [PATCH 14/14] mm/sparse: move memory hotplug bits to
 sparse-vmemmap.c
Message-ID: <abppEiCJN_432O6w@kernel.org>
References: <20260317165652.99114-1-david@kernel.org>
 <20260317165652.99114-15-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165652.99114-15-david@kernel.org>

On Tue, Mar 17, 2026 at 05:56:52PM +0100, David Hildenbrand (Arm) wrote:
> Let's move all memory hoptplug related code to sparse-vmemmap.c.
> 
> We only have to expose sparse_index_init(). While at it, drop the
> definition of sparse_index_init() for !CONFIG_SPARSEMEM, which is unused,
> and place the declaration in internal.h.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mmzone.h |   1 -
>  mm/internal.h          |   4 +
>  mm/sparse-vmemmap.c    | 308 ++++++++++++++++++++++++++++++++++++++++
>  mm/sparse.c            | 314 +----------------------------------------
>  4 files changed, 314 insertions(+), 313 deletions(-)

-- 
Sincerely yours,
Mike.
