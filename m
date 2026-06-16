Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F463423164
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781602789; cv=none; b=Z10zkBiys4NGWG+12Ap9O1BUeKumm/ME+xQP0OkifxcUWaWZZX85Sj7R/7CKa9Uf7lAn+8EZ9adf0afkrBU4qb4ncwhcjJAE6ObG6kqCpbyl5A2CSijabyhu+ZF1LJZt3KQ1InILaaEqldNpI60fhXzXEWPg1mp7Q0O6tRogyD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781602789; c=relaxed/simple;
	bh=xDVf0parVCBAHtRzqwnSxtffzhQMOJFeP8x5R99Kv+o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV/oL30fVum4q/FeXFnyqPENYxBwrw7j9Aa5Gb8GMpIltRWgYM07TqGWU1GQ5Yfnkj6/XtDRpZcBnuN9BfVv5X2Dv73Jy8W8ZJq4JGqrJFic/oAVlFQsAEdKsLH/UJTaw8B+w99Ve0kZ1BJhm6kYk5msRAnq7Cz+HB4ILqYi9pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK2CeGFk; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK2CeGFk"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1370417c01cso5568550c88.1
        for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 02:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781602784; x=1782207584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2jH9xgGEpgLUsYUiK9ayDBe3cLTWFuYMoIe7OKXgFs=;
        b=dK2CeGFkiGIZh6ZTbnG9wiMelKhNDWqP8xtsgjJ0BGxOSjCmpFhSmVXD3OAYUL80ya
         KFwGsaz/O9sYJS7y9UpDTSXD6McIS8/KufhRzoDKV1idhqHHfbAXlrYy0PaB3C4xGg0Q
         wdRaNPLsKWDKx+SD1zSx/dAnwnzr3WEEK+t7uR1DMEpDH5eSYIgb5po1JhvDBd5hKtjI
         qFMmDx+JxMi1FYkOvdk57KDVR6cZ3DATfyp9f8SYZ3DADjp3IbBg5G8BYhB1LljKoF3r
         QfXWNx2ULRpu1ykBdiqU27203vXRutatCqWWFw1tX87BDVyaQE9piMI4uKXy3PWhV3O/
         fh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781602784; x=1782207584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2jH9xgGEpgLUsYUiK9ayDBe3cLTWFuYMoIe7OKXgFs=;
        b=IwikXF3XXvYMislUKHgaTWEVoLX86O4QNVN0vgQN0o0/KBWOPZNrzC+ggKjypUl8dG
         JR+aJh3mzrb35EznEh0aESHCKxcME5a12QNIPorBwnRUyRbCyU0wADi3Jx9YWmVyCw+S
         mzGAspJ4uZWai7MqYJAvgM99J/z6zqapi7XgQCd9EfXS9oVU34qibd4ZXGPT9L3ZHCPp
         MNr/sHryEE434zJI/UNUFFAczdya+S9iH3WCO4Jg/Ra7R6tIb3W7/khLAjSLN+/0ricY
         eRPiyx7oxP8HtfuJ32Qi4peN1U9vi8bpQ7Z/nSHIZyeNnUFxg5Uvgk3U/JNR2E8HUTiJ
         MlTQ==
X-Forwarded-Encrypted: i=1; AFNElJ98SfKkxpx9mupqjpDDLZcrUGixbnd94gzZZgneqmAmW3qfLs2DZcOHzkUAzX5P9mh9Prwiaq/EJs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioFw9faHb+++TT2gPhOwX3FLDdNcwKdYqps1b3/6MMnyygL5G
	OPMceYQpPFltWoyu8eM/SiysG6HLValsHcw4xjqlcTsaXj70irCJQZYu
