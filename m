Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5081C5D59
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 01:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789004509; cv=none; b=lzWK4KgxZ1LKRMvYZUkWxxnCBMVcfi1xW+0ksk71NRev5YcD3ubA7SsYBaQgB1fdn5bnbC/P0ZEiLBIR3Dl3u3DQzi/uds8DvRzNol1fr0XTbNVrH3tykV85q05lDWsCs64DtZbtohvCJ4WPf7asDrD+4WZ5uJ25jpR6UyBytvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789004509; c=relaxed/simple;
	bh=X9cJ5GpyRuZn8yvDFZg1Wx6ghzCLQ1VhNXIitKz/Sdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKBvYNNHOexz7RFYX7Zfd+X9eaN+ilULRqGW7VIiWZk/7LLWu6yDFGHlurWXCCeQmxQBzYeJX/5kJXtjqS6wZg8D0GIFk5O+OzyNR8sg5lwLmj0NcF+4vV7MfQXT80PO3Qww4wtnyPaHS9GvuqAsK5DKD5d51nWNbdtgMvvNoPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=mWBxOr2A; arc=none smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="mWBxOr2A"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9889A381805;
	Thu, 10 Sep 2026 01:34:01 +0000 (UTC)
Received: from pdx1-sub0-mail-a261.dreamhost.com (100-99-183-67.trex-nlb.outbound.svc.cluster.local [100.99.183.67])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 44BAA381A83;
	Thu, 10 Sep 2026 01:34:01 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Skirt-Name: 337deb175d0c1a5e_1789004041400_2909956001
X-MC-Loop-Signature: 1789004041400:305097137
X-MC-Ingress-Time: 1789004041400
Received: from pdx1-sub0-mail-a261.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.183.67 (trex/8.0.2);
	Thu, 10 Sep 2026 01:34:01 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a261.dreamhost.com (Postfix) with ESMTPSA id 4hgKvr4N7Gzypk;
	Wed,  9 Sep 2026 18:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1789004041;
	bh=xe8IWzOi7lS7b3x6rBIaYSRrr7JNNCLr4YzDUZ18HVk=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=mWBxOr2AjvyiVrp+FH5jlRXk25Ex7LRnhQESam/jrAcizwUl2ATRp/aUdMxLRngiQ
	 d7ey+TfIbnk3qZDSOpjeZMK/WeOg9VdKZlD/Oq0KQqlVcOz/H7NxOHUOQ4RWRQap07
	 imEdhS8S04oF4OPGomuzI+fNOjoUPbk4MzfrOgsnLet5mhwn+2KP8+kDSOeTFI20GK
	 w9HjHTUKTiiRjWRUwpKsPO63urJNkE0YNQaRL8Np6uUdhgnxZ5BdPBKe+1Q/0M69jk
	 zIEr+xf6V9Dxbvg1SBIyQKtYeqhsOlKz9pGL7Sa6B0KvTg+FEWo+ne29V2TRj1xg3/
	 AI4o3q6/QqAcg==
Date: Wed, 9 Sep 2026 18:33:58 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: dave.jiang@intel.com, alison.schofield@intel.com, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org, John Groves <john@groves.net>
Subject: Re: [PATCH v8 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <20260910013358.zi6jr7a6sfowinou@offworld>
References: <20260909170302.1550680-1-dave@stgolabs.net>
 <20260909170302.1550680-3-dave@stgolabs.net>
 <20260909222130.14387e8c@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260909222130.14387e8c@jic23-hlaptop>
User-Agent: NeoMutt/20220429

On Wed, 09 Sep 2026, Jonathan Cameron wrote:

>> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable,
>> +			       bool direct)
>> +{
>> +	void __iomem *bi = dport->regs.bi_decoder;
>> +	struct cxl_port *port = dport->port;
>> +	u32 ctrl, value, set, clr;
>> +	int rc;
>> +
>> +	guard(mutex)(&port->bi_lock);
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +	if (!enable) {
>
>There isn't really that much shared code between enable and disable paths.
>Maybe just have separate functions / push the implementation down to
>the wrappers?

I don't want to change much code around at this point, but I
will look at doing this.

>
>> +		if (WARN_ON_ONCE(dport->nr_bi == 0))
>> +			return -EINVAL;
>> +		/* others below still need this level */
>> +		if (--dport->nr_bi > 0)
>> +			return 0;
>> +
>> +		writel(ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> +				CXL_BI_DECODER_CTRL_BI_ENABLE),
>> +		       bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +		return cxl_bi_commit_dport(dport);
>So this sent me on a wild goose chase.  The actual definitions
>for committing rather imply that you don't need to commit when
>turning it off, but the Implementation note in 9.14.2
>does have a commit sequence like you have here.

This was a late addition to the series, from me being extra
cautios and assuming some potential problem with recycled BI-IDs(?)
throughout the topology.

>
>For reference we have: Table 8-156
>"Explicit BI Decoder Commit Required"
>If 1, indicates that the software must set the BI decoder commit
>bit whenever a new BI Device is enabled anywhere below this
>port or any component below this port undergoes bus number
>reassignment." which is the normative text and doesn't say anything
>about commit being used when turning things off...

Agreed that it would be good to get clarity here. For now I will
leave the commit upon disable unless there are strong thougths
against it.

>
>John, can you note this one down for possible discussion / clarification
>in the spec?
>
[...]

>> +
>> +/*
>> + * devm teardown on endpoint port destruction. Registered before the
>> + * decoders, so devres runs it after them: regions are detached and
>> + * decoders unregistered by the time BI comes down.
>> + */
>> +static void cxl_bi_dealloc(void *data)
>> +{
>> +	struct cxl_port *endpoint = data;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_dport *dport_iter;
>> +	struct cxl_port *port_iter;
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>
>Maybe a comment on why the region lock is needed. I couldn't immediately
>spot the answer and this is doing stuff that doesn't seem to have
>much to do with regions.

Yes, I believe this can be dropped.

(and pretty much ack to the rest of the comments, thanks for reviewing).

Thanks,
Davidlohr
