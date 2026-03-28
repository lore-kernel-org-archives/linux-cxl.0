Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D4321C181
	for <linux-cxl@vger.kernel.org>; Sat, 28 Mar 2026 04:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670610; cv=none; b=r5mTKyQVQESpk0cpTfU4C/a7hYKdfqi/L2wboJcJhJ4lOlYYHV8dqkadBQ7GrtdXafWov8LWjjAP7jMhw8pTp1Ucyfxa/Vtx56BswjOhET4t68H7i9RJpzZ1N6N0V+PWvRe/Z+Ugtl5Ir1lBbtn8lG/Iw+GLEEa3JX8ySCqv3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670610; c=relaxed/simple;
	bh=fvjBgLgf2p9NHYvEuLjkHeiHUIvwM+keOe0NHmyT/nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnZwsGuEfxL0ScVztuXS6k310BzXOfql3nTG/mzSv1shLpPM0EOfMRBikrqKP+N/hXvK8vUupFkWr9i5wAtdpYB4xoUZyBINRkEdP2qHGe99g4utbdvCbrFgB2SQTm44LIn0vnCAZ+ZLy9/J0Co4UWnz2RmGakRyXoU4I+vHfUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qm+FF9hD; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qm+FF9hD"
Date: Sat, 28 Mar 2026 12:03:11 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774670606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YFg2BFAkAsXMYffunawiC8ZyRv2iQ9r6mtG0i0jtdNA=;
	b=Qm+FF9hDwUkdRudeCgYOR2HuLZdwJDlmWQyVaGLS9o1LewruK7uLo4dg8olFPeijhZ7f2S
	cmbCdI+TLCcV2x+oBwgMdWuLTigpbwBKfhL5AwATcHkSn7EweGctE39dZP17LZxreBQ7Wx
	WlpUFlWIzeKUEmUTqiofVh7hfhmEIWs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org, 
	vbabka@suse.cz, harry.yoo@oracle.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <onaszvpegcqt2y3domgplkne5wrpk7iibgj3mybx4wvckqwe5f@qrnlhiksef4b>
References: <2356614e-d9b8-4639-8e2a-96c5e4eaef61@kernel.org>
 <20260327163554.42487-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327163554.42487-1-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 27, 2026 at 09:35:54AM -0700, Joshua Hahn wrote:
> On Fri, 27 Mar 2026 15:44:18 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:
> 
> > On 3/27/26 15:38, Joshua Hahn wrote:
> > > On Fri, 27 Mar 2026 20:42:47 +0800 Hao Li <hao.li@linux.dev> wrote:
> > > 
> > > Hello Hao,
> > > 
> > > I hope you are doing well, thank you for the patch!
> > > 
> > >> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> > >> hotplug currently only updates N_MEMORY. As a result, a node that gains
> > >> normal memory via hotplug can remain invisible to users iterating over
> > >> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> > >> incorrectly marked as such.
> > > 
> > > The second part feels more important than the second part, doing a quick
> > > glance through the code I can see a few N_NORMAL_MEMORY iterators that
> > 
> > Note in practice it's unlikely that a node would hotplug normal memory,
> > start using it, and then manage to successfully hotremove it, due to
> > unmovable allocations. Most likely only ZONE_MOVABLE memory can get hotremoved.
> 
> Hello Vlastimil! I hope you are doing well.
> 
> Yup, makes sense : -)

Yes, indeed.

> 
> > > are in some hot paths like shrink_memcg. Iterating over nodes that don't
> > > contain any NORMAL memory seems like an inefficiency rather than a bug
> > > though. 
> > 
> > Ignoring nodes that have normal memory, just because it was hotplugged, will
> > result also just in some form of inefficiency, or can the consequences be worse?
> 
> Aaaahh yeah, seems like ignoring the hotplugged normal memory would be a bigger
> problem. struct zswap_entries allocated from slab allocator on hotplugged
> nodes would just get ignored by shrink_memcg, seems like a much bigger
> issue than iterating through extra nodes :P thanks for calling this out.

Yes, make sense to me. It could be more serious than just inefficiency. The
shrinkers might even fail to visit reclaimable objects on that node.

> 
> > >> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> > >> offline_pages(). Set the bit when a node that currently lacks normal
> > >> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> > >> offlining removes the last present pages from zones <= ZONE_NORMAL.
> > >> 
> > >> This restores the intended semantics without bringing back the old
> > >> status_change_nid_normal notifier plumbing which was removed in
> > >> 8d2882a8edb8.
> > 
> > But commit 8d2882a8edb8 didn't introduce the current state, or did it?
> 
> I don't mean to speak on Hao's behalf, but as far as I can tell I think this
> would have been the commit to introduce the state, since 
> node_states_check_changes_online would set status_change_nid_normal to nid,
> then nodes_states_set_node would come around and set it to N_NORMAL_MEMORY.
> Maybe I'm missing something? :0

Thanks for this analysis. I was thinking the same. N_NORMAL_MEMORY is no longer
updated after this commit.

> 
> Thanks for the reply, Vlastimil. I hope you have a great day : -)
> Joshua

-- 
Thanks,
Hao
