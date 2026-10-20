Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507164;
	b=WIMTuKNl10VX+JQ6MDnlop6abfk/e1frLWQfdH2RyFOqYkGK47dxs2+UK5VMB59HNmZ4
	 WAZoaVjunRVG3SstqKJlH4nr6U5SYU/sXiKZx1ZL09Dr/Vxj5UTPG8M7u6+wiEeJdcaKO
	 32J96KfIe+5fdNJ0+Rfp4VyFwSd+NzLU5I0scwhDpk6eULrH4ZJBxL4GnSfH9o55oW+Im
	 7tRxiH7SbZ6VvBwqAoZ2HDuKBCyNeOjAZXFtoE8SQ6GYalf41lgD50rON5ogSYp/5/1dA
	 oQp5WikZoetJpfUrdNISjTL5/GzsKXsHmsw80GIrWG2Pj34+AkRqqqd9Og6sLngnDNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507164;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Irritate-Print:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=F0iQ13EGLTQI5kyo2tmyN9DpTgiYHlNMjaPo9MBxLzA=;
	b=Pdkaky7s3kBCJjV+rfGi8MIyJah2T/r3FOWU70qYUY2PW9wpOiLvq4abS95zhPb0OUeE
	 Dpbe1zLXo9B72r6UWJV2sIgqUuCtFdYPcDXBTyPy6FtDZlJtGGFO4ri6XiDMsmrUofXwb
	 MAIPkzvaM9qyURc6tCjhJTN29hUEYvec0eoW+X9W+RC7IjR5vCZHnaWEanaa54MV0ihso
	 fcwF1FwZhtE7isbwE0fukdndlcXPCs/eO+7Oy99zA9aPwlchBExODHQtfQtJ0MVZ/zRvz
	 CPZ184CMVZXCKXJPRPal1ZFCUweDFpM15gEUDVQq97Q42wqJuS2l4lRL3MmKICH2tgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Av325PyH;
	arc=none smtp.remote-ip=23.83.222.36
Received: from cichlid.ash.relay.mailchannels.net (cichlid.ash.relay.mailchannels.net [23.83.222.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DD606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 14:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A3DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=Av325PyH
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 18E184C2801;
	Tue, 20 Oct 2026 14:39:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a246.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.96.2.151])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9A9F04C2469;
	Tue, 20 Oct 2026 14:39:15 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Irritate-Print: 6513ff5f174ab094_1792507156005_2331947423
X-MC-Loop-Signature: 1792507156005:1314674617
X-MC-Ingress-Time: 1792507156005
Received: from pdx1-sub0-mail-a246.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.2.151 (trex/8.0.2);
	Tue, 20 Oct 2026 14:39:16 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a246.dreamhost.com (Postfix) with ESMTPSA id 4j8FRQ6zDXz105h;
	Tue, 20 Oct 2026 07:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1792507155;
	bh=F0iQ13EGLTQI5kyo2tmyN9DpTgiYHlNMjaPo9MBxLzA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Av325PyH4kSAYLM7gp85dn/xtBETjppl135CERXOLDyxUm0PIdNS7PVjtdoONZXHe
	 ys2OFuzmeRRV72Fca7wtJDsDIm//RbEOvHDZR36GGG08uGwcseM0MVIzk5q0bpSYH2
	 smNmh0WXMBBP36AsMUbJZF91pRDzL7zeIGu2L9/Y+0YsoVeJiypiD1bFvmTlpRP5Wq
	 nyr4VtHI+tsqNn55LBNvTPnOO2EKFt7rAabSNFYgM9vcp4sobXmvIO2iEjeLZ0aW8l
	 dtC44EtQ5IkYpKHDAvdGcS0eSHAl7CwNwYSJEVy+gb1k1HOhtBXK6jlDHQf9SB/B77
	 tD/rEiEExtRYQ==
Date: Tue, 20 Oct 2026 07:39:11 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 08/10] cxl: Allow auto-committed BI hdm decoders
Message-ID: <20261020143911.arsz5nojzeepndla@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <60fe8a8a0f66a9535905092e1dee604c1f7ae48c.1790103847.git.dave@stgolabs.net>
 <ar3YZtnQbE-n13qz@aschofie-mobl2.lan>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ar3YZtnQbE-n13qz@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Wed, 30 Sep 2026, Alison Schofield wrote:

>On Tue, Sep 22, 2026 at 04:38:45PM -0700, Davidlohr Bueso wrote:
>
>
>The cover letter says the series could be picked up with or without this
>patch. I'm guessing that is a stale statement. Today a committed BI decoder
>is enumerated like any other. After patch 3 it fails port enumeration,
>and this patch is what fixes that.  So not really optional?

