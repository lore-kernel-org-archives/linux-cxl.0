Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606721B1AB
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002886; cv=none; b=Z5yWXYMVRhTh4epsunF9yEfTPuZiaK4+aEMovtnOHVJfmQf8i0XHUdzAD4vU3O1Nwy/h8OqiMNDGrNiJJsGq/wbite0wc4g4aer9v1iJB2m71GAaXxa1ApTbePOAIB3uTG006SBmq1WiCuvbgMwJsMfKgqM/2g7Q55h3GIjR574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002886; c=relaxed/simple;
	bh=yGE3G/H3RFORBXlLYutaRqtVNPBxmwmx67nYDSWtzIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcFHjnOXu5zlJwUSvokcnIspdSJuMKXKFkseaOFOwiBZ7cUOFJPgFj7KpMWn5oB+m0xX+RksEGm9diwuaeBeAaeAnq/phoOawY4iKYmll6vJ5OpZi3hQ+Zu/t03Bt0QxqamkwWX/+qibRMTAJs/7QyXhxUcDqbTJ2LM2OHd4WYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A4rpqwt+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WZG4kVlg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A4rpqwt+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WZG4kVlg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A4rpqwt+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WZG4kVlg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A4rpqwt+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WZG4kVlg"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71BF3218A4;
	Wed, 30 Apr 2025 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746002877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ/SU+1kzMe1oWfhizQGoaQEDlPJx/6TZT65l5Z1oSs=;
	b=A4rpqwt+ZUyrhe2gvbZrmYQPBmY8oak9DS+v6BlekisISBVQGqXIgwwN879mbDD4/bdrIS
	BmsiHGmZJeqKOmL3B1eyd1lfKo4ERXc/Ar39sLDUrJxi6vZuPste89ApkEuBBOp6qwssAs
	j+NA7P7mpXkN669FtpOq0zdZ57iPAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746002877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ/SU+1kzMe1oWfhizQGoaQEDlPJx/6TZT65l5Z1oSs=;
	b=WZG4kVlgVpJUiUOvnC70CwQVMzuPqoivqcoiUo6QWO8VtoVyGWjx+J6X8ARygOkzNBbmbu
	1jCcILSgKnILLVBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746002877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ/SU+1kzMe1oWfhizQGoaQEDlPJx/6TZT65l5Z1oSs=;
	b=A4rpqwt+ZUyrhe2gvbZrmYQPBmY8oak9DS+v6BlekisISBVQGqXIgwwN879mbDD4/bdrIS
	BmsiHGmZJeqKOmL3B1eyd1lfKo4ERXc/Ar39sLDUrJxi6vZuPste89ApkEuBBOp6qwssAs
	j+NA7P7mpXkN669FtpOq0zdZ57iPAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746002877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ/SU+1kzMe1oWfhizQGoaQEDlPJx/6TZT65l5Z1oSs=;
	b=WZG4kVlgVpJUiUOvnC70CwQVMzuPqoivqcoiUo6QWO8VtoVyGWjx+J6X8ARygOkzNBbmbu
	1jCcILSgKnILLVBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0235713A25;
	Wed, 30 Apr 2025 08:47:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sEwsOLzjEWiiFgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 30 Apr 2025 08:47:56 +0000
Date: Wed, 30 Apr 2025 10:47:51 +0200
From: Oscar Salvador <osalvador@suse.de>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Message-ID: <aBHjt9D7m03FOPCJ@localhost.localdomain>
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com>
 <Z_UwPmyxyu8YNLG_@harry>
 <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
 <d581417f-7756-4ce7-8a5a-49149db33b8c@suse.cz>
 <60ae4d6b-3ace-482b-9945-1261003f3785@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60ae4d6b-3ace-482b-9945-1261003f3785@redhat.com>
X-Spam-Score: -4.30
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
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Apr 08, 2025 at 08:18:32PM +0200, David Hildenbrand wrote:
> We could by grabbing the mutex in MEM_GOING_ONLINE and putting it in
> MEM_CANCEL_ONLINE / MEM_ONLINE when a node is going online.

Hi guys,

After a few busy days I have been revisiting this.

I checked the proposal of slab_mutex spanning GOING_ONLINE <-> ONLINE,
and I did not see any issue.

The only concern I had is that we might be calling some slab function from
{online,offline}_pages() that also takes the mutex.
I am not aware of any though, and quickly checking did not reveal
anything either.

If there is any will be quickly revealed though :-).

So, unless there is an opposition, I can move forward and see how it
looks.

Thoughts?


-- 
Oscar Salvador
SUSE Labs
