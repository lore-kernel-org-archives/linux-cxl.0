Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2548731F9A4
	for <linux-cxl@vger.kernel.org>; Sun,  9 Aug 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306016; cv=none; b=C+gkq/9bbVHJhweqn+NKLIeXZEqAHeJ9N0QdXXrYPmUylynXL3NCVa3fwdo5cIvimOxXPzaNiGXSyMZv6GM1Rybaeug4qKBp772DuXSTdT8dYyin5Y8iEqug6gvBMX+kexkvMKRe4/+PJXUwo6gYsEAIg6Mj1nz9tKrJA9BGPCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306016; c=relaxed/simple;
	bh=nSBtQx5s8WIGz06Agj7JmzCFoMqzwgiNiiNSQ2QA2qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX10RmNbqAG0CSyt924I0JO49+aWJoFHHLxRWeFaD144uq3nPUt+syJaaY2AfrR/xmBr3tEdc5uWu+hhnGLm2WlFkNNuRyc8kqqOEZloNMYD+ipN2CDi/rZK6wv2H28RFqdNDup49kDxaj1MU6QbkysQME+yaHB2ARbmg5rVcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=JpqodqzR; arc=none smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="JpqodqzR"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3AA2D161FD0;
	Sun, 09 Aug 2026 20:06:48 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (100-111-249-226.trex-nlb.outbound.svc.cluster.local [100.111.249.226])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C035F162053;
	Sun, 09 Aug 2026 20:06:45 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bottle-Spicy: 603bcc5f37ea8639_1786306008016_270426347
X-MC-Loop-Signature: 1786306008016:197005890
X-MC-Ingress-Time: 1786306008016
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.249.226 (trex/8.0.2);
	Sun, 09 Aug 2026 20:06:48 +0000
Received: from offworld (unknown [172.56.213.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4hJ86X66qFz103y;
	Sun,  9 Aug 2026 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1786306005;
	bh=3fZlfpYZhzHg3MjJItsWA706lgLIbhHcLbOyxjbcwSY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=JpqodqzRf83wtjcaJSCRIB8gvxXBH4ZgpKVWRl8WuDgCES1VcY7zYbsZZnCDEiuKj
	 0Bg7+ZTioOn6fCZvjdvLeKJLMrOzg7MMuuIUBVl03ZJ7pFliEPqlCZ7oMdwgrw0Xr4
	 ptON0OX50k5MnUr0EC1i3gf/Q2sI1SwOtpL5ZsuYPKhiGpKg9NgbXro1Df5mpffL8D
	 unBf53qGfhHp44Ez14pN+WWWFSmdEa/FFQ1d8qo2hnDT/QjV0HWfsNh34XJ968Z7Ga
	 0Q6tQz5YPFZ0k/0kZrZN26eBvjWbJZbCd2o1lkc66O426qCG20aC3aFNJI7A0Kwj/a
	 4QSsQddR4dWlw==
Date: Sun, 9 Aug 2026 13:06:40 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 1/8] cxl: Add BI register probing and port
 initialization
Message-ID: <20260809200640.ahsbgyt7e6kg4klf@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-2-dave@stgolabs.net>
 <anVt9LtGbP8PzklF@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anVt9LtGbP8PzklF@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 07 Aug 2026, Richard Cheng wrote:

>On Tue, Jul 28, 2026 at 07:41:29AM +0800, Davidlohr Bueso wrote:
>> +static void cxl_port_map_bi(struct cxl_port *port)
>> +{
>> +	struct cxl_register_map *map = &port->reg_map;
>> +	struct cxl_dport *parent_dport = port->parent_dport;
>> +	struct device *udev;
>> +	int cap_id;
>> +
>> +	/* no upstream BI registers above host bridges or the cxl_root */
>> +	if (!parent_dport || is_cxl_root(parent_dport->port))
>> +		return;
>> +
>> +	udev = is_cxl_endpoint(port) ?
>> +		port->uport_dev->parent : port->uport_dev;
>> +	if (!dev_is_pci(udev))
>> +		return;
>> +
>> +	/* BI requires 256B Flit on the upstream link */
>> +	if (!cxl_pci_flit_256(to_pci_dev(udev)))
>> +		return;
>> +
>> +	/* map this port's own BI capability */
>> +	if (is_cxl_endpoint(port)) {
>> +		if (!map->component_map.bi_decoder.valid) {
>> +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
>> +			return;
>> +		}
>> +		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
>> +	} else {
>> +		if (!map->component_map.bi_rt.valid) {
>> +			dev_dbg(&port->dev, "BI RT registers not found\n");
>> +			return;
>> +		}
>> +		cap_id = CXL_CM_CAP_CAP_ID_BI_RT;
>> +	}
>> +
>> +	map->host = &port->dev;
>> +	if (cxl_map_component_regs(map, &port->regs, BIT(cap_id)))
>> +		dev_dbg(&port->dev, "Failed to map BI capability 0x%x\n",
>> +			cap_id);
>
>Do we need to distinguish an optional absent BI RT from an advertised BI RT
>that failed to map?
>
>In both cases port->regs.bi_rt is NULL, then cxl_is_bi_capable() accepts a NULL BI
>pointer for a USP, and __cxl_bi_ctrl_dport() consequently skips __cxl_bi_commit_rt().
>
>So a mapping failure of a present BI RT can be treated like the switch do not need a
>route table.
>
>I think we should treat mapping failure of BI RT differently.

I agree. For example a switch that requires an explicit BI RT commit would have BI
enabled below it without its route table ever being committed. I have fixed this
for v8 such that cxl_is_bi_capable() does:

	if (port_iter->reg_map.component_map.bi_rt.valid &&
	    !port_iter->regs.bi_rt) {
		dev_dbg(cxlds->dev,
			"BI RT advertised but unmapped\n");
		return;
	}

So then the later cxl_bi_setup will fail.

Thanks,
Davidlohr
