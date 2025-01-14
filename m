Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377C1FBC9B;
	Tue, 14 Jan 2025 19:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736883019; cv=pass; b=LjxKK1gBW7iZfdCb46BfL8juReY2ep85i2QxAhbzgBRIMNDYCWiWfMIQRmJVG8xDb5K8W6khOZp9yUwt3Ch9hxf6NHtZXBDMTqorJZ0pbkJ2L2I6Oicyupl4QSPmTzNCZEswGPJGJV2slghg4LzPJambx+fDueeLDx+/jGZOf6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736883019; c=relaxed/simple;
	bh=qJENimxIO0LFn0tlo3BcZXAqxcJfJjJhAVmc/b3dUB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN7IZek9/u4/nGX9eQAvnWrDgsKduXZIY/rMjogfQsLdtxG3QxR5SV2tR2tzIO+q5giC+u2Dup8ltTVKcgMOXGBbi+DCVFUtlr364f2p8af3gQ/hUhkRs9J60+QQZCI2WT/A+shlpxxak3Exoulg3NexYpH4HcjKOXqnUBlPNRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=layuxeJK; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="layuxeJK"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E6DDC1C3D4D;
	Tue, 14 Jan 2025 19:30:10 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.111.93.161])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 4EFBB1C3DB0;
	Tue, 14 Jan 2025 19:30:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736883010; a=rsa-sha256;
	cv=none;
	b=xzAtrXzlE3KiaVP+yR7uJiWmGhPKuxcMkyxHXH1AU7V2HIohpuUhi4xlUr+GhLEDL+FLU6
	+UAei9dV2u4qWLrTdBh7hvs6uxT8Skqv8/mgaiFmVBHh4IjMKuyGTFiwIYECmkzk0QZP8p
	KYNOHUR8JrNdDqt430D4Rok10E6W9CgKEEnxiVLy2YmH09bTIMEvYeL09VKwXJ12VS8g5r
	Lc5N6gShthoo3nYityo8Xu5C6bv09g8UQdAWHPMri09x8QKfGx+s3So5wswnQUIO7+QQcC
	bNIIRcpg960+doJ5viaALekJ+dVwzC6Wr9g1xaNWfqD3fY5jfLoCZ82TPs91Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1736883010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=7hrIu5BWjcbr+lrStbIBvmiH+KWZCTYkjbG71LTBlCs=;
	b=WWzujK4Gs3vY/wzZxLIo5Mi+y45nUl95iUmgJDfO0C352QzfYLc3rOsHUQrWaGu7+Fg2Ew
	jOcv+MOQKrNpJBfaTKva7qsMqJkWX71B8BDt+u4Gqrk5NUvm/2j1sQAaQ89jr/yCpib2NE
	p9y4Pssq6AuexNBQnNiwfKwfMvfNMxE+X1hv1+LoAFrJxnQgX111iwqNR13E+EL2x/t+kt
	QudzGOdeVoFxpUf/e/R5V+pxhh5RHf53ZeKLHNsTmzFF/Xq6zqMM7oE6BIgWOJVj/p15o3
	5UVHRECzuMrNDjkezJyGFx00MZbvWd1kd+Xis5IeYnluKlW4IotITKvDY4wCIw==
ARC-Authentication-Results: i=1;
	rspamd-7df4dcbd86-7sphw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lettuce-Relation: 2e4dea330d415899_1736883010653_1835888191
X-MC-Loop-Signature: 1736883010653:2918379151
X-MC-Ingress-Time: 1736883010653
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.93.161 (trex/7.0.2);
	Tue, 14 Jan 2025 19:30:10 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4YXfNK2HMLz9x;
	Tue, 14 Jan 2025 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1736883010;
	bh=7hrIu5BWjcbr+lrStbIBvmiH+KWZCTYkjbG71LTBlCs=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=layuxeJK+5+QOhetRbLjHEKsVsecvGSipUaN3EBvsKTVDtxLfH6ds1m5ZpAFx7znY
	 aj0azktry+Fy8SOxStuqOV9uDybo8nJs52XLBflYJT9pCMo+H4KTY+wF7Hds8Scbb3
	 H+xy43iiiSYGJXGnEKCl8t63FhWmFxBD77lPG7EP5toPIjQNlz24GsydsVVU2KyxtF
	 2WGGAa4HuAfy4N8ZQ265QKMI+U7OutzzRYYvBbCxQ8Gi0AJZp3QfExpFw7fNs/BVHe
	 5DWeWtB4Dusbvj6IlAn3/jSRBdent8+K/848tvG7L8CPHzOAQQ4X9rpwyQqKyWyT1k
	 ureLdm47vJhmg==
Date: Tue, 14 Jan 2025 11:30:06 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, fan.ni@samsung.com, a.manzanares@samsung.com,
	sthanneeru.opensrc@micron.com, emirakhur@micron.com,
	ajayjoshi@micron.com, Ravis.OpenSrc@micron.com,
	sthanneeru@micron.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/pci: lockless background synchronous polling
Message-ID: <20250114193006.eqdbemtkmfkdapst@offworld>
References: <20241022031809.242591-1-dave@stgolabs.net>
 <20241022031809.242591-2-dave@stgolabs.net>
 <831f83fa-01da-42aa-8d9b-c0662e520134@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <831f83fa-01da-42aa-8d9b-c0662e520134@intel.com>
User-Agent: NeoMutt/20220429

On Tue, 14 Jan 2025, Dave Jiang wrote:

>On 10/21/24 8:18 PM, Davidlohr Bueso wrote:
>> +static inline bool cxl_is_background_cmd(u16 opcode)
>> +{
>> +	switch (opcode) {
>> +	case CXL_MBOX_OP_TRANSFER_FW:
>> +	case CXL_MBOX_OP_ACTIVATE_FW:
>> +	case CXL_MBOX_OP_SCAN_MEDIA:
>> +	case CXL_MBOX_OP_SANITIZE:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>
>Should this information be pulled from the CEL entry? We should add the code to store the 'command effect' field when walking the CEL and store this information for each command. And then we can just check bit6 of the field rather than statically program that in the kernel.

Yeah, Will do.

Thanks,
Davidlohr
