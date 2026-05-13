Received: from shrimp.cherry.relay.mailchannels.net (shrimp.cherry.relay.mailchannels.net [23.83.223.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90475181334
	for <linux-cxl@vger.kernel.org>; Wed, 13 May 2026 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778632415; cv=pass; b=sVmib+e+k6/WH03bTblK/aoGR46I/2LTbkeXM1YnroWbX5bumo+qyjY8PrdKbiiyVDbNPdVcZibuBsdl3vrHTxl/rDTruoeaJgBvr5SqXRKv69Hm8yS0Au5SEmw48Ua1ofWq3QPtR8uyeJBhsNnSIuxQnAL0GngP5+Fd+mEmLsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778632415; c=relaxed/simple;
	bh=aketoE8qAyAAndUBZac0DDvLq0jFMZggioH0v/N5vOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDQxHDGclB22qI1B4iyehR62QiWYSai5qGz6SA/Fo/XBlM4CHOlVJwUcHyBVYdoZzWNMCfvsW0nMXsY8olRWaKKWn/hmXqlAxNUBM5q55k9TT4u8eb8jVT9rIq+2JEHccxFq1k3wlid6fqFtVi5kEoMpkyK0o6jwapALulshjXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fD7liiqX; arc=pass smtp.client-ip=23.83.223.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fD7liiqX"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id B4CB93E1B4D;
	Wed, 13 May 2026 00:33:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a207.dreamhost.com (100-104-1-130.trex-nlb.outbound.svc.cluster.local [100.104.1.130])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 43AAB3E1C53;
	Wed, 13 May 2026 00:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778632408;
	b=4b/Ypyh4NrpnFu/GKyBw9ULMkoQwUtS/c2wroscFJYHiOMv6ztbBBRIlKnoqX/+46FMghV
	3axtUsJf9VOCFWjBgDbBgkGlCijd3Bo96gLgD6456qj/XPp8C+VuXvPXCmRtwk6sRkTg0n
	D3FzecqtOchWudpoCuPrZYMga5mTUSIY4L0pgKj+hot7VGMHpm6P3Rl+ty8lEd7GyLmoBv
	GgjlYYHIqots059Ue60WhUcHwUPJn4uL7P8BQm0D6nmOPhv3BA3Rn7UAUUOSdAgzJNC5qy
	S80pqak5FYo8lVPgdg5597jenMH4cfZbQs0kWr2vexdYPzeMRhaqUIMY6VsaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778632408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=X49gifiTztp7Rfa1desnyZaz4If7oxYODnrg3gO0GYg=;
	b=dfdsQTiqvIZOTSTbHPgzyiwdBWY6FUnt8p3krHfu7AbOUG3+VSwSPD29y8EXUcXMSnIA+k
	zcCc71roaC3QPNoB7dtFRbdF995sfhDwT78CusiilbiGZCumvVkl7gzP+UlliBisMbvR5O
	AHszbk7WBqgPpOML3jEc29tN5do9BXtHsRfbggTGH1OANQDdKR6hPnCitusQdMYfyjeYzQ
	AfepkNcV849yPEBuky6I2ILEEnGfgsL+PAuNJEosJMiwCLgCDnbcpYrkiJZjDr+bwoviv7
	Y+N0IG9kMDVUBnjy1zLFbak72KGHlE9CC1d6nNggQeSfk67OEd3fb4kfIElM5w==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-fngrl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Spicy: 33ef16fe048deed8_1778632408548_4002107350
X-MC-Loop-Signature: 1778632408547:110815284
X-MC-Ingress-Time: 1778632408547
Received: from pdx1-sub0-mail-a207.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.1.130 (trex/7.1.5);
	Wed, 13 May 2026 00:33:28 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a207.dreamhost.com (Postfix) with ESMTPSA id 4gFZFM4qynz2Y;
	Tue, 12 May 2026 17:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1778632408;
	bh=X49gifiTztp7Rfa1desnyZaz4If7oxYODnrg3gO0GYg=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fD7liiqXgsPb7tQXv1C/1CdKTEDosyZpinnqD1zXYybp73BpScek/skTNE3OOdwdK
	 dVgmK9QzjfYWcoOH42Qchh37cRRCp2I0ppcWgUlvQdW5qiFlsb4pDr3uAT1Kt5kBwL
	 zynOK9Q9NFq7I10KKomePENNVyzVZjitMBCMVOsG/rKQQKwKiRgbJIYNYPXNLPQ3Fh
	 F5gZcXcCd/717TQyyvQhOVj8p/upfofrW+rTgnGuqmEGxWwmca7z54Havou1v5H782
	 dysQelWoDXViLl0LbvbkuXYigHozy2xzGfIxmlxHZfCqOi/WA//75O3Md/MHbdPen7
	 hFz0nm2gfjsig==
Date: Tue, 12 May 2026 17:33:24 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave.jiang@intel.com, dan.j.williams@intel.com,
	alison.schofield@intel.com, ira.weiny@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/6] cxl: Add Back-Invalidate register definitions and
 structures
Message-ID: <20260513003324.7g757sq5k7acyt7w@offworld>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-2-dave@stgolabs.net>
 <20260320145749.0000656c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260320145749.0000656c@huawei.com>
User-Agent: NeoMutt/20220429

On Fri, 20 Mar 2026, Jonathan Cameron wrote:

>On Sun, 15 Mar 2026 13:27:36 -0700
>Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Add CXL Back-Invalidate (BI) capability IDs, register definitions for
>> the BI Route Table and BI Decoder capability structures, and associated
>> fields. This includes HDM decoder coherency capability and control fields
>> needed to support HDM-DB (device-managed coherency with back-invalidate).
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> ---
>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index fa7269154620..74be940364e1 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -34,10 +34,12 @@ struct cxl_regs {
>>  	 * Common set of CXL Component register block base pointers
>>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>>  	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
>> +	 * @bi: CXL 3.2 8.2.4.26/27 CXL BI Capability Structure
>
>Whilst it is indeed one or the other depending on whether we are upstream or
>downstream ports, smashing them into a single entry in here seems liable
>to generate long term confusion.
>
>Other than a bit of storage, given this is optional anyway I'm guessing it
>doesn't cost us much to have bi_rt and bi_decoder?
>I think we just hit the
>if (!mi->rmap->valid) check and continue in cxl_map_component_regs().
>I also don't really think it's our problem to check for hardware that
>surfaces these caps on the wrong type of devices.  We'll map
>it but not use it.

I quite agree, having each its own reg is a nice cleanup.

Thanks,
Davidlohr

>
>
>
>>  	 */
>>  	struct_group_tagged(cxl_component_regs, component,
>>  		void __iomem *hdm_decoder;
>>  		void __iomem *ras;
>> +		void __iomem *bi;