You are correct about the fully auto committed BI topology case,
the problem today is that bogus topologies can still be onlined.

I will rephrase the cover letter for patch 8, drop the refusal in
patch 3, and have patch 2 adopt a device firmware already enabled, so
that through patch 7 the auto-committed semantics are identical to
upstream and patch 8 refuses only what cannot route BISnp.

>
>> An HDM decoder that firmware committed with the BI bit set was
>> refused outright. Accept it, and refuse only what is broken - BI
>> paired with a host-only target range type, or for an endpoint
>> decoder BI on a path that cannot route BISnp.
>>
>> Taking over such a path must not re-program what firmware already
>> did, and a dport's committed state does not say which device it was
>> committed for, only that firmware committed for something below it.
>> Two endpoints sharing a level show why that is not enough to go on.
>>
>>                         RP      Forward set, but for mem0
>>                         |
>>                        USP
>>                        /  \
>>                    DSP0    DSP1
>>                      |       |
>>                   mem0      mem1
>>                BI Enable   BI Enable
>>                   set       clear
>>
>> Adoption is therefore seeded from the endpoint's own BI Enable, since
>> only a device firmware itself enabled can have had its BI-ID
>> accounted for above, and carried up the walk. A level is taken as
>> found, with no register write and no commit, when nothing this driver
>> routed sits below it, the value this driver would write is already
>> there, and both the decoder and the switch's route table are
>> committed - the table carries a commit of its own that firmware may
>> not have performed. The first level to fall short ends adoption, and
>> from it up the driver programs and commits as for any other device.
>>
>>                     RP    Forward, written but never committed
>>                     |
>>                   USP0    route table committed by the driver
>>                     |
>>                   DSP0    Forward, written and committed
>>                     |     ..... adoption ended here .....
>>                   USP1    route table already committed
>>                     |
>>                   DSP1    Enable, taken as found
>>                     |
>>                   mem0    BI Enable already set by firmware
>>
>> An adopted level owes no commit either way. Table 8-152 and Table
>> 8-156 owe one per new BI device enabled below the port, and an
>> adopted level is not seeing one.
>>
>> The endpoint is adopted the same way. BI Enable already set was an
>> error before, since only this driver set it; it is now kept and
>> cxlds->bi taken up without a write.
>>
>> On failure the walk unwinds only the levels it did not adopt. Since
>> adoption is a prefix, the unwind drops the refcount below the first
>> non-adopted level and leaves those registers alone. Teardown is
>> unchanged and still deallocates every level.
>>
>> A committed decoder is refused when its coherency model does not fit
>> where it lands. The window must permit it, and unlike a decoder this
>> driver programs it cannot inherit a region's model, so its committed
>> Target Range Type and BI bit must already match. Assembly never
>> validated these bits, so setting them wrongly costs a platform the
>> auto-assembly of the affected decoders.
>
>
>Assembly did validate Target Range Type until patch 4.
>cxl_region_attach() refused a decoder whose type differed from the
>region's. The window check this adds also refuses non-BI auto regions
>that assemble today.  More inline at construct_region()...
>
>
>
>snip
>
>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9bf05820c142..f83f5d1d8255 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1087,6 +1087,29 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>>  				    scale, base);
>>  }
>>
>> +/* Committed, or no explicit commit required */
>> +static bool cxl_bi_decoder_committed(void __iomem *bi)
>> +{
>> +	u32 caps = readl(bi + CXL_BI_DECODER_CAPS_OFFSET);
>> +	u32 sts = readl(bi + CXL_BI_DECODER_STATUS_OFFSET);
>> +
>> +	if (!FIELD_GET(CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ, caps))
>> +		return true;
>> +
>> +	return FIELD_GET(CXL_BI_DECODER_STATUS_BI_COMMITTED, sts);
>> +}
>> +
>> +static bool cxl_bi_rt_committed(void __iomem *bi)
>> +{
>> +	u32 caps = readl(bi + CXL_BI_RT_CAPS_OFFSET);
>> +	u32 sts = readl(bi + CXL_BI_RT_STATUS_OFFSET);
>> +
>> +	if (!FIELD_GET(CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ, caps))
>> +		return true;
>> +
>> +	return FIELD_GET(CXL_BI_RT_STATUS_BI_COMMITTED, sts);
>> +}
>> +
>
>
>Above 2 helpers differ only in register offsets and masks, and repeat
>the EXPLICIT_COMMIT_REQ caps test already in __cxl_bi_commit_rt() and
>__cxl_bi_commit_decoder().
>
>Could they be one helper taking offsets and masks, like __cxl_bi_wait_commit()
>does?

