Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FEA46D089
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 18:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264261; cv=none; b=jWuFllWI0BOZJXDXf2aYeuLAjRbW0LskwDNP7+xF/kGPmvPnIeaaOY0+QdMjjbrEKDiKRFWTpHK5s36ysN0aavh7zOoAoMNh952h/TNcqRR49+m7DBfV7t5vGqVR+Llr1ZicW0cwFVP9cp4Rvs84LhVyr/wP7Z3vN4WRX31ZaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264261; c=relaxed/simple;
	bh=BybutgC3O5pamdcIn/79ctmcAzs0BgnL93R+708UPGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yqhple/mRN3TXi6GlCwUNBOKDG/QqBRCvhvjGjzrPGpuuNCCuiGFuGuOfGrh+ZYd3gggapjokwuGk89aVIIvf/8GgaYC6TtoAj5HYKTCKA5yUMqLPlmmoSSWlPdkY4F98cpWZhIFOVyJaFpjgSw9SlWfeM9sskpiIqV/MN5770g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=O7hYJ+pE; arc=none smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="O7hYJ+pE"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F0FFE462D4E;
	Tue, 28 Jul 2026 18:44:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a232.dreamhost.com (100-108-75-34.trex-nlb.outbound.svc.cluster.local [100.108.75.34])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BB4824625D3;
	Tue, 28 Jul 2026 18:44:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Celery-Chemical: 1f967cc760c443bb_1785264252824_3616488199
X-MC-Loop-Signature: 1785264252823:3084516082
X-MC-Ingress-Time: 1785264252823
Received: from pdx1-sub0-mail-a232.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.75.34 (trex/8.0.2);
	Tue, 28 Jul 2026 18:44:12 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a232.dreamhost.com (Postfix) with ESMTPSA id 4h8krr2g9qzym6;
	Tue, 28 Jul 2026 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785264252;
	bh=0dPipwYpZ5Ok9fGFIHyIuqDeX8WqpZG6ok0wAqab7Yo=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=O7hYJ+pEe/pjfcqBqNjksjWV3pHvTBL0TqKSKYQCELottZjqYlmQ3cy73F+KQ4hlc
	 8Dl0dPwmO19Q4YFTtSuzZywKcGlFRhOsngC4yKZ62EtyBmceaf1N6clNZDAZhAeWyD
	 iWV8A6DBzpgIBMN7bng6VFJykUG4lkMryvV9gGH8SmwhgbAIQl5JTJLF2GtOr3u56O
	 0+sSIWs05tapSypp6sZJDP+36YZXHQORUqLIwefnIgwEwkOH7Kh9J9aznE2kzgjaDc
	 c/jF5RVyButfUvQiXsi23CLTYVD3A6LPDfkWn5Mp/Gt+XGFlwL+nMow3LQlM55iJch
	 XLlQvQv3BI2IQ==
Date: Tue, 28 Jul 2026 11:44:09 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: sashiko-reviews@lists.linux.dev, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 3/8] cxl/hdm: Add BI coherency support for endpoint
 decoders
Message-ID: <20260728184409.oknajvuhtuk467gp@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-4-dave@stgolabs.net>
 <20260728152634.1E1B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260728152634.1E1B91F00A3A@smtp.kernel.org>
User-Agent: NeoMutt/20220429

On Tue, 28 Jul 2026, sashiko-bot@kernel.org wrote:

>Thank you for your contribution! Sashiko AI review found 1 potential issue=
(s) to consider:
>
>Pre-existing issues:
>- [High] Kernel stack out-of-bounds read when parsing HDM decoder target l=
ists with interleave_ways > 8.

This came up previously but taking a look now: I think this is valid only f=
or out
of spec decoders. See below.

>--
>
>--- Patch [3]: [PATCH v7 3/8] cxl/hdm: Add BI coherency support for endpoi=
nt decoders ---
>commit b9f3e30d3fbbe54161183f25487d1176310fc0eb
>Author: Davidlohr Bueso <dave@stgolabs.net>
>
>cxl/hdm: Add BI coherency support for endpoint decoders
>
>This commit caches the HDM decoder's supported coherency models on struct
>cxl_hdm. It also uses this to default the target_type for uncommitted endp=
oint
>decoders and blocks support for pre-committed decoders with the BI bit set.
>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 0c80b76a5f9b4..9da8aa2116095 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>
>[ ... ]
>
>> @@ -1040,17 +1063,7 @@ static int init_hdm_decoder(struct cxl_port *port=
, struct cxl_decoder *cxld,
>>  		port->commit_end =3D cxld->id;
>>  	} else {
>>  		if (cxled) {
>> -			struct cxl_memdev *cxlmd =3D cxled_to_memdev(cxled);
>> -			struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
>> -
>> -			/*
>> -			 * Default by devtype until a device arrives that needs
>> -			 * more precision.
>> -			 */
>> -			if (cxlds->type =3D=3D CXL_DEVTYPE_CLASSMEM)
>> -				cxld->target_type =3D CXL_DECODER_HOSTONLYMEM;
>> -			else
>> -				cxld->target_type =3D CXL_DECODER_DEVMEM;
>> +			cxld->target_type =3D cxled_default_type(cxled);
>>  		} else {
>>  			/* To be overridden by region type at commit time */
>>  			cxld->target_type =3D CXL_DECODER_HOSTONLYMEM;
>
>[Severity: High]
>This is a pre-existing issue, but looking further down in init_hdm_decoder=
(),
>is there a risk of a kernel stack out-of-bounds read?
>
>When parsing HDM decoder target lists for a switch decoder, the loop uses
>cxld->interleave_ways as the upper bound:
>
>	union {
>		u64 value;
>		unsigned char target_id[8];
>	} target_list;
>=09
>	...
>=09
>	if (!cxled) {
>		lo =3D readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>		hi =3D readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>		target_list.value =3D (hi << 32) + lo;
>		for (i =3D 0; i < cxld->interleave_ways; i++)
>			cxld->target_map[i] =3D target_list.target_id[i];
>
>		return 0;
>	}
>
>Since the target_list union is fixed at 8 bytes, if a CXL switch device
>presents an interleave_ways value greater than 8 (such as 12 or 16), could
>this loop read up to 8 bytes of adjacent kernel stack memory into
>cxld->target_map?

Such switch IW > 8 are *only* allowed for cxl.mem devices (per table 8-123).
But yes, faulty hw/fw would cause a splat, ie: with a hacked qemu:

   BUG: KASAN: stack-out-of-bounds in devm_cxl_enumerate_decoders+0xefd/0x1=
b00
   Read of size 1 at addr ffff8881003bf180 by task kworker/u16:0/12
    kasan_report+0xe0/0x110
    devm_cxl_enumerate_decoders+0xefd/0x1b00
    cxl_port_add_dport+0x9c/0x200
    devm_cxl_enumerate_ports+0xa36/0x1190
    cxl_mem_probe+0x26f/0x710

   The buggy address belongs to stack of task kworker/u16:0/12
    and is located at offset 40 in frame:
    devm_cxl_enumerate_decoders+0x0/0x1b00
   This frame has 1 object:
    [32, 40) 'target_list'

I will send a patch to robustify.

Thanks,
Davidlohr

>Because this mapped array is subsequently exposed to user-space via the
>target_list sysfs attribute, could this allow unprivileged users to leak
>stack canaries or kernel addresses?
>
>--=20
>Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260728144136.709882=
-1-dave@stgolabs.net?part=3D3
