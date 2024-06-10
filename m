Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F39A953
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015797; cv=none; b=M0/m7LyzGpAEFww4K0469jW/DmBi86zJ/qSfmOnwncU9DPxsgpCv5hEoJO9PEs3XLW+rIu0zm4KKAV8KTXLGtj1XKYl98F6092gRIqfNQFqyMu5qstUMO61tbWj3UE6xD2cgfxLrxKOFMx8yV7S/V4iKNJxq9Y2WL1y7l+6APzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015797; c=relaxed/simple;
	bh=IbHY3rbSAQJKIRgVEylFz2FZF87qFuLrd8HHxMqcJYU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Op5nRU4Cy74Slywnf+F7fdA8+qk4IB+xREuk4AWgilq9dQ1p0fFH/r5bEnayX0FESXTCt902VNJAbomoQKceKKvfHasqwlXM9rEUWN2ss3fusRoN1AqvHHSV/O+jbddmLulUKD3FYfUiLZHC5jr2id8GzK0DUtgXtmDr0UfsFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VySqg1Ss9z67l0C;
	Mon, 10 Jun 2024 18:35:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 77223140C98;
	Mon, 10 Jun 2024 18:36:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 10 Jun
 2024 11:36:29 +0100
Date: Mon, 10 Jun 2024 11:36:28 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com>
CC: Alison Schofield <alison.schofield@intel.com>, "dave@stgolabs.net"
	<dave@stgolabs.net>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5] cxl/region: check interleave capability
Message-ID: <20240610113628.00001ca4@Huawei.com>
In-Reply-To: <OSZPR01MB6453A7CC146B904AE2C881C08DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
References: <20240524092740.4260-1-yaoxt.fnst@fujitsu.com>
	<ZmCKcVZPS/5MztqD@aschofie-mobl2>
	<OSZPR01MB6453A7CC146B904AE2C881C08DFA2@OSZPR01MB6453.jpnprd01.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 6 Jun 2024 03:46:42 +0000
"Xingtao Yao (Fujitsu)" <yaoxt.fnst@fujitsu.com> wrote:

> > -----Original Message-----
> > From: Alison Schofield <alison.schofield@intel.com>
> > Sent: Wednesday, June 5, 2024 11:55 PM
> > To: Yao, Xingtao/姚 幸涛 <yaoxt.fnst@fujitsu.com>
> > Cc: dave@stgolabs.net; jonathan.cameron@huawei.com; dave.jiang@intel.com;
> > vishal.l.verma@intel.com; ira.weiny@intel.com; dan.j.williams@intel.com;
> > jim.harris@samsung.com; linux-cxl@vger.kernel.org
> > Subject: Re: [PATCH v5] cxl/region: check interleave capability
> > 
> > On Fri, May 24, 2024 at 05:27:40AM -0400, Yao Xingtao wrote:  
> > > Since interleave capability is not verified, if the interleave
> > > capability of a target does not match the region need, committing decoder
> > > should have failed at the device end.
> > >  
> > 
> > What happens now if the driver tries to program a decoder with capabilities
> > it does not support?  
> Sorry, Currently I have not a real cxl memory device to verify this capability,
> I use the qemu to emulate the cxl memory, and it will decode the HPA to a wrong DPA,
> and then the memory access will fail.

Thought experiment.  If we think it's fine to configure with 16x interleave and it's
not because one EP in the set doesn't support that (predates the ECN)

Write IW 4, that's reserved value with no way to say what device does. I'm a lazy
device vendor, I implemented only 3 bits (I think that's allowed, or at least that
compliance checks won't notice if that's the implementation).  EP Things it's in 1
way interleave.

Rest of flow just works as if everything is fine.  This device won't do the address
bit dropping necessary for 16 way interleave so we will instead by providing decoding
up to 16x expected PA space (1/16th of which will ever be accessed)

My guess is that we'll have configured an HDM decoder way over likely physical capacity
(if we try to program another one next to it for say a DCD region, then we'll get an
error).

At that point best we can hope for is that device will feed us poison and drop
writes on everything after 1/16th of expected range.

Pretty bad outcome.   Checking that we support the desired interleave is very
important.  Fix is urgent.

Originally I thought we'd get an HDM Decoder commit error, but I'm not sure
we will.  Depends on whether the device will sink the write of an IW it doesn't
understand or not.

Jonathan



