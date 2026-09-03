Received: from toucan.tulip.relay.mailchannels.net (toucan.tulip.relay.mailchannels.net [23.83.218.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7527283FDC
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.218.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405154; cv=none; b=GZnx+eL9SB5AMORgQ/i+Egg8rNl2JMkC0oQ8Ub8vz0gSG99fOuxJklNo+r0rDlI8rdCvI3DQUCLlGyCY0hu7qxuKYxkfXoBIfqRDa8qaollppKRh/S7ZrxJtbu2rf+JbkCHGYGJPAKEgKHnC5nyuR5iAazbQSy3DCT5sLXRoppA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405154; c=relaxed/simple;
	bh=xfoI/oP54GGrwuEFwIKVO/VJwASkx0nP9paFP08Xmnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmRyGRTc7Czo/mnon4fWhJz/BNOtVVSS942h0qe13NbqZl2u1jJ8sQq32+PDEnSLd1yo5p2g0YpCnjOfEQT9U4KOAKNDXPTa6XGAeyEsuSpTo4x+U2rUEz8GAy94MTdmLDdUnepzHmB7wuwShI08AkqAqYV7gU1merbbq/CfxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=X8HhXx9H; arc=none smtp.client-ip=23.83.218.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="X8HhXx9H"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 737D27A02D2;
	Thu, 03 Sep 2026 00:12:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (100-97-98-140.trex-nlb.outbound.svc.cluster.local [100.97.98.140])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 05C917A10F6;
	Thu, 03 Sep 2026 00:12:37 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Eight: 65b0b0750713aca5_1788394357242_2763280336
X-MC-Loop-Signature: 1788394357242:3028740863
X-MC-Ingress-Time: 1788394357242
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.98.140 (trex/8.0.2);
	Thu, 03 Sep 2026 00:12:37 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4hb0R82v2tzPr;
	Wed,  2 Sep 2026 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1788394356;
	bh=ACLGFQ+trHjn7ZkdhqQaoN54yMIuJdLZbkYEsHgg8So=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=X8HhXx9HIw1b+jg+1WqsmNWLQNTks18isgV37mSUb+ABvw6YuBJFSbIxS4zWZA5oO
	 owRnJUZnaKp5HULro4gI2lMCjH+KXavzh3O3SUigWgMRAuhQWKhy5hxGx/0Z3T+NxV
	 6tAjEjhb2gT1/nv+xHOBhMiIMW7guvxUdgqfx6nLsPwiq9lOUKbEkJogPECqcOwGWV
	 rlRoBXWbftjm1CIkC3XT9TsEqFSomWeE4po+l2K3ySXqsA/w2VuGwIJBm8Cr+jYMJI
	 WA5VUMhCrGvN8NRBRn9AUqpv61o5YCXuzLsq+9Wm/L+3gsRhgKGrB4YXXgynheqpuW
	 OUG0r9dmAHthQ==
Date: Wed, 2 Sep 2026 17:12:33 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	benjamin.cheatham@amd.com, alucerop@amd.com,
	dongjoo.seo1@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 2/8] cxl/pci: Add BI topology enable/disable
Message-ID: <20260903001233.zzxuq2vfwnkr2g2r@offworld>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-3-dave@stgolabs.net>
 <anV9OphxsNzGO6mR@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <anV9OphxsNzGO6mR@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Fri, 07 Aug 2026, Richard Cheng wrote:

>On Tue, Jul 28, 2026 at 07:41:30AM +0800, Davidlohr Bueso wrote:
>> +static int __cxl_bi_ctrl_endpoint(struct cxl_dev_state *cxlds, bool enable)
>> +{
>> +	struct cxl_port *endpoint = cxlds->cxlmd->endpoint;
>> +	void __iomem *bi = endpoint->regs.bi_decoder;
>> +	u32 ctrl, val;
>> +
>> +	if (!bi)
>> +		return -EINVAL;
>> +
>> +	ctrl = readl(bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +
>> +	if (enable) {
>> +		if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
>> +			if (cxlds->bi)
>> +				return 0;
>> +			dev_err(cxlds->dev,
>> +				"BI already enabled in hardware\n");
>> +			return -EBUSY;
>> +		}
>> +		val = ctrl | CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +	} else {
>> +		if (!FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE, ctrl)) {
>> +			if (!cxlds->bi)
>> +				return 0;
>> +			dev_err(cxlds->dev,
>> +				"BI already disabled in hardware\n");
>> +			return -EBUSY;
>> +		}
>> +		val = ctrl & ~CXL_BI_DECODER_CTRL_BI_ENABLE;
>> +	}
>> +
>> +	writel(val, bi + CXL_BI_DECODER_CTRL_OFFSET);
>> +	cxlds->bi = enable;
>> +
>> +	dev_dbg(cxlds->dev, "BI requests %s\n",
>> +		str_enabled_disabled(enable));
>> +
>> +	return 0;
>> +}
>
>After a PCI reset or CXL reset, shouldn't "cxlds->bi" be invalidated and restored ?

