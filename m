Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28891B6CFE
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744134948; cv=none; b=sPAPK0BZ1Gs22mbg8CLIiBOSR6+KrxDmPAdxGHnnvhpRkDwRiwBlCrEjJxNOOVe423BF1JvcRPiSHqiRQ69qGG3TIxee7qBV+ny629H7pf0tL+73JqzWL+DTbPLIALeFHdWMWDVU89QwH2vUg/QHjbY0SKJpxeC3YAC8VXgenVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744134948; c=relaxed/simple;
	bh=+52Wx0ZBKH7qIBXNKXZ+y4sHU+3pzhNiphcyd+oNU7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlbZIJtiE7S+5IivEQeEnikNHyaZESDMWpQMYpH1IJLc8+5jlza4vZUEDdUnwhGuhod4irZ7LK5C+Apjk5sighlDziMyuiDsDtwGpokbk1nKThSL3mVKnEgVVIa1dr9ixUBw4EQZYflMeTstds5QHBjOHvEnRR/Ef0Pyy/+pmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4XmL1B+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NtYIA8XS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4XmL1B+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NtYIA8XS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4XmL1B+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NtYIA8XS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4XmL1B+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NtYIA8XS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07F0F2116C;
	Tue,  8 Apr 2025 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744134945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILcTKFwHSs+Kj97k6bGMomNdzQtsb2/Hina4A04EDn8=;
	b=R4XmL1B+eODZABxcxJrDlqF/5AhLatuwjT3EuGejEz0/edvN0ou4ndGl+VXwu6BrWE9fr/
	9rPmiFhtFCtH4O3SXaCtc/lx9uQrKKwpa7o0xE7uEPKzCgMSmHmIkEW5s9gKvg4oUJdbtp
	nbOwbzWPZPEpPqJpBzmSSi/7A79Pv1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744134945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILcTKFwHSs+Kj97k6bGMomNdzQtsb2/Hina4A04EDn8=;
	b=NtYIA8XSHu5jGlHZmTyi3M8CVErqjaovkFMLuuKLmJHOiHR60L5AVCEoSC1og2fbKdx7dJ
	an6grO8U4lOo+pCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744134945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILcTKFwHSs+Kj97k6bGMomNdzQtsb2/Hina4A04EDn8=;
	b=R4XmL1B+eODZABxcxJrDlqF/5AhLatuwjT3EuGejEz0/edvN0ou4ndGl+VXwu6BrWE9fr/
	9rPmiFhtFCtH4O3SXaCtc/lx9uQrKKwpa7o0xE7uEPKzCgMSmHmIkEW5s9gKvg4oUJdbtp
	nbOwbzWPZPEpPqJpBzmSSi/7A79Pv1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744134945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILcTKFwHSs+Kj97k6bGMomNdzQtsb2/Hina4A04EDn8=;
	b=NtYIA8XSHu5jGlHZmTyi3M8CVErqjaovkFMLuuKLmJHOiHR60L5AVCEoSC1og2fbKdx7dJ
	an6grO8U4lOo+pCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E70A213A1E;
	Tue,  8 Apr 2025 17:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gBf7NyBj9WcmBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 08 Apr 2025 17:55:44 +0000
Message-ID: <d581417f-7756-4ce7-8a5a-49149db33b8c@suse.cz>
Date: Tue, 8 Apr 2025 19:55:40 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Harry Yoo <harry.yoo@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com> <Z_UwPmyxyu8YNLG_@harry>
 <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 4/8/25 16:25, David Hildenbrand wrote:
> On 08.04.25 16:18, Harry Yoo wrote:
>> On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
>>> On 08.04.25 10:41, Oscar Salvador wrote:
>>>> Currently, slab_mem_going_going_callback() checks whether the node has
>>>> N_NORMAL memory in order to be set in slab_nodes.
>>>> While it is true that gettind rid of that enforcing would mean
>>>> ending up with movables nodes in slab_nodes, the memory waste that comes
>>>> with that is negligible.
>>>>
>>>> So stop checking for status_change_nid_normal and just use status_change_nid
>>>> instead which works for both types of memory.
>>>>
>>>> Also, once we allocate the kmem_cache_node cache  for the node in
>>>> slab_mem_online_callback(), we never deallocate it in
>>>> slab_mem_off_callback() when the node goes memoryless, so we can just
>>>> get rid of it.
>>>>
>>>> The only side effect is that we will stop clearing the node from slab_nodes.
>>>>
>>>
>>> Feel free to add a Suggested-by: if you think it applies.
>>>
>>>
>>> Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
>>> would have to be a N_MEMORY check.
>>>
>>>
>>> But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?
>> 
>> The following commit says that SLUB has slab_nodes thingy for a reason...
>> kmem_cache_node might not be ready yet even when N_NORMAL_MEMORY check
>> says it now has normal memory.
> 
> node_states_set_node() is called from memory hotplug code after 
> MEM_GOING_ONLINE and after online_pages_range().
> 
> Pages might be isolated at that point, but node_states_set_node() is set 
> only after the memory notifier (MEM_GOING_ONLINE) was triggered.
> 
> So I don't immediately see the problem assuming that we never free the 
> structures.

Hm, I think it still exists. So consider:

- slab_mem_going_online_callback() creates kmem_cache_node for the new node
for existing caches under the mutex

Then a cache creation races with "node_states_set_node() is set only after
the memory notifier (MEM_GOING_ONLINE) was triggered" in a way that it
doesn't see the node set yet - kmem_cache_node for the new node on the new
cache will be missing.

The root issue is node_states_set_node() doesn't happen under slab_mutex.
slab_nodes update happens under the slab_mutex to avoid this race.

And once we have slab_nodes for this cache creation vs hotplug
synchronization then it's also to use it for the ___slab_alloc() checks,
although they could indeed now use node_state(node, N_NORMAL_MEMORY) once we
create the node structures and set bits in slab_nodes for N_MEMORY.

Maybe it could be solved at the memory hotplug level if it we had a new
state e.g.  N_GOING_ONLINE that was set before calling MEM_GOING_ONLINE
callbacks and was never reset. Then init_kmem_cache_nodes() could iterate on
that. But I'm not sure if slab_mutex would provide necessary synchronization
guarantees here so that the addition of node to MEM_GOING_ONLINE can't be
missed, hm.

> But yeah, this is what I raised below: "Not sure if there are any races 
> to consider" :)
> 
>> 
>> @Vlastimil maybe a dumb question but why not check s->node[nid]
>> instead of having slab_nodes bitmask?

You mean check i.e. in ___slab_alloc()? We'd still be prone to miss a
kmem_cache_node creation and degrade the particular cache that way, we'd
just avoid a NULL pointer dereference.