> 
> > 
> > Can you offer me the changelog here?  Definately in the next revision
> > but also right here in reply to remind me of prior discussions.  
> OK.
> 
>     V4 -> V5:
>     1. update comment.
>     2. add nr_targets check while attaching a port to switch.
>     3. delete passthrough flag and allow all the capabilities for passthrough
>        decoders.
> 
>     V3 -> V4:
>     1. update comment.
>     2. optimize the code.
>     3. add a passthrough flag to mark the passthrough decoder.
> 
>     V2 -> V3:
>     1. revert ig_cap_mask to interleave_mask.
>     2. fix the interleave bits check logical.
> 
>     V1 -> V2:
>     1. rename interleave_mask to ig_cap_mask.
>     2. add a check for interleave granularity.
>     3. update commit.
>     4. move hdm caps init to parse_hdm_decoder_caps().
> > -- Alison
> > 
> >   
> > > In order to checkout this error as quickly as possible, driver needs
> > > to check the interleave capability of target during attaching it to
> > > region.
> > >
> > > According to the CXL specification (section 8.2.4.20 CXL HDM Decoder
> > > Capability Structure), bits 11 and 12 within the 'CXL HDM Decoder
> > > Capability Register' indicate the capability to establish interleaving
> > > in 3, 6, 12, and 16 ways. If these bits are not set, the target cannot
> > > be attached to a region utilizing such interleave ways.
> > >
> > > Additionally, bits 8 and 9 in the same register represent the capability
> > > of the bits used for interleaving in the address, Linux tracks this in the
> > > cxl_port interleave_mask.
> > >
> > > Regarding 'Decoder Protection':
> > > If IW is less than 8 (for interleave ways of 1, 2, 4, 8, 16), the
> > > interleave bits start at bit position IG + 8 and end at IG + IW + 8 - 1.
> > >
> > > If the IW is greater than or equal to 8 (for interleave ways of 3, 6, 12),
> > > the interleave bits start at bit position IG + 8 and end at IG + IW - 1.
> > >
> > > If the interleave mask is insufficient to cover the required interleave
> > > bits, the target cannot be attached to the region.
> > >
> > > Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> > > Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> > > ---
> > >  drivers/cxl/core/hdm.c    | 10 +++++
> > >  drivers/cxl/core/region.c | 83  
> > +++++++++++++++++++++++++++++++++++++++  
> > >  drivers/cxl/cxl.h         |  2 +
> > >  drivers/cxl/cxlmem.h      |  1 +
> > >  4 files changed, 96 insertions(+)
> > >
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index 7d97790b893d..5b7dff19bbfa 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -52,6 +52,11 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port  
> > *port)  
> > >  	struct cxl_dport *dport = NULL;
> > >  	int single_port_map[1];
> > >  	unsigned long index;
> > > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> > > +
> > > +	/* allow all the interleave capabilities for passthrough decoder */
> > > +	cxlhdm->interleave_mask = GENMASK(14, 8);
> > > +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> > >
> > >  	cxlsd = cxl_switch_decoder_alloc(port, 1);
> > >  	if (IS_ERR(cxlsd))
> > > @@ -79,6 +84,11 @@ static void parse_hdm_decoder_caps(struct cxl_hdm  
> > *cxlhdm)  
> > >  		cxlhdm->interleave_mask |= GENMASK(11, 8);
> > >  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> > >  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> > > +	cxlhdm->iw_cap_mask = BIT(1) | BIT(2) | BIT(4) | BIT(8);
> > > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY,  
> > hdm_cap))  
> > > +		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
> > > +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> > > +		cxlhdm->iw_cap_mask |= BIT(16);
> > >  }
> > >
> > >  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 5c186e0a39b9..6b7400313cb2 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -1054,6 +1054,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
> > >  	struct cxl_decoder *cxld;
> > >  	unsigned long index;
> > >  	int rc = -EBUSY;
> > > +	struct cxl_switch_decoder *cxlsd;
> > >
> > >  	lockdep_assert_held_write(&cxl_region_rwsem);
> > >
> > > @@ -1101,6 +1102,23 @@ static int cxl_port_attach_region(struct cxl_port *port,
> > >  	}
> > >  	cxld = cxl_rr->decoder;
> > >
> > > +	/*
> > > +	 * the number of targets should not exceed the target_count
> > > +	 * of the decoder
> > > +	 */
> > > +	if (is_switch_decoder(&cxld->dev)) {
> > > +		cxlsd = to_cxl_switch_decoder(&cxld->dev);
> > > +		if (cxl_rr->nr_targets > cxlsd->nr_targets) {
> > > +			dev_dbg(&cxlr->dev,
> > > +				"%s:%s %s add: %s:%s @ %d overflows  
> > targets: %d\n",  
> > > +				dev_name(port->uport_dev),  
> > dev_name(&port->dev),  
> > > +				dev_name(&cxld->dev),  
> > dev_name(&cxlmd->dev),  
> > > +				dev_name(&cxled->cxld.dev), pos,
> > > +				cxlsd->nr_targets);
> > > +			goto out_erase;
> > > +		}
> > > +	}
> > > +
> > >  	rc = cxl_rr_ep_add(cxl_rr, cxled);
> > >  	if (rc) {
> > >  		dev_dbg(&cxlr->dev,
> > > @@ -1210,6 +1228,53 @@ static int check_last_peer(struct  
> > cxl_endpoint_decoder *cxled,  
> > >  	return 0;
> > >  }
> > >
> > > +static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
> > > +{
> > > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> > > +	unsigned int interleave_mask;
> > > +	u8 eiw;
> > > +	u16 eig;
> > > +	int rc, high_pos, low_pos;
> > > +
> > > +	rc = ways_to_eiw(iw, &eiw);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	if (!test_bit(iw, &cxlhdm->iw_cap_mask))
> > > +		return -ENXIO;
> > > +
> > > +	rc = granularity_to_eig(ig, &eig);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	/*
> > > +	 * Per CXL specification (8.2.3.20.13 Decoder Protection in r3.1)
> > > +	 * if eiw < 8, the interleave bits start at bit position eig + 8, and
> > > +	 * end at eig + eiw + 8 - 1.
> > > +	 * if eiw >= 8, the interleave bits start at bit position eig + 8, and
> > > +	 * end at eig + eiw - 1.
> > > +	 */
> > > +	if (eiw >= 8)
> > > +		high_pos = eiw + eig - 1;
> > > +	else
> > > +		high_pos = eiw + eig + 7;
> > > +	low_pos = eig + 8;
> > > +	/*
> > > +	 * when the eiw is 0 or 8 (interlave way is 1 or 3), the num of
> > > +	 * interleave bits is 0, there is no interleaving, the following
> > > +	 * check is ignored.
> > > +	 */
> > > +	if (low_pos > high_pos)
> > > +		return 0;
> > > +
> > > +	interleave_mask = GENMASK(high_pos, low_pos);
> > > +	if (interleave_mask & ~cxlhdm->interleave_mask)
> > > +		return -ENXIO;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int cxl_port_setup_targets(struct cxl_port *port,
> > >  				  struct cxl_region *cxlr,
> > >  				  struct cxl_endpoint_decoder *cxled)
> > > @@ -1360,6 +1425,15 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> > >  			return -ENXIO;
> > >  		}
> > >  	} else {
> > > +		rc = check_interleave_cap(cxld, iw, ig);
> > > +		if (rc) {
> > > +			dev_dbg(&cxlr->dev,
> > > +				"%s:%s iw: %d ig: %d is not supported\n",
> > > +				dev_name(port->uport_dev),
> > > +				dev_name(&port->dev), iw, ig);
> > > +			return rc;
> > > +		}
> > > +
> > >  		cxld->interleave_ways = iw;
> > >  		cxld->interleave_granularity = ig;
> > >  		cxld->hpa_range = (struct range) {
> > > @@ -1796,6 +1870,15 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> > >  	struct cxl_dport *dport;
> > >  	int rc = -ENXIO;
> > >
> > > +	rc = check_interleave_cap(&cxled->cxld, p->interleave_ways,
> > > +				  p->interleave_granularity);
> > > +	if (rc) {
> > > +		dev_dbg(&cxlr->dev, "%s iw: %d ig: %d is not supported\n",
> > > +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> > > +			p->interleave_granularity);
> > > +		return rc;
> > > +	}
> > > +
> > >  	if (cxled->mode != cxlr->mode) {
> > >  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
> > >  			dev_name(&cxled->cxld.dev), cxlr->mode,  
> > cxled->mode);  
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 036d17db68e0..dc8e46a1fe82 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -45,6 +45,8 @@
> > >  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> > >  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> > >  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> > > +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> > > +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> > >  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> > >  #define   CXL_HDM_DECODER_ENABLE BIT(1)
> > >  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> > > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > > index 36cee9c30ceb..6b8cf20ff375 100644
> > > --- a/drivers/cxl/cxlmem.h
> > > +++ b/drivers/cxl/cxlmem.h
> > > @@ -853,6 +853,7 @@ struct cxl_hdm {
> > >  	unsigned int decoder_count;
> > >  	unsigned int target_count;
> > >  	unsigned int interleave_mask;
> > > +	unsigned long iw_cap_mask;
> > >  	struct cxl_port *port;
> > >  };
> > >
> > > --
> > > 2.37.3
> > >  

