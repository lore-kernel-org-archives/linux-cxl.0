Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5D431E4C;
	Wed,  1 Jul 2026 20:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936863; cv=none; b=XZ9mzVRsaV9rfx0wXp1XLo5QASN5E0TUbDQ6WfA8e6C9IprMGsup08UhfxM1WYG51BAWDGfKaY5WC7yUirQ8CgqatKgBLADIbrVlzducyoNsGGVQCJJIiDK0NX+KJHUBD7ggB8T6Q4Ib7KOV/JStbblmWvuKWiRac+li9T1/Q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936863; c=relaxed/simple;
	bh=hOe8vuqIPmIDmZ4xPAHah5l8W6e6QKmGgQWDlSa/aiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk7hxAN0ShSV3Rw59AlsyMVMrlGh3dyyh1lUaCDAp+DSn3If9fgg4yX91UK70uVpcdPQWOjyChGUi+B8UX9xNQBYB4ubw+9BWwcsEj41jtX5AN0hX4VPWB6igfjB7NhO+0BVqLlKxROqbVLXotTivqpqsu/kSubcUcFz1kz5jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSHbzv7l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSHbzv7l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8E21F000E9;
	Wed,  1 Jul 2026 20:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936862;
	bh=LN5wY39rxmjMcB4krynfJZUE82lE8sfQRixsHNNFZNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fSHbzv7lNrJgxq534POGzzIiYDP/LjCsKwNZQubCncE7XAynQMeoUL8k2colY/dub
	 aK/tZEKT6jzjG8jWP5Gykq9LTfu8d+i99NDRxQDJnql14zMgVcKO6m44lSZNOCwU56
	 jQHUR/yGysMEtriO7rab6a0K9NqavGIVSc2Wq5d/9mQr7TAJbhwsCmE0rvqjjGIM3o
	 /G/ei6Nho7/l2Nm3aEnTD+1m7/rUGMC3vM0DhLS71P8Sb/+usJFTP14G4tuv+vBOx5
	 LEAiaEmbZRSO9lu9iclN6Wo7tIu6cG9y2GvY8ULedGIHYrhGeN6x6eDlk/hUc2rs3G
	 90w/bopp4u6Vw==
Date: Wed, 1 Jul 2026 23:14:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com, david@kernel.org,
	osalvador@suse.de, akpm@linux-foundation.org,
	mgorman@techsingularity.net, hannes@cmpxchg.org, vbabka@kernel.org
Subject: Re: [PATCH] mm/mm_init: handle alloc_percpu failure in
 free_area_init_core_hotplug
Message-ID: <akV1F0yx593BwaN3@kernel.org>
References: <20260630214039.2263562-1-gourry@gourry.net>
 <akS2AYLzOzlJ8tIO@kernel.org>
 <akUwUv_rrgmRP4bK@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akUwUv_rrgmRP4bK@gourry-fedora-PF4VCD3F>

On Wed, Jul 01, 2026 at 11:20:50AM -0400, Gregory Price wrote:
> On Wed, Jul 01, 2026 at 09:38:57AM +0300, Mike Rapoport wrote:
> > On Tue, Jun 30, 2026 at 05:40:39PM -0400, Gregory Price wrote:
> > > We miss a failed allocation check for pgdat->per_cpu_nodestats, which
> > > results in a NULL deref when we offset into the per-cpu area.
> > > 
> > > Propagate -ENOMEM up the stack and leave per_cpu_nodestats pointing
> > > at boot_nodestats so a later online can retry the allocation.
> > > 
> > > hotadd_init_pgdat() returns NULL on failure, which __try_online_node()
> > > already maps to -ENOMEM.
> > > 
> > > Assisted-by: Sashiko:unknown-model
> > 
> > I suppose it's rather 
> > 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> 
> I honestly wasn't sure here, Assisted-by is the tag for LLMs lol
> i can change it

My understanding is that Assisted-by is for cases when you drive an LLM to
create the patch.

And Sashiko reports issues so I believe it should be attributed just as
kernel build robot with Reported-by.

-- 
Sincerely yours,
Mike.
