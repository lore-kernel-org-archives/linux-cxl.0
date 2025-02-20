Received: from brown.aspen.relay.mailchannels.net (brown.aspen.relay.mailchannels.net [23.83.221.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D4E1DED7C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.221.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081371; cv=pass; b=UJbqYnVxgqelpaqgLAv+7AZ3rDeFi9DhF72Ek0d27X2rMj6brmjTtvKKRiltJ60FGW4VDJCVfa/yaYTRDB80XUcl2rusEhKXpmNyrGnuwt8lfQiveuNtgs8+S7n/X8tVZidBX6ax5UA8IrnzoEhBGE3YMThTxukdDRhDetfpHIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081371; c=relaxed/simple;
	bh=13U5IuuThoS2jAUBTL0Bmt8a1R+NKkIQSX/buXv6I3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPSKEqjPHT8c87prMXUjRBoe65cUXFxsc1ah7f87O62jHfK/GYu1r13yHTK88mXSOLpEHG355F+vDGE9GHAayXwYPLMCmawtzW3oRpQsI6+ClYOgALtLRFWckMC4evlDoGHSyx19afD0nWyZh1GwZw/4CZtOFbH7dIAB7uylpAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=B/Fks41e; arc=pass smtp.client-ip=23.83.221.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="B/Fks41e"
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E94228A6943;
	Thu, 20 Feb 2025 19:54:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a208.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.105.230.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DA6F38A6025;
	Thu, 20 Feb 2025 19:51:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740081226; a=rsa-sha256;
	cv=none;
	b=gX00CsG0lRzmf6TUG87S4l5WLAjPf6ZnusleyYKZmuTTIql3ftqdm7hM814yf1PgIs14lk
	MEVYG9aobTKn7nJhSvIUYb+Ikd8ZHuNhW4RDOx8ZapVseyJjLTzqxaZG1vAyvFPvtCEYEH
	B0h05Dna5Ty0gavyW3EuriDWE78F/8Np2eCR9to7yuTysscxnH5Sh8WBOrl/Zpcr3lzH4F
	avtVIDpay8blc8GXqmwAyqLV2x8XP6qFe5jq/U/AZUVUsGHNpjFT4Ii4ni8PkLIcaVaAHa
	/BERRILcrXFwa1pVf8HuKMUYTgN8JndC1NV6wNVJ4HFmZ0Ag9OG2+fq4ARYWLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740081226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JgG90nUMsnXJZSf6wgYOwJatNMEE9jQ/YFPCu29GpAM=;
	b=VIMlkBh9IJm7FnABR54K7qpmC3nN2AlagrZRkt2KfDbIKLWJa88/biBDnhQLQPm6RvoshS
	NbWMQf4aYXlUbPBXlcGD2QAiRX0r61HFDyrmwoFTUpwXaba3NezHeS/wLFo86TF1jw3uHS
	nsQFcBX26rBjW8e6zAXSY7EOmsr9s/vwTdNfwnmZoGAk/FYNqu9F5xoFteLfJcNKKgQ9Cj
	+eguUV9ootpMrldR+x9C3Zi5Jsr+HqfyCPwReHY+RFMPHF0E0htZ7f5EJxj4MAvaXL+9ur
	Fh/G1+Z/2LCznOo1CqSyvMiJm/KjrrEwgc19BsxH2SYmoJpR8rLvuwSK1z5Z+Q==
ARC-Authentication-Results: i=1;
	rspamd-78ddd997cc-hhww8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
Received: from pdx1-sub0-mail-a208.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.230.78 (trex/7.0.2);
	Thu, 20 Feb 2025 19:53:46 +0000
Received: from offworld (unknown [104.36.25.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a208.dreamhost.com (Postfix) with ESMTPSA id 4YzP5T2qtFzdm;
	Thu, 20 Feb 2025 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1740081070;
	bh=JgG90nUMsnXJZSf6wgYOwJatNMEE9jQ/YFPCu29GpAM=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=B/Fks41ej89loR5LN+6qzXnGrJGDvTCOj2brjKDJbjP2b/5S8FpniLn6UZQ0eY0io
	 XQqbpLkrrFW78nWemkSx+eEtGJDGvB/9/NOBvg1FT1PbV/erM+xOXxFLE9NcQ3pyWR
	 lr4JNq3HCLFk+e1FlHAmepZNuWh7+QcFLqQqQhgShGz6beBTkCw3gOUD6XEkx4vFOn
	 9hyzreAUNZOIjkBqW8vS1aqCOXQGPOqrIfJpSHnNl6F5yUKwVahJFilgyfI122zOOE
	 2DY3o4qK0l6PZzNGBbeX5G+S2A7JP7KGMYsJLbqq/zinhg5o0IXak0TOIEjxpXywfi
	 +ocWJGboH/zhg==
Date: Thu, 20 Feb 2025 11:51:06 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
	ming.li@zohomail.com, a.manzanares@samsung.com, fan.ni@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
Message-ID: <20250220195106.mkvs3xmhnovjxoym@offworld>
References: <20250220013604.263489-1-dave@stgolabs.net>
 <20250220013604.263489-3-dave@stgolabs.net>
 <20250220171257.0000605f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250220171257.0000605f@huawei.com>
User-Agent: NeoMutt/20220429

On Thu, 20 Feb 2025, Jonathan Cameron wrote:

>On Wed, 19 Feb 2025 17:36:02 -0800
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> ... to a better suited 'cxl_arm_dirty_shutdown()'.
>
>But it works on x86 as well! I'll cope I suppose.
>
>Mind you why not let it take the state as a parameter
>and always pass 1?  From a mailbox command point of
>view 0 is valid. The text in table 8-152 has me a little confused
>but I think it says you can set it to 1 and back to 0 and
>then reset at which point the dirty shutdown count will
>not increment.
>
>No idea why you'd do that, but just passing a 1 into
>this function would make a call of
>cxl_set_dirty_shutdown_state(mds, 1)
>seem reasonable, or pass a boolean.

I prefer how it is now, really.

No point passing the arg which will always be 1, and that
"arm/setup" is in the name, so passing 0 would be counter
intuitive as well.

Thanks,
Davidlohr
