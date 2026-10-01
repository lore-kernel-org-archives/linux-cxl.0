Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8282D404BD4
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.214.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845060; cv=none; b=kKB11FMV7LcZf+UFzbzUNgvVFTz5IElcikiyBnOCqah7gTADk+WOcE2uEizfQyGOmhi/p/IulXDabJVD6fOg9aZFozJTl72X8oA+pY2hvLHKYAbKs8WsQqytLxaPJGGsmBa+VSLLQAEtI5UmAndZDygGJirEzKt1GkLPxiXY6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845060; c=relaxed/simple;
	bh=4gly3qDSHXKijomajJ1nj+uhdTPZJKE02oeAQ9XUY/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpnMkzumFuD6eAX17Tr8VK5s2x72S4vCnjouR63egnI6IAF/UhPyH7z0Y3BklxdmXMmS/0vMrCkOqIxzyDI59eB4uuMzsEi9qfPPu8SjYTxCVKx2TFcVwGop/onHNSqCc5pA3nkppR2R/d1FTjcetB+I46WFVq9D66GGBYyXS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=kuCG/yOc; arc=none smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="kuCG/yOc"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 33FF04C2311;
	Thu, 01 Oct 2026 08:57:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a257.dreamhost.com (100-96-12-121.trex-nlb.outbound.svc.cluster.local [100.96.12.121])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id BC67C4C26F1;
	Thu, 01 Oct 2026 08:57:31 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Rock: 2d46cdda4be19f6c_1790845052042_751404184
X-MC-Loop-Signature: 1790845052042:388221587
X-MC-Ingress-Time: 1790845052042
Received: from pdx1-sub0-mail-a257.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.12.121 (trex/8.0.2);
	Thu, 01 Oct 2026 08:57:32 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a257.dreamhost.com (Postfix) with ESMTPSA id 4hwQlv0ZK8z103j;
	Thu,  1 Oct 2026 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1790845051;
	bh=Z73CgnpXVkAY5QDmnetujHPdE+OBp/aMEGBEKSpRDKU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=kuCG/yOcZtTuCwGnarjEHrdY05++EB1HdSr3MT+JEvSbFLTrtTb9JhY2fftqbIFlG
	 lMupDibCTFuDBiF7FYNGh0g7Y6kMHATbeIdjZOvLAh6SheKQW/Mrbc7vR9InCWChYw
	 /TpoHXjE9RbVNEgiWJXR7NjizOS3WfTfSLvePC/GyyJtk8Zsdv/6MZAYEwFC/Ejqse
	 OTwdZ38UybP+155Go6HT6iFsk4Zi7wFz/VPpUDVRBHZUK8YNIMIMG7jTmp2s0+1NxS
	 UoG1rKuVd/D5qz/0r79jWqSVmSVlt7loLCD3FLtbL/p6r3pNRk2mU5ZFI9Beg3VFhD
	 qj0+tnkW+UMSQ==
Date: Thu, 1 Oct 2026 01:57:28 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, icheng@nvidia.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 04/10] cxl: Add HDM-DB region creation
Message-ID: <20261001085728.ko2pi62yweg3klnf@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <4a85b58e026256ea66b2d5f71c73cc6e03620330.1790103847.git.dave@stgolabs.net>
 <ar3TU4IM_TtcGgwl@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ar3TU4IM_TtcGgwl@aschofie-mobl2.lan>
User-Agent: NeoMutt/20220429

On Wed, 30 Sep 2026, Alison Schofield wrote:

>On Tue, Sep 22, 2026 at 04:38:41PM -0700, Davidlohr Bueso wrote:
>> A region inherits its coherency from the chosen root decoder - HDM-DB
>> if the root has CXL_DECODER_F_BI, otherwise HDM-H.
>
>Above holds for regions created from sysfs. An auto region takes its type
>from the first committed endpoint decoder in construct_region(), without
>looking at the root decoder. A committed host-only decoder in a BI window
>becomes an HDM-H region under a BI root, and an HDM-D region is neither
>HDM-DB nor HDM-H. Can this say which regions it applies to?

Right, that only describes regions created through sysfs. An
auto-assembled region still takes its type from the committed decoder
it is built from, so under a BI root a committed host-only decoder
gives an HDM-H region and an HDM-D region is neither, as you say.
Nothing here consults the Window for a committed decoder; that
starts with patch 8, which also removes the refusal of committed BI
decoders at enumeration, so auto HDM-DB regions do not exist before
it.

