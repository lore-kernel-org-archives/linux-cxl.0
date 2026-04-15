Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E514283FEA
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242282; cv=none; b=GfUJqqhNoFM10rjoqnGCQIM0C/d8t74tNQeGC70ocFeoRXhRQJHdSRMMd15EbNAsY18hNftC3K9yvUNtoxrK8anmUnKaM9JSfgAhgMYwPlL7TSbGpa4abxKC1BoJ7pE0EXhC6erNoWpd55OA6ECDYb1eabEKPjbrdYDY7l/q8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242282; c=relaxed/simple;
	bh=bvtpQzYmg3c+2M/Kl6VldmjPHdSjyNuWHHi91KpHADE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVYeXaMIQGy3rzYUq8B/3ssyaXRlT5GaMe0WtIUnHcUbYmglBL2swdcR8fcCDNxB6rCp3ueK9jncptS7fGWVv7zYgk1eJwofnAHzNCQBmZ7jX3oKQXywkmm2aXWGB/xIt85PIQKtwQM5kPUxsHVuUy4jIv4hfBqRKghoglTb7dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J3YBlqxF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hEvGsYck; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J3YBlqxF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hEvGsYck; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J3YBlqxF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hEvGsYck";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J3YBlqxF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hEvGsYck"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86EC25BE28;
	Wed, 15 Apr 2026 08:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776242279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PB019jISU1/JV0vj13AJi5SAPdeqiJKzwFyxmcN5xO8=;
	b=J3YBlqxFO9//ViOCKoMwBkJc6v5lA/uIpEljRxo13KRQDtjFdorQ3di6/ETeuxQqhMvOVv
	jV8x9EJfxYywMEhhzvePCwtoEN+yIpdYws9IUjHOIGeSZJNKFJAvZYjpKllryJRdb+3yly
	+RfnqgoasI/hIMqdMhkQz1BDsqOy00A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776242279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PB019jISU1/JV0vj13AJi5SAPdeqiJKzwFyxmcN5xO8=;
	b=hEvGsYckZeEjadqHGTRQTe2iQZeX5fpLUmKCBJ9iego3f8uIuCOi5I4NDJOvwbCLOD3sh1
	fS1RWStf2Y2ybzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776242279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PB019jISU1/JV0vj13AJi5SAPdeqiJKzwFyxmcN5xO8=;
	b=J3YBlqxFO9//ViOCKoMwBkJc6v5lA/uIpEljRxo13KRQDtjFdorQ3di6/ETeuxQqhMvOVv
	jV8x9EJfxYywMEhhzvePCwtoEN+yIpdYws9IUjHOIGeSZJNKFJAvZYjpKllryJRdb+3yly
	+RfnqgoasI/hIMqdMhkQz1BDsqOy00A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776242279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PB019jISU1/JV0vj13AJi5SAPdeqiJKzwFyxmcN5xO8=;
	b=hEvGsYckZeEjadqHGTRQTe2iQZeX5fpLUmKCBJ9iego3f8uIuCOi5I4NDJOvwbCLOD3sh1
	fS1RWStf2Y2ybzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F7334B8FF;
	Wed, 15 Apr 2026 08:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5g2QHGZO32lFRAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 15 Apr 2026 08:37:58 +0000
Date: Wed, 15 Apr 2026 10:37:56 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	Muchun Song <muchun.song@linux.dev>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/sparse: Fix race on mem_section->usage in pfn walkers
Message-ID: <ad9OZAVnYvhxfh-Z@localhost.localdomain>
References: <20260415022326.53218-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415022326.53218-1-songmuchun@bytedance.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Wed, Apr 15, 2026 at 10:23:26AM +0800, Muchun Song wrote:
> When memory is hot-removed, section_deactivate() can tear down
> mem_section->usage while concurrent pfn walkers still inspect the
> subsection map via pfn_section_valid() or pfn_section_first_valid().
> 
> After commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
> memory_section->usage") converted the teardown to an RCU-based
> scheme, the code still relies on SECTION_HAS_MEM_MAP becoming visible
> to readers before ms->usage is cleared and queued for freeing.
> 
> That ordering is not guaranteed. section_deactivate() can clear
> ms->usage and queue kfree_rcu() before another CPU observes the
> SECTION_HAS_MEM_MAP clear. A concurrent pfn walker can therefore see
> valid_section() return true, enter its sched-RCU read-side critical
> section after kfree_rcu() has already been queued, and then dereference
> a stale ms->usage pointer.
> 
> And pfn_to_online_page() can call pfn_section_valid() without its
> own sched-RCU read-side critical section, which has similar problem.
> 
> The race looks like this:
> 
>   compact_zone()                    memunmap_pages
>   ==============                    ==============
>                                     __remove_pages()->
>                                       sparse_remove_section()->
>                                         section_deactivate():
>                                           a) [ Clear SECTION_HAS_MEM_MAP
>                                                is reordered to b) ]
>                                           kfree_rcu(ms->usage)
>       __pageblock_pfn_to_page
>          ......
>           pfn_valid():
>             rcu_read_lock_sched()
>             valid_section() // return true
>             pfn_section_valid()
>               [Access ms->usage which is UAF]
>                                           WRITE_ONCE(ms->usage, NULL)
>             rcu_read_unlock_sched()       b) Clear SECTION_HAS_MEM_MAP
> 
> Fix this by using rcu_replace_pointer() when clearing ms->usage in
> section_deactivate(), then it does not rely on the order of clearing
> of SECTION_HAS_MEM_MAP.

The fix itself does not look too intrusive and I guess it kind of makes
sense when you think about the ordering issue, so if we want to be
rock solid, why not. 
Does it slow down operations a lot?

I would also point out that you rcu-protect pfn_section_valid().

Regarding the pfn_to_online_page() race, that is something that every now
and then pops up, but as David said, we never seen that happening in the
wild so I guess no one really made the time to look into that.

 

-- 
Oscar Salvador
SUSE Labs
