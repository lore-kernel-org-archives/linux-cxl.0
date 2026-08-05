Received: from purple.birch.relay.mailchannels.net (purple.birch.relay.mailchannels.net [23.83.209.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2383F410D
	for <linux-cxl@vger.kernel.org>; Wed,  5 Aug 2026 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965460; cv=none; b=q0g2IXJp2i0RIEiO68Ge3VpX1A2QVpwdxY/qjolleeJObFs6BKuUpMxxWeEhTW5IY9SNSzWvx2PxUQsOrEUEYY/5oTY28yx/4TLdBp0eOJCIQKtzA8h0fhhKc+2SepOrG97qsa1X2LueGbMVHSWcaVjVdhjqlti52oD1WsyFKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965460; c=relaxed/simple;
	bh=eEDp6mWmh9J86X9evXmxY83Zv3rITXIO8cnBZhQM/FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLIQU+0s6Q6YNRKRhqqGsJV9K7vRsGUVbFYhmeBG0H4hx66DPTHFahej5z8tq34VnqOVIbdblGrF7CoW58IKJYF5XGWn7JnW0LFFNlVolVZOcLSXJJ8QFTlrHlo07jp2U9jSBWYU9IAj0bfN/F3WYCx5MLuRLQwtRGKR+4597GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=gt/hbrrA; arc=none smtp.client-ip=23.83.209.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="gt/hbrrA"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 46B764C29A5;
	Wed, 05 Aug 2026 20:53:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a220.dreamhost.com (100-108-76-70.trex-nlb.outbound.svc.cluster.local [100.108.76.70])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DA0394C13F8;
	Wed, 05 Aug 2026 20:53:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trail-Bottle: 66c8a53b37bf46bb_1785963206122_2813196590
X-MC-Loop-Signature: 1785963206121:2805551669
X-MC-Ingress-Time: 1785963206121
Received: from pdx1-sub0-mail-a220.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.108.76.70 (trex/8.0.2);
	Wed, 05 Aug 2026 20:53:26 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a220.dreamhost.com (Postfix) with ESMTPSA id 4hFjL91vD9zTh;
	Wed,  5 Aug 2026 13:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1785963201;
	bh=dLa1blbCz0Ox1ZTuv3y4tIU4mMR3emoIxz8xsT2YPeU=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=gt/hbrrABWEoD3w4sXlsQ3/XfR4TibBczzTh7tL+xEqfdfQHuXbTR/lypRtrBBeIj
	 GAmB1LhMsktzhwqQze502Sh9MHtefRR6JLgwBtJYJzrrz+Cq8mlYggbowqFEqG7OLY
	 bO1Gwl6dZyGYy2GtEfcRoTIm+VY1JmKqItYluT5XZg6sgXyi9hXKGPUgaNmjHaXh67
	 mRlVvB3fg3YSmtArKUYjLtCW0GquXspd2LbS6FJU3wmNf6bjozFtmXVWBtp8FKNkBq
	 Ft2Nfauzfz7sr8MgviSRSo5Qmq+Jt/QGflBlwayu8iz66CGFzzTYl4n2EsZ871Ux9x
	 ZeOrybiQ6RiMA==
Date: Wed, 5 Aug 2026 13:53:18 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, icheng@nvidia.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 8/8] cxl: Allow auto-committed BI hdm decoders
Message-ID: <20260805205318.mdrqr5sfsgncty74@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-9-dave@stgolabs.net>
 <anKJGC7iXDifSHZt@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <anKJGC7iXDifSHZt@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Tue, 04 Aug 2026, Alison Schofield wrote:

>On Tue, Jul 28, 2026 at 07:41:36AM -0700, Davidlohr Bueso wrote:
>> @@ -1061,13 +1061,23 @@ static int init_hdm_decoder(struct cxl_port *por=
t, struct cxl_decoder *cxld,
>>		else
>>			cxld->target_type =3D CXL_DECODER_DEVMEM;
>>
>> -		/*
>> -		 * Autocommit BI-enabled decoders is not supported.
>> -		 * At this point cxlds->bi is not yet setup, so there
>> -		 * are no guarantees that the platform supports BI.
>> -		 */
>> -		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
>> -			return -ENXIO;
>> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl)) {
>> +			struct cxl_dev_state *cxlds =3D cxled ?
>> +				cxled_to_memdev(cxled)->cxlds : NULL;
>
>Here we first read CTRL register -
>
>> +
>> +			if (cxld->target_type =3D=3D CXL_DECODER_HOSTONLYMEM) {
>> +				dev_warn(&port->dev,
>> +					 "decoder%d.%d: BI with host-only\n",
>> +					 port->id, cxld->id);
>> +				return -ENXIO;
>> +			}
>> +			if (cxlds && !cxlds->bi_capable) {
>> +				dev_warn(&port->dev,
>> +					 "decoder%d.%d: path not BI capable\n",
>> +					 port->id, cxld->id);
>> +				return -ENXIO;
>> +			}
>> +		}
>>
>>		guard(rwsem_write)(&cxl_rwsem.region);
>>		if (cxld->id !=3D cxl_num_decoders_committed(port)) {
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 76c6dc28a407..5578ef68034d 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1827,6 +1827,21 @@ static int cxl_region_attach_position(struct cxl_=
region *cxlr,
>>	return rc;
>>  }
>>
=E2=87=9E>> +/* Read back the committed BI bit of an auto-discovered decode=
r */
>> +static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port =3D cxled_to_port(cxled);
>> +	struct cxl_hdm *cxlhdm =3D dev_get_drvdata(&port->dev);
>> +	u32 ctrl;
>> +
>> +	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
>> +		return false;
>> +
>> +	ctrl =3D readl(cxlhdm->regs.hdm_decoder +
>> +		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));
>> +	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
>
>And then we re-read it here.  Could we record the bit at the earlier read?

I prefer not adding complexity in managing a new flag (ie: now we have to d=
eal
with symmetry for the manual region creation counterpart, syncing etc.) at
the cost of one readl per decoder as regions are assembled.

Thanks,
Davidlohr

>
>
>> +}
>
>snip to end
