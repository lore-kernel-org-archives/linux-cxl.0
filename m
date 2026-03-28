Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267DC33F8B1
	for <linux-cxl@vger.kernel.org>; Sat, 28 Mar 2026 04:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670988; cv=none; b=FRUFjBf1QWjfo9RJtv9c8G4P9JiYBP30fKT+GXywdPkuSrGPLCKYlHQ33zLxXXJh4m0rtV4CvGvkexwHOVVjAV0GBxdGtoOJPTj98uDOGfJ9A0S47EQU4H7h/esxNPybfrWKuk3eHHVvdRgPQojl0BtLRelPj/Tdhh5FfeWOv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670988; c=relaxed/simple;
	bh=ursqSFjYlLHPXrts2MCXvdtcMZt6osC438WJ6ljBq+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGHkIsfZotwc1I56b6bQp6A1f5KrYLp38u/ze97lVhs1beGTkQlJ3kzTNUJ0tOu1pBUSHKnOs8mPdTJ4SJbEf6lYVHkS1eIo9P5SPLJ9HGYYIwjeWyoKWE8RTiC+X66fkWfcFHpKIa1kuMZrngFJiefgHBDieg2I1o03CX42CqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cZHIRaKd; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cZHIRaKd"
Date: Sat, 28 Mar 2026 12:09:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774670975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYR1gJ6M/Z6ak/fzYuriJiVP1fqhOV2XtXnkDDYeAFI=;
	b=cZHIRaKdYHylWzqRzuEVjgXCIT34HtCUlx16WpIdv9ZQ7ZHGq+GByTN6sAO55DZI5pCmv2
	Qa31Rs/b+mTyU8BN3sUi2ZgFnIq3y35Ju/kczSm0e5ScYB5mMT3C3jHNJqhluni060tuiw
	HEHugFthSEkmOatsPcOGxqOpdD2Bh3M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, osalvador@suse.de, akpm@linux-foundation.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <5omwfganlhwbmllrmab6f2v473rrgirvbtqrcouj6tz4karzjb@xiheplfxwap5>
References: <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
 <2356614e-d9b8-4639-8e2a-96c5e4eaef61@kernel.org>
 <c3b10a9b-d3a8-4e5a-8cf9-3ddb172d2c0e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b10a9b-d3a8-4e5a-8cf9-3ddb172d2c0e@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 27, 2026 at 04:22:52PM +0100, David Hildenbrand (Arm) wrote:
> On 3/27/26 15:44, Vlastimil Babka (SUSE) wrote:
> > On 3/27/26 15:38, Joshua Hahn wrote:
> >> On Fri, 27 Mar 2026 20:42:47 +0800 Hao Li <hao.li@linux.dev> wrote:
> >>
> >> Hello Hao,
> >>
> >> I hope you are doing well, thank you for the patch!
> >>
> >>> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> >>> hotplug currently only updates N_MEMORY. As a result, a node that gains
> >>> normal memory via hotplug can remain invisible to users iterating over
> >>> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> >>> incorrectly marked as such.
> >>
> >> The second part feels more important than the second part, doing a quick
> >> glance through the code I can see a few N_NORMAL_MEMORY iterators that
> > 
> > Note in practice it's unlikely that a node would hotplug normal memory,
> > start using it, and then manage to successfully hotremove it, due to
> > unmovable allocations. Most likely only ZONE_MOVABLE memory can get hotremoved.
> 
> Yes, hotunplug of all normal memory of a node is unlikely. Possible, but
> nothing to optimize for.

Yes, I agree that fully hot-unplugging the last normal-memory node is probably
uncommon.

That said, once we restore the set side, clearing it feels like the symmetric
counterpart as well. If we leave the clear side as-is, it seems like it could
be a bit confusing for others later on.

-- 
Thanks,
Hao
