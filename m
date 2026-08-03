Received: from fennec.ash.relay.mailchannels.net (fennec.ash.relay.mailchannels.net [23.83.222.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184C5394470
	for <linux-cxl@vger.kernel.org>; Mon,  3 Aug 2026 19:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785989; cv=none; b=D6TLK/yeAyY90Oydfn90iJOGpwS4ffmVIXlWjR7Eo1PK3ulJgDHM333tDeAFdocevH6+XPjZ/orpGCNoDrR7rbaUzKGJOn1iZZeDa0ayDoQQMsiEdUI5Het7L1iSgM88HcgUdK8obQXYOkIHcISUHDVnNDVHQa19gLsyZ6ELq9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785989; c=relaxed/simple;
	bh=rZ5IpCmxCZMsodZantLtpiwM/7Z8caFM+tYmvVLDGDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARKvlZZBP7F9VnSSw9Fytm9u60s3REwYRCbhwFSrMSMDOt/b0SbTD6enghv16BJFF4ZZh4vliF01G+ZYMCyzVnk4UQnTRMslz3sIllVwmkdD3Uv/sc7yNuiomO5gmb9RbiG8OuejnUeJ+Sj1YehJelFUCkziaNrqwadqbf+19K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=JXEVS9Jz; arc=none smtp.client-ip=23.83.222.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="JXEVS9Jz"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 75994643B82;
	Mon, 03 Aug 2026 19:04:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.106.248.225])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1B3C6641E6E;
	Mon, 03 Aug 2026 19:04:14 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Scare: 6aa87b0511d66088_1785783854318_3598694244
X-MC-Loop-Signature: 1785783854318:4278984273
X-MC-Ingress-Time: 1785783854317
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.106.248.225 (trex/8.0.2);
	Mon, 03 Aug 2026 19:04:14 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4hDR194spsz3M;
	Mon,  3 Aug 2026 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785783853;
	bh=CkfM59Y1CBc/VfDNIow5A+KGKS+85EDIBifkWG6P0qY=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=JXEVS9Jz3IMe1uAgCTdQ3aMz9arpoAx7re2Dygygbhv3EKLzp8VNq0prED134hSBK
	 OYPXUv+wK3S02ewrSSKLKBm4CSr9GQp0MLVsmIdW9vvdjSXyqRbknRwI75gt8CZ57n
	 Tgy0FsTW+WYAqV1yv/sSFaHKJpiE1+TidgudCL+WXBc2B4yaSw+rXqWKBfmUF+Hj/a
	 MNedaZlxDq/pzm+6nhENt9Z1Q1rngZ7YHcZm/8M3wGne97U9yXLyfptVwEiueDs0af
	 9nue+STsUfhuu5zDgJHAEDkqjihbN3M5Ed2dBHQuvjIJFCdpBNimX2NxR7fDP/MtFQ
	 wSrA8lQ8/Yq1A==
Date: Mon, 3 Aug 2026 12:04:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Message-ID: <20260803190410.zjtr3idmnsyrmbyh@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
 <20260728154628.B135A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260728154628.B135A1F000E9@smtp.kernel.org>
User-Agent: NeoMutt/20220429

On Tue, 28 Jul 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 1 potential issue=
(s) to consider:
>- [High] Auto-committed BI decoders can be improperly assembled into regio=
ns even if BI path setup fails, leading to fatal hardware routing errors or=
 cache incoherence.

False positive, see below.

>--
>
>--- Patch [8]: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders ---
>commit 5bfa0978968677982ba4863deb2a8257dcfab9b1
>Author: Davidlohr Bueso <dave@stgolabs.net>
>
>cxl: Allow auto-committed BI hdm decoders
>
>This commit allows auto-committed BI HDM decoders on capable platforms.
>It ensures that committed BI decoders are not assembled into regions
>with mismatched coherency models or non-BI windows.
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1839,6 +1854,16 @@ static int cxl_region_attach_auto(struct cxl_regi=
on *cxlr,
>>  		return -EINVAL;
>>  	}
>>
>> +	/* A committed decoder may only join a region of its own flavor */
>> +	if (cxled_committed_bi(cxled) !=3D
>> +	    (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
>> +	     cxl_root_decoder_is_bi(cxlr->cxlrd))) {
>> +		dev_err(&cxlr->dev, "%s:%s coherency model mismatch\n",
>> +			dev_name(&cxled_to_memdev(cxled)->dev),
>> +			dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +
>
>[ ... ]
>
>> @@ -3806,6 +3831,14 @@ static struct cxl_region *construct_region(struct=
 cxl_root_decoder *cxlrd,
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
>[ ... ]
>
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -181,6 +181,10 @@ static int cxl_endpoint_port_probe(struct cxl_port =
*port)
>>  	if (rc)
>>  		return rc;
>>
>> +	/*
>> +	 * Must precede region discovery so that any firmware-committed BI
>> +	 * decoder is adopted before its region is assembled.
>> +	 */
>>  	rc =3D cxl_bi_setup(port);
>>  	if (rc)
>>  		dev_dbg(&port->dev, "BI setup failed rc=3D%d\n", rc);
>
>[Severity: High]
>If cxl_bi_setup() fails in cxl_endpoint_port_probe() (for example, due to
>register read/write failures on intermediate switches), the error is only
>logged and probe continues.
>
>Since cxl_region_attach_auto() and construct_region() authorize the decoder
>to join a BI region based on cxled_committed_bi() checking the hardware st=
ate
>instead of checking the software state (cxlds->bi), could an auto-committed
>BI decoder be improperly assembled into a region even if its path setup fa=
iled?

No, the software state is checked first and it is fatal to the attach.

Auto-assembly runs cxl_add_to_region() -> construct_region() ->
attach_target() -> cxl_region_attach(), and cxl_region_attach() does
before anything else:

	if (cxlr->type =3D=3D CXL_DECODER_DEVMEM &&
	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n", ...);
		return -ENXIO;
	}

So for a device-coherent region under a BI window must have cxlds->bi set.

>
>Does this risk fatal hardware routing errors or silent cache incoherence if
>the OS failed to properly configure or adopt the BI path?
>
>--=20
>Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260728144136.709882=
-1-dave@stgolabs.net?part=3D8