I went ahead with the following, which I'm not sure is particularly better,
but at least abstracts the core logic:

/* Committed, or no explicit commit required */
static bool __cxl_bi_committed(void __iomem *caps_reg, void __iomem *status_reg,
                                u32 req_bit, u32 committed_bit)
{
       if (!(readl(caps_reg) & req_bit))
               return true;   
   
       return readl(status_reg) & committed_bit;
}             
         
static bool cxl_bi_rt_committed(void __iomem *bi)
{             
       return __cxl_bi_committed(bi + CXL_BI_RT_CAPS_OFFSET,
                                 bi + CXL_BI_RT_STATUS_OFFSET,
                                 CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
                                 CXL_BI_RT_STATUS_BI_COMMITTED);
}                               
                                  
static bool cxl_bi_decoder_committed(void __iomem *bi)
{                               
       return __cxl_bi_committed(bi + CXL_BI_DECODER_CAPS_OFFSET,
                                 bi + CXL_BI_DECODER_STATUS_OFFSET,
                                 CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
                                 CXL_BI_DECODER_STATUS_BI_COMMITTED);
}                               

>
>
>snip
>
>>  static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
>>  			      struct cxl_port *port, struct cxl_dport *dport)
>>  {
>> -	struct cxl_dport *dport_iter, *failed;
>> +	struct cxl_dport *dport_iter, *failed, *programmed = NULL;
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>>  	struct cxl_port *port_iter;
>> +	bool adopt, clear;
>>  	int rc;
>>
>> +	/*
>> +	 * Adoption is a path property, not a per-dport one: only when
>> +	 * firmware enabled the device itself does a dport's committed
>> +	 * state cover this device's BI-ID.
>> +	 */
>> +	adopt = FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
>> +			  readl(endpoint->regs.bi_decoder +
>> +				CXL_BI_DECODER_CTRL_OFFSET));
>> +
>
>
>Is this cxl_bi_decoder_enabled(endpoint) from core.h?

It is, will update.