X-Gm-Gg: Acq92OGJe0huIF5kMgnZhssThtFXvHuQtZEsFTJ383sYNYwiptTySXZvWMA8sAk7W3L
	FXhW4MMI8TekOF/pgktvVjbnvg4sXoC/CEj6uKPQn1OrSfSLob/tctHUG6uX30z5tFuRvF8hVY6
	U+Mr3JJ2w7bKsQWV9bVtiZO8U8IT+TVm8CexI1JsMTgfPZ05SAOrH4MBNg/0DZeFs8VAhVQaCUl
	iu3DjWMAVExt4X4kZp75t4DZWyIL/Aq5/5dRXhQHD7G2xxtqZrxBA/0kuP0q6o6OcrHlcFpfxHy
	0s83b/o/uWiR/iFXgCpRxZZCimQ6nlc+krtOq4IgEgGY6PDKaE68mQowHku/QE/i1MKhNoxHeiE
	jNRizm99wP9JH9mWvp50BxEQkrpFufS+fKIsRk/aJdn7WXvNo9hIx2tRlH5hzgnsYcqNOp4b9by
	hKJpnl59ncKC6Spyb7RzwUPC7JKXIdfP0p0Sr6y1DPe+jp3KnDVDoa5I+065EcVEk6E4DbGrjon
	1I3CRI=
X-Received: by 2002:a05:7301:1f17:b0:30a:e530:ebc6 with SMTP id 5a478bee46e88-30ba59fe62cmr1737317eec.12.1781602784137;
        Tue, 16 Jun 2026 02:39:44 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48c3dcsm19177476eec.1.2026.06.16.02.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:39:43 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 16 Jun 2026 02:39:41 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v10 27/31] cxl/region: Read existing extents on region
 creation
Message-ID: <ajEZ3dp6M2TOIRwf@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <ec8d257b53053061d70ca0b30408be116d479a03.1779528761.git.anisa.su@samsung.com>
 <a737d037-1331-46f4-b5c3-cf819690727d@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a737d037-1331-46f4-b5c3-cf819690727d@intel.com>

On Fri, May 29, 2026 at 02:30:20PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Dynamic capacity device extents may be left in an accepted state on a
> > device due to an unexpected host crash.  In this case it is expected
> > that the creation of a new region on top of a DC partition can read
> > those extents and surface them for continued use.
> > 
> > Once all endpoint decoders are part of a region and the region is being
> > realized, a read of the 'devices extent list' can reveal these
> > previously accepted extents.
> > 
> > CXL r3.1 specifies the mailbox call Get Dynamic Capacity Extent List for
> > this purpose.  The call returns all the extents for all dynamic capacity
> > partitions.  If the fabric manager is adding extents to any DCD
> > partition, the extent list for the recovered region may change.  In this
> > case the query must retry.  Upon retry the query could encounter extents
> > which were accepted on a previous list query.  Adding such extents is
> > ignored without error because they are entirely within a previous
> > accepted extent.  Instead warn on this case to allow for differentiating
> > bad devices from this normal condition.
> > 
> > Latch any errors to be bubbled up to ensure notification to the user
> > even if individual errors are rate limited or otherwise ignored.
> > 
> > The scan for existing extents races with the dax_cxl driver.  This is
> > synchronized through the region device lock.  Extents which are found
> > after the driver has loaded will surface through the normal notification
> > path while extents seen prior to the driver are read during driver load.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/core.h       |   1 +
> >  drivers/cxl/core/mbox.c       | 116 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/region_dax.c |  27 ++++++++
> >  drivers/cxl/cxlmem.h          |  21 ++++++
> >  4 files changed, 165 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index c28e357c5817..f5b05de5ed83 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -28,6 +28,7 @@ cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> >  	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> >  }
> >  
> > +int cxl_process_extent_list(struct cxl_endpoint_decoder *cxled);
> >  int cxl_region_invalidate_memregion(struct cxl_region *cxlr);
> >  
> >  #ifdef CONFIG_CXL_REGION
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 8071c1ed1b36..486110e1c03d 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -2083,6 +2083,122 @@ int cxl_dev_dc_identify(struct cxl_mailbox *mbox,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_dc_identify, "CXL");
> >  
> > +/* Return -EAGAIN if the extent list changes while reading */
> > +static int __cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	u32 current_index, total_read, total_expected, initial_gen_num;
> 
> initial_gen_num should be initialized to something invalid?
> 
Since first is set to true, the if (first) always reads initial_gen_num
from the first extent, so it should be fine... right?

