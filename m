Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD92388E53
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777433537; cv=none; b=GiHl9irtq5FNNrKOG603Rk0/XhoX8ovaL5lrNP3lKOfQ7nxoL7yrxQlrDS8eGhtF6Q3MXzKRobkKx3IgHg0XGkuo4nDfpscJWFsOmcFAuKaOgLMC8Rfbr4MmFXWgGLCOZGrbgylIW+f8GAmqnH9NA5oO4ukxKECIoi3H/14hdls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777433537; c=relaxed/simple;
	bh=BYihhc2dx0Xp/vQEroKSJwGIjY4dB91OmxZhrt0s1vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4X3MmwlvOqumxviOlZ2UR3mrUoJeXSwA/CapKxjvJtf73hCC4XgvLkGNvYS8AXykuuHXEvm+FtdkO7JUfHM3Fro6T9F3DMbIkGetyiNjWygBLqkeGNu7P/Rj7Nc2bJqmtKcVfggZfWHpdGEMu+dfYgW1phz2HmM1Lc7XknCMi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J/dkKNIg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=obUrxMTS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J/dkKNIg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=obUrxMTS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J/dkKNIg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="obUrxMTS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J/dkKNIg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="obUrxMTS"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A20135BD4F;
	Wed, 29 Apr 2026 03:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777433534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkMuz1cS2oVApSEm5t+gykE+rAqHJofwoAD6Cia1xhQ=;
	b=J/dkKNIgu8elcZhN50GVIHmLaBzgpquaed+/7P9TFJ0ZEmYS3TFEtzzfaTZ8KeRtuLVZwY
	nxO8fPhAdCR+CjUEz9GeK1i5FGDoDeyvu2soe9hJvOTYz/TtzWbe+MVa3442vF6vPzrkAT
	jSf5emQugyis6e3yy3P+UjcHtYvaKm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777433534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkMuz1cS2oVApSEm5t+gykE+rAqHJofwoAD6Cia1xhQ=;
	b=obUrxMTS9ky/k3/KdLdMB9aby5iIFa91VEaGnFhAXWMk5Hi389z0e0gW6NXRK5q02XPyk5
	h65N3bwwPBI36eAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="J/dkKNIg";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=obUrxMTS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777433534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkMuz1cS2oVApSEm5t+gykE+rAqHJofwoAD6Cia1xhQ=;
	b=J/dkKNIgu8elcZhN50GVIHmLaBzgpquaed+/7P9TFJ0ZEmYS3TFEtzzfaTZ8KeRtuLVZwY
	nxO8fPhAdCR+CjUEz9GeK1i5FGDoDeyvu2soe9hJvOTYz/TtzWbe+MVa3442vF6vPzrkAT
	jSf5emQugyis6e3yy3P+UjcHtYvaKm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777433534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DkMuz1cS2oVApSEm5t+gykE+rAqHJofwoAD6Cia1xhQ=;
	b=obUrxMTS9ky/k3/KdLdMB9aby5iIFa91VEaGnFhAXWMk5Hi389z0e0gW6NXRK5q02XPyk5
	h65N3bwwPBI36eAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BC4593B0;
	Wed, 29 Apr 2026 03:32:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U2WdKb178WkeKgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 29 Apr 2026 03:32:13 +0000
Date: Wed, 29 Apr 2026 05:32:12 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <djbw@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael J Wysocki <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
Message-ID: <afF7vI_fNXs4mCVA@localhost.localdomain>
References: <94F5B89A-008A-4EDB-920F-31B4895C2699@linux.dev>
 <c6e1df1e-be5e-2468-d46e-453985ba1e79@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e1df1e-be5e-2468-d46e-453985ba1e79@huawei.com>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.dev,bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org,linux-foundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A20135BD4F

On Wed, Apr 29, 2026 at 11:08:51AM +0800, Miaohe Lin wrote:
> Right, I missed that. Thanks. But I'm still worried that there might be potential issues.
> For example, this function could be called while lock_page is held. Acquiring lock_device_hotplug
> while already holding lock_page might cause problems, though I haven't seen any specific issues yet.
> Also there might be some other potential scenarios that haven't been considered. Hope I'm just
> overthinking it. :)

lock_device_hotplug is a mutex lock, and we already take other mutex locks while
holding lock_folio in other paths, so I am not sure I see what should be special
in this case.


-- 
Oscar Salvador
SUSE Labs
