Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8A35DA63
	for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150506; cv=none; b=Ra6r78z5gXXLA19s0axY/T/h9HKkSzUEjWe3QwKEMXSbtTH6khEuN20yDxMWA8rjhceS5JjQKaMkJYjkSAdPrlp+uQUf2+609ZPrreRZRCuxUIpSUUaqzIg9rjuaNBvD6RZuEhv06BE6rC8cyFztlWLdoJ6IAPotrNUuUqfZ0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150506; c=relaxed/simple;
	bh=6ULNw+7qjHeF3d4yTKwQLQi3THOD2jv5jeXt1zc3dEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b/4U+/WpeyDbz6d5YThCRUggwcuYv8+rNIvE0catrCbe4MY9U2OcNtyZ2frlgL27Q6YZxVPqBCBiqEAkQNvo8LjuC2IupaMYoYbTkOSm9Mz0lUhi0KGcODxdFV18QC7zPcXb5Vmt2Amv4R0UPXIZKD0b1EXoc9p4OZwLxRcMg0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZrEZXGp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5oqspILO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2ZrEZXGp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5oqspILO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZrEZXGp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5oqspILO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2ZrEZXGp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5oqspILO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F1225BDC6;
	Tue, 14 Apr 2026 07:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776150503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt6kw4jL5p1XsC5RPgmFgPFuBvYztobMsY4SgGXfGIc=;
	b=2ZrEZXGpnbNVpWl5bb3rjDubn8n/uzqsSwnNSubmdUKYn061Yu/3GKbR4Z7I9Y5S/dOu1l
	hDMahK0ZAntq0tJ4cRPcNY52JJ//x7qsq2RUWV1SbnAAfRpbg9Elsu/Gzu0y3ewcO0FtWX
	3O/ukZPgqns4u3oHem6D/H3tbr1lCuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776150503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt6kw4jL5p1XsC5RPgmFgPFuBvYztobMsY4SgGXfGIc=;
	b=5oqspILO4TNmq/oBc+DBMhbzi6+Zy/7eixVJk+OPjH6QOcOcz2RM0hUAJUKLnc4J5TJRGa
	G3hPwIt2kWJW5tCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776150503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt6kw4jL5p1XsC5RPgmFgPFuBvYztobMsY4SgGXfGIc=;
	b=2ZrEZXGpnbNVpWl5bb3rjDubn8n/uzqsSwnNSubmdUKYn061Yu/3GKbR4Z7I9Y5S/dOu1l
	hDMahK0ZAntq0tJ4cRPcNY52JJ//x7qsq2RUWV1SbnAAfRpbg9Elsu/Gzu0y3ewcO0FtWX
	3O/ukZPgqns4u3oHem6D/H3tbr1lCuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776150503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt6kw4jL5p1XsC5RPgmFgPFuBvYztobMsY4SgGXfGIc=;
	b=5oqspILO4TNmq/oBc+DBMhbzi6+Zy/7eixVJk+OPjH6QOcOcz2RM0hUAJUKLnc4J5TJRGa
	G3hPwIt2kWJW5tCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14E424B302;
	Tue, 14 Apr 2026 07:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1fzmA+fn3WlsPQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 14 Apr 2026 07:08:23 +0000
Message-ID: <38952332-dad4-4d17-a9c1-5c25d79f67b4@suse.de>
Date: Tue, 14 Apr 2026 09:08:22 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Strategies for memory deallocation/movement
 for Dynamic Capacity Pooling
To: Gregory Price <gourry@gourry.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <e06deabf-44ad-4f3f-b817-78506c5e3203@suse.de>
 <20260413164359.00001c86@huawei.com>
 <ad1b4dVCgG27A5AK@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ad1b4dVCgG27A5AK@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO

On 4/13/26 23:10, Gregory Price wrote:
> On Mon, Apr 13, 2026 at 04:43:59PM +0100, Jonathan Cameron wrote:
>>>
>>> So quite some things to discuss; however, not sure if this isn't too
>>> much of an arcane topic which should rather be directed at places like
>>> LPC. But I'll let the PC decide.
>>
>> Superficially feels a bit arcane, particularly as we are currently
>> kicking untagged memory into the long grass as there are too many
>> open questions on how to present it at all (e.g. related to Gregory's
>> recent work on private nodes).  On recent CXL sync calls the proposal
>> has been to do tagged memory first and only support allocation of
>> all memory with a given tag in one go and full release.
>>
> 
> General consensus after last few months seems to be:
> 
> "While technically possible, untagged memory a bad idea for $REASONS"
> 
> I do not thing the private node case changes this, if anything it only
> changes where the capacity ends up.
> 
Thing is, there will be things like CXL switches. And with that we'll 
get CXL memory behind the switch, making it possible to reshuffle memory
'behind the back' of the application.
While the situation is similar to the current memory hotplug case
(and, in fact, the mechanism on the host side will be the same I guess),
the problem is now that we have a bit more flexibility.

The reason why one would want to reshuffle memory behind a CXL switch
is to deallocate memory from one machine to reassign it to another
machine. But as the request is just for 'memory' (not 'this particular
CXL card holding _that_ memory'), the admin gets to decide _which_
of the memory areas assigned to machine A should be moved to machine B.
But how?

And that basically is the question: Can we get the admin / orchestration
a better idea which of the memory blocks should be preferred for 
reassignment?
I'm sure there are applications which have a pretty flexible memory
allocation strategy which, with some prodding, they would be happy to 
relinquish. But I'm equally sure there are applications which react
extremely allergic to memory being pulled of underneath them.
And then there are 'modern' applications, which also don't like that
but for them it really doesn't matter as one can simply restart them.

So it would be cool if we could address this, as then the admin 
/orchastration can make a far better choice which memory area to
reassign.
And it might even help in other scenarios (VM ballooning?), too.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
