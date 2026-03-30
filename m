Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1233A6F17
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857600; cv=none; b=Z4cDHoavpWEvVKny+2HZvu+W0mubsbpswUMeHxE3SFEnB7jYaquDoTZfxyaRXfQ2FSXeMTpo+tHMeGVEYlTfHWuygfXKCOjKvbQAY+dHvveuGhSF8Mf/oZYi/Z1QMnjN44Z63b37ziDL/w9lU3QA6kF/CorH8koFlZA8eYeHe6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857600; c=relaxed/simple;
	bh=On+5TNT/a2qCCsGWnRoKiqe9wAlWY5lMDN2hymFFVTo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=iHDOXmglMYd6mIfU4iq4FdrrbBN/FiGJUZ7OmaRi7XQVYbbL8ztLCDJ3OmH6nXMHJiU5arSrsjnCFxsKOAJ539K+9+MH5ntaw0OaJ1iuCR9YfcWxPc0kU8iJX1ybhCIwFfKHy2zugeyni0SzJz+IzfoPwvIS5fY2fUR5Msh7FH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DVqKR34e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e9hB2+q/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DVqKR34e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e9hB2+q/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DVqKR34e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e9hB2+q/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DVqKR34e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e9hB2+q/"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E7794D521;
	Mon, 30 Mar 2026 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774857597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2MuVzNnvc+lp/lx6vvEM5pbvKJ4+UfTZF7WaWKGgmSM=;
	b=DVqKR34e8x2HMvRSmpDKiH0ZzxxffumGGsv2mKN541UTA4zA4g/NZEg/qp06jdj+SWjR7R
	O7sTl2vDlkRwluT3mDhi6n4uO1w0QZ5cLKYeMXZHaMG+x3DLe2H3uQ4UUorzvlKeUilJlI
	8MzHB4AU2JJuuT5mwWzcISuYc+jv4jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774857597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2MuVzNnvc+lp/lx6vvEM5pbvKJ4+UfTZF7WaWKGgmSM=;
	b=e9hB2+q/S4daTKHe+ReZb7hycDHcyMs7qr8TcGiUlj0XXmUWrewMVB3ND9yiRJxaQPWyl9
	WM7I1yMFoYNWaZBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DVqKR34e;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="e9hB2+q/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774857597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2MuVzNnvc+lp/lx6vvEM5pbvKJ4+UfTZF7WaWKGgmSM=;
	b=DVqKR34e8x2HMvRSmpDKiH0ZzxxffumGGsv2mKN541UTA4zA4g/NZEg/qp06jdj+SWjR7R
	O7sTl2vDlkRwluT3mDhi6n4uO1w0QZ5cLKYeMXZHaMG+x3DLe2H3uQ4UUorzvlKeUilJlI
	8MzHB4AU2JJuuT5mwWzcISuYc+jv4jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774857597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2MuVzNnvc+lp/lx6vvEM5pbvKJ4+UfTZF7WaWKGgmSM=;
	b=e9hB2+q/S4daTKHe+ReZb7hycDHcyMs7qr8TcGiUlj0XXmUWrewMVB3ND9yiRJxaQPWyl9
	WM7I1yMFoYNWaZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C53A4A0A2;
	Mon, 30 Mar 2026 07:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id t/SEAX0tymkGQAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 30 Mar 2026 07:59:57 +0000
Message-ID: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
Date: Mon, 30 Mar 2026 09:59:56 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Strategies for memory deallocation/movement for
 Dynamic Capacity Pooling
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2E7794D521

Hi all,

during discussion with our partners regarding implementing dynamic 
capacity devices (DCD) on CXL the question has been brought up if
we can somehow 'steer' which memory page to move.
The problem is that for dynamic capacity devices we have a certain
freedom which memory page to move/deallocate, so ideally there would
be a strategy which pages to move/deallocate.
Should it be per application/cgroup?
Does it make sense to move individual pages from one application/cgroup
or would it be better to move all pages from the application/cgroup?
Should we implement something (eg via madvise()) to allow applicaitons
to influence the policy?
If so, what would that be?

So quite some things to discuss; however, not sure if this isn't too
much of an arcane topic which should rather be directed at places like
LPC. But I'll let the PC decide.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