Ah, I had not really considered the reset action. afaict we need to invalidate it,
but restored, is left to the rebind.

>
>As far as I know SBR can reset endpoint BI decoder's BI Enable bit to 0, but here we leave
>its software value stale.

Yeah, for example for mem0:

         # echo cxl_bus > /sys/bus/pci/devices/0000:0d:00.0/reset_method
         # echo 1 > /sys/bus/pci/devices/0000:0d:00.0/reset

Without the invalidation, a HDM-DB region can be created the device
with the BI Enable register cleared.

         # echo region0 > /sys/bus/cxl/devices/decoder0.0/create_ram_region
           (geometry, mode, dpa_size elided)
         # echo decoder2.0 > /sys/bus/cxl/devices/region0/target0
         # echo 1 > /sys/bus/cxl/devices/region0/commit

The eventual unbind then grumbles about the state it inherited:

         cxl_pci 0000:0d:00.0: BI already disabled in hardware

With the invalidation, target0 write is now refused:

         cxl region0: mem0:decoder2.0 BI not enabled on device
         cxl_port endpoint2: failed to attach decoder2.0 to region0: -6

and the unbind is quiet. After a manual rebind:

         # echo 0000:0d:00.0 > /sys/bus/pci/drivers/cxl_pci/bind
         cxl_pci 0000:0d:00.0: BI requests enabled

>
>Should we covery this value in the reset path or rerun BI path setup ?
>
>Best regards,
>Richard Cheng.
>
>> +
>> +static int cxl_bi_ctrl_endpoint_enable(struct cxl_dev_state *cxlds)
>> +{
>> +	return __cxl_bi_ctrl_endpoint(cxlds, true);
>> +}
>> +
>> +static int cxl_bi_ctrl_endpoint_disable(struct cxl_dev_state *cxlds)
>> +{
>> +	return __cxl_bi_ctrl_endpoint(cxlds, false);
>> +}
>> +
>> +/*
>> + * devm teardown on endpoint port destruction. Endpoint decoders may
>> + * still be committed here (cxl_workqueue tears them down
>> + * asynchronously), but memory access has been quiesced.
>> + */
>> +static void cxl_bi_dealloc(void *data)
>
>Hi Davidlohr,
>
>Few questions in my mind.

Thanks again for all your feedback!

>
>This function disables BI, but does it detach the active region or its HDM decoder ?
>I think no ?
>
>devres register the cleanup functions after the decoder autoremove actions, devres will
>run  cxl_bi_dealloc() first and then cxld_unreigster().
>
>To me it seems that this leave an active HDM-DB region with BI disabled, though temporarily.
>I think the users of the region should be stopped first before cxl_bi_dealloc() runs ?
>Should BI cleanup run after the decoder and region have been detached ?

Right. So by moving cxl_bi_setup() before the decoder setup, the teardown action is
registered first and therefore the dealloc runs last. BI setup itself has no dependency
on the decoders; it only needs the BI register mappings and the dport chain.

@@ -177,18 +177,20 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
         if (rc)
                 return rc;
  
-       rc = devm_cxl_endpoint_decoders_setup(port);
-       if (rc)
-               return rc;
-
         /*
-        * Must precede region discovery so that any firmware-committed BI
-        * decoder is adopted before its region is assembled.
+        * Registers the BI teardown action before the decoders' so
+        * devres, unwinding in reverse, brings BI down after them.
+        * Must also precede region discovery, adopting any
+        * firmware-committed BI decoder before its region is assembled.
          */
         rc = cxl_bi_setup(port);
         if (rc)
                 dev_dbg(&port->dev, "BI setup failed rc=%d\n", rc);
  
+       rc = devm_cxl_endpoint_decoders_setup(port);
+       if (rc)
+               return rc;
+
         /*
          * With VH (CXL Virtual Host) topology the cxl_port::add_dport() method
          * handles RAS setup for downstream ports. With RCH (CXL Restricted CXL

Thanks,
Davidlohr
