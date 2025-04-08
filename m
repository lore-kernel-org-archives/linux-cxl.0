Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060E2686BC
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116589; cv=none; b=cEofhkagKIUZAz3aYTmNQxqMWCJUjR9CvrWile9vhfJx4jYMG9K8VfbtIVqB5hsu3UfsH7nain5ZRUFrKR6sw/E5wezfA9RzzwM4EhYGEGfNxX5mEmOfcq0xEg/e1m302DIDlZYZ6uxpB2VdkHwpn6vdII+Pl3HsF1C3zgA97LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116589; c=relaxed/simple;
	bh=rjBgU2iacb6hBJ8pQ9nQu+kSFlDifCgAo6hJywpVIEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2ht2L1zD8KMYX4U3tWGtbDzSC0KRevq/Mf3ue9+JxXVaHHQq8TyC2AuhLeFWSeL60eiXuj7zAMQlLKIqMEnv8sjCxJ6heVsVLjhBBcUzJe+RHQsSHMCx49k279ChHrP98Bpkjy0kdbPk9l372pW2W7+u1HuEF1rZxJrGc6+Wwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WERNnnpT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0e6k+DqP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQ8ybMv1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OrAaAqSk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WERNnnpT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0e6k+DqP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQ8ybMv1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OrAaAqSk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC38321186;
	Tue,  8 Apr 2025 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744116586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5zMIUf/aj6q3SKRrmU7YoUI1fIw3u1hN5+0Mrx9/Jg=;
	b=WERNnnpThQMaIFrxN5WARut0+BisWisdIAspRt7xsps/VCoLFwNv3i6H+dXTqyZGfQnVwX
	jm9IB2kwRI4hSocsN2dCbi8IhNMTQBmxg8RZcdUYHXpL/UEakEQx4JImtaRqwwwMRd9fdU
	PMoU2hy6lvRgRL4k7l0NR/aI5Zg2sVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744116586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5zMIUf/aj6q3SKRrmU7YoUI1fIw3u1hN5+0Mrx9/Jg=;
	b=0e6k+DqPZPlx9rBenoFr5tw2Qy2GTjrlYDUoVUEC6I+jshc08PoUZsYQ2mp/C2p3Isekcz
	lEorM5E6/5E/p1Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744116585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5zMIUf/aj6q3SKRrmU7YoUI1fIw3u1hN5+0Mrx9/Jg=;
	b=OQ8ybMv1L5Jic5/jjeZ228l3CnI+uzK6QsswZGEGhr7UFug9EtYXnAuxiBRpjncHw089lG
	ikcgGGyx+gvYVvATJJoUuzUFRMYA99BLhdv48msHS2JWg9iDX4FSgQtNIsScH+8xok520N
	rgyqswEpfCVB8ZXX3KPagsGFLfmb6W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744116585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P5zMIUf/aj6q3SKRrmU7YoUI1fIw3u1hN5+0Mrx9/Jg=;
	b=OrAaAqSkJTMBqEN073m2gSqZrUoErcXMtiOBnFEZYE7OW09Zg6RvTQPur4hVK9fRCimB4a
	ZBcKCODktAmsXoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F8813691;
	Tue,  8 Apr 2025 12:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zne0Fmkb9WeYJgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 08 Apr 2025 12:49:45 +0000
Date: Tue, 8 Apr 2025 14:49:43 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Message-ID: <Z_UbZ8yY7lbB15-P@localhost.localdomain>
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
> Feel free to add a Suggested-by: if you think it applies.

Sorry David, my bad, totally missed it.
I shall add it.

> Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
> would have to be a N_MEMORY check.

Yes, should be N_MEMORY.

> But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?

I glanced over it and I did not see anything wrong with it, just a
question below.

So, if Vlastimil and Harry think this is fine, we can indeed do this.
If so, I would combine this and the #1 first of this series and add
your Signed-off-by as co-autor. Is that fine by you?


> @@ -3706,10 +3698,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	if (!slab) {
>  		/*
>  		 * if the node is not online or has no normal memory, just
> -		 * ignore the node constraint
> +		 * ignore the node constraint.
>  		 */
> -		if (unlikely(node != NUMA_NO_NODE &&
> -			     !node_isset(node, slab_nodes)))
> +		if (unlikely(node != NUMA_NO_NODE && !node_state(node, N_NORMAL_MEMORY)))
>  			node = NUMA_NO_NODE;

After my first patch, slab_nodes will also contain N_MEMORY nodes, which
makes me think whether that check should be N_MEMORY?



-- 
Oscar Salvador
SUSE Labs