> > +	struct cxl_memdev_state *mds = cxled_to_mds(cxled);
> > +	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u32 max_extent_count;
> > +	int latched_rc = 0;
> > +	bool first = true;
> > +
> > +	struct cxl_mbox_get_extent_out *extents __free(kvfree) =
> > +				kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
> > +	if (!extents)
> > +		return -ENOMEM;
> > +
> > +	total_read = 0;
> > +	current_index = 0;
> > +	total_expected = 0;
> > +	max_extent_count = (cxl_mbox->payload_size - sizeof(*extents)) /
> > +				sizeof(struct cxl_extent);
> > +	do {
> > +		u32 nr_returned, current_total, current_gen_num;
> > +		struct cxl_mbox_get_extent_in get_extent;
> > +		int rc;
> > +
> > +		get_extent = (struct cxl_mbox_get_extent_in) {
> > +			.extent_cnt = cpu_to_le32(max(max_extent_count,
> > +						  total_expected - current_index)),
> 
> Should be min() here right?
> 
That looks like it was the original intention, but since total_expected is
initialized to 0, using min would set extent_cnt to 0.

So I just did
.extent_cnt = cpu_to_le32(max_extent_count),

to always ask for the max and then the device is free to return < than
that. Should be ok, right?

> > +			.start_extent_index = cpu_to_le32(current_index),
> > +		};
> > +
> > +		mbox_cmd = (struct cxl_mbox_cmd) {
> > +			.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +			.payload_in = &get_extent,
> > +			.size_in = sizeof(get_extent),
> > +			.size_out = cxl_mbox->payload_size,
> > +			.payload_out = extents,
> > +			.min_out = 1,
> > +		};
> > +
> > +		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
> > +		if (rc < 0)
> > +			return rc;
> > +
> > +		/* Save initial data */
> > +		if (first) {
> > +			total_expected = le32_to_cpu(extents->total_extent_count);
> > +			initial_gen_num = le32_to_cpu(extents->generation_num);
> > +			first = false;
> > +		}
> > +
> > +		nr_returned = le32_to_cpu(extents->returned_extent_count);
> > +		total_read += nr_returned;
> > +		current_total = le32_to_cpu(extents->total_extent_count);
> > +		current_gen_num = le32_to_cpu(extents->generation_num);
> > +
> > +		dev_dbg(dev, "Got extent list %d-%d of %d generation Num:%d\n",
> > +			current_index, total_read - 1, current_total, current_gen_num);
> > +
> > +		if (current_gen_num != initial_gen_num || total_expected != current_total) {
> > +			dev_warn(dev, "Extent list change detected; gen %u != %u : cnt %u != %u\n",
> > +				 current_gen_num, initial_gen_num,
> > +				 total_expected, current_total);
> > +			return -EAGAIN;
> > +		}
> > +
> > +		for (int i = 0; i < nr_returned ; i++) {
> > +			struct cxl_extent *extent = &extents->extent[i];
> > +
> > +			dev_dbg(dev, "Processing extent %d/%d\n",
> > +				current_index + i, total_expected);
> > +
> 
> Should probably hold the mds->add_ctx->lock before calling add_to_pending_list()? handle_add_event() holds the lock before calling. Maybe also add a lock assert in add_to_pending_list().
> 
Oh yeah... it definitely should. Also lock assert added to
add_to_pending_list()

> > +			rc = add_to_pending_list(&mds->add_ctx.pending_extents,
> > +						 extent);
> > +			if (rc) {
> > +				latched_rc = rc;
> 
> Is the intention here to report the last found error and not the first error?
> 
Changed to report first error:

if (rc && !latched_rc)
	latched_rc = rc;

> > +			}
> 
> {} not needed if single line
> 
removed

> > +		}
> > +
> > +		current_index += nr_returned;
> > +	} while (total_expected > total_read);
> > +
> > +	if (!latched_rc && !list_empty(&mds->add_ctx.pending_extents)) {
> > +		latched_rc = cxl_add_pending(mds);
> > +	}
> > +	clear_pending_extents(mds);
> > +
> > +	return latched_rc;
> > +}
> > +
> > +#define CXL_READ_EXTENT_LIST_RETRY 10
> > +
> > +/**
> > + * cxl_process_extent_list() - Read existing extents
> > + * @cxled: Endpoint decoder which is part of a region
> > + *
> > + * Issue the Get Dynamic Capacity Extent List command to the device
> > + * and add existing extents if found.
> > + *
> > + * A retry of 10 is somewhat arbitrary, however, extent changes should be
> > + * relatively rare while bringing up a region.  So 10 should be plenty.
> > + */
> > +int cxl_process_extent_list(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	int retry = CXL_READ_EXTENT_LIST_RETRY;
> > +	int rc;
> > +
> > +	do {
> > +		rc = __cxl_process_extent_list(cxled);
> > +	} while (rc == -EAGAIN && retry--);
> 
> I think it's retrying 11 times here.
> 
Changed to while (rc == -EAGAIN && --retry);
> > +
> > +	return rc;
> > +}
> > +
> >  static void add_part(struct cxl_dpa_info *info, u64 start, u64 size, enum cxl_partition_mode mode)
> >  {
> >  	int i = info->nr_partitions;
> > diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> > index 519e203c486a..e7a812e8b2e7 100644
> > --- a/drivers/cxl/core/region_dax.c
> > +++ b/drivers/cxl/core/region_dax.c
> > @@ -82,6 +82,26 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
> >  	device_unregister(&cxlr_dax->dev);
> >  }
> >  
> > +static int cxlr_add_existing_extents(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	int i, latched_rc = 0;
> > +
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		struct device *dev = &p->targets[i]->cxld.dev;
> > +		int rc;
> > +
> > +		rc = cxl_process_extent_list(p->targets[i]);
> > +		if (rc) {
> > +			dev_err(dev, "Existing extent processing failed %d\n",
> > +				rc);
> > +			latched_rc = rc;
> > +		}
> > +	}
> > +
> > +	return latched_rc;
> > +}
> > +
> >  int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  {
> >  	struct device *dev;
> > @@ -110,6 +130,13 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> >  		dev_name(dev));
> >  
> > +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A) {
> > +		rc = cxlr_add_existing_extents(cxlr);
> 
> cxlr_add_existing_extents() -> cxl_process_extent_list() -> __cxl_process_extent_list() -> cxl_add_pending() -> CXL_MBOX_OP_ADD_DC_RESPONSE sent.
> 
> CXL r4.0 8.2.10.9.9.3:
> Device shall report Invalid Physical Address if:
> One or more extents in the updated extent list specify a DPA range that has already been added with a previous call to the Add Dynamic Capacity Response.
> 
> Aren't existing extents already been added previously and responded by ADD_DC_RESPONSE? For add existing extent path it seems like no response is needed to send to the device and can be skipped. Otherwise the software will receive error from the device when sending ADD_DC_RESPONSE.
> 
very true

cxl_add_pending() gains the param: bool existing

__cxl_process_extent_list() calls cxl_add_pending(mds, true);

And before cxl_add_pending sends add DC response, check existing

/*
 * Recovered (already-accepted) extents must not be re-reported in an
 * Add-DC-Response: the device rejects a DPA range already added by a
 * previous response (CXL r4.0 8.2.10.9.9.3, Invalid Physical Address).
 */
if (existing)
	return 0;

return cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
			    pending, total_accepted);

