Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27F63C5833
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788461909; cv=none; b=i/i1Nq0PC3msP1FtF9NcKyrD08GPPw36uqjUNKtUp8p5hccsQIclweBlieGMN5j9b31dvWXJEeb4nzUMZ7AGUXDV4Uw6/j6d8f/wXBgjxYOOq1vqNHBIUd+WcjgoJrt52dZD3iYldYk879jT0jw4u1vczP43fVkXfRrG7lycQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788461909; c=relaxed/simple;
	bh=LD+/5q4UoQhnQPiSzrpDEzXQid24U7rlGEhJMjuTLHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKfQneok0PGp1ycX9tgzmGAw+BfGbnFzyCp/WzX0G1+gztKz7gqEKQOQlOIbH3YcYGDUyjULsyei/ILwZx0XEjutJzJTWPXPk1AvDVEVMSphIrWkd9gC83Xuld1g0oEoKpxjZ1/qnpFwctwrw9wVYlVEfu6owZMoJEm6FMPniIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=hS2TQbuw; arc=none smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="hS2TQbuw"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F01B74C1655;
	Thu, 03 Sep 2026 18:58:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (trex-green-1.trex.outbound.svc.cluster.local [100.97.105.60])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 797064C13E6;
	Thu, 03 Sep 2026 18:58:14 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Attack-Arithmetic: 6fee436e51ae9562_1788461898713_4207495950
X-MC-Loop-Signature: 1788461898713:2836627364
X-MC-Ingress-Time: 1788461898713
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.105.60 (trex/8.0.2);
	Thu, 03 Sep 2026 18:58:18 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hbTPx624KzRr;
	Thu,  3 Sep 2026 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788461894;
	bh=MsRAe3yd5mS8IGv00KvmSVcNXdvDxMf/ORiw49ODbMw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=hS2TQbuwCR8GvqJyHnQ8KpAB38oIDAlY2iTUz1NuwZDkQxqXsvyKFiYxoQ/TFB4Ys
	 v6Dy2KM93+YW6WhtyOP1ip7XNZ9HN/0mqLLPFWPu1mM3EwqT8onvckClw8A5eLd4IH
	 7vueH23+RnLx1kgs8O/Rkc33E2LJPcNEDtuRNMkzq7UKNqbaWJdzrTlDl92xse7Zan
	 TwBGgNo3Ylhg+U3lKy87TXORvcsPbHb7uRuzLyLiMYCzpwkKVmu8PkeYU9BeIqclQL
	 eXgAYA0j5es4UR52EwwqHQnd8NJOa0Oc3/rQ0NmI8DFddFoVRHHdbbNd6NRxkndExP
	 5J6x7YCOQnvyQ==
Date: Thu, 3 Sep 2026 11:58:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Message-ID: <20260903185810.qph364d4rlpcjazy@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
 <anXH5vC_w-iu6_iB@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anXH5vC_w-iu6_iB@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 07 Aug 2026, Richard Cheng wrote:

>On Tue, Jul 28, 2026 at 07:41:36AM +0800, Davidlohr Bueso wrote:
>>  /* Enable or dealloc BI-ID changes in the given level of the topology. */
>>  static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>>  {
>> @@ -1127,6 +1139,16 @@ static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>>  		return 0;
>>  	case PCI_EXP_TYPE_DOWNSTREAM:
>>  		if (enable) {
>> +			/*
>> +			 * Adopt a dport that was already programmed and
>> +			 * committed by firmware: nothing new is enabled
>> +			 * below it, so no commit is due.
>> +			 */
>> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl) &&
>> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
>> +			    cxl_bi_decoder_committed(bi))
>> +				return 0;
>> +
>
>Small question, when DSP's BI related registers are committed by FW, does it guaranteed
>that all the intermediate switch on the path are also committed with BI enabled ?

No, there are no guarantees at all for any of this. Please see below for details on the
most flexible way I could come up with.

...

>> @@ -3806,6 +3831,14 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  	if (part < 0)
>>  		return ERR_PTR(-EBUSY);
>>
>> +	/* avoid UB */
>> +	if (cxled_committed_bi(cxled) && !cxl_root_decoder_is_bi(cxlrd)) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s BI decoder in a non-BI window\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>
>Should we also check the inverse mismatch case here ?
>
>if (!cxled_committed_bi() && cxl_root_decoder_is_bi()) {}
>
>thoughts ?

Yep, and the whole thing can be turned into:

if (cxled_committed_bi(cxled) != cxl_root_decoder_is_bi(cxlrd)) { }

...

>
>Hmmm just curious are intermediate switch are guaranteed to be valid in AUTO discovery
>scenario , seems that the implementation only checks DSP.

So overall I had been ignoring nested switches because all this
is quite unsupported in Linux.

But for v8 I went ahead and added support for this. Basically
for patch 2 I redid the dport ctrl to handle nr_bi with nested
switches (as opposed to just for root port).

Now, for this auto discovery, when an endpoint device detects
the BI Enable already there it will "adopt" already configured
switch(es) and rp as it goes up the hierarchy. If at any level
things are not already configured, this adoption is broken and
it will do the respective BI decoder programming/committing as
it always does. For all level(s) above, every DSP that requires
explicit commits gets one, even with the decoder already configured
and previously committed because the new device's BI-ID may or
may not be accounted for.

Thanks,
Davidlohr
