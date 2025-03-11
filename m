Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE525FA33
	for <linux-cxl@vger.kernel.org>; Tue, 11 Mar 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710918; cv=none; b=PbwIG0IYB30dJqdYt51yp4tn+Q6BotTkC652N8ui01u57/B3xQpt9BLx6sGDo4YVL63EfwC5Qzat2/Iyjdg9Zd+n9F/u9SntaKVWpwq72ob9GhwAfzE5TNfrtfMOAR9GOTg1y+tQ0z3MxFdyJQOQaEJNMTAyn+izC3fAsQq9+Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710918; c=relaxed/simple;
	bh=/svaRfiYI4lkEZDADjUZDmB8YqnexxNtUQwHPcBD4/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAWhFa5Hwhq7YCkqeUxYRCwxXAW4OetuE4HDS9mYZu163VM466RLaElWq+m7n3mQQA7s5XTrsdz9eegJlz8XWOtCI0QTUlD551ZWT7r0CUxGtXlADGgYwpW6Nc6BxNsd/nxGVX1V8gKadbId0DJpg+X9XZPVWJORaQGitIik2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=asDfZYqy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=27gEdoBE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=asDfZYqy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=27gEdoBE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="asDfZYqy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="27gEdoBE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="asDfZYqy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="27gEdoBE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96C4C1F7F8;
	Tue, 11 Mar 2025 16:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741710914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqLnaJ6B5vJlBfOyqtzWOpIISZfLjXQhQVAEiGNZ9e8=;
	b=asDfZYqyBkCyzr8CJ2e6ehtldUBJ0YHzjFOXMsjzXK72X/kD1U4ymb16vbtaY52At+Tceo
	ffbDTrWZaj64yLfuHFrRwJIWyl3sWSvyS9VPvmq1OH2jg02c5/H1aBtVZkBxAzo1E5XcUb
	wF47e2seMEHyC/y6Dx5Nmgje8fbeV7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741710914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqLnaJ6B5vJlBfOyqtzWOpIISZfLjXQhQVAEiGNZ9e8=;
	b=27gEdoBEv63Z8w2nop7f6TK06Gm+z8fi7Sft2rbkVqj1Crb1D0tevf4nMUaBNVoZjqe5eM
	KiPmHOlii3Ax5ZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741710914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqLnaJ6B5vJlBfOyqtzWOpIISZfLjXQhQVAEiGNZ9e8=;
	b=asDfZYqyBkCyzr8CJ2e6ehtldUBJ0YHzjFOXMsjzXK72X/kD1U4ymb16vbtaY52At+Tceo
	ffbDTrWZaj64yLfuHFrRwJIWyl3sWSvyS9VPvmq1OH2jg02c5/H1aBtVZkBxAzo1E5XcUb
	wF47e2seMEHyC/y6Dx5Nmgje8fbeV7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741710914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqLnaJ6B5vJlBfOyqtzWOpIISZfLjXQhQVAEiGNZ9e8=;
	b=27gEdoBEv63Z8w2nop7f6TK06Gm+z8fi7Sft2rbkVqj1Crb1D0tevf4nMUaBNVoZjqe5eM
	KiPmHOlii3Ax5ZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 233CE132CB;
	Tue, 11 Mar 2025 16:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fxP5BUJm0GeTAwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 11 Mar 2025 16:35:14 +0000
Date: Tue, 11 Mar 2025 17:35:12 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Zi Yan <ziy@nvidia.com>
Cc: Gregory Price <gourry@gourry.net>, David Hildenbrand <david@redhat.com>,
	Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z9BmQH5EMpC1noCz@localhost.localdomain>
References: <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
 <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
 <Z9BdwFZ-ZRpMSabG@gourry-fedora-PF4VCD3F>
 <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7A60A7B1-0BFF-45ED-8A11-06F0D5286723@nvidia.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gourry.net,redhat.com,gmail.com,lists.linux-foundation.org,kvack.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, Mar 11, 2025 at 12:08:03PM -0400, Zi Yan wrote:
> Or a new option for memmap_on_memory like “use_whole_block”, then hotplug
> code checks altmap is NULL or not when a memory block is plugged.
> If altmap is NULL, the hot plugged memory block is used as memmap,
> otherwise, the memory block is plugged as normal memory. The code also
> needs to maintain which part of the altmap is used to tell whether
> the memmap’d memory block can be offline or not.

One of the first versions of memmap_on_memory did not have the restrictions of
working only per memblock, so one could hot-plug more than a memory-block worth
of memory using memmap_on_memory, meaning that we could end up with memblocks
only containing memmap pages.

Now, we decided to go with only one memblock at a time because of simplicity
and also because we did not have any real-world scenarios that needed that
besides being able to have larger contiguos memory for e.g: hugetlb.

If people think that there is more to it, we could revisit that and see how it
would look nowadays. Maybe it is not too much of a surgery. (or maybe it is :-))
 

-- 
Oscar Salvador
SUSE Labs
