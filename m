Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3C01B0F33
	for <linux-cxl@vger.kernel.org>; Mon, 10 Feb 2025 07:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739170987; cv=none; b=q1PGCt3E0cA5ur80Npdk255Zo1k9PHL+vrq6r+wgwT7RRbPbwPZzzFLfSSV1u5e7HnJwoCxLFfIXb+nOLWkzCt//1dQW5Rb10/joJOpx54ErfNG2dsDQJTXthMV2fsEhBO1HsySb6lcx3BXDfdovjnlrLiQ6J9WOIMP9uLYls7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739170987; c=relaxed/simple;
	bh=dR4z+iQ5PzxDl+dE+omMr3LTPe78lZe1IJe1S9AQa7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URWDF/6R5tJl8ORVf/Eysll7I9rGhL5UE5X8yA1t/2YtgzdWW3y5/pt8BEX7f+dFeadZPbLfEkO1u3zj9AirhIz6PppzYuQuU1pANyTLBHrR6CLeAcAe3O7CGTKlzbge5sm154JdIqEP5lXzk13Xptg5ILpzqyqO0BC/JLuBQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-7f-67a9a49c09aa
Date: Mon, 10 Feb 2025 16:02:47 +0900
From: Byungchul Park <byungchul@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Honggyu Kim <honggyu.kim@sk.com>,
	kernel_team@skhynix.com
Subject: Re: [LSF/MM/BPF TOPIC] Restricting or migrating unmovable kernel
 allocations from slow tier
Message-ID: <20250210070247.GA39454@system.software.com>
References: <Z54hUTXRsw0LYQ8b@localhost.localdomain>
 <Z54p4QOnAlTYm6DG@casper.infradead.org>
 <20250207072024.GA48419@system.software.com>
 <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6XLCeU0vjIOYGKe@gourry-fedora-PF4VCD3F>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnke6cJSvTDZZu07GY2GNg8fPucXaL
	87NOsVjcW/Of1WLf673MFr9/zGFzYPPYOesuu0d322V2j80rtDw2fZrE7jH5xnJGj8+b5ALY
	orhsUlJzMstSi/TtErgydlzYz17wmb9i4YwfrA2Mc3i6GDk5JARMJD4eOsgMY587u48VxGYR
	UJX4fuwCmM0moC5x48ZPoBoODhGgeNsV9y5GLg5mgUeMEtvf72MDiQsLpEm8/eEHUs4rYCFx
	v+cUK0iNkMBORolZ21tZIRKCEidnPmEBsZkFtCRu/HvJBNLLLCAtsfwfB0iYU8BM4lLjXTYQ
	W1RAWeLAtuNMEKftYZO4sIwFwpaUOLjiBssERoFZSKbOQjJ1FsLUBYzMqxiFMvPKchMzc0z0
	MirzMiv0kvNzNzECg3pZ7Z/oHYyfLgQfYhTgYFTi4T0wY0W6EGtiWXFl7iFGCQ5mJRFek4VA
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJMHJxSDYx1kw8qW8pG
	nSuYVWrFGNU2MyvVNbGSQTmJ6elTibux0ed4y/OvOAX5LttVI+sm0jn7BWuPhPvh6GCZZSoh
	DOttFNfc1Jt3Pur4vsM1Fx9p2RzeMyvWOSBEXjes7BZP5kdDpVmrru4oPBobq2K5eJdBzhLJ
	/82pV3WPLjF2X7NPsKY6pPHKOyWW4oxEQy3mouJEAHHsIzNmAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsXC5WfdrDtnycp0g5WnFS0m9hhY/Lx7nN3i
	87PXzBaH555ktTg/6xSLxb01/1kt9r3ey2zx+8ccNgcOj52z7rJ7dLddZvfYvELLY9OnSewe
	k28sZ/T4dtvDY/GLD0wenzfJBXBEcdmkpOZklqUW6dslcGXsuLCfveAzf8XCGT9YGxjn8HQx
	cnJICJhInDu7jxXEZhFQlfh+7AKYzSagLnHjxk/mLkYODhGgeNsV9y5GLg5mgUeMEtvf72MD
	iQsLpEm8/eEHUs4rYCFxv+cUK0iNkMBORolZ21tZIRKCEidnPmEBsZkFtCRu/HvJBNLLLCAt
	sfwfB0iYU8BM4lLjXTYQW1RAWeLAtuNMExh5ZyHpnoWkexZC9wJG5lWMIpl5ZbmJmTmmesXZ
	GZV5mRV6yfm5mxiBYbus9s/EHYxfLrsfYhTgYFTi4T0wY0W6EGtiWXFl7iFGCQ5mJRFek4VA
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBkYuv+mrbnjO
	qdnu576dkXXJT+XL11K+TGPKtK4LaJe9kJH9IWpvRMnDKSt1dl1yZH/CtnLy0RP11Ue1Va78
	Oe+V9PlO1In36SsTWx5slzipeVKOM2f3Znfe4z9/CMz9XvovsnfXKneT6p9ZU960TblqUae+
	cYbtt2T5r3u65m7eOe+QbpdGZ8N2JZbijERDLeai4kQAjYfA+lcCAAA=
X-CFilter-Loop: Reflected

On Fri, Feb 07, 2025 at 03:57:45AM -0500, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 04:20:24PM +0900, Byungchul Park wrote:
> > On Sat, Feb 01, 2025 at 02:04:17PM +0000, Matthew Wilcox wrote:
> > 
> > We can work with from the easiest object
> 
> >e.g. page table
> 
> It's more efficient and easier to change page sizes than it is to make
> page tables migratable.
> 
> It's also easier to reclaim cold pages eating up significantly more
> memory than the page table (which describes pages at ~8 bytes per page).

Sorry for leaving comments in an excited manner last time.  Lemme focus
on what to consider and how to resolve them:

Case 1. A system with no or little non-DRAM capacity

   You are right.  It'd be easier to reclaim cold pages eating up
   ZONE_NORMAL.  ZONE_NORMAL in DRAM probably can cover whole memory.

Case 2. A system with very huge non-DRAM capacity

   ZONE_NORMAL in DRAM might not be able to cover whole memory.  So
   either allowing ZONE_NORMAL in non-DRAM or allowing some kernel
   objects to be placed in ZONE_MOVABLE would be required.

   If all the guys agree with Matthew - a system should never be able to
   equipped with very huge non-DRAM memory, then yes, we might not need
   the discussion.

Case 3. A system with a capacity between huge and little non-DRAM

   ZONE_NORMAL in DRAM might or might not be able to cover whole memory.
   Quite big amount of kernel object would be still required.  Of course,
   properly reclaiming cold pages eating up ZONE_NORMAL in DRAM might
   work for the purpose.  At the same time, any efforts to reduce the
   ZONE_NORMAL cost would help and mitigate the pressure on ZONE_NORMAL
   in DRAM.  Here, the efforts include e.g. reducing size of kernel
   object, making some kernel objects migratable, and so on.
   
   Same.  If this case is also the one that Matthew and others think
   is not realistic, then yes, we might not need the discussion.  If not,
   we need to consider the issue.

	Byungchul
