Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC12EAD1B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688055; cv=none; b=m0osGGYrtwHBt1DN7GSf+N1NmVsQ6DKVevbeIvpnLipNP4ksDU6Yku1P1+l2sMrUD8fSvRLRkzLmpbyfYxPtjnC381evMhrUiQaKyZOVsFg++3tXn6PV9JvQnWCgevb25H4QPXBS6IGhmG+oe2wAWyP4Tb/GwupUp+6UPURNbGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688055; c=relaxed/simple;
	bh=XJEbLv3DioGqXXQKEnpEBVCri3y+t11I1PTapUrLMbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiQFbijErGNZjulTGeiWn0BxDDiswq+3jO+IfdJRrEahEEQIWEFDD1n3G5beU8JxywDl0Ndp/SgF/U5Tc20n8Yo92/GOF13xfXypSQAhuDAuZUzoVz82xLlDmuf206jYZzeHad9H8KxMcC+ri70P8Gav2w2Y7Pe5VJnIhVWNSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Cv4kiAdo; arc=none smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Cv4kiAdo"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A18584E3436;
	Fri, 05 Jun 2026 19:23:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.105.228.210])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E1CE74E33ED;
	Fri, 05 Jun 2026 19:23:19 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bubble-Trade: 75785d6508eb3285_1780687400485_349733502
X-MC-Loop-Signature: 1780687400485:1350421797
X-MC-Ingress-Time: 1780687400484
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.228.210 (trex/7.1.5);
	Fri, 05 Jun 2026 19:23:20 +0000
Received: from offworld (186-79-219-2.fo.baf.movistar.cl [186.79.219.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4gXBDP1c4Cz106G;
	Fri,  5 Jun 2026 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1780687399;
	bh=G89bI8y7jl8JJTVniN/ubVyGlrzNbadUaI7B4CPbo00=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Cv4kiAdoOf+Iq4DHrC00tBJxpAJLNUkJ7Qkws2iIh0Bb+FsASnYg3axfzam8e7Fqs
	 vMFzcFcDKty7ZbQy7bqyE/xlVfEPNIscfE/wo4bVkaCGE88zL9CW+Asv2LQg0Bi8tB
	 8ZGaHTjz6drrSQvPq1SZtf31lxzOCHqDcUBTXw31ufZwtI9TMBTvdlvFjhixDVVZrT
	 c0Qg6oUTFj5D3wt+aVxr60GAQ4Bm1TQQulmQ/BuaDwhzoaQoGMMqRUNjqsMsQwEsZT
	 1/pHeB4TceQEzgHlhTWSxTZc3UMAi+TnlzRmqq/L2Go/Ei/w92w37mE2zSAc+5TsJm
	 Il0Z8wJF6mxaw==
Date: Fri, 5 Jun 2026 12:23:11 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/5] cxl: Add HDM-DB region creation
Message-ID: <20260605192311.4gqglu5i6pz6jcfo@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-5-dave@stgolabs.net>
 <aiI1ZVwF-b-KA4Sf@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aiI1ZVwF-b-KA4Sf@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 05 Jun 2026, Richard Cheng wrote:

>On Thu, Jun 04, 2026 at 05:33:28PM +0800, Davidlohr Bueso wrote:
>> -	if (cxled->cxld.target_type != cxlr->type) {
>> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
>> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> -			cxled->cxld.target_type, cxlr->type);
>> +	/*
>> +	 * Verify the device and HDM are capable of the region's flavor before
>> +	 * proceeding. The endpoint decoder's target_type is then inherited
>> +	 * from cxlr->type later in cxl_rr_assign_decoder().
>> +	 */
>> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
>> +	    cxlds->type == CXL_DEVTYPE_CLASSMEM && !cxlds->bi) {
>> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>
>Hi Davidlohr,
>
>This might not be a hole today, but CXL_DEVTYPE_DEVMEM type-2 device
>will bypass this part and commit HDM-D in a BI-restricted window, Type-2
>will never have cxlds->bi set.

Agreed.

>
>Maybe something like "DEVMEM" regions on F_BI windows, require cxlds->bi
>for all device types.

Yeah, I ended up with this (and we consolidate that F_BI Window check
as well):

	if (cxlr->type == CXL_DECODER_DEVMEM &&
	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
		return -ENXIO;
	}

Thanks,
Davidlohr
