Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BF21FC110
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782746815; cv=none; b=ASQTcx5AHnwkYdVYxeMom3br4ZNu/6ySvB2s64dwln9vhWZB1AYGusdLdBTkPGxkh//8yb+37ciAMWMEj/z6MXw7Js7Ps/gqwgir/PH8Fiba1LHAWkzaAqW3jYKA4eHUwCxk266BvUpQBYopi/Khl3FPweIfr5dZrGbYb8UuP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782746815; c=relaxed/simple;
	bh=e0At9uclpYUbcyzjVLCKgetTsqb97BECJczweF5Yb2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoWCBZb8DXjKxSn6vAMwKlQMgWG0hQLxG6sWQzWtzeVwZcZyZi+sB4gwhIwj879QW3TUuZwDKS6oeAGGEDeOeqDffBGxa3CfkHyaIKbygq5dhR+gjqm8AjsrR4J2rpVS/WFlDP/zZP524vUil6JJbbyvAzGbJ7sf6z9bsjLB08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=XXqI6GiR; arc=none smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="XXqI6GiR"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 16F9D8020F6;
	Mon, 29 Jun 2026 15:26:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a254.dreamhost.com (100-99-12-125.trex-nlb.outbound.svc.cluster.local [100.99.12.125])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 8D2F580168E;
	Mon, 29 Jun 2026 15:26:53 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Average-Tangy: 407d1a6575198f4c_1782746813873_147058888
X-MC-Loop-Signature: 1782746813873:3114553993
X-MC-Ingress-Time: 1782746813872
Received: from pdx1-sub0-mail-a254.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.12.125 (trex/7.1.5);
	Mon, 29 Jun 2026 15:26:53 +0000
Received: from offworld (181-161-142-22.fo.baf.movistar.cl [181.161.142.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a254.dreamhost.com (Postfix) with ESMTPSA id 4gpqrW1DBnz105D;
	Mon, 29 Jun 2026 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1782746813;
	bh=aTJKtklzL4XN53I0J+60jx2d9jh3xeKgEmePp+maHwE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=XXqI6GiRmxkx7JkwSQ/Hdes/plWxRdc0C040uVawT4Bz3qjgH5wVg8OikkRx2afiB
	 eJh4Ezsd6aZ/K20VdhP0p3sKQwvqjvxRs7C9x1lLOYD2lYUgCWhYLGiZLcZUkGwwIi
	 zAHBlmh/nS2QJsrYYfLIOK0yAMJafbVTmYaaUgI0z2dDKTQc7ojPndH4XKoJqcusxq
	 uHWHXVQrOOtzPjtqD1ZXufIsHJn708NUP8ZV1xbdzATpJnq31pFrNyRVpr5rGcpDrX
	 N+/qZrazDekOrYxH6P468KRLenB1Jj2EEQOerLyDV3NOglXKk4JBxQLB039+EPwlYH
	 fnhKFZ3iGfugw==
Date: Mon, 29 Jun 2026 08:26:45 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cxl: Add HDM-DB region creation
Message-ID: <20260629152645.whsvecptqcgcnh3q@offworld>
References: <20260615145529.13848-1-dave@stgolabs.net>
 <20260615145529.13848-5-dave@stgolabs.net>
 <ajpHWPTGviu63cx9@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ajpHWPTGviu63cx9@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Tue, 23 Jun 2026, Richard Cheng wrote:

>On Mon, Jun 15, 2026 at 07:55:28AM +0800, Davidlohr Bueso wrote:
>> @@ -198,6 +200,12 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>>  			cfmws->header.length, expected_len);
>>
>> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
>> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
>> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
>> +		return -EINVAL;
>> +	}
>> +
>
>Plus for this part, it rejects host-only + BI, but device-coherent + host-only isn't caught.
>For that combo __cxl_parse_cfmws() now picks DEVMEM, whereas before this series it always defaulted
>to HOSTONLYMEM, so it silently changes from host-only to device-coherent.

I will default back to HOSTONLY.

>
>Is it meant to be legal ? why DEVMEM wins the precedence in __cxl_parse_cfmws() ?
>Those 2 coherency models are mutually exclusive, I thought both should be rejected, symmetric with the BI check.

The text in the spec is not 100% clear, so I just went with the BI+HOSTONLY check (and on the
last cxl upstream call nobody really objected to this). Further, please see the discussion
with Jonathan when doing the qemu window restriction flags:

https://lore.kernel.org/all/20260616141834.012ad646@jic23-huawei/

Thanks,
Davidlohr
