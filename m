Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF71D5ADC
	for <linux-cxl@vger.kernel.org>; Thu, 26 Sep 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727311924; cv=pass; b=qUEeU93UjpJItPwKIwE1KrpaQ4Li2XBJRE3HCdefM3mm0EAzi5Z+di6EaGzaMNImg3TIOMf4PcQnRBtCHM+fBYRIwLMy/UUr/YZ/p0l5Ac+nlb7wuom/dfrn8RxCuOWlNvZTKhKWnRvwbPLpPrpVm6pH2z05q4VdddOkznJ2JtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727311924; c=relaxed/simple;
	bh=dmNHV4Pg48rYsm7rRXIp4O+NfIgLcXdVbidpDmcV6Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahC+Me6dTqNASTq8wU0J4IEc+R68xkna8vjOgzuvZ+stMroQhUfJcfwuOUeiqWP22F+94Xv5yNkE74HnObdHy1iHW5eplwOXIE6EtV7U4a6niqtO72tflquL8Fz4nDIRk1V8f56wmi3tIAakt7Ac/B4Sz6xQA2tfhDD1VFchF4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=NUNEw1qz; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="NUNEw1qz"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1B76E47960;
	Wed, 25 Sep 2024 23:36:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.99.96.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 98A5547899;
	Wed, 25 Sep 2024 23:35:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1727307359; a=rsa-sha256;
	cv=none;
	b=jyW5/7/K93ZTxw4shduDCuVy6z6rmwz62NwO8S6/FvXDqdo6QiSCKGoqXotn7qtJSiitNi
	JYLI/QXP1SvWUj6JoNmAfM8WV1DKZyL1KCJJkpWRq2Y0XnwyfsvOMDDogMSAWuPWcp9jNZ
	71e27YoGvgoBa9sqCfQuytksqvm/WcIAD0nrlsypUN940ZCYcSWGD3erw879MCu5sW/izd
	jNRWwba/WIrNKxcEGWOJ6FCZXC/RlIze8KM0OUQkpYFpwyPE9NoREuRMUFlzkQ9uwnrA4m
	RdWuyLSYdlcogT92B9nTVEZv96vuJu3qntRnJCjfg16lMlkQDZbZaJ3t9To3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1727307359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dmNHV4Pg48rYsm7rRXIp4O+NfIgLcXdVbidpDmcV6Ts=;
	b=WWUuvkEOzYNFey0LGWmwObknyKsxqUSWrTXMKapbIpfc1aE0/QGqhIk+Hfl7i+AdAj+Lxp
	sw2d47lWKdNP1FWvwQkW5nnX8Rk3FTBG+N94RfvVZwAEFR01i1Kj2y8rZqz2r13ljlF0mu
	wkuqLGMtWBN+v7MAotL026a2h3kXTDo3JeTEkVVbG/htl/QchuLB/FSqMI45GO28pOH8Eu
	HJJd8uR9mVjZX1h0azBa+TsMXR6QG2FZst1RnfoD96V0sR++tuBnZ1s3TpLetpTeg+eUP0
	VSKIgLhIZYYdxpTGAH/XrmwGhYFwE+O1jJQOls4piEJnUrbAgMumMy6taT3/wQ==
ARC-Authentication-Results: i=1;
	rspamd-5b46bcd97f-s2rjn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Occur-Well-Made: 36bd57f8698a68ee_1727307359869_2821239621
X-MC-Loop-Signature: 1727307359869:2613949886
X-MC-Ingress-Time: 1727307359869
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.96.146 (trex/7.0.2);
	Wed, 25 Sep 2024 23:35:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4XDY5C13b0z3b;
	Wed, 25 Sep 2024 16:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1727307359;
	bh=dmNHV4Pg48rYsm7rRXIp4O+NfIgLcXdVbidpDmcV6Ts=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=NUNEw1qzgEIzW+qLo8RGn/LSGTGvpaR9RGrmUtzUexPgboJR7fxxiX4PC9YuxJIbH
	 ryYsxGiqYMEKJukJv0K3h8qpNCtMraRjStQI0cqAgPQcEZaFh8COPbGCI4Tg0VOPjj
	 IoVJfK0MpVP/LiGkZRwbV8asqfzKqjmIb9DRxyqpty3GVbqNgawqskcNiiS/27wNUM
	 JRLbhplR0zTDopLF5JEa8WP8rXhGNQK5o8ncRJfQYhLOjZGIqVKyz28da7sR9+2g+b
	 iCELjB/k24GQxvHLTYXRqWl5+WM860iauELKH3G0zJEAwvt3tiPcRs9UPnYzLVzXmI
	 r9jLDdDnPUZAg==
Date: Wed, 25 Sep 2024 16:34:47 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: How to start sanitize?
Message-ID: <smroptdwwqext5epffyfapmvmnsrs6u4h4shxjdsysuyzldqxb@3z23ueivsesl>
References: <TYRPR01MB12335599B869ED3E7716A758790692@TYRPR01MB12335.jpnprd01.prod.outlook.com>
 <ZvRIA27BPRQNtzaR@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZvRIA27BPRQNtzaR@aschofie-mobl2.lan>
User-Agent: NeoMutt/20240425

On Wed, 25 Sep 2024, Alison Schofield wrote:\n
>On Wed, Sep 25, 2024 at 10:41:46AM +0000, Yasunori Gotou (Fujitsu) wrote:
>> Hello,
>>
>> I have a question about sanitize feature for cxl memory.
>>
>> How to start the sanitize feature for a cxl memory device?
>> Is it just writing "1" to /sys/bus/cxl/devices/memX/security/sanitize ?
>
>The CXL unit test, cxl-sanitize.sh, demonstrates the ABI.
>5db52b115620 ("cxl/test: Validate sanitize notifications")
>Hope that's helpful,
>Alison
>
>>
>> I found cxl command has "cxl wait-sanitize" feature, but it seems to just wait the completion of sanitize,
>> and not to start it. In my understanding, there is no feature to start sanitize in cxl command.
>>
>> Are there any plan to make "cxl start-sanitize" command?

I sent it out at one point, but never got merged, just the wait-sanitize:

https://lore.kernel.org/linux-cxl/20230713195455.19769-1-dave@stgolabs.net/

Will rebase and send out again.

Thanks,
Davidlohr
