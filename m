Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793607737;
	b=4XBaPm1+4HRnx6vWZCK6nNbTR5j+seYxDZkcZNEyXfHxoXJg5ynbWn87sxWAXNqmPlDo
	 Q4ef8noie2WfpF88HGZ9oF1rwXT6ZWpcEqHlOoDGPywpM75QMvx/Lox9r3nDWL7qM6yWm
	 cCtETtdOgHHXDmlWGQtdk3aOIubwqZuTAHd1uViLY3icsgcEQkNosFg5IyQTbqKRaID/o
	 o35vrnvKhwWhJaiD7qRLNSso8oiAx62w0qFM2CEu3FCTZDHlW3oAFMqBuYJQaGAwMx6mO
	 1GjDm10o4GVaD9YGHzffktzF0x029bcQNehVMTLUPlmVzQb/qkEAaRTRhtgL97K5m3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607737;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=nqgKG2aQlTCcnVag65791fardCq0tRcDuzRBsNCgkRs=;
	b=I4h6nXKQhqK9GAJj0jhHcIW6HQJpDO03/6jIImbUPMDUj7oWy8zxjeck37tZCuzBOkMR
	 C/YrLr4wi0WsD4lytA7C4G8ieoZn5yx66hb6sKZMNXs9z50nR7ROQOqE/WZdegzsl7koM
	 MkY+hCXQLwIozlS6MJKO70meRRlTDWPSwog1miUgWnTw8TQOW9dTHSOtpibDWHTgJH27Q
	 uYdALEJYL4EajwHPxiAuAsRcSTWaYgzXBqhu1lbn7TRyByOYBjNWARiTFXFHNUhw/wESn
	 6NI4hTpqeFavoGfFZv/JB7VIY9MVRXXVbJQNmXLe0fGfIHAY/m53H4BAiI2wSC6CIjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=RBscp4x5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.94