I'll scope the sentence to sysfs regions.

>
>>
>> cxl_acpi_cfmws_verify() rejects a Window that declares no coherency
>> model at all (neither Device Coherent nor Host-only Coherent), one that
>> sets BI together with Host-only Coherent, which the CFMWS definition
>> calls undefined behavior, and one that sets BI without Device Coherent,
>> since HDM-DB is defined only as bit[0] and bit[5] together. A BI Window
>> therefore always exposes device-coherent memory and nothing else.
>
>These rejections drop windows that are accepted and usable today.  See
>the cxl_acpi_cfmws_verify() comment inline below.
>
>> The root decoder's target_type follows the Window as well -
>> device-coherent when only Device Coherent is set, host-only otherwise.
>
>I'll comment inline on this one too, acpi.c hunk below. I think this
>describes dead code and opportunity for cleanup.
>
>>
>> Introduce the following read-only sysfs ABI.
>>
>>   - decoderX.Y/cap_back_invalidate (root) reports the CFMWS BI
>>     restriction.
>>   - decoderX.Y/back_invalidate (endpoint) reads '1' when configured
>>     for HDM-DB.
>>
>> cxl_region_attach() rejects endpoints whose device or HDM cannot
>> serve the region's type; target_type is inherited from cxlr->type
>> in cxl_rr_assign_decoder(), restored to the endpoint default on
>> detach, and to whatever it was on a failed attach - a refusal may
>> come before any inheritance, for a decoder another region owns or
>> one firmware committed, and must not relabel it.
>
>A decoder firmware committed is still relabelled when its attach succeeds,
>since the type mismatch check is gone. More inline at
>cxl_region_attach()
>
>snip
>> +
>> +
>> +What:		/sys/bus/cxl/devices/decoderX.Y/back_invalidate
>> +Date:		September, 2026
>> +KernelVersion:	v7.4
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Shows '1' if this endpoint decoder is currently configured
>> +		for HDM-DB (device-managed coherency with back-invalidate).
>> +		The HDM-DB state is inherited from the region the decoder is
>> +		attached to, which is in turn set from the chosen root
>> +		decoder's CFMWS BI restriction (see cap_back_invalidate).
>> +
>>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
>>  Date:		May, 2022
>>  KernelVersion:	v6.0
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 3b818adbd38b..2e8e31544a5f 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -152,6 +152,8 @@ static unsigned long cfmws_to_decoder_flags(int restrictions)
>>  		flags |= CXL_DECODER_F_PMEM;
>>  	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_FIXED)
>>  		flags |= CXL_DECODER_F_LOCK;
>> +	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)
>> +		flags |= CXL_DECODER_F_BI;
>>
>>  	return flags;
>>  }
>> @@ -198,6 +200,24 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>>  		dev_dbg(dev, "CFMWS length %d greater than expected %d\n",
>>  			cfmws->header.length, expected_len);
>>
>> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM) &&
>> +	    (cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI)) {
>> +		dev_err(dev, "CFMWS cannot have both HDM-H and HDM-DB\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (!(cfmws->restrictions & (ACPI_CEDT_CFMWS_RESTRICT_DEVMEM |
>> +				     ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM))) {
>> +		dev_err(dev, "CFMWS has no coherency model\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_BI) &&
>> +	    !(cfmws->restrictions & ACPI_CEDT_CFMWS_RESTRICT_DEVMEM)) {
>> +		dev_err(dev, "CFMWS BI requires device-coherent\n");
>> +		return -EINVAL;
>> +	}
>> +
>
>
>Can these checks break windows that are accepted and usable today?  A
>rejected window gets no root decoder, and auto-assembly then fails with
>"no CXL window for range".
>
>A window that sets neither coherency bit is accepted today and can hold
>auto regions, since assembly never looks at the restriction flags.

I could remove the check for no ACPI_CEDT_CFMWS_RESTRICT_DEVMEM/HOSTONLYMEM,
but would rather break bogus firmware.

>
>A window that sets BI together with Host-only, or BI without Device Coherent,
>is accepted today as a non-BI window, because BI is ignored.
>Manual HDM-H region creation in it is lost as well.

We cannot accept UB scenarios, I think these should be rejected regardless.

>
>Even if no shipping firmware does this, is cxl_acpi_cfmws_verify() the right
>place for these checks? Til now it has only rejected windows that cannot be
>decoded (arithmetic, alignment, ways, length).  What a window may be used for
>is decided later, by cfmws_to_decoder_flags() and can_create_ram|pmem().
>Might it be enough to withhold CXL_DECODER_F_BI for an invalid combination,
>so that only HDM-DB is refused?

Yes, I think this is the right place for these checks, aligned with its
name cxl_acpi_cfmws_verify(). These are minimum sanity checks, just as you
point out with those that cannot be decoded.

I will leave these checks as is.

>
>
>>  	return 0;
>>  }
>>
>> @@ -437,7 +457,14 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>>
>>  	cxld = &cxlrd->cxlsd.cxld;
>>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>> +	/* host-only wins if firmware sets both coherency restrictions */
>>  	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>> +	if (cxld->flags & CXL_DECODER_F_TYPE2) {
>> +		if (cxld->flags & CXL_DECODER_F_TYPE3)
>> +			dev_dbg(dev, "CFMWS has both HDM-H and HDM-D\n");
>> +		else
>> +			cxld->target_type = CXL_DECODER_DEVMEM;
>> +	}
>
>
>Mentioned in commit msg, I think this is dead code needing cleanup.
>I don't see a consumer of a root decoder's target_type.
>
>Building window-derived logic and a dev_dbg() on top of it makes it
>look as if the root decoder's type matters when it doesn't.  Can this
>hunk be dropped?  Removing the old line can be a separate cleanup.

