Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179357ED83
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.214.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197068; cv=none; b=Rq1sHMwe7/GBg9JhADtQw8h4TOWVT1ozoiPq4QYBAdW56zkSoHID4C8wY1VzQ4xj5EtB/8VK/Y/ugULA8deAoKzimdXzyXdGFBllAlvaRsQ0vkjlvjEKYMdKS8jxBanP6JhyLvaDmzTclhaZzjIGSpV0ilzc1Rp4HMydl1j5pjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197068; c=relaxed/simple;
	bh=akKv8QPc6zsWnwlUu+rJeQuh18Jn9ZzV1fjt1OhlRJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=naoLmrD8ZFYpliaB2w1CUTj/mlQaVfMKqWDqfsWWpDDyPV+oJkXGdbKI41KV+oVtF6AWGLYB17uySaYM2NIHUXUK/Hg71od29KNad0citDVAZcIHHwi3ZYN+ZGUoz7CZiBxbmPYgoq4NFb2qxtGR20vH9Z6pT0fF+kfYFTnAGEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=L7R2Tuo0; arc=none smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="L7R2Tuo0"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 9765E161A8C;
	Wed, 23 Sep 2026 20:57:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a230.dreamhost.com (100-100-68-17.trex-nlb.outbound.svc.cluster.local [100.100.68.17])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5D6ED1619E4;
	Wed, 23 Sep 2026 20:57:39 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Trouble: 031032e163c86f32_1790197059452_2496903977
X-MC-Loop-Signature: 1790197059452:3818249721
X-MC-Ingress-Time: 1790197059452
Received: from pdx1-sub0-mail-a230.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.68.17 (trex/8.0.2);
	Wed, 23 Sep 2026 20:57:39 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a230.dreamhost.com (Postfix) with ESMTPSA id 4hqq6V725bz1d5;
	Wed, 23 Sep 2026 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790197059;
	bh=TVB+i48RmEI0/Wsm8uQlSUm8bEiJrK4IEyBgWCvWDwc=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=L7R2Tuo0K6Fsng+HB90+ksjTHwWUB9Cm+JjRkW9dyM4TCrYOrkPB02k8K7L+rh6Tn
	 WdNL/Jmc8HMHwtyQGllNDXUG8gCyD7J40DUoN+a2HVKuuEn7xKbmFxHKzeTpoFhFWD
	 xF0FndteSCSAEKk2eCY/3QuXTsgButXnBYk12cyvj75E8eRY9EB/r3u3N50sz8cucZ
	 GA2fh0j2nRQt4G2JwfIySMDazQvc8KBFukfYsaRyGsmvmaq4E4o6cZAlRs8BzIYRfN
	 jW0IBBFawj+Y3RqXtWJaI0KZgT5m7qOXIatkEU8sWXL+l4KbDlBp1xX/RUz6Ysxl2+
	 ttkFe4VP16RJA==
Date: Wed, 23 Sep 2026 13:57:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v9 09/10] cxl/test: Add mock BI topology support
Message-ID: <20260923205736.tvxwcz3qizvp3jsx@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <113381dfa31a452a5522ed84b14a3b77b6e027f3.1790103847.git.dave@stgolabs.net>
 <20260923011129.BF5F31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260923011129.BF5F31F000FF@smtp.kernel.org>
User-Agent: NeoMutt/20220429

On Wed, 23 Sep 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>- [Medium] cxl/test: Use-After-Free in mock_cxl_setup_hdm() on unbind/rebind

This is valid, but just affects the mock device, I have fixed it per the below.

>--
>
>commit 943579b999ae7670b28d433527c8563008ab779f
>Author: Davidlohr Bueso <dave@stgolabs.net>
>
>    cxl/test: Add mock BI topology support
>
>    Extend the mock topology with a Back-Invalidate path
>    covering both the type3 memdevs and the type2 accelerator.
>
>[ ... ]
>
>    Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>    Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 62bd92b3be45f..cddea44e780aa 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>[ ... ]
>> @@ -736,10 +767,65 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
>>	cxlhdm->port = port;
>>	cxlhdm->interleave_mask = ~0U;
>>	cxlhdm->iw_cap_mask = ~0UL;
>> +
>> +	/*
>> +	 * A page of plain memory stands in for the HDM decoder register
>> +	 * block: cxled_committed_bi() reads the per-decoder BI bit from
>> +	 * it, which mock_decoder_commit()/reset() maintain below. All
>> +	 * other consumers of these registers are bypassed by the mocked
>> +	 * decoder setup and commit paths.
>> +	 */
>> +	cxlhdm->regs.hdm_decoder =
>> +		(void __iomem *)devm_get_free_pages(dev,
>> +						    GFP_KERNEL | __GFP_ZERO, 0);
>> +	if (!cxlhdm->regs.hdm_decoder)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	/* likewise for the endpoint's BI Decoder block, BI Enable set */
>> +	if (is_cxl_endpoint(port) && !port->regs.bi_decoder) {
>> +		void __iomem *bi = (void __iomem *)
>> +			devm_get_free_pages(dev, GFP_KERNEL | __GFP_ZERO, 0);
>> +
>> +		if (!bi)
>> +			return ERR_PTR(-ENOMEM);
>> +		writel(CXL_BI_DECODER_CTRL_BI_ENABLE,
>> +		       bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +		port->regs.bi_decoder = bi;
>> +	}
>
>[Severity: Medium]
>Could this lead to a use-after-free during a driver unbind/rebind cycle?
>
>In mock_cxl_setup_hdm(), devm_get_free_pages() is used to allocate memory
>for port->regs.bi_decoder. During a cxl_test unbind, devres will free this
>memory, but the pointer remains set in the long-lived struct cxl_port.
>
>On a subsequent rebind, the condition !port->regs.bi_decoder will evaluate to
>false, skipping the allocation of new memory. This leaves a dangling pointer
>that could be dereferenced later by cxl_bi_decoder_enabled().

I was able to reproduce this pounding with the mock device with:

     echo endpoint16 > /sys/bus/cxl/drivers/cxl_port/unbind
     echo endpoint16 > /sys/bus/cxl/drivers/cxl_port/bind
     <create an HDM-DB region on decoder16.0 and commit it>

The bind mostly fails with ENODEV, but for a window where that bind beats
the the unbind's queued detach work, that reprobes the same cxl_port, so
we run into:

     [   25.154927] cxl_port endpoint14: probe: 0
     [   25.229702] cxl region6: mem7:decoder14.0 BI disabled by reset during commit

Nothing had cleared BI Enable on that endpoint.

I will fold this fix fix with:

   -     if (is_cxl_endpoint(port) && !port->regs.bi_decoder) {
   +     if (is_cxl_endpoint(port)) {

(mock device only, real driver not affected since devm_cxl_port_bi_setup()
re-maps on every probe and cxl_map_component_regs() assigns
unconditionally).
