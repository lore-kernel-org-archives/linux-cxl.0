Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2B84DA533
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.254
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778694174; cv=pass; b=nghMsdQfJJPPFtXCKD8xz/29YRs2gkAyjMuv3CG8+jZ4W36QcnhIcugYJw4VZCTSfLiYJJDyWcQWzZr+wC9snvx9Zuv+OpXmtsA565qdseIFUEl5Ya2biJeOl3wyCjizkf3Y9gn8ltDl+t80kWcq59MoVbKS74HBD6qR1+JvTT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778694174; c=relaxed/simple;
	bh=CfLh0/83EvduiOvq8tD7kOvBRO2Vj6GGvRJkt5cLdqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzPpD5aa/DvuLnZnkiv7FjVcOzC1i8Jbu09BwWYIYf/bTGNCUu6mMOA3RMG/KHgwgiPDrHfwfKRn0KpyBEVbbNK4HQH3zJuwf9LBkIcTxfotTwx+/9n3gpaLHfCfAa0SERxWVkT1vGfxx6vCpkvrIWSxX83OVw9goz+VUdd+z3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Ps1ea6p0; arc=pass smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Ps1ea6p0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4E632642015;
	Wed, 13 May 2026 17:33:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.98.28.153])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A2C81641FEB;
	Wed, 13 May 2026 17:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778693621;
	b=ZoyO7Wrxz8yIqcnEAR3CSmAInQvzbbvmNS3MECp3Jc1bVGeeainrYolloMoM28gFfQkfHo
	ko8fgDYG+068nU9L4ekAgwfOnU95bklGKLxFYsTXblIvCMXVsQwbD8HuRbO5Q+R1x39HxU
	of2i1huPQSPHRfR5xs5eVHXSIZupKaZg4TxhCePOdSYOuvJ3XACgPmyMIYRzkf/pfw0qNK
	i6zOSP9k5e07sYvlw76rjdsdA5EDlr0KATS1iVX+bxMFSBdAaBzdQG0FZIJm+XdcdRCTns
	XvUwBoO9h4/tJmMRYwyV8NlwvGIAfgu887CJhhCjlzZoIZ1jWtuxD188QyC1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778693621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ypQBSdFjpIWyY3lJ211TKABbme2d0ybEhJklRs1xO9A=;
	b=BiCxJXlRytzchAQ/HJLMAVH53Yc0z4K40DFuErpHM6o2Vg/OkR+41xMvTqkhV5tLd9MssW
	dsLjIwNolHOcHu1rCPwSHhyiXBPTE1AxNiiGRlj7w2H4k19fvYCc+oa7feu9ewYYtzG1ew
	pAUWTELTmPO78K8eZrPLIHIi7/Gs7XHhnGxpP3cDMS7idHdqIUA4neWIJ4bGB0TjJ8wdJp
	TUDEx3Nbc9deV1D3gYUMrw7GCgyY09pWWwqaOR+rS3Fan/8cLzuEDCJl0UqgCDsO8VpA1O
	avMYzKHtur7VeW1GkLLWQznvZf4G7CdQ/UPR3mwQaIcFBZGHKOkhqec6EMRmDw==
ARC-Authentication-Results: i=1;
	rspamd-5c5444c55f-9k9lm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Shrill: 3362ca9e58182b5e_1778693622144_1755407790
X-MC-Loop-Signature: 1778693622144:4269560550
X-MC-Ingress-Time: 1778693622144
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.28.153 (trex/7.1.5);
	Wed, 13 May 2026 17:33:42 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4gG0tY091wz105g;
	Wed, 13 May 2026 10:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778693621;
	bh=ypQBSdFjpIWyY3lJ211TKABbme2d0ybEhJklRs1xO9A=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Ps1ea6p0OHXhcOj2Sv1mhBM9pJq/PfKcnVZilh8OdQDZz+ij0Dqtd/uhgQfi8XMFr
	 iQ7VrHuZOktlvGIuz8GSrQpDrMSDELrnyqRXEBl89KxxK33JlPv0fpniuNW52JyIA2
	 cHFSpD8aBwQezzcND49ae60Yx2Y/6VAYIDXuekxWZuyihcUfIbMHQDrPR+Ksi4Xqlo
	 bm/wtXwajuYi59bGct2658gfeJmauavvN7Aod3B4vfi5vmMa62eq3iZk8UUhal1mu8
	 xqCZ2w+1xVuhpRyhJm7BA92efPL8tb6L219c5T9O0sm6NxkDTUtVk2XLWHYdF4Uaf0
	 kEEPaVrGWUf0g==
Date: Wed, 13 May 2026 10:33:38 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	ira.weiny@intel.com, gourry@gourry.net, dongjoo.seo1@samsung.com,
	anisa.su@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 5/6] cxl/hdm: Add BI coherency support for endpoint
 decoders
Message-ID: <20260513173338.4ybay7n3vjhs6prj@offworld>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-6-dave@stgolabs.net>
 <db39fa66-3b40-4291-8538-13674a3a438f@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <db39fa66-3b40-4291-8538-13674a3a438f@amd.com>
User-Agent: NeoMutt/20220429

On Fri, 20 Mar 2026, Cheatham, Benjamin wrote:

>On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
>> @@ -1030,6 +1063,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>>  		else
>>  			cxld->target_type = CXL_DECODER_DEVMEM;
>>
>> +		/*
>> +		 * Autocommit BI-enabled decoders is not supported.
>> +		 * At this point ->bi is not yet setup, so there
>> +		 * are no guarantees that the platform supports BI.
>> +		 */
>> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
>> +			return -ENXIO;
>
>->bi here is ambiguous, I think you mean the endpoint device isn't configured yet. If so,
>I'd spell it out.

Yes.

>
>Also, why don't we leave it enabled and then disable it if the device doesn't support it
>as part of cxl_mem probe? It adds some unnecessary work in when it's disabled, but
>allows for more configurations.

I do like the idea of more configurations, but I kept it conservative because the
range is live (ie: firmware could stage some HDM-DB range into sysram map via
CEDT/CFMWS or some other shenanigans) - of course rejecting this in the driver
doesn't really fix anything either :)

Further, disabling the bit involves uncommit+recommit under live memory, which is
of course very nasty and we don't do anything like that anywhere else. And failing
to disable later leaves things in a bad place.

If the use case comes up, maybe this can be revisited, but probably best to leave
as is for this series.

Thanks,
Davidlohr
