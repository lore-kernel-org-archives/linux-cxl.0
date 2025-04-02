Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E938DE9
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608523; cv=none; b=fR5AyeCD3HQVB8nuDCRRgFGidMRO9DBGZ8WGk/x3ndPuUqj7/k2ywVtNboSf3q01dIkEXPPxxwW8iNf+YtWB7wdoGl/P8cthNXy81c2mVtqbPih32Q3U2w4nXhRWGAvvPbKLFtyuuMcMpjnbS5Tk5QK3XQGHO5QR8tQSCzpumxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608523; c=relaxed/simple;
	bh=J2W7LvDFGQtX8XgoFhdUO3rwtfk23G3m7HHAPLWyyrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMzGWNqHZ/6U5ows/f2fmPF5I1s8er8gGNfsyc379eglRhFmjCSr2flR91XtIvsk1cKfLSQU7xH/uM64YE9Czw+1bMIs30s/TSzyrC0ex6F+I9aJnUqiiTXoZ+wC/yjYP6xxmR/w0/uXpdWlsj0j4khuipfnn/9Sn7599WgDYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DEKUU0rt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yX3/I4fR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XOAx7ptH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v3igOhzZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DEKUU0rt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yX3/I4fR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XOAx7ptH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v3igOhzZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD7D721190;
	Wed,  2 Apr 2025 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743608520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG22P7DxCo5cHt+oi7u2ba0p8PnBOgUBOEtLQ0J4nE0=;
	b=DEKUU0rttV2MWjSJQi/gwRKIJ5aaZhFrc0wM6CjWsGO5NseAUgs0cuE39SSB5HcnF+psVn
	8atC2B6ExhJZIwbObAk8M6PUfezbR5fazlU4i6EbFwpzfObVKjldNzTk14JSetjjO0ZWLN
	aYv9aSY7ECYbVjglHjHsjxGqMqyPP5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743608520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG22P7DxCo5cHt+oi7u2ba0p8PnBOgUBOEtLQ0J4nE0=;
	b=yX3/I4fR3q2cI9nV6PHYWaZNTRXkS8Cp/HA74t7DOxUTb+W02zoBbGYKMGvUPo4X3fqoyX
	FHD8LjRaWkzeqQDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XOAx7ptH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v3igOhzZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743608519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG22P7DxCo5cHt+oi7u2ba0p8PnBOgUBOEtLQ0J4nE0=;
	b=XOAx7ptHfzSQXto+VYp/gSOwLXIKLrKqD8HxJze5Jplt0OTllgPk32ynTKx2ZrgptsiSWV
	qbOTaYDWiLJJwwgxw/p9X2iOIBxmwfIoJIQTwFiXhOtwI5B9xY+W0a9cQg28GGDuQgG9jH
	gUlTAZFn63uY01aSJPCMMNJvCbJggK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743608519;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EG22P7DxCo5cHt+oi7u2ba0p8PnBOgUBOEtLQ0J4nE0=;
	b=v3igOhzZ1nZP1cBe7tnGSAYt9rDg/L+O/ZpDPdnB5poTOkx4o27Bp9od7y4jJug3DpovSh
	TiWWJb6bwECRsBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FD8213A4B;
	Wed,  2 Apr 2025 15:41:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FPX3BMda7WcmRgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 02 Apr 2025 15:41:59 +0000
Date: Wed, 2 Apr 2025 17:41:57 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Gregory Price <gourry@gourry.net>
Cc: Rakie Kim <rakie.kim@sk.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, joshua.hahnjy@gmail.com,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	david@redhat.com, Jonathan.Cameron@huawei.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-1axdrOVBYESrXo@localhost.localdomain>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
 <Z-0IlZgYLjogZSZO@localhost.localdomain>
 <Z-1GUrdcOeYQgkE3@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-1GUrdcOeYQgkE3@gourry-fedora-PF4VCD3F>
X-Rspamd-Queue-Id: DD7D721190
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sk.com,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,intel.com,linux.alibaba.com,redhat.com,huawei.com,skhynix.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Wed, Apr 02, 2025 at 10:14:42AM -0400, Gregory Price wrote:
> On Wed, Apr 02, 2025 at 11:51:17AM +0200, Oscar Salvador wrote:
> > > +	case MEM_OFFLINE:
> > > +		if (!node_state(nid, N_MEMORY))
> > > +			sysfs_wi_node_release(nid);
> > 
> > This check is not needed.
> > 
> > If status_change_nid is different than NUMA_NO_NODE, it means that the memory
> > state of the numa node was effectively changed.
> > So doing:
> >  
> >   case MEM_OFFLINE:
> >           sysfs_wi_node_release(nid)
> >  
> > is enough.
> 
> offline_pages will call this callback unconditionally any time it's
> called (and succeeds).  If 2 dax devices online into the same node, it's

Yes, this callback will be called whenever {online,offline}_pages succeeds, but
status_change_nid will be != NUMA_NO_NODE IFF the node state changes.
And you already have the check

 if (nid < 0)
    goto out

at the beginning, which means that all {offline,online}_pages operation that
do not carry a numa node state change will be filtered out there.

Makes sense, or am I missing something?

-- 
Oscar Salvador
SUSE Labs
