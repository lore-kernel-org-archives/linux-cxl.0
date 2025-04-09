Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9426FD82
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744217898; cv=none; b=p6THD7k/65opRrn6gmSBhaNOGuQOQ2RmplJRrz5UzdrOxRlyVRqRxavb6BpfFBsvxZfSTGPAWUW9nWBB+nVje4XA/WdwWTbGVPKotTgAyxgwhAWlMwE2tONXnNU0Qsd7qb0n04rqO13AwmaQtHYMndV4hI2auUa/Q5ei1ii31Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744217898; c=relaxed/simple;
	bh=mnW2GFg4IqkS6SgY7SxVfv2bb9ReIjviHkGL/NPqNjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+3L/okgLMonwuipDH4kLPsrFbsN0GBrNUW8921BHE2sm1fgq/2bvRj67RnbrfjuWtcNr56CZ8DGdTTqNi18JaPFcckevwLJ/OeMVCSFXxqjzqj5+LdGta4rMqYmNw8g5vUWSjvrU55iaSMzTX/h7qPnV2LXw86A1iv4vB66GYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nG/KNcwD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VryLfxF4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nG/KNcwD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VryLfxF4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nG/KNcwD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VryLfxF4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nG/KNcwD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VryLfxF4"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B38D31F38D;
	Wed,  9 Apr 2025 16:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744217894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/yNPsqF0kJWQivUHk1FCQy7nHAfxv9twVK6iPfPrdA=;
	b=nG/KNcwDcIsW/uK7FgBg9uFMxMMbMdgKZGFJqQD7g3wxCWGMXFZwgwtXesBnup+RsqLqjh
	+FRG1uXjzuimm+0liQYvoojNFFIlZIhM5CCcAkay3Uy8mKpTc2m0Xqef4ONihrRIASiy1X
	WUddoKC3bIXYV2Cf4/3E38RbkMLK8IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744217894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/yNPsqF0kJWQivUHk1FCQy7nHAfxv9twVK6iPfPrdA=;
	b=VryLfxF4k3vzxpwJSDcYomsatCSdfnOM2r12zx8StboxFOFWYF5/aLUivSLmH8VjfTuPrH
	PIRVX/TDQI4iRkBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="nG/KNcwD";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VryLfxF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744217894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/yNPsqF0kJWQivUHk1FCQy7nHAfxv9twVK6iPfPrdA=;
	b=nG/KNcwDcIsW/uK7FgBg9uFMxMMbMdgKZGFJqQD7g3wxCWGMXFZwgwtXesBnup+RsqLqjh
	+FRG1uXjzuimm+0liQYvoojNFFIlZIhM5CCcAkay3Uy8mKpTc2m0Xqef4ONihrRIASiy1X
	WUddoKC3bIXYV2Cf4/3E38RbkMLK8IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744217894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+/yNPsqF0kJWQivUHk1FCQy7nHAfxv9twVK6iPfPrdA=;
	b=VryLfxF4k3vzxpwJSDcYomsatCSdfnOM2r12zx8StboxFOFWYF5/aLUivSLmH8VjfTuPrH
	PIRVX/TDQI4iRkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15B9013691;
	Wed,  9 Apr 2025 16:58:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ot2VAian9mfLAwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 09 Apr 2025 16:58:14 +0000
Date: Wed, 9 Apr 2025 18:58:04 +0200
From: Oscar Salvador <osalvador@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm,memory_hotplug: Implement numa node notifier
Message-ID: <Z_anHMHgQQM3y-w2@localhost.localdomain>
References: <20250408084153.255762-3-osalvador@suse.de>
 <202504092104.MyHeSV43-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202504092104.MyHeSV43-lkp@intel.com>
X-Rspamd-Queue-Id: B38D31F38D
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, Apr 09, 2025 at 09:44:52PM +0800, kernel test robot wrote:
> Hi Oscar,
> 
> kernel test robot noticed the following build errors:
... 
> >> drivers/base/node.c:115:5: error: redefinition of 'register_node_notifier'
>      115 | int register_node_notifier(struct notifier_block *nb)
>          |     ^
>    include/linux/memory.h:172:19: note: previous definition is here
>      172 | static inline int register_node_notifier(struct notifier_block *nb)
>          |                   ^
> >> drivers/base/node.c:121:6: error: redefinition of 'unregister_node_notifier'
>      121 | void unregister_node_notifier(struct notifier_block *nb)
>          |      ^
>    include/linux/memory.h:176:20: note: previous definition is here
>      176 | static inline void unregister_node_notifier(struct notifier_block *nb)
>          |                    ^
> >> drivers/base/node.c:127:5: error: redefinition of 'node_notify'
>      127 | int node_notify(unsigned long val, void *v)
>          |     ^
>    include/linux/memory.h:179:19: note: previous definition is here
>      179 | static inline int node_notify(unsigned long val, void *v)
>          |                   ^
>    3 errors generated.

Ah, I see. When CONFIG_MEMORY_HOTPLUG=n those come into play.
That is not a problem for the memory-notify thing because drivers/base/memory.c
gets compiled IFF CONFIG_MEMORY_HOTPLUG=y.
I am thinking two ways to fix this:

 1) Move the code for node-notify to drivers/base/memory.c
 2) Surround those functions within a
 #ifdef CONFIG_MEMORY_HOTPLUG
 ...
 #endif

Thoughts? I lean towards option #2 as it looks cleaner to me:

 diff --git a/drivers/base/node.c b/drivers/base/node.c
 index 182c71dfb5b8..3b084d71888a 100644
 --- a/drivers/base/node.c
 +++ b/drivers/base/node.c
 @@ -110,6 +110,7 @@ static const struct attribute_group *node_access_node_groups[] = {
         NULL,
  };
  
 +#ifdef CONFIG_MEMORY_HOTPLUG
  static BLOCKING_NOTIFIER_HEAD(node_chain);
  
  int register_node_notifier(struct notifier_block *nb)
 @@ -128,6 +129,7 @@ int node_notify(unsigned long val, void *v)
  {
         return blocking_notifier_call_chain(&node_chain, val, v);
  }
 +#endif
  
  static void node_remove_accesses(struct node *node)
  {



-- 
Oscar Salvador
SUSE Labs