Agreed. I justified this because we already had the old line doing
the host-only assignment, but this can be removed.

>
>
>>  	cxld->hpa_range = (struct range) {
>>  		.start = cfmws->base_hpa,
>>  		.end = cfmws->base_hpa + cfmws->window_size - 1,
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 18200a8f3f72..44ff64b1a9df 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -705,9 +705,21 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>>
>>  static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>>  {
>> +	bool bi = cxld->target_type == CXL_DECODER_DEVMEM &&
>> +		  cxld->region && cxl_root_decoder_is_bi(cxld->region->cxlrd);
>> +
>>  	u32p_replace_bits(ctrl,
>>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
>> +	u32p_replace_bits(ctrl, bi, CXL_HDM_DECODER0_CTRL_BI);
>> +
>> +	if (bi && is_endpoint_decoder(&cxld->dev)) {
>> +		struct cxl_endpoint_decoder *cxled =
>> +			to_cxl_endpoint_decoder(&cxld->dev);
>> +
>> +		u32p_replace_bits(ctrl, cxled->pos,
>> +				  CXL_HDM_DECODER0_CTRL_ISP_MASK);
>> +	}
>
>
>The commit message does not mention ISP programming. Can it get a
>sentence with the spec reference for ISP being required when BI is set?

It's per Table 8-123, will add a comment.

>
>snip
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>
>snip
>
>> @@ -1131,16 +1163,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>>  	}
>>
>>  	/*
>> -	 * Endpoints should already match the region type, but backstop that
>> -	 * assumption with an assertion. Switch-decoders change mapping-type
>> -	 * based on what is mapped when they are assigned to a region.
>> +	 * Endpoint decoders inherit their type from cxlr->type; broken
>> +	 * pairings were already rejected by the coherency checks in
>> +	 * cxl_region_attach(). Switch-decoders change mapping-type based
>> +	 * on what is mapped when they are assigned to a region.
>>  	 */
>> -	dev_WARN_ONCE(&cxlr->dev,
>> -		      port == cxled_to_port(cxled) &&
>> -			      cxld->target_type != cxlr->type,
>> -		      "%s:%s mismatch decoder type %d -> %d\n",
>> -		      dev_name(&cxled_to_memdev(cxled)->dev),
>> -		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
>>  	cxld->target_type = cxlr->type;
>
>
>A Type 3 endpoint decoder in an HDM-DB region now reads "accelerator" from
>decoderX.Y/target_type, and the ndctl test on the branch linked in the cover
>letter checks for that. So I take it target_type is now being used to report
>the decoder's coherency model, device-coherent vs host-only, rather than the
>Type-2/Type-3 as documented by the existing ABI.

Type2 and Type3 are names from the old pre-BI CXL (and were later renamed by
the spec, per patch 5), but the intent behind was always about coherency type.

>
>Does this need sysfs ABI update?

I don't think so, the doc already mentions:

""
The 'target_type' attribute indicates the current setting which may
dynamically change based on what memory regions are activated in this
decode hierarchy.
""

>
>cxl list doesn't show target_type, but libcxl exports it through
>cxl_decoder_get_target_type().  If that is intentional, libcxl.txt will
>need the same semantic update with the ndctl patches.
>
>
>>  	cxl_rr->decoder = cxld;
>>  	return 0;
>> @@ -1803,6 +1830,7 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
>> +	enum cxl_decoder_type type = cxled->cxld.target_type;
>>  	struct cxl_decoder *cxld = &cxlsd->cxld;
>>  	int iw = cxld->interleave_ways;
>>  	struct cxl_port *iter;
>> @@ -1828,6 +1856,8 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>>  	for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
>>  	     iter = to_cxl_port(iter->dev.parent))
>>  		cxl_port_detach_region(iter, cxlr, cxled);
>> +	/* undo cxl_rr_assign_decoder() type inheritance */
>> +	cxled->cxld.target_type = type;
>>  	return rc;
>>  }
>>
>> @@ -2056,6 +2086,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>  	struct cxl_region_params *p = &cxlr->params;
>>  	struct cxl_port *ep_port, *root_port;
>>  	struct cxl_dport *dport;
>> +	struct cxl_hdm *cxlhdm;
>>  	int rc = -ENXIO;
>>
>>  	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
>> @@ -2105,10 +2136,39 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>  		return -ENXIO;
>>  	}
>>
>> -	if (cxled->cxld.target_type != cxlr->type) {
>> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
>> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>> -			cxled->cxld.target_type, cxlr->type);
>
>
>Should the type check stay for committed decoders?  With it gone, a
>second auto-assembled decoder whose committed Target Range Type differs
>from the region's is accepted, and cxl_rr_assign_decoder() then
>overwrites its target_type while the hardware keeps the committed value.
>I think this changes in Patch 8 - which really makes patch 8 required,
>not optional. (more on that in patch 8)

