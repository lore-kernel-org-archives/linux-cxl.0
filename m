Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010A03AFCF4
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955722; cv=none; b=fNZCfeiIJ7Gf8KYd7+qze8slrIPHNXzwnabwdAvTib0K5nanMAs8yAOdpm5TK0alekHiCOGxQcaQffhq42WiBKfPI6bDGoprYtiRbGORixGq8MO8K1sqscGUR0uqlVJv+Y7220u/wrzCbaaBLNFPOtv7eR1bR3dKCR3eda2iZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955722; c=relaxed/simple;
	bh=hfVTKUaVJZf90EZndEoq5Ta7exZVbGalInyYLQNl7bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/dQnxa2o7/wDbCqDh6dSPIj3WzPQhjPcpzCDLJp1ibgtYDqdLjuWfdOjSiaI8Hqop0v7Z4ZInMY4PYTuV8KllnhvmIH12pD6utgCHovB6JYgmV/3mskf9XE/BNfUtiaI8laR4SIR1aMYS0z42jSKmM83Z8wXktXprSglAJ2T9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=q6SjnkN/; arc=none smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="q6SjnkN/"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4ECDF62220;
	Mon, 08 Jun 2026 21:55:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (100-105-222-117.trex-nlb.outbound.svc.cluster.local [100.105.222.117])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BB21F62019;
	Mon, 08 Jun 2026 21:55:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Troubled-Grain: 0badf0a851be637f_1780955719190_3874000294
X-MC-Loop-Signature: 1780955719190:3241040313
X-MC-Ingress-Time: 1780955719189
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.222.117 (trex/7.1.5);
	Mon, 08 Jun 2026 21:55:19 +0000
Received: from offworld (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4gZ5SM15n2zPh;
	Mon,  8 Jun 2026 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780955718;
	bh=LszyOS6QEeEOqWzToXTBb+/wP56flk439kfyX7DRCyw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=q6SjnkN/0m7+Olc/d+7Iyap2yiuMErv4hw6iEMhzqO0I22xQSkZpwuZP3mc2v0n/G
	 MnxRcGGduZjEQ8fnqwd/pDc0L5kiBNK0B6v1nMeiqknbGavcZYzJCRO5PEJsVmwYZc
	 7LY7GHMTWNbrShgwW92r7IE1JGrqvNEeRPX4pLg63IqGa3BYlvsbPj/ohsFJdfelEj
	 Ehua7R0QLwk9ufD7EAOswQuQDUn5RvrxxW1ER8YoAmQeyt8JHfVG8Rx2RCEQPaRZka
	 FRGPCrU6PM8XkdXecSKh+EXakB+7MyqmIP7OY+gzxefcpO2HhqDE8+zjbBGOc/S0R4
	 z5Bu7McTxKtFA==
Date: Mon, 8 Jun 2026 14:55:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl: Add BI register probing and port initialization
Message-ID: <20260608215509.nhppkigu2oqv7i6v@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-2-dave@stgolabs.net>
 <d430e2d5-3e16-4de1-a1a7-2ba6bb2acc4c@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d430e2d5-3e16-4de1-a1a7-2ba6bb2acc4c@amd.com>
User-Agent: NeoMutt/20220429

On Mon, 08 Jun 2026, Cheatham, Benjamin wrote:

>On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
>>  static int cxl_switch_port_probe(struct cxl_port *port)
>>  {
>>  	/* Reset nr_dports for rebind of driver */
>> @@ -66,6 +122,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	/* Cache the data early to ensure is_visible() works */
>>  	read_cdat_data(port);
>>
>> +	cxl_port_map_bi(port);
>> +
>
>I can't remember if I said something about this last revision (and I'm too lazy to go back
>and check), but is this in the right spot? It looks like the port's component registers
>are enumerated as part of cxl_port_add_dport() (in cxl/port.c) when the first dport is found.
>
>I'm pretty sure this runs before that happens, so I either got something wrong here (likely)
>or this shouldn't work.

Yeah, I moved this, please see:
https://lore.kernel.org/all/20260608003323.lsja233dvqltwjqm@offworld/

>
>>  	return 0;
>>  }
>>
>> @@ -128,6 +186,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	read_cdat_data(port);
>>  	cxl_endpoint_parse_cdat(port);
>>
>> +	cxl_port_map_bi(port);
>> +
>
>This one is fine though, the component register enumeration is handled as part of endpoint creation.
>
>Rest looks good to me.

Thanks,
Davidlohr
