Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579218D
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743587484; cv=none; b=pOSMjXhAaVQYttCA987vGFuHgHHfSyMo1mCFKIWI4PixdTdhGLhh2AzjZAP2GISTAe/v7El8AEmz8du4D1S3/oxqZheSKXyQi22H90WTN4TIHSv2/Rd0zZAOExjfDvqk+Gym5Bv0dRGNrFABVi7ePxFYzzCMHbXc2IDl1egoXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743587484; c=relaxed/simple;
	bh=ZZmdhK0KFUzrmEzlc6FDQSy4/9xR/0o5UH3Erqg8HWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Poappou3GKbpWH4Um2BgfHAUS5kJmTubnSRtlp41D4nymwDGUhxpug0QfMGuEp42/TNvgBiy7IrcUzjCbZHGJDBnkdat//90bXpLKpe2hSGSQCVOzpNjMIJjFc/PqIswnBo9Kdk1uDDTAFa5euwDe3v97PygVlPIRAKPE0idFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X1QyQou5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qSkwyygT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uIxj7Jx7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cEkFFwzc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X1QyQou5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qSkwyygT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uIxj7Jx7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cEkFFwzc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBEC11F455;
	Wed,  2 Apr 2025 09:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743587480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h0MejSQI3KBOnek2/gBRpxyi+9smv0xNIt5VJGPse8=;
	b=X1QyQou5LY25WyQ4IW/sqDCwutVg8d4tqL0wPH5o5HudyqpweqJqZqUQzqq2CgScN9p+kJ
	5uhBO1G14XFr15oAEsbu7ULD+SIFgHqwPVQCsIpmaZ7dQBKwRz9TuPw9zx1k+Vwsa+Kz9H
	mQC2yNmEWIgiB7xgPip+o2Sf3y29Pu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743587480;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h0MejSQI3KBOnek2/gBRpxyi+9smv0xNIt5VJGPse8=;
	b=qSkwyygTSKmfiFPYnMxoa1nIA8Y4Ors+1hXJK4S5QmggYEOvNDQhPT6yLgWIPVjIdZBiG8
	MI/Hg1XDcE9rPQBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743587479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h0MejSQI3KBOnek2/gBRpxyi+9smv0xNIt5VJGPse8=;
	b=uIxj7Jx7XqskoKJMUhK/tF8+nEG1pcmXjFhMwiEQVUVC8e29zAZ0Heo+3uKOOphF1mDzHa
	NZ8ECE1j8AWHyR3ARz2R0yuDSd8MCDSZPzfdYt6YtEU6CqagaL94XP2rmDHgP+xYY0zyTL
	A1xognHRQ9vnbHsHurdk1i0opHg0D+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743587479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h0MejSQI3KBOnek2/gBRpxyi+9smv0xNIt5VJGPse8=;
	b=cEkFFwzcnKl1nbHJudO4/EF9dubIcflkaaEpkC/gBzKHvBfAIk2TgCbxdZt5lUKa2uRlTe
	sY7TwOyaFgVBcJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 319E313A4B;
	Wed,  2 Apr 2025 09:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DltCZcI7WdJTAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 02 Apr 2025 09:51:19 +0000
Date: Wed, 2 Apr 2025 11:51:17 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Rakie Kim <rakie.kim@sk.com>
Cc: gourry@gourry.net, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-0IlZgYLjogZSZO@localhost.localdomain>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402014906.1086-4-rakie.kim@sk.com>
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gourry.net,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,intel.com,linux.alibaba.com,redhat.com,huawei.com,skhynix.com,sk.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 02, 2025 at 10:49:04AM +0900, Rakie Kim wrote:
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

Sorry to jump at v5, and maybe this was already discussed but:

> +static int wi_node_notifier(struct notifier_block *nb,
> +			       unsigned long action, void *data)
> +{
> +	int err;
> +	struct memory_notify *arg = data;
> +	int nid = arg->status_change_nid;
> +
> +	if (nid < 0)
> +		goto notifier_end;
> +
> +	switch(action) {
> +	case MEM_ONLINE:
> +		err = sysfs_wi_node_add(nid);
> +		if (err) {
> +			pr_err("failed to add sysfs [node%d]\n", nid);
> +			return NOTIFY_BAD;
> +		}
> +		break;
> +	case MEM_OFFLINE:
> +		if (!node_state(nid, N_MEMORY))
> +			sysfs_wi_node_release(nid);

This check is not needed.

If status_change_nid is different than NUMA_NO_NODE, it means that the memory
state of the numa node was effectively changed.
So doing:
 
  case MEM_OFFLINE:
          sysfs_wi_node_release(nid)
 
is enough.

-- 
Oscar Salvador
SUSE Labs
