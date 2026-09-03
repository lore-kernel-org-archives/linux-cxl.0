Received: from caracal.ash.relay.mailchannels.net (caracal.ash.relay.mailchannels.net [23.83.222.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE022F8EA3
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.222.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398661; cv=none; b=BetKasI0cfyxIW/Oe6QsfSS6SVzf3NvxDD8vtD1cRtLcJetQqnUli3Lcw2frQUdirgSKwqVs/PGJcSwzfeAu6gm6b3K9sAsoXBckk3ENOFX0YieT0yQ/fhnpUq0O0kCsyuUW8ZYusgRpJDl31TiU0/NdIA62BvsMKZilIP5VXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398661; c=relaxed/simple;
	bh=YMbtV9nunqkj9jxTpPZ/p/VxlTrsHjM4uInYjxy7Fjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rLEteDeDR5O6HOS4PirU8CNPFVi7zuSowNdK877AlLhM4RRJnLs+gvlXS8UZUhniGpt2rBWkfndD15J/jQAIWRBBTvthbZcmaSIlVwENvPoPUPZ6TgWRhm3VhVJy8Tg+2R7bepCrOdh5//ceSW09LNAH/96Jl+VoZJjdNZQ3l1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=qpp7Q6Yk; arc=none smtp.client-ip=23.83.222.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="qpp7Q6Yk"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D3FA6641C32;
	Thu, 03 Sep 2026 01:16:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.96.14.225])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 71279640ABE;
	Thu, 03 Sep 2026 01:16:40 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Whimsical-Broad: 61675689169ed73f_1788398200688_2889051032
X-MC-Loop-Signature: 1788398200687:4181958208
X-MC-Ingress-Time: 1788398200687
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.14.225 (trex/8.0.2);
	Thu, 03 Sep 2026 01:16:40 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4hb1s35Qnfz2h;
	Wed,  2 Sep 2026 18:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788398200;
	bh=cOBjALLauKPcEMGzt7Wlxo+1oAT6j3oO8c1tAyjUNk8=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
	b=qpp7Q6YkcEdeSslovPGZ1KBdErvBGvPSfWjANKJ9yUpwNyh6tBsM/o1VLEtbH66su
	 8fLDc90x0CpZWbR2fHCxEHdBlGcDmx1KcCwiJlBu91WXz/u5chuvv4rPl3aNwCTC7s
	 3l8tUlTDQvVlMqGGN3p4uBBnQ9yPtvqkN7vuGBCGpPLuhGJawV7+wwIX2coP2ROVYW
	 zcMZsn07XOxeeTUejrulsDhmsfwXKC8RKm0A3Cs9Tk9BuJjE1NmCfsFLrx1cBCn7tw
	 yjdtljzkHOamhFImewFyetSncvWFG2EVzhUCHpHQJYwuA0knEbg+KLlfSdCkmPlKfh
	 JjgqAFQZCWmqg==
Date: Wed, 2 Sep 2026 18:16:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Li Ming <ming.li@zohomail.com>
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org,
	dave.jiang@intel.com
Subject: Re: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable
Message-ID: <20260903011636.zflv2y7tmdfc6f3h@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-3-dave@stgolabs.net>
 <a417b52b-41a7-4f90-9231-6abf82ee22a6@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a417b52b-41a7-4f90-9231-6abf82ee22a6@zohomail.com>
User-Agent: NeoMutt/20220429

On Wed, 05 Aug 2026, Li Ming wrote:

>On 7/28/2026 10:41 PM, Davidlohr Bueso wrote:
>> +/* Enable or dealloc BI-ID changes in the given level of the topology. =
*/
>> +static int __cxl_bi_ctrl_dport(struct cxl_dport *dport, bool enable)
>> +{
>> +	struct pci_dev *pdev =3D to_pci_dev(dport->dport_dev);
>> +	void __iomem *bi =3D dport->regs.bi_decoder;
>> +	struct cxl_port *port =3D dport->port;
>> +	u32 ctrl, value;
>> +	int rc;
>> +
>> +	guard(mutex)(&port->bi_lock);
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	ctrl =3D readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +	switch (pci_pcie_type(pdev)) {
>> +	case PCI_EXP_TYPE_ROOT_PORT:
>> +		if (enable) {
>> +			/*
>> +			 * There is no point of failure from here on,
>> +			 * BI will be enabled on the endpoint device.
>> +			 */
>> +			dport->nr_bi++;
>> +
>> +			if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_FW, ctrl) &&
>> +			    !FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
>> +				return 0;
>> +
>> +			value =3D ctrl | CXL_BI_DECODER_CTRL_BI_FW;
>> +			value &=3D ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		} else {
>> +			if (WARN_ON_ONCE(dport->nr_bi =3D=3D 0))
>> +				return -EINVAL;
>> +			if (--dport->nr_bi > 0)
>> +				return 0;
>> +
>> +			value =3D ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
>> +		}
>> +
>> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +		return 0;
>> +	case PCI_EXP_TYPE_DOWNSTREAM:
>> +		if (enable) {
>> +			value =3D ctrl & ~CXL_BI_DECODER_CTRL_BI_FW;
>> +			value |=3D CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +		} else {
>> +			if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl))
>> +				return 0;
>> +			value =3D ctrl & ~(CXL_BI_DECODER_CTRL_BI_FW |
>> +					 CXL_BI_DECODER_CTRL_BI_ENABLE);
>> +		}
>> +
>> +		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +		rc =3D __cxl_bi_commit_decoder(dport->dport_dev, bi);
>> +		if (rc)
>> +			return rc;
>> +
>> +		if (port->regs.bi_rt)
>> +			return __cxl_bi_commit_rt(&port->dev, port->regs.bi_rt);
>> +		return 0;
>
>I think another issue here is:
>
>Per CXL r4.0 8.2.4.27.2 Table 8-157. the description of BI=A0 Enable and B=
I Forward fields.
>
>My understanding is that if a DSP or RP connects to a BI-Capable device di=
rectly, the BI Enable field should be set.
>
>Which means if a BI-Capable device is connected to a root port directly, t=
he BI Enable filed of the root port should be set.
>
>In multiple switch levels case, only the last level DSP should set BI Enab=
le filed, other DSPs and root port should set BI Forward.
>
>But current implementation will set BI Enable on all DSPs, and set BI Forw=
ard on root port whatever the root port connects to BI-Capable device direc=
tly.
>
>If my understanding is incorrect, please let me know. thanks

Thanks for reviewing, I am just now circling back to this.

Yes, I think you are right. For v8 I have consolidated this for root ports =
and dsp,
the component directly attached to the device now always gets the Enable, t=
he rest get FW.

Thanks,
Davidlohr