Received: from sender6-pp-o94.zoho.com (sender6-pp-o94.zoho.com [165.173.180.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F98606A331
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 08:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F98606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=RBscp4x5
ARC-Seal: i=1; a=rsa-sha256; t=1793607724; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lgHIQoHchryo/CEyK2erun/tv9Yvt7mrQuXQsmP9FvBqg9Y48b7NySzl2VbYKSH8V/29jHfUq8ygZdBwW0VimgUVOAOK4lLmpg61dWI2l3RAwUHw0f3IxPqXN9vG35jHTA71hgswecLr39eLEsKQIs5z0FVCYK6DdwQszcNeqQg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793607724; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nqgKG2aQlTCcnVag65791fardCq0tRcDuzRBsNCgkRs=; 
	b=OXYq4OBbjZxDxJmXaMgT0AuFXpArO5n+ro5r6b6NqtfhGQx9M9kTjN4EaNQBuhJGeyB0xaYqHERkdpTFwtcNAk1VNxyyG+EoCHdxI3kjajqwXcFu9xxX0RMCfPnRa9UBUcv4kMmpPSKKmT4biwKxAMxIu/vd5895wNcvwPJ+o2c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=RBscp4x54RO9PXrmSB9c+ILQSkaA3oNaVP74Sg/xAbl83+m5ajtYvbZ7bzPG39jro3xQvXtRbGFsg3dcg/BSkki1iprxi0+ftIdaZFocD3b+ywQtDRKR3luFk19AxIMSmLVLN4Z+WgJal/jCzhEdgTKyBLoWfxclksihqMsb2jQ=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=nqgKG2aQlTCcnVag65791fardCq0tRcDuzRBsNCgkRs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179360772056490.77155162428278;
	Mon, 2 Nov 2026 00:22:00 -0800 (PST)
Message-ID: <dfe70cf5-f6ef-4b28-9c51-49e7fbd8b9c8@zohomail.com>
Date: Mon, 2 Nov 2026 16:21:56 +0800
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/10] cxl: Handle auto-committed BI hdm decoders
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1793567979.git.dave@stgolabs.net>
 <db0f7cc38da1300596a7b8653bd2fba010e20e52.1793567979.git.dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <db0f7cc38da1300596a7b8653bd2fba010e20e52.1793567979.git.dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227ea3721bea2a9ce4fa47cceb80000993dc31d5276bde1a285fb4a0b936c0c316ef7c2418f9edab3:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/2 05:51, Davidlohr Bueso 写道:
> An HDM decoder that firmware committed with the BI bit set was
> assembled without the bit ever being looked at. Record it, and
> refuse what is broken - BI paired with a host-only target range type,
> or for an endpoint decoder BI on a path that cannot route BISnp.
>
> Taking over such a path must not re-program what firmware already
> did, and a dport's committed state does not say which device it was
> committed for, only that firmware committed for something below it.
> Two endpoints sharing a level show why that is not enough to go on.
>
>                          RP      Forward set, but for mem0
>                          |
>                         USP
>                         /  \
>                     DSP0    DSP1
>                       |       |
>                    mem0      mem1
>                 BI Enable   BI Enable
>                    set       clear
>
> Adoption is therefore seeded from the endpoint's own BI Enable, since
> only a device firmware itself enabled can have had its BI-ID
> accounted for above, and carried up the walk. A level is taken as
> found, with no register write and no commit, when nothing this driver
> routed sits below it, the value this driver would write is already
> there, and both the decoder and the switch's route table are
> committed - the table carries a commit of its own that firmware may
> not have performed. The first level to fall short ends adoption, and
> from it up the driver programs and commits as for any other device.
>
>                      RP    Forward, written but never committed
>                      |
>                    USP0    route table committed by the driver
>                      |
>                    DSP0    Forward, written and committed
>                      |     ..... adoption ended here .....
>                    USP1    route table already committed
>                      |
>                    DSP1    Enable, taken as found
>                      |
>                    mem0    BI Enable already set by firmware
>
> An adopted level owes no commit either way. Table 8-152 and Table
> 8-156 owe one per new BI device enabled below the port, and an
> adopted level is not seeing one.
>
> On failure the walk unwinds through the same release as teardown. An
> adopted level was found up and is held, so the unwind drops its
> reference and leaves its register alone; a level this walk brought up
> is cleared. Teardown works the same way: every level this driver
> brought up is deallocated, unless a decoder below still decodes with
> BI and holds it.
>
> A committed decoder is refused when its coherency model does not fit
> where it lands: unlike a decoder this driver programs it cannot
> inherit a region's model, so its committed BI bit must match the
> window's, checked before the region is built and again at attach,
> where a second decoder joining the region arrives.
>
> A committed decoder's BI bit is recorded as CXL_DECODER_F_BI. On a
> root decoder the same flag is the window's BI restriction, as F_LOCK
> already means a fixed window there and Lock On Commit below.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>


One comment below.

> ---
>   drivers/cxl/core/hdm.c    | 31 ++++++++++++++++++--
>   drivers/cxl/core/pci.c    | 60 +++++++++++++++++++++++++++++++++++++--
>   drivers/cxl/core/region.c | 32 +++++++++++++--------
>   drivers/cxl/cxl.h         |  3 +-
>   4 files changed, 108 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c272fc6faf37..1136f7d1bd5b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -907,6 +907,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>   	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>   	int id = cxld->id, rc;
> +	u32 ctrl;
>   
>   	if (cxld->flags & CXL_DECODER_F_ENABLE)
>   		return 0;
> @@ -950,6 +951,10 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>   	port->commit_end++;
>   	cxld->flags |= CXL_DECODER_F_ENABLE;
>   
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_BI)
> +		cxld->flags |= CXL_DECODER_F_BI;
> +

IIUC, this part is unrelated auto-committed BI HDM decoder handling, 
because above "if (cxld->flags & CXL_DECODER_F_ENABLE)" will return 
directly for auto-committed BI HDM decoder, I guess this part should 
move to patch #4?


Ming