>
>
>
>>  	port_iter = port;
>>  	dport_iter = dport;
>>  	while (!is_cxl_root(port_iter)) {
>> -		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
>> +		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport,
>> +					      &adopt);
>>  		if (rc)
>>  			goto err_rollback;
>>
>> +		/* adoption is a prefix: this is the first level not adopted */
>> +		if (!adopt && !programmed)
>> +			programmed = dport_iter;
>> +
>>  		dport_iter = port_iter->parent_dport;
>>  		port_iter = dport_iter->port;
>>  	}
>> @@ -1301,8 +1360,11 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
>>  	failed = dport_iter;
>>  	dport_iter = dport;
>>  	port_iter = port;
>> +	clear = false;
>>  	while (!is_cxl_root(port_iter) && dport_iter != failed) {
>> -		cxl_bi_ctrl_dport_disable(dport_iter);
>> +		if (dport_iter == programmed)
>> +			clear = true;
>> +		cxl_bi_ctrl_dport_disable(dport_iter, clear);
>>  		dport_iter = port_iter->parent_dport;
>>  		port_iter = dport_iter->port;
>>  	}
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index f322a8a4a66d..0e3ba7c79a75 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1861,6 +1861,20 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>>  	return rc;
>>  }
>>
>> +static bool cxled_committed_bi(struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port = cxled_to_port(cxled);
>> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>> +	u32 ctrl;
>> +
>> +	if (!cxlhdm || !cxlhdm->regs.hdm_decoder)
>> +		return false;
>> +
>> +	ctrl = readl(cxlhdm->regs.hdm_decoder +
>> +		     CXL_HDM_DECODER0_CTRL_OFFSET(cxled->cxld.id));
>
>
>I'm having some deja vu here. I may have asked and you answered this on
>an earlier version, but now that I see Patch 9 it makes me ask again.
>Patch 9 wouldn't need to mock this if we stored it as committed BI
>state instead. Maybe in cxld->flags using CXL_DECODE_F_BI.
>

Ok.

>
>
>> +	return FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl);
>> +}
>> +
>>  static const char *cxl_coherency_name(enum cxl_decoder_type type, bool bi)
>>  {
>>  	if (type == CXL_DECODER_HOSTONLYMEM)
>> @@ -2179,6 +2193,24 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>  		return -ENXIO;
>>  	}
>>
>> +	/* a committed decoder cannot inherit the region's flavor */
>> +	if (cxled->state == CXL_DECODER_STATE_AUTO) {
>> +		bool bi = cxled_committed_bi(cxled);
>> +		const char *have, *want;
>> +
>> +		have = cxl_coherency_name(cxled->cxld.target_type, bi);
>> +		want = cxl_coherency_name(cxlr->type,
>> +					  cxl_root_decoder_is_bi(cxlrd));
>> +		if (cxled->cxld.target_type != cxlr->type ||
>> +		    bi != cxl_root_decoder_is_bi(cxlrd)) {
>
>
>Looks like only need have and want computed when mismatch is detected.
>cxl_root_decoder_is_bi could also be cached once.

Yep, I've cleaned these up as such:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3b42ecd4c34f..8edbfecb3950 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2133,6 +2133,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
         struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
         struct cxl_dev_state *cxlds = cxlmd->cxlds;
         struct cxl_region_params *p = &cxlr->params;
+       bool root_bi = cxl_root_decoder_is_bi(cxlrd);
         struct cxl_port *ep_port, *root_port;
         struct cxl_dport *dport;
         struct cxl_hdm *cxlhdm;
@@ -2190,8 +2191,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
          * proceeding. The endpoint decoder's target_type is then inherited
          * from cxlr->type later in cxl_rr_assign_decoder().
          */
-       if (cxlr->type == CXL_DECODER_DEVMEM &&
-           cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
+       if (cxlr->type == CXL_DECODER_DEVMEM && root_bi && !cxlds->bi) {
                 dev_dbg(&cxlr->dev, "%s:%s BI not enabled on device\n",
                         dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
                 return -ENXIO;
@@ -2224,17 +2224,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
         /* a committed decoder cannot inherit the region's flavor */
         if (cxled->state == CXL_DECODER_STATE_AUTO) {
                 bool bi = cxled_committed_bi(cxled);
-               const char *have, *want;
  
-               have = cxl_coherency_name(cxled->cxld.target_type, bi);
-               want = cxl_coherency_name(cxlr->type,
-                                         cxl_root_decoder_is_bi(cxlrd));
-               if (cxled->cxld.target_type != cxlr->type ||
-                   bi != cxl_root_decoder_is_bi(cxlrd)) {
+               if (cxled->cxld.target_type != cxlr->type || bi != root_bi) {
                         dev_err(&cxlr->dev,
                                 "%s:%s coherency model mismatch: %s vs %s\n",
                                 dev_name(&cxlmd->dev),
-                               dev_name(&cxled->cxld.dev), have, want);
+                               dev_name(&cxled->cxld.dev),
+                               cxl_coherency_name(cxled->cxld.target_type, bi),
+                               cxl_coherency_name(cxlr->type, root_bi));
                         return -ENXIO;
                 }
         }

>
>
>> +			dev_err(&cxlr->dev,
>> +				"%s:%s coherency model mismatch: %s vs %s\n",
>> +				dev_name(&cxlmd->dev),
>> +				dev_name(&cxled->cxld.dev), have, want);
>> +			return -ENXIO;
>> +		}
>> +	}
>> +
>>  	if (!cxled->dpa_res) {
>>  		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
>>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> @@ -3838,10 +3870,26 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	int rc, part = READ_ONCE(cxled->part);
>>  	struct cxl_region *cxlr;
>> +	unsigned long need;
>>
>>  	if (part < 0)
>>  		return ERR_PTR(-EBUSY);
>>
>> +	/*
>> +	 * A committed decoder defines the region built from it, so no
>> +	 * attach check can find its coherency model wrong. Only the
>> +	 * window's restrictions can, on the BI and range type axes.
>> +	 */
>> +	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
>> +	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
>> +	if (cxled_committed_bi(cxled) != cxl_root_decoder_is_bi(cxlrd) ||
>> +	    !(cxlrd->cxlsd.cxld.flags & need)) {
>
>
>This refuses non BI auto regions that assemble before this patch.
>Why is this in a patch called 'Allow auto-committed BI hdm decoders'.

The range type half belongs in patch 4 with the other coherency checks,
and I will move it there. The BI half is this patch's.

Thanks,
Davidlohr

>
>
>
>> +		dev_err(&cxlrd->cxlsd.cxld.dev,
>> +			"%s:%s coherency model not permitted by the window\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>>  	do {
>>  		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>>  				       atomic_read(&cxlrd->region_id),
>> --
>> 2.39.5
>>