> Would be good to get this tested on hw.
> 
> 
> > +		if (rc)
> > +			dev_err(&cxlr->dev,
> > +				"Existing extent processing failed %d\n", rc);
> 
> No return on error?
> 
oops, fixed

> DJ
> 
Thanks,
Anisa
> > +	}
> > +
> >  	return devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> >  					no_free_ptr(cxlr_dax));
> >  }
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index d992cc9b7811..1ad3dc7e413c 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -564,6 +564,27 @@ struct cxl_mbox_dc_response {
> >  	} __packed extent_list[] __counted_by(extent_list_size);
> >  } __packed;
> >  
> > +/*
> > + * Get Dynamic Capacity Extent List; Input Payload
> > + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-166
> > + */
> > +struct cxl_mbox_get_extent_in {
> > +	__le32 extent_cnt;
> > +	__le32 start_extent_index;
> > +} __packed;
> > +
> > +/*
> > + * Get Dynamic Capacity Extent List; Output Payload
> > + * CXL rev 3.1 section 8.2.9.9.9.2; Table 8-167
> > + */
> > +struct cxl_mbox_get_extent_out {
> > +	__le32 returned_extent_count;
> > +	__le32 total_extent_count;
> > +	__le32 generation_num;
> > +	u8 rsvd[4];
> > +	struct cxl_extent extent[];
> > +} __packed;
> > +
> >  struct cxl_mbox_get_supported_logs {
> >  	__le16 entries;
> >  	u8 rsvd[6];
> 
