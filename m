Received: from dog.elm.relay.mailchannels.net (dog.elm.relay.mailchannels.net [23.83.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9D119341C
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135494; cv=pass; b=bXEJjtLvMpmX0JDX5W0ah9XaDuMTDu1jIHcCLi/iizIyCCRWw1GV/eQ6M6o537f5Te1o3RG3ez+kMHFY+AJHS176h6VaFOj4hN9WiWvSxXGpJ59yfs1QM46QP0BTXhQuagGOFuU52QdqSLevxBMVtdLKuQJiMWemocQTwP7icGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135494; c=relaxed/simple;
	bh=sb7RtaUDMHTvo8rUIKZ6aVzEUOvkrWXZMUVtIUaeOqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmaBqwVl2TXI9TbzTq4vfWtFgAUBuaAriSgQ75fvKoq4UhMgEmlroiV+PFWeY0I8Hkx0WI6Jr37F5NjA6DPPUzOIzEgH6fRH05No60bTOzy69oBzxsH5EyOWTPSRelUG8wYCre3CdVdwaDUmmYJVSeJdO0xWjFoYwAoLGPhFlJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=AzRya4Ag; arc=pass smtp.client-ip=23.83.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="AzRya4Ag"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A04428A111D;
	Thu, 12 Sep 2024 03:23:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a282.dreamhost.com (trex-3.trex.outbound.svc.cluster.local [100.96.68.98])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3C0708A3249;
	Thu, 12 Sep 2024 03:23:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1726111420; a=rsa-sha256;
	cv=none;
	b=AgXHB0PYHrsRH2dpZgRUyjexG9I/BpLvaQzCHW1dp88XuM2dZadMRdrhlgisO2cdYPbjtt
	/qQaJZCYFwVv2YWZYltfNX1ud/UqREHR2vL6sF/FQ/LlRIKn/9yJW8WPx8toW/8MLrUXXD
	xtjwx3EmQvAhb5Vyt6jCxGMPji+OU8bnuMkZWNOxWR6Ce0B63/w9opP0APt3vSYRC7zrQq
	ScOHq35KTQ5i+1b1Xv50LX7ANJaDXZtAu1w494WHdE+UWncEEU8eeW4HcN5H+uMS70IsK8
	OytlMTI6uD1H6sfjWgLFczkkS+nQ6pnKlaElUlDTuPeRNDpu+LKoRMt6WvAadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1726111420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4XSFk0LY27uf0nc37RHHsJRhAhp4BXs1A6hT1co+3bE=;
	b=EJMTHvAyd3SeScup/rhOlNGluJ0x8BILAXxbFi7cFRZSa/LY+TO6Voj+9jYUCLilWhb3p7
	eysCbCHs0qEqd52aN2rdroP8kvJnw/nsWI/VWHEH+dCNgY6ojJflUzZuUV/hns2b/L5qe8
	iG+N5ZqvAru0Jn2qVC9QbofDCZ05s5NMmKhsTe3b54ORSvurPehqQy65o2mKtmhBrJv5oH
	Eh13kGUNrNwhd7POHkSTqHSKi6vwX5dCKM429KyVNlGDV911JMZeEiSKvQs9iESIUdIIzn
	YwEAXO/g9Air740bSdEJzZBtWRLI/+aCcD3Ku4cNdxqeeHXCETKxR6GLilyCHQ==
ARC-Authentication-Results: i=1;
	rspamd-77766c4bb8-lhtrb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Stretch: 42dd9a7d2b5b92ff_1726111420473_4036044548
X-MC-Loop-Signature: 1726111420473:4125234529
X-MC-Ingress-Time: 1726111420473
Received: from pdx1-sub0-mail-a282.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.68.98 (trex/7.0.2);
	Thu, 12 Sep 2024 03:23:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a282.dreamhost.com (Postfix) with ESMTPSA id 4X42pM5K8tz9d;
	Wed, 11 Sep 2024 20:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1726111420;
	bh=4XSFk0LY27uf0nc37RHHsJRhAhp4BXs1A6hT1co+3bE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=AzRya4Ag7T/vEV/fmRJKhp5WsY/Mmxr4l/JK+raUJgti+n3wsSKIRzWDQxfpWqI4k
	 XSGoigIMl/SZcQL/oYtfPP3YzO40pEBgaOSJBA+sxdTTFPks3gUXEdy6kERNZzXImJ
	 MFsb88WPfGZ6LW8xPC8TtW3Sdylv+th/QNhP9+Uxf9uHmHedwa83p4UCWi5g0WTMmQ
	 50bz2/O45iHzSLMMJKrvWqBrP0oXyy/vNZJ5PW/eRJogxFURZp9S1AIF3CIpK0BNTp
	 5Fc+HbI4j6hcjub2huPAumQml2sU22dVMmJ6jLk9rQCXp5Xl/XXTzoxGch8iVAP32K
	 VUUIaczA/VX9A==
Date: Wed, 11 Sep 2024 20:23:14 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <b4qrc6xbwmmfidmyhaieu3kxlqewtupttp3pqatg2rj6ua2yxd@xwx4ybpysnil>
References: <20240911215221.308483-1-dave@stgolabs.net>
 <ZuJBKHi-l3YSgDEW@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZuJBKHi-l3YSgDEW@aschofie-mobl2.lan>
User-Agent: NeoMutt/20240425

On Wed, 11 Sep 2024, Alison Schofield wrote:\n
>On Wed, Sep 11, 2024 at 02:52:21PM -0700, Davidlohr Bueso wrote:
>> Update the CXL PMU driver to support the new events introduced
>> in the latest revision. These are:
>>
>> - read/write accesses with TEE constraints.
>> - S2M indicating Modified state.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>>  drivers/perf/cxl_pmu.c | 31 ++++++++++++++++++-------------
>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>> index 1f93a66eff5b..13005f410ee0 100644
>> --- a/drivers/perf/cxl_pmu.c
>> +++ b/drivers/perf/cxl_pmu.c
>> @@ -63,7 +63,7 @@
>>
>>  #define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
>>
>> -/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
>> +/* CXL rev 3.1 Table 13-5 Events under CXL Vendor ID */
>
>I hesitate to be picky here, but also I don't think we want to set
>a precedent. In CXL-land at least, I don't think it is our intent
>to keep spec revisions, sections, tables updated in general.
>
>That makes me think the only places where this patch should reference
>3.1 is for the new items you added. All the extra spec updates can be
>omitted.

I have no strong preference really. I updated all the event references
to 3.1 because it felt weird just updating the comments for the new ones.

Thanks,
Davidlohr