>   	return 0;
>   }
>   
> @@ -1020,7 +1025,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>   	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
>   	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
>   
> -	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +	cxld->flags &= ~(CXL_DECODER_F_ENABLE | CXL_DECODER_F_BI);
>   
>   	/* Userspace is now responsible for reconfiguring this decoder */
>   	if (is_endpoint_decoder(&cxld->dev)) {
> @@ -1140,11 +1145,32 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		cxld->flags |= CXL_DECODER_F_ENABLE;
>   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>   			cxld->flags |= CXL_DECODER_F_LOCK;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_BI)
> +			cxld->flags |= CXL_DECODER_F_BI;
> +
>   		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
>   			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   		else
>   			cxld->target_type = CXL_DECODER_DEVMEM;
>   
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl)) {
> +			struct cxl_dev_state *cxlds = cxled ?
> +				cxled_to_memdev(cxled)->cxlds : NULL;
> +
> +			if (cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
> +				dev_warn(&port->dev,
> +					 "decoder%d.%d: BI with host-only\n",
> +					 port->id, cxld->id);
> +				return -ENXIO;
> +			}
> +			if (cxlds && !cxlds->bi_capable) {
> +				dev_warn(&port->dev,
> +					 "decoder%d.%d: path not BI capable\n",
> +					 port->id, cxld->id);
> +				return -ENXIO;
> +			}
> +		}
> +
>   		guard(rwsem_write)(&cxl_rwsem.region);
>   		if (cxld->id != cxl_num_decoders_committed(port)) {
>   			dev_warn(&port->dev,
> @@ -1423,7 +1449,8 @@ int devm_cxl_endpoint_decoders_setup(struct cxl_port *port)
>   	 * Between the port's HDM state and its decoders: devres,
>   	 * unwinding in reverse, brings BI down only after the decoders
>   	 * quiesce, while its slow walk still precedes the HDM state
> -	 * free.
> +	 * free. Must also precede region discovery, where HDM-DB
> +	 * assembly requires cxlds->bi.
>   	 */
>   	rc = cxl_bi_setup(port);
>   	if (rc)
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index aec1edf648bd..11e2a97f6567 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1109,6 +1109,32 @@ static int __cxl_bi_commit_decoder(struct device *dev, void __iomem *bi)
>   				    scale, base);
>   }
>   
> +/* Committed, or no explicit commit required */
> +static bool __cxl_bi_committed(void __iomem *caps_reg, void __iomem *status_reg,
> +			       u32 req_bit, u32 committed_bit)
> +{
> +	if (!(readl(caps_reg) & req_bit))
> +		return true;
> +
> +	return readl(status_reg) & committed_bit;
> +}
> +
> +static bool cxl_bi_rt_committed(void __iomem *bi)
> +{
> +	return __cxl_bi_committed(bi + CXL_BI_RT_CAPS_OFFSET,
> +				  bi + CXL_BI_RT_STATUS_OFFSET,
> +				  CXL_BI_RT_CAPS_EXPLICIT_COMMIT_REQ,
> +				  CXL_BI_RT_STATUS_BI_COMMITTED);
> +}
> +
> +static bool cxl_bi_decoder_committed(void __iomem *bi)
> +{
> +	return __cxl_bi_committed(bi + CXL_BI_DECODER_CAPS_OFFSET,
> +				  bi + CXL_BI_DECODER_STATUS_OFFSET,
> +				  CXL_BI_DECODER_CAPS_EXPLICIT_COMMIT_REQ,
> +				  CXL_BI_DECODER_STATUS_BI_COMMITTED);
> +}
> +
>   static int cxl_bi_commit_dport(struct cxl_dport *dport)
>   {
>   	struct cxl_port *port = dport->port;
> @@ -1136,7 +1162,8 @@ static int cxl_bi_commit_dport(struct cxl_dport *dport)
>    * @direct says the device is connected directly to this dport, which
>    * takes BI Enable; every dport above it takes BI Forward.
>    */
> -static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
> +static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct,
> +				    bool *adopt)
>   {
>   	struct cxl_port *port = dport->port;
>   	u32 ctrl, value, set, clr;
> @@ -1168,6 +1195,20 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
>   		       CXL_BI_DECODER_CTRL_BI_ENABLE;
>   
>   	value = (ctrl | set) & ~clr;
> +
> +	/*
> +	 * Adopt this level as firmware left it: nothing below it that
> +	 * firmware did not account for, nothing this driver has routed
> +	 * through it, the value this walk would write already in place,
> +	 * and the decoder (and route table) committed.
> +	 */
> +	if (*adopt && !dport->nr_bi && value == ctrl &&
> +	    cxl_bi_decoder_committed(bi) &&
> +	    (!port->regs.bi_rt || cxl_bi_rt_committed(port->regs.bi_rt)))
> +		goto done;
> +	/* firmware did not bring this level up, so nothing above may */
> +	*adopt = false;
> +
>   	if (value != ctrl)
>   		writel(value, bi + CXL_BI_DECODER_CTRL_OFFSET);
>   
> @@ -1181,6 +1222,7 @@ static int cxl_bi_ctrl_dport_enable(struct cxl_dport *dport, bool direct)
>   		}
>   		return rc;
>   	}
> +done:
>   	dport->nr_bi++;
>   
>   	return 0;
> @@ -1277,7 +1319,9 @@ static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
>   /*
>    * Release the device's BI, then each dport up the path short of @stop,
>    * following the deallocate sequence in the implementation notes of
> - * CXL 4.0 9.14.2. Setup's unwind and teardown alike.
> + * CXL 4.0 9.14.2. Setup's unwind and teardown alike: a level the
> + * walk adopted was found up and is held, so the unwind leaves its
> + * register as it found it.
>    *
>    * A decoder that still decodes with its BI bit set needs BI Enable,
>    * the device-wide permission behind it, so the device keeps it. The
> @@ -1341,14 +1385,24 @@ static void cxl_bi_dealloc(void *data)
>   static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
>   			      struct cxl_port *port, struct cxl_dport *dport)
>   {
> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>   	struct cxl_dport *dport_iter;
>   	struct cxl_port *port_iter;
> +	bool adopt;
>   	int rc;
>   
> +	/*
> +	 * Adoption is a path property, not a per-dport one: only when
> +	 * firmware enabled the device itself does a dport's committed
> +	 * state cover this device's BI-ID.
> +	 */
> +	adopt = cxl_bi_decoder_enabled(endpoint);
> +
>   	port_iter = port;
>   	dport_iter = dport;
>   	while (!is_cxl_root(port_iter)) {
> -		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport);
> +		rc = cxl_bi_ctrl_dport_enable(dport_iter, dport_iter == dport,
> +					      &adopt);
>   		if (rc)
>   			goto err_rollback;
>   
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 06a0e9bb892f..4c92aed1a744 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2129,13 +2129,19 @@ static int cxl_region_check_coherency(struct cxl_region *cxlr,
>   		return -ENXIO;
>   	}
>   
> -	/* a committed decoder cannot inherit the region's type */
> -	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) &&
> -	    cxled->cxld.target_type != cxlr->type) {
> -		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			cxled->cxld.target_type, cxlr->type);
> -		return -ENXIO;
> +	/* a committed decoder cannot inherit the region's flavor */
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		bool bi = cxled->cxld.flags & CXL_DECODER_F_BI;
> +
> +		if (cxled->cxld.target_type != cxlr->type || bi != root_bi) {
> +			dev_dbg(&cxlr->dev,
> +				"%s:%s coherency model mismatch: %s vs %s\n",
> +				dev_name(&cxlmd->dev),
> +				dev_name(&cxled->cxld.dev),
> +				cxl_coherency_name(cxled->cxld.target_type, bi),
> +				cxl_coherency_name(cxlr->type, root_bi));
> +			return -ENXIO;
> +		}
>   	}
>   
>   	return 0;
> @@ -3898,6 +3904,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   	struct cxl_endpoint_decoder *cxled = ctx->cxled;
>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	bool bi = cxled->cxld.flags & CXL_DECODER_F_BI;
>   	int rc, part = READ_ONCE(cxled->part);
>   	struct cxl_region *cxlr;
>   	unsigned long need;
> @@ -3907,14 +3914,15 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>   
>   	/*
>   	 * A committed decoder defines the region built from it, so no
> -	 * attach check can find its range type wrong. Only the window's
> -	 * restrictions can.
> +	 * attach check can find its coherency model wrong. Only the
> +	 * window's restrictions can, on the BI and range type axes.
>   	 */
>   	need = cxled->cxld.target_type == CXL_DECODER_DEVMEM ?
>   	       CXL_DECODER_F_DEVMEM : CXL_DECODER_F_HOSTONLY;
> -	if (!(cxlrd->cxlsd.cxld.flags & need)) {
> -		dev_dbg(&cxlrd->cxlsd.cxld.dev,
> -			"%s:%s range type not permitted by the window\n",
> +	if (bi != cxl_root_decoder_is_bi(cxlrd) ||
> +	    !(cxlrd->cxlsd.cxld.flags & need)) {
> +		dev_err(&cxlrd->cxlsd.cxld.dev,
> +			"%s:%s coherency model not permitted by the window\n",
>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
>   		return ERR_PTR(-ENXIO);
>   	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a95045b05601..90815daffe8e 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -311,7 +311,8 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>   #define CXL_DECODER_F_ENABLE    BIT(5)
>   #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
>   #define CXL_DECODER_F_BI    BIT(7)
> -#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
> +#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK | \
> +				  CXL_DECODER_F_BI)
>   
>   enum cxl_decoder_type {
>   	CXL_DECODER_DEVMEM = 2,
