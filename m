Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5493C060F
	for <linux-cxl@vger.kernel.org>; Mon, 11 May 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490146; cv=none; b=khOqDqE3q2WG9cdTTlFlGz/lseSUHUoweKTtJUAkgIjpZO7RIJnJoYWwBKZfRPisKTTqnEAIed1Jfymcq/ptsZLTi1krNxaiY3InUcvXwbSGjcdWhUpUT6ApjHLStlutvNA56sFkiLxtLVZygK5Am7UBlOitNIERiFDYQ0RZmOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490146; c=relaxed/simple;
	bh=8t0pjognVrKDItaBNGHlRn9xCyw4tHQ1nXmt5skAiLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGtWyxf+gEkESMOzI3Wq9sIxaL63iMALKDmy1eDWmDDvpR0ZD+QasJIJYuqjcJ8ljvKDLEvrL5cFo2CU23KyHuENzXC8Rsmzi030lkdEANaFuJLfn9Iujx2IJA1qTZXz7P3gunZXX6q3uMZLuOqIDhB4mlMtlhvEIBe1MXVIWpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PoCU8OzY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fUlUSKNr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p2LY0gDu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j9c2qRiB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PoCU8OzY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fUlUSKNr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p2LY0gDu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j9c2qRiB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 13B0B67EAE;
	Mon, 11 May 2026 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778490143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWWQDm25jLJiRbtKOd/fbqnKTLV1LaC9qSn9EBz6Y9Q=;
	b=PoCU8OzYFqlNgawABXNYSMy2qaLFjPCaRy4eT8EnHHuFjtDcpxE9NI7RUT2WOffeY0mnd8
	BHFo2W48VCESmk6fMtFtNBmtqd2kt2pw8olUsyreeGGLzn7+94TCZB72wQarXlWCa/fL/x
	Jo9VpIR/YSVJadRJdfVtW2JeQd9Nac4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778490143;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWWQDm25jLJiRbtKOd/fbqnKTLV1LaC9qSn9EBz6Y9Q=;
	b=fUlUSKNrKwGJEiVngq+DDIB6Ntk1eRbZ2+Y5VNKG3wyRIsgukmHOf/qjlIqV+ymbrVo+XH
	b+iZsQX46Cvy4FCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778490142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWWQDm25jLJiRbtKOd/fbqnKTLV1LaC9qSn9EBz6Y9Q=;
	b=p2LY0gDuJVtgja3TPdczNQezQQLva3OYEpxP3EVpoqqIzJfhcvkOtlBtOPjp3gtJrP0hsE
	GjwyThofqFBvdxwxoPqJdh8FH99aDq03gCCYfNLBknOkfOIYdh63rrIk+9qGmbbxOw15MR
	oevWaNtGlOU7J6kN8PTWbjA5+r4npfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778490142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWWQDm25jLJiRbtKOd/fbqnKTLV1LaC9qSn9EBz6Y9Q=;
	b=j9c2qRiBQ6fZl2gTsEXipcDU866IrbfW//42tU5HoZPaZF57OlQ36BO3YebxqTW02oshGe
	OA0tMuLh+UnI1gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93B11593A3;
	Mon, 11 May 2026 09:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XpbIB2bAWpkEwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Mon, 11 May 2026 09:02:21 +0000
Date: Mon, 11 May 2026 11:02:19 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	muchun.song@linux.dev, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: Factor out altmap freeing checks
Message-ID: <agGbG3pWN_qvPWqS@localhost.localdomain>
References: <20260511084307.1827127-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511084307.1827127-1-songmuchun@bytedance.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,bytedance.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, May 11, 2026 at 04:43:07PM +0800, Muchun Song wrote:
> Use a small helper to centralize altmap freeing after verifying that all
> vmemmap pages were released. This keeps the check consistent between the
> normal teardown path and the memory hotplug error paths.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs
