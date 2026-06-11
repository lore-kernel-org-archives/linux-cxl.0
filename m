Received: from siberian.tulip.relay.mailchannels.net (siberian.tulip.relay.mailchannels.net [23.83.218.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C8331237
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196695; cv=none; b=uyKG8o8uO1t8QUUS8h9xhtvJIRA/C+j8jUicwyHjvmYGs77B1YzQebyiXrg8ch2mxpf+6gcs3NRAqWD63nuV/NEuCyThe5nbVWSDBGB5jOGckWpxRl+HafgKTrgL8z5647aTXNqV1M0UGaX2FpkuMeCvnw6azJ1GxG76YWSqkeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196695; c=relaxed/simple;
	bh=IVlhiU9gY9tu2d21lItg363B0MuZkAKsLZy5JcZVXTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6dUPhoroLqb3TMT2ObMWcNicWcgo4tO4l8u3Q2+UAET4pBuM52Le6fjh/S4Cg4v+Tfk8XoDpYx/mApn60ZTIao96ERmJmCmCZhd7olIzh1UGY+QzWgLHHbVWLiuoVYMVQPnzWWz1ZQA2IL5DXeIA1G/W8xXdZYsyry2uDTf85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=lWGgdLdt; arc=none smtp.client-ip=23.83.218.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="lWGgdLdt"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 26DAA940F02;
	Thu, 11 Jun 2026 16:51:27 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (100-116-148-85.trex-nlb.outbound.svc.cluster.local [100.116.148.85])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 2EAAF940BAF;
	Thu, 11 Jun 2026 16:51:26 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Slimy-Glossy: 49b6795b2cf21101_1781196686904_1565285934
X-MC-Loop-Signature: 1781196686904:2414726003
X-MC-Ingress-Time: 1781196686904
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.116.148.85 (trex/7.1.5);
	Thu, 11 Jun 2026 16:51:26 +0000
Received: from offworld (186-79-212-212.fo.baf.movistar.cl [186.79.212.212])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4gbpZL5VL8z1040;
	Thu, 11 Jun 2026 09:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1781196686;
	bh=SD6v773xzpha1xs+CaCRP2qeeSyWjmTHj1bmr9Uytn8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=lWGgdLdtTrSgqcoDzGjtlA/JvSf/eW7FvV+3AEj5j2UENZP9BQNBECSlgTWmEbMXg
	 fxrsj4E8GfSmoesYmmichVN+Gxr4eNydudCOc9rrrxLJwXbZbR6hzEfLFf1MkvYPCo
	 LKoXqnAPYcI1CmIQtrD0XcV1LZnbX2/ZLUvwS9efOqm2Br4J5ey4QYF2OepxUKl2xb
	 lpw1DK3U4m3SjaBRyF9yWLUJYnyMqoBWCXW+wLCPWPxArahjTaEIS91I1Pb8p2FVwi
	 a7agLjlu9UyFSPa2kdNobFWIPW+hDnpW7pMeX1VtnnyYRY9KVjuDtDr21DonD43jfj
	 LoBWaP7ikaefQ==
Date: Thu, 11 Jun 2026 09:51:16 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: dave.jiang@intel.com, djbw@kernel.org, jic23@kernel.org,
	alucerop@amd.com, alison.schofield@intel.com, gourry@gourry.net,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/5] cxl: Add HDM-DB region creation
Message-ID: <20260611165116.uvitch6vf3o53m72@offworld>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-5-dave@stgolabs.net>
 <d5b9470c-cdf3-4bcd-853d-f5e6c1ee174e@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d5b9470c-cdf3-4bcd-853d-f5e6c1ee174e@amd.com>
User-Agent: NeoMutt/20220429

On Mon, 08 Jun 2026, Cheatham, Benjamin wrote:

>On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
>>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>>  {
>> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM;
>> +
>> +	if (is_endpoint_decoder(&cxld->dev)) {
>> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
>> +		struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
>> +
>> +		bi = bi && cxlds->bi;
>> +	} else if (cxld->region) {
>> +		struct cxl_root_decoder *cxlrd = cxld->region->cxlrd;
>> +
>> +		bi = bi && (cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI);
>> +	}
>> +
>
>Minor optimization, but you could wrap do the following instead of the above:

Sure.

>
>if (bi) {
>	if (is_endpoint_decoder(&cxld->dev)) {
>		...
>
>		bi = cxlds->bi;
>	} else if (cxld->region) {
>		...
>
>		bi = cxlrd->cxlsd.cxld.flags & CXL_DECODER_F_BI;
>	}
>}
>>	u32p_replace_bits(ctrl,
>>			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>>			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>> +	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
>>  }
>>
>>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index c5aacd7054f1..2b463a8b06a7 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -131,6 +131,7 @@ CXL_DECODER_FLAG_ATTR(cap_ram, CXL_DECODER_F_RAM);
>>  CXL_DECODER_FLAG_ATTR(cap_type2, CXL_DECODER_F_TYPE2);
>>  CXL_DECODER_FLAG_ATTR(cap_type3, CXL_DECODER_F_TYPE3);
>>  CXL_DECODER_FLAG_ATTR(locked, CXL_DECODER_F_LOCK);
>> +CXL_DECODER_FLAG_ATTR(cap_bi, CXL_DECODER_F_BI);
>>
>>  static ssize_t target_type_show(struct device *dev,
>>				struct device_attribute *attr, char *buf)
>> @@ -233,6 +234,18 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>>  }
>>  static DEVICE_ATTR_RW(mode);
>>
>> +static ssize_t bi_show(struct device *dev, struct device_attribute *attr,
>> +		       char *buf)
>> +{
>> +	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +
>> +	return sysfs_emit(buf, "%d\n", cxlds->bi && cxled->cxld.region &&
>> +			  cxled->cxld.target_type == CXL_DECODER_DEVMEM);
>> +}
>> +static DEVICE_ATTR_RO(bi);
>
>Is there not a register bit that enables BI in the decoder? I think it would be
>better to present the hardware value here.

Reading the hw bit moves the semantics in a way I don't think we want. The bit
is only written by cxld_set_type() at commit time, so an attached, but not yet
committed, HDM-DB decoder would read 0 from hw, but the user should already
know this is BI.

>
>Is it possible to have the decoder be configured for BI if there's no region? If so,
>I'd remove the region check here.

We need the region check because that confirms the root decoder is BI as well.

>> +
>>  static ssize_t dpa_resource_show(struct device *dev, struct device_attribute *attr,
>>			    char *buf)
>>  {
>> @@ -329,6 +342,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>>	&dev_attr_cap_ram.attr,
>>	&dev_attr_cap_type2.attr,
>>	&dev_attr_cap_type3.attr,
>> +	&dev_attr_cap_bi.attr,
>>	&dev_attr_target_list.attr,
>>	&dev_attr_qos_class.attr,
>>	SET_CXL_REGION_ATTR(create_pmem_region)
>> @@ -339,16 +353,22 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>>
>>  static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
>>  {
>> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
>> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
>> +	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
>> +	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
>> +			       CXL_DECODER_F_PMEM;
>>
>> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>>  }
>>
>>  static bool can_create_ram(struct cxl_root_decoder *cxlrd)
>>  {
>> -	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
>> +	unsigned long flags = cxlrd->cxlsd.cxld.flags;
>> +	unsigned long hdm_h = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
>> +	unsigned long hdm_db = CXL_DECODER_F_TYPE2 | CXL_DECODER_F_BI |
>> +			       CXL_DECODER_F_RAM;
>>
>> -	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
>> +	return (flags & hdm_h) == hdm_h || (flags & hdm_db) == hdm_db;
>>  }
>>
>>  static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
>> @@ -402,6 +422,7 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
>>  static struct attribute *cxl_decoder_endpoint_attrs[] = {
>>	&dev_attr_target_type.attr,
>>	&dev_attr_mode.attr,
>> +	&dev_attr_bi.attr,
>>	&dev_attr_dpa_size.attr,
>>	&dev_attr_dpa_resource.attr,
>>	SET_CXL_REGION_ATTR(region)
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e50dc716d4e8..3f9ddacfae4e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1129,17 +1129,6 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>		return -EBUSY;
>>	}
>>
>> -	/*
>> -	 * Endpoints should already match the region type, but backstop that
>> -	 * assumption with an assertion. Switch-decoders change mapping-type
>> -	 * based on what is mapped when they are assigned to a region.
>> -	 */
>> -	dev_WARN_ONCE(&cxlr->dev,
>> -		      port == cxled_to_port(cxled) &&
>> -			      cxld->target_type != cxlr->type,
>> -		      "%s:%s mismatch decoder type %d -> %d\n",
>> -		      dev_name(&cxled_to_memdev(cxled)->dev),
>> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>
>I'm not sure it's possible, but it would be good to leave this in and just
>skip it if the decoder is configured for BI so that we don't silently allow
>broken configurations.

That's fair, I wasn't crazy about removing this either, we can just check
the cfmw root decoder:

	dev_WARN_ONCE(&cxlr->dev,
		      port == cxled_to_port(cxled) &&
			      cxld->target_type != cxlr->type &&
			       !cxl_root_decoder_is_bi(cxlr->cxlrd),
		      "%s:%s mismatch decoder type %d -> %d\n",
		      dev_name(&cxled_to_memdev(cxled)->dev),
		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);

>
>>	cxld->target_type = cxlr->type;
>>	cxl_rr->decoder = cxld;
>>	return 0;
>> @@ -2034,6 +2023,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>	struct cxl_region_params *p = &cxlr->params;
>>	struct cxl_port *ep_port, *root_port;
>>	struct cxl_dport *dport;
>> +	struct cxl_hdm *cxlhdm;
>>	int rc = -ENXIO;
>>
>>	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
>> @@ -2083,10 +2073,31 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>		return -ENXIO;
>>	}
>>
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
>> +
>> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
>> +	if (!cxlhdm)
>> +		return -ENXIO;
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
>> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
>> +		dev_dbg(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
>> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
>> +		dev_dbg(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>
>I'd upgrade to a dev_warn() for both of these prints. A broken configuration
>should be a warning IMO.

Sure.

Thanks,
Davidlohr
