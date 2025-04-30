Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BC21ADB0
	for <linux-cxl@vger.kernel.org>; Wed, 30 Apr 2025 08:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003430; cv=none; b=rO8Hi8oFEs4Bm70C51Eei78o6omVK/63iJxEoYx2gHYTf/ivUr0kl54PajZi+HLRLmKestOYFMVaLtiEeeWAHB1/CzUj1b4vX9MvKuGOdC3JcuUs6ymXiE5nGeQv6WAbX3GM6ZJ1QfhveO37A4ScLvQ+BjWki4rW44GNOFM7FCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003430; c=relaxed/simple;
	bh=ii7pFgsEuqLd30OkRSllkNrI8GIJO+CXx6sFyJ2x2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+yqFG106kyMt6S+5JrcejSprHO8mt+FZQx5y47qKOLz4T6kgLklyZ2t33lMCiiseWkcjkKMNG6VJ/Kkufq613HUCvBl2BQXMfHuO7ysfMsljF1GvSBMGAB9h+WZf0oEYQaKM1Esvh+PqWmgUNZuZubTZEkN70dDwm19JHaw3oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02D3C2117A;
	Wed, 30 Apr 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E450C13A25;
	Wed, 30 Apr 2025 08:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qtRuN+LlEWiMGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 30 Apr 2025 08:57:06 +0000
Message-ID: <f06d735c-894a-4c93-bd1b-817e9e978be6@suse.cz>
Date: Wed, 30 Apr 2025 10:57:06 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
Content-Language: en-US
To: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com> <Z_UwPmyxyu8YNLG_@harry>
 <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
 <d581417f-7756-4ce7-8a5a-49149db33b8c@suse.cz>
 <60ae4d6b-3ace-482b-9945-1261003f3785@redhat.com>
 <aBHjt9D7m03FOPCJ@localhost.localdomain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <aBHjt9D7m03FOPCJ@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 02D3C2117A
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On 4/30/25 10:47, Oscar Salvador wrote:
> On Tue, Apr 08, 2025 at 08:18:32PM +0200, David Hildenbrand wrote:
>> We could by grabbing the mutex in MEM_GOING_ONLINE and putting it in
>> MEM_CANCEL_ONLINE / MEM_ONLINE when a node is going online.
> 
> Hi guys,
> 
> After a few busy days I have been revisiting this.
> 
> I checked the proposal of slab_mutex spanning GOING_ONLINE <-> ONLINE,
> and I did not see any issue.
> 
> The only concern I had is that we might be calling some slab function from
> {online,offline}_pages() that also takes the mutex.
> I am not aware of any though, and quickly checking did not reveal
> anything either.
> 
> If there is any will be quickly revealed though :-).
> 
> So, unless there is an opposition, I can move forward and see how it
> looks.
> 
> Thoughts?

I feel a bit uneasy about it, while maintaining slab_nodes doesn't seem like
a huge issue to me, so dunno. Maybe David has a better idea now :)
