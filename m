Received: from giraffe.ash.relay.mailchannels.net (giraffe.ash.relay.mailchannels.net [23.83.222.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902E390CB9
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427290; cv=none; b=EoI6RUj1Tb+2d0SWtstrAMkJVMAWcZtRvKmNN/ptbx2Cn4Cn/lKuHLfDNpPaNT75XPf+25TcnLljGp3EeklzKwPpz441KR95QNG821bdaK1XdfnpQdy1w/EFAOQ6M0Xh9Xmqk/1HHxOQpBH5aifdVruGUvVVwzuNb6KwGFUGk8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427290; c=relaxed/simple;
	bh=sf9xBYAs6pD+f1ez8PF9Thia1XAq8pfJbpxa2bBs2Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsHpvpBjdNZlY3IUm4YqOcSnRaMo9dI07GmQeUs72RdQC4ElPtV0E+CjYdNCfVliPQVcnUCyyhDYxfHc8pOyhPyWCY/aNHD5cycsD5pSmNhSqFFIBBohoP2XQhw6ES4bRb/x9UKtbYa5Gv0OuRbtRKxVPuwMPBHRLF7DOBNUVCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=HE4FrqKq; arc=none smtp.client-ip=23.83.222.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="HE4FrqKq"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 178583E09BD;
	Tue, 02 Jun 2026 19:01:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-109-199-18.trex-nlb.outbound.svc.cluster.local [100.109.199.18])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9B4923E1971;
	Tue, 02 Jun 2026 19:01:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Reaction-Plucky: 736ff8c15b8654fe_1780426876914_2104776002
X-MC-Loop-Signature: 1780426876914:936965911
X-MC-Ingress-Time: 1780426876913
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.109.199.18 (trex/7.1.5);
	Tue, 02 Jun 2026 19:01:16 +0000
Received: from offworld (unknown [181.212.92.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4gVKtM3nmHz1Nc;
	Tue,  2 Jun 2026 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780426876;
	bh=yGDSMv00199A0ekaOEFASzqHkfb8xg3DJr0yjqm6WWY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=HE4FrqKq4PZfxkDe0a812egqjq4vP8JhM1kPj9qdDwa+uBYi46L+IqbTN8ET95c2t
	 aUMeSxVn49Mt5RY+bHjTldARYEEoZg8xNQ5pxExlkDFdedczTdIQtGJiu7ad9b8irD
	 NzBof2+cY4Y0BNr+qZuZqmAxttliPxQXYbWx1P0qp6nLN40oPcdayLpB16CIpDVH2t
	 1VqB3Yq4IoUMZBUy7YRYS+qYfaZr4oD6mvRXlbG/rDGYbH97AumRBZ3AbWOczIMUpj
	 7W3y0B+76o9YhOeVzXWUl0WlBSYPPWjcJjUkmweKY2RVLM1UMeVqkWbPM45nSMmp/b
	 oSYyZIcJ3vz8g==
Date: Tue, 2 Jun 2026 12:01:11 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH -qemu] hw/cxl: Use host-only coherency for default CFMW
 restrictions
Message-ID: <20260602190111.5jcmcdxfhk2yiqgv@offworld>
References: <20260602043029.2341246-1-dave@stgolabs.net>
 <20260602153803.322bf993@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260602153803.322bf993@jic23-huawei>
User-Agent: NeoMutt/20220429

On Tue, 02 Jun 2026, Jonathan Cameron wrote:

>On Mon,  1 Jun 2026 21:30:29 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Change the default CXL Fixed Memory Window restrictions from
>> 0x2f to 0xe, dropping Device Coherent and Back-Invalidate,
>> which are considered spec violations when using in combination
>> with host-only.
>>
>> For HDM-D and HDM-DB models, the user will need to explicitly
>> pass the correct restrictions bitmask.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>So this only applies on my staging qemu tree (as the
>restrictions control patch is not upstream yet). Would you mind
>also doing a fix for mainline qemu as we need to change the default
>prior to that restrictions patch?

Ah right, I keep forgetting that. I'm too used to using your tree
in my test scripts :)

>For anyone wondering why that isn't upstream yet - it is mostly
>a question of working out a better command line than writing the
>bitmap.  Probably as set of flags for each thing with checks
>to ensure we don't end up with impossible combinations.

I actually have no problem with just using restrictions, if the
user cares enough about not doing the default, then it should
not be hard to construct the bitmap.

>If you have time to look at that Davidlohr, would be much appreciated.
>Without it the BI stuff in upstream qemu will be untestable.

I had been thinking about an alternative, and went with one explicit
flag for each Window restriction - the problem with this is that
it gives users a lot of options to play with, so just passing partial
options requires qemu automatically setting flags - ie: just bi sets
device coherent; just passing volatile and/or pmem (no coherency) sets
host-only, etc.

I will send a combined patchset to (i) fix the current default
restrictions, and (ii) adds the new cfmw options.

Thanks,
Davidlohr
