Received: from bird.cedar.relay.mailchannels.net (bird.cedar.relay.mailchannels.net [23.83.210.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9E32A3FD
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.210.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291553; cv=none; b=Kp7Ng/Zq8dGhDtr98jv/a39PVwDI5kk381m4VHUSrpUTfLKYh9Jtkk//0J1gGiwLwZESkpWReJZb3b4pICcjR5iwW0oLIdVoHNYSHxHA7zw4AbJKpaUitYb7/2FABqCEMXu1WH3c2+anwY5/lam/gioN5f3ewJH1CeEjNEdFx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291553; c=relaxed/simple;
	bh=3hzEzV7pviVg8rXVmBnYgDk6YlNJfhjn3Grkd2FHN30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Uh0wOL1pcVGYah/A/4V78tCLdiGP9ng4StmzrqktNaeq8+17QHTU1cbdyOt4oEGBLgVNQdMaMQDS9YhAYrf0JnryDMcC4FFwA0I/PvQ4RNjTiTbg5gytHzoDvuvBugoAzdiFfrOP2FZ5WFNnp6OSDrDla2e4EgVgx9L1IDPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ksd2Rm9S; arc=none smtp.client-ip=23.83.210.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ksd2Rm9S"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31A8E62726;
	Fri, 12 Jun 2026 18:54:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (100-105-228-80.trex-nlb.outbound.svc.cluster.local [100.105.228.80])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BAC4061FDB;
	Fri, 12 Jun 2026 18:54:49 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Junk
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trouble-Spot: 5ebc9f2e18d71f7b_1781290490033_3254114912
X-MC-Loop-Signature: 1781290490033:1733610305
X-MC-Ingress-Time: 1781290490032
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.228.80 (trex/7.1.5);
	Fri, 12 Jun 2026 18:54:50 +0000
Received: from offworld (unknown [172.59.185.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4gcTGG3mSpz1db;
	Fri, 12 Jun 2026 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781290489;
	bh=3hzEzV7pviVg8rXVmBnYgDk6YlNJfhjn3Grkd2FHN30=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ksd2Rm9SkiUYAXOcPihLmUqcgs/QzIaAyGz6miVLHm8/htA1rPe5k7naR1ANcVsoq
	 I4IonYxRCKiHX7DRSfGr/XSmlIOdm1rttBIPw+lKGqknHnzP3bt30HOHjN1/18XOvN
	 JlgzsbHVG6n/ZJdPFMqB/sz7COu5P5dzTc04coVZ3KxqGdTiP10hSMUsV82DO3Puvx
	 VJPj+uwtfEg8G+FcgMj14Ud6gRcNY7tUd7iiVuSWOUJVet1SWxuDfaRl752c1/cuns
	 jxlm34u0GXumyyQlox3ho8NMhX88RmWFATBpf29Iqf4zXTUHr9OUayAQa5ziNI4JSv
	 9zdRJtaS8Ammw==
Date: Fri, 12 Jun 2026 11:54:42 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 3/5] cxl/hdm: Add BI coherency support for endpoint
 decoders
Message-ID: <20260612185442.yljbcwz2xbjtt7jr@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-4-dave@stgolabs.net>
 <fdbc0f06-cd3a-49db-8f86-3e856b97a0db@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fdbc0f06-cd3a-49db-8f86-3e856b97a0db@amd.com>
User-Agent: NeoMutt/20220429

On Mon, 08 Jun 2026, Cheatham, Benjamin wrote:

>On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
>> Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
>> Region attach consults this to verify the HDM supports the region's
>> coherency type.
>>
>> For uncommitted endpoint decoders, init_hdm_decoder() defaults
>> target_type from supported_coherency: Type 3 devices default to
>> HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.
>>
>> Pre-committed decoders with the BI bit set are not supported because
>> endpoint and port enumerations are independent -- at decoder
>> enumeration cxlds->bi is not yet known, so the topology cannot be
>> verified.
>
>Would it be possible to allow unlocked pre-committed decoders and
>just disable CXL.mem on them until we verify the endpoint supports
>BI? It may be possible to just disable the endpoint decoder, but
>I don't know if that comes online before CXL.mem is enabled
>on the device.

This sounds very iffy (and imo most solutions around this are ugly
and hacky). Maybe the kernel should not bend over backwards to
accomodate auto-commited BI decoders on non-BI platforms/topology.
So what if we trusted this case and then cxl_bi_setup() just WARNs
if things are broken and let the user keep the pieces (and maybe
just offline and try to do the HOSTONLY) ?

Regardless, I would still like for this to be a follow up to this
series.

Thanks,
Davidlohr
