Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7E3F9D2
	for <linux-cxl@vger.kernel.org>; Sat, 21 Dec 2024 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734755056; cv=fail; b=g0E0/zsaouNANMMy0uXN57m3R7ZBZwkNQFPtPyzmoCUJ6o9sFpofClbqXPH6+Zuz3uPd9dRhp+OxF8syHrfqpE+1Od5A2Ka+SMen8SF8nXXKTZJdQRgsoMtJMbj2o4dtddulcTy1tyXfKSwORYnlNQXJf+iX6fWHpsJMS3Cuuqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734755056; c=relaxed/simple;
	bh=oTxrEP2t3AYChkHw3MVbUTTefM/BJolKzlq27O0Vi+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJz0ufdR4scSmlW2IJ2yFw9LCif04SX3yD6gFBl41hJCZPWaiwr+8yHfrsTfqMw1upgXwWbgAQJitmuSTq1eqWEt5nIgxSMBEMGYcYwphEfwjcmTp3EtEgc1ntQL5MiflnjH1qwwuo9Ed06arKxs97uR0/L4dSaCQ0o07k6ka94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=QOMVumYr; arc=fail smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="QOMVumYr"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B2A852C18DF;
	Sat, 21 Dec 2024 04:14:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a303.dreamhost.com (100-108-41-186.trex-nlb.outbound.svc.cluster.local [100.108.41.186])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 197E82C1A9B;
	Sat, 21 Dec 2024 04:14:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1734754483; a=rsa-sha256;
	cv=none;
	b=VKDOkDEVvwDxuPYy5THFigcOFRnRnOdSSXKgwJSu0/GFUp0kDQHX1f4ucPCxQRoBB2hg3P
	5Pzv3mr4wQMw5OgcBX6qUdlsvMKdJzLs68HZtFIu58s37miPdgssGMpBSvZeEAwuUHng3E
	8Yk20kKpCZJqcTLLu1JbCnAluaUreCKrL4NbB/1G6nkn/flq5GyuVP6gT74Ng72D+VknoP
	2B6gnFjcF2HabDLqoPjo/j1Culsz9DP9jfHh6RezmO77bAwD69SIGR5CMed8rfysqg+/jo
	CsAnr+QfqsFG/T4o6flEQQYJXAleiaRzgNsJKGLY/fuu5LQ/SiV+sCc1NR4ZRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1734754483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8QTkq4GzhhX26lmv/fkzb6wZUCYSCYX1+Wr/Ip9nCwg=;
	b=WoWs+FmmtfY/t2+LrHYRxwG5/BZa+EPjfWRZCXnMy4kPZ7TzxWuN2Z2f6DZjkxSvaowNEr
	gTkZST/4BY1LNoQNNFqatoPQxdjvS6p+zrDVwfaK/K1440UTN42gJ6FtZpR0lVGs4u7ebh
	CSAMDak6AErnG75Il5IvZfszeTkJFNeWWyttYWJk+rGJF24O2T3WS0DKVaPL8SOs8Rfrl8
	bI92EqgyJsMEdAe7gzRKLuyC3rz5E4iR/+rob/cXEQtj+/z/WuNIRkgPeLoxmgHrw2REZB
	DV50QJ4thcAuT2/VrfkH2MOLma4wA4C+sykmVenw9hiFOv602p4tJ26+peT7cg==
ARC-Authentication-Results: i=1;
	rspamd-7d788bbf85-f4kp8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Macabre-Abortive: 504664b0432782cb_1734754483410_2202731017
X-MC-Loop-Signature: 1734754483410:1433670508
X-MC-Ingress-Time: 1734754483409
Received: from pdx1-sub0-mail-a303.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.41.186 (trex/7.0.2);
	Sat, 21 Dec 2024 04:14:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a303.dreamhost.com (Postfix) with ESMTPSA id 4YFWC62R8lzJt;
	Fri, 20 Dec 2024 20:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1734754482;
	bh=cFi8lQGl5hIt56kvyyQOWIr+Lw4VovWQ4wsU5C+3Zc0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=QOMVumYrQ9Amp4ezwGoVdEyMU2poeQTFDXhClK2kKwWshWrrnEsQSSHNoNViVq5IJ
	 MLlmmBGiU566uXR+IhtyxiCpYwKr9ZhRo37o+D1x9u+H3RC1xHrv5LFZokVBosvUZN
	 UjlnvWtHNOM54xLULOKGXmpASr4BAJzYQ/0ebS6AwOyrszSyrexCG9opRFyt+bX8df
	 iFglrITVe28x/lL0/+sPN+3qyCsITQvu3TWzHlnne7v4ehh2oHxrw2zsMd33qc3GZ/
	 krlKb/a8gJpirdUi+R/CsGNMn33imTYEQjGiY7whhm/MssEnQtfwktx+4IuEptSo26
	 kyvv+Tbo3jkqQ==
Date: Fri, 20 Dec 2024 20:14:39 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ira Weiny <ira.weiny@intel.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com, hch@infradead.org,
	a.manzanares@samsung.com, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <20241221041439.dofjmps6zdqnntap@offworld>
References: <20241220164337.204900-1-dave@stgolabs.net>
 <20241220164337.204900-2-dave@stgolabs.net>
 <6765b5c5560e5_2e2afc29467@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6765b5c5560e5_2e2afc29467@iweiny-mobl.notmuch>
User-Agent: NeoMutt/20220429

On Fri, 20 Dec 2024, Ira Weiny wrote:

>Davidlohr Bueso wrote:
>> +	/*
>> +	 * Set max timeout such that vendors will optimize GPF flow to
>> +	 * avoid the implied worst-case scenario delays.
>> +	 */
>> +	device_tmo = gpf_timeout_us(7, GPF_TIMEOUT_SCALE_MAX);
>
>What is '7' here?  Seems like another define would be good.

This is the max for both scale and base components of the timeout,
and we actually have:

+#define GPF_TIMEOUT_SCALE_MAX 7 /* 10 seconds */

... which could be renamed to GPF_TIMEOUT_MAX and use it
for the cases you mention.

Alternatively, since we limit timeouts to 20 secs, we could
just set that here and not rely on gpf_timeout_us() to do it.

...

>> +	while (1) {
>> +		struct cxl_dport *dport;
>> +
>> +		parent_port = to_cxl_port(port->dev.parent);
>> +		xa_for_each(&parent_port->dports, index, dport) {
>
>Does this set the dports for all ports on a switch?  Is that the
>intention?

Correct. For full output of a CXL Switch example, please see (iii) from
the tests shown in:

     https://lore.kernel.org/linux-cxl/20241205082101.1193038-1-dave@stgolabs.net/

...

>> +	/*
>> +	 * Set dirty shutdown now, with the expectation that the device
>> +	 * clear it upon a successful GPF flow. The exception to this
>> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
>> +	 *
>> +	 * XXX: For non-fail scenarios, this is cleared by the driver
>> +	 * at hot-unplug. But, what about reboot/shutdown case? Is this
>> +	 * done by hw if no data integrity failure is detected?
>
>Does this path execute on reboot/shutdown as part of delete_endpoint()?

That was my expectation, but it did not; only for hot-remove. This is
my main concern about this patch.

Thanks,
Davidlohr
