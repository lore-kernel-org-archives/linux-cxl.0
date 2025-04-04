Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6CD19ABC2
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756205; cv=none; b=qZEiptrcEWI6jPNsFm88/nAUtOwjksgO3fZAeFgZI6xJdN4VpbkoEIHHSUcFEdaegHZWjejw6jkax95BVt3NGJ/CFrj//FKNAvz6jsflWAz7aMClTgnhfyunhib4yY87vMtjmz1TVh2Mxe2hMdfn9GFKtrfDMcu8zfaZTTgtVAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756205; c=relaxed/simple;
	bh=xTZjdyz7Hd09YT23p68mLHwQ4x1O7/z84eAdnFI1vPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjGMvHDX5NXN8eQClRexl5qknbvk36AgXyqvLu4Ktyy+SCrUL8SvRGJSFFX/HWgjE7CifC2HpPitSQ6fpePyeLhMeQr/FsqcazyvPq/FqmEKao8amDXa/qM0Rc9wtu+nt5KhOKB2VBHunAoHvqCNiPV2lyvfHYtBUYVjA2vYEyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=POTkSHk0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cn32Yqx+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ED9O2Vx0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=69FstQe9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="POTkSHk0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cn32Yqx+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ED9O2Vx0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="69FstQe9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACF401F385;
	Fri,  4 Apr 2025 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743756201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OrZgIzLm3PyWeKUSNlcKFVAqLYDLMpRNMU+d2NZfOsE=;
	b=POTkSHk0i8Pb4qfwOG3XpgMZMazbhvYt2nQi00ULHevtqUgSyvJthWeCQg1JsmVNX2nHpt
	L2q4gstO5+dB57+gZyH+Te7LpuQNzcz7Bv6nCkO8+sFNGVaq6K/IgpDO3rnaoNKAOUH5TT
	x+XbG4PnT/mEeFftxF8GvYyw/PGYOMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743756201;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OrZgIzLm3PyWeKUSNlcKFVAqLYDLMpRNMU+d2NZfOsE=;
	b=cn32Yqx+3rr4MqtGfBzfHXiFyrBsZF9h82Facd3KMo2ojv3Y0cnltjhQXFe86ZolzrtfoI
	GzY0Fl/TD5HxI4Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ED9O2Vx0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=69FstQe9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743756200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OrZgIzLm3PyWeKUSNlcKFVAqLYDLMpRNMU+d2NZfOsE=;
	b=ED9O2Vx0E8yHxc7oS7PQlGnuI6L4rcC+V3IAK0rajq+1rZdW5Br7OcjuUNQY4EINXgRmjM
	dla+CUwyuy87W/p1XEYXrQi4oDc3uj3L2q3dKXIbuxOaJw5R34G2d5SIVQdxHBLdR0bJSO
	k9+GPuDJxmbEDMFJR2ELVF9A2zXGFsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743756200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OrZgIzLm3PyWeKUSNlcKFVAqLYDLMpRNMU+d2NZfOsE=;
	b=69FstQe9GZGgTWIuTDFf4ZPVfR9uLJDZLTAAWcyoZcP3ogXeCUSxs2aRlfyplPFUqY0bcF
	0oaqhW32i3osceCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDCFA13691;
	Fri,  4 Apr 2025 08:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gCVpM6eb72fofAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Fri, 04 Apr 2025 08:43:19 +0000
Date: Fri, 4 Apr 2025 10:43:18 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, gourry@gourry.net, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v6 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z--bppMUIo5k5eOF@localhost.localdomain>
References: <20250404074623.1179-1-rakie.kim@sk.com>
 <20250404074623.1179-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404074623.1179-4-rakie.kim@sk.com>
X-Rspamd-Queue-Id: ACF401F385
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gourry.net,kvack.org,vger.kernel.org,gmail.com,intel.com,linux.alibaba.com,redhat.com,huawei.com,skhynix.com,sk.com];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Apr 04, 2025 at 04:46:21PM +0900, Rakie Kim wrote:
> The weighted interleave policy distributes page allocations across multiple
> NUMA nodes based on their performance weight, thereby improving memory
> bandwidth utilization. The weight values for each node are configured
> through sysfs.
> 
> Previously, sysfs entries for configuring weighted interleave were created
> for all possible nodes (N_POSSIBLE) at initialization, including nodes that
> might not have memory. However, not all nodes in N_POSSIBLE are usable at
> runtime, as some may remain memoryless or offline.
> This led to sysfs entries being created for unusable nodes, causing
> potential misconfiguration issues.
> 
> To address this issue, this patch modifies the sysfs creation logic to:
> 1) Limit sysfs entries to nodes that are online and have memory, avoiding
>    the creation of sysfs entries for nodes that cannot be used.
> 2) Support memory hotplug by dynamically adding and removing sysfs entries
>    based on whether a node transitions into or out of the N_MEMORY state.
> 
> Additionally, the patch ensures that sysfs attributes are properly managed
> when nodes go offline, preventing stale or redundant entries from persisting
> in the system.
> 
> By making these changes, the weighted interleave policy now manages its
> sysfs entries more efficiently, ensuring that only relevant nodes are
> considered for interleaving, and dynamically adapting to memory hotplug
> events.
> 
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Yunjeong Mun <yunjeong.mun@sk.com>

For the memory-hotplug bits: Reviewed-by: Oscar Salvador
<osalvador@suse.de<

Just one thing that caught my eye:

Cannot add_weighted_interleave_group be __init? AFAICS, it only gets
called at boot time?


-- 
Oscar Salvador
SUSE Labs
