Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1433EFFC5
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965589; cv=none; b=DQytDvNc+AOCkng3MziQHXbopYEYgH6vqW+Ss5PzOIAdhUphhDqte/CucgXrKtskd1DplzETtoEv0UuW4LDON/lk1nvjkUvYgcYy5+DFCT27sxqpuQGiX7vGb+ArIB0jETaH446BZxFTElFSCM8735bgHGiBTBkxKkOTgmsvspI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965589; c=relaxed/simple;
	bh=YKBpBe9GKVjS2hRhGTcrvrZnxeP+k1GSUot9IL1SmSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUaqrXKilKRrnc2G2axJ8ZrysorWBiD/u5oLY1L2B/mnBS0wDzE2ienCCDA/MLxf3iwh/iiRXHwoa5bR+B6xHyV4Tbp69lfis1fhPB2zJu1JKBzPtI9dO7xthPgXvo/edObMdJaXWRNvKiFUMjVhKc7uFqSCWV+GcUQ9GeYM9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=ShpQNyRZ; arc=none smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ShpQNyRZ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 29FEA3E16E8;
	Wed, 05 Aug 2026 19:10:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (100-111-248-111.trex-nlb.outbound.svc.cluster.local [100.111.248.111])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 5EBD33E0C44;
	Wed, 05 Aug 2026 19:10:38 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Supply-Invention: 0cf5e0e16d343ef8_1785957038799_998002380
X-MC-Loop-Signature: 1785957038799:3646080685
X-MC-Ingress-Time: 1785957038799
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.111.248.111 (trex/8.0.2);
	Wed, 05 Aug 2026 19:10:38 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4hFg3d5WNtz1049;
	Wed,  5 Aug 2026 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785957038;
	bh=hOhIIQY17IMtjyX9O2RYsvg5nPvBEHE+gM4WXAAUlGg=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=ShpQNyRZ+49gb0oYm7fXbuHUPrdHuXB8YZUyW6UQPRRhxYTn10hlKtmgheUGHKJb3
	 D9F2k2WBCcPFlWk3ssR4lEZmwyKKGUSPNRxkic7w2B5hcFxu5Ii3BZuTpVJ3a1PWJG
	 DaTmZJA4n3x0asPPCSxqjrHGxsDamoGY7bO/U2/MHFtEB92hoAV+JCSP/vw4h9J2eS
	 vcN6ukcnbxNn9AJHaF3UQMVO37v2gB8xwurZD4xPZsTtbQJxtMf2zwDJPrWZ8zUGNd
	 lFh9uIp+I8DIveCJWvfSnh57t8YXGJbo9vHfaUSkIxAQSbw4ZKTGfodf+Ze4eBIQFw
	 mzxevpoxn4/ew==
Date: Wed, 5 Aug 2026 12:10:35 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, icheng@nvidia.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 4/8] cxl: Add HDM-DB region creation
Message-ID: <20260805191035.z7ayr7koxbomgq2h@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-5-dave@stgolabs.net>
 <anJ_lwQfXvGaoLxJ@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <anJ_lwQfXvGaoLxJ@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

Hi Alison, thanks for having a look at the series.

On Tue, 04 Aug 2026, Alison Schofield wrote:

>On Tue, Jul 28, 2026 at 07:41:32AM -0700, Davidlohr Bueso wrote:
>> A region inherits its coherency from the chosen root decoder: HDM-DB
>> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
>>
>> Surface the topology through read-only sysfs:
>>
>>   - decoderX.Y/cap_bi (root): CFMWS BI restriction.
>>   - decoderX.Y/bi (endpoint): '1' when configured for HDM-DB.
>
>Hi Davidlohr,
>
>$ grep What Documentation/ABI/testing/sysfs-bus-cxl
>shows that we have a precedent for spelling things out in the
>sysfs attribute names. Even long things like interleave_granularity
>and extended_linear_cache_size. Suggest doing same for these.

Sure, I can rename to backinv or back_invalidate.

>one bit below..
>
>
>> @@ -2108,10 +2106,31 @@ static int cxl_region_attach(struct cxl_region *=
cxlr,
>>		return -ENXIO;
>>	}
>>
>> -	if (cxled->cxld.target_type !=3D cxlr->type) {
>> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
>> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> -			cxled->cxld.target_type, cxlr->type);
>
>The new checks below seem to ignore CXL_HDM_DECODER_COHERENCY_UNKNOWN.
>Does the existing type check need to stay for UNKNOWNS?

This is a good point; I will be more explicit about the UNKNOWN handling
in the changelog. But we don't want it as a type match perse as unknown
could still allow for configurable settings (CXL_HDM_DECODER_COHERENCY_BOTH)
but its just not announcing it - albeit that would be pretty funky hw.

cxled_default_type() gives a type 3 decoder HOSTONLYMEM unless the HDM
reports device-coherent only, so the check would refuse every unknown
=66rom HDM-DB regions.

Thanks,
Davidlohr

>> +	/*
>> +	 * Verify the device and HDM are capable of the region's flavor before
>> +	 * proceeding. The endpoint decoder's target_type is then inherited
>> +	 * from cxlr->type later in cxl_rr_assign_decoder().
>> +	 */
>> +	if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
>> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
>> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	cxlhdm =3D dev_get_drvdata(&ep_port->dev);
>> +	if (!cxlhdm)
>> +		return -ENXIO;
>> +	if (cxlr->type =3D=3D CXL_DECODER_HOSTONLYMEM &&
>> +	    cxlhdm->supported_coherency =3D=3D CXL_HDM_DECODER_COHERENCY_DEV) {
>> +		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
>> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +	if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
>> +	    cxlhdm->supported_coherency =3D=3D CXL_HDM_DECODER_COHERENCY_HOST)=
 {
>> +		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
>> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>>		return -ENXIO;
>>	}
>
>snip to end