Yeah I see what you mean, I will move that logic from cxl_region_attach()
in patch 8 in here.

>Maybe the CXL_DECODER_STATE_AUTO mismatch check fits better in here,
>since this patch that removes the old one?

Agreed.

>
>
>> +	/*
>> +	 * Verify the device and HDM are capable of the region's flavor before
>> +	 * proceeding. The endpoint decoder's target_type is then inherited
>> +	 * from cxlr->type later in cxl_rr_assign_decoder().
>> +	 */
>> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
>> +	    cxl_root_decoder_is_bi(cxlrd) && !cxlds->bi) {
>> +		dev_err(&cxlr->dev, "%s:%s BI not enabled on device\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (cxled->state != CXL_DECODER_STATE_AUTO &&
>> +	    cxlr->type == CXL_DECODER_HOSTONLYMEM &&
>> +	    cxlds->type == CXL_DEVTYPE_DEVMEM) {
>> +		dev_warn(&cxlr->dev, "%s:%s HDM-H requires a Type 3 device\n",
>> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	cxlhdm = dev_get_drvdata(&ep_port->dev);
>> +	if (!cxlhdm)
>> +		return -ENXIO;
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM &&
>> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV) {
>> +		dev_warn(&cxlr->dev, "%s:%s HDM is device-coherent only\n",
>> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +	if (cxlr->type == CXL_DECODER_DEVMEM &&
>> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST) {
>> +		dev_warn(&cxlr->dev, "%s:%s HDM is host-only coherent\n",
>> +			 dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>>  		return -ENXIO;
>>  	}
>
>
>Why dev_err()/dev_warn() here?  The type mismatch refusal this replaces was
>a dev_dbg().  The attach fail here would be reported as -ENXIO.

Ok, will change to dev_dbg().

>
>Tidy up opportunity, maybe move the 4 coherency checks into a helper so
>cxl_region_attach() stays cleaner.

Ok

>
>Another cleanup - the 'is this reion HDM-DB test is now coded in a few
>places, my look may have been limited:
>	cxld_set_type():		target_type == DEVMEM && cxl_root_decoder_is_bi()
>	back_invalidate_show():		same, plus cxlds->bi
>	cxl_region_decode_commit():	cxlr->type == DEVMEM && cxl_root_decoder_is_bi()
>	cxl_region_attach():		same
>
>Maybe a single cxl_region_is_hdm_db() would be clearer and cleaner.

Ok, makes sense.

Thanks,
Davidlohr
