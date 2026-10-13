Received: from bumble.birch.relay.mailchannels.net (bumble.birch.relay.mailchannels.net [23.83.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EE5328B8
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906679; cv=none; b=F92V2EfprVQWg+laNKib7iEki9FjFwOq4v3vxl+ARlGMoWqcq9oFAL3pHTF8ZvuAXBsRhAuckBgd/gr8BmxgFug6yqGJFI28cSyY2D0cz9hBpb0grkKkD7mSXLwYQZN1cNngkm/jmNGxfqJ7BMjdzyTBuy/E4Xyz1ped7o+HiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906679; c=relaxed/simple;
	bh=ahMUCuujPAxawFznO+6DQhEJY5jy1Ttnmc9O5oArtig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlEJDMbkC/sTP7Pgg/FOCg381dmY+F+GhaUhv2YPkCqvr7p4wcfLpg2jYS/TjiJ/ZMq8iyJ8bycaL0oYdpwunwae+mLzIeqzgI7ist4+evbZNtEIKbJOA/pESAdxjPP2MTuTVqeC20Pq/adsaTmTalGtvlR4R36YEBpaM4fbfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=fJnKWEmw; arc=none smtp.client-ip=23.83.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="fJnKWEmw"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D71AC3827D1;
	Tue, 13 Oct 2026 14:34:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (100-100-69-187.trex-nlb.outbound.svc.cluster.local [100.100.69.187])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6F0D238265B;
	Tue, 13 Oct 2026 14:34:21 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Cooing-Whispering: 247cc30d1f6baed0_1791902065688_3970985056
X-MC-Loop-Signature: 1791902065688:1831258091
X-MC-Ingress-Time: 1791902065688
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.69.187 (trex/8.0.2);
	Tue, 13 Oct 2026 14:34:25 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4j3xg05hxvz105F;
	Tue, 13 Oct 2026 07:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1791902061;
	bh=0i9AZM8OXSBrpXtm3iRYM2IMIfoJKPPXCYcUeyr6TfA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fJnKWEmwHwKBD9fgnMZDaiOkycVdHWVryTaQf+JWsSncieAcYR9mi/LBAwfX5mIHn
	 5bziKkJXMuIeE+ifODTm0pvDOgOHakDyrUtFTiyRK3Ubc2IpFYHzEplfg50iyoN8Kv
	 CvPs7uPJVCqseXhQkfmcNTiAjZGbK+INvi70bmtGOKCNDV+ImQeWeBTychvS/hXiBI
	 fxTIB90J8nI5Br3xYSUmABdVR7GhCqODDkRfNa2EsIFgMUp9ujoy+Mkwpw2DYQNgNS
	 80OhB1S3bqcIjgXNjZzlqzVtvyxHva/vV5AqCTnnvz1BUmkWJuvhL/8jitNVc51tFt
	 dtqKQHgTWYh9Q==
Date: Tue, 13 Oct 2026 07:34:17 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Richard Cheng <icheng@nvidia.com>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com,
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v9 02/10] cxl/pci: Add BI topology enable/disable
Message-ID: <20261013143417.ukmry7evjoef3jji@offworld>
References: <cover.1790103847.git.dave@stgolabs.net>
 <d87ff01d77dacc7c0a0d20aaebb1ce906c968b91.1790103847.git.dave@stgolabs.net>
 <art5JoFbkTv7PT39@MWDK4CY14F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <art5JoFbkTv7PT39@MWDK4CY14F>
User-Agent: NeoMutt/20220429

On Tue, 29 Sep 2026, Richard Cheng wrote:

>On Tue, Sep 22, 2026 at 04:38:39PM +0800, Davidlohr Bueso wrote:
>> +/*
>> + * devm teardown on endpoint port destruction. Registered before the
>> + * decoders, so devres runs it after them: regions are detached and
>> + * decoders unregistered by the time BI comes down.
>> + */
>> +static void cxl_bi_dealloc(void *data)
>> +{
>> +	struct cxl_port *endpoint = data;
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct cxl_dport *dport_iter;
>> +	struct cxl_port *port_iter;
>> +
>> +	cxl_bi_ctrl_endpoint_disable(cxlds);
>> +	cxlds->bi = false;
>> +
>
>
>Is it safe to disable BI unconditionally ?
>
>For a FW-configured HDM-DB region with locked decoders, resetting decoders can
>leave the HW mapping active. If that memory is boot System RAM, it can remain
>in use after driver unbind, while the cleanup here disable BI.
>
>I think one of the scenario is when decoders are boot-programmed and locked.
>FW could configure such a range with BI enabled and expose it
>
>Should we preserve BI when those locked mapping remain active ?

The HDM decoder BI bit is RWL, while the BI Decoder/RT are not locked; which
makes this a policy decision, afaict.

So your example scenario makes sense not to disable the endpoint, but the same
applies to the dports, essentially making cxl_bi_dealloc() a nop for the locked
BI enabled HDM decoder. In terms of BI-ID this seems ok as the device is actually
not dissapearing.

Is this something we want? Should the spec pronounce itself in the cases of
locked decoders?

Thoughts?

Thanks,
Davidlohr

----8<-----------------------
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index c57c6474a8a1..77c14801d4d8 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -231,4 +231,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
  
  resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
  					   struct cxl_dport *dport);
+bool cxl_bi_enabled(struct cxl_port *endpoint);
+
  #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4a504afbf78b..f71f625282b6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1355,6 +1355,15 @@ static int cxl_bi_enable_path(struct cxl_dev_state *cxlds,
  	return rc;
  }
  
+/* the device's BI Enable as the hardware has it right now */
+bool cxl_bi_enabled(struct cxl_port *endpoint)
+{
+	void __iomem *bi = endpoint->regs.bi_decoder;
+
+	return FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
+			 readl(bi + CXL_BI_DECODER_CTRL_OFFSET));
+}
+
  /*
   * An SBR wipes the device's BI Enable; an FLR leaves it alone.
   * The check is against the hardware, not decoder state: BI is
@@ -1366,13 +1375,11 @@ void cxl_bi_reset_detected(struct cxl_port *endpoint)
  {
  	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	void __iomem *bi = endpoint->regs.bi_decoder;
  
  	if (!cxlds->bi)
  		return;
  
-	if (FIELD_GET(CXL_BI_DECODER_CTRL_BI_ENABLE,
-		      readl(bi + CXL_BI_DECODER_CTRL_OFFSET)))
+	if (cxl_bi_enabled(endpoint))
  		return;
  
  	dev_warn(cxlds->dev, "BI disabled by reset\n");
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index da83700f81ca..41bba6da5321 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -361,6 +361,23 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
  		}
  	}
  
+	/* a reset during the commits: only the device can tell */
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+
+		if (cxlr->type == CXL_DECODER_DEVMEM &&
+		    cxl_root_decoder_is_bi(cxlr->cxlrd) &&
+		    !cxl_bi_enabled(cxled_to_port(cxled))) {
+			dev_err(&cxlr->dev,
+				"%s:%s BI disabled by reset during commit\n",
+				dev_name(&cxlmd->dev),
+				dev_name(&cxled->cxld.dev));
+			cxl_region_decode_reset(cxlr, p->nr_targets);
+			return -ENXIO;
+		}
+	}
+
  	return 0;
  
  err:
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 575fcad47a6a..25e73da19402 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -822,6 +824,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
  	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
  	int id = cxld->id, rc;
+	u32 ctrl;
  
  	if (cxld->flags & CXL_DECODER_F_ENABLE)
  		return 0;
@@ -865,6 +868,17 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
  	port->commit_end++;
  	cxld->flags |= CXL_DECODER_F_ENABLE;
  
+	/* an armed Lock On Commit fires here, not at enumeration */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	if ((ctrl & CXL_HDM_DECODER0_CTRL_LOCK) &&
+	    (ctrl & CXL_HDM_DECODER0_CTRL_BI) &&
+	    is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxled_to_memdev(cxled)->cxlds->bi_locked = true;
+	}
+
  	return 0;
  }
  
@@ -1057,6 +1071,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  		cxld->flags |= CXL_DECODER_F_ENABLE;
  		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
  			cxld->flags |= CXL_DECODER_F_LOCK;
+
+		/* Lock On Commit froze this BI bit set */
+		if (cxled && (cxld->flags & CXL_DECODER_F_LOCK) &&
+		    (ctrl & CXL_HDM_DECODER0_CTRL_BI))
+			cxled_to_memdev(cxled)->cxlds->bi_locked = true;
+
  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
  		else
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2e1a7ebae35c..d099cc5b1c1e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1305,6 +1305,15 @@ static void cxl_bi_dealloc(void *data)
  	struct cxl_dport *dport_iter;
  	struct cxl_port *port_iter;
  
+	/*
+	 * A locked HDM decoder keeps its BI bit set and keeps decoding
+	 * after this driver lets go, and BI Enable is the device-wide
+	 * permission behind it, so neither it nor the levels forwarding
+	 * for it are released.
+	 */
+	if (cxlds->bi_locked)
+		return;
+
  	cxl_bi_ctrl_endpoint_disable(cxlds);
  	cxlds->bi = false;
  
@@ -1478,6 +1489,16 @@ int cxl_bi_setup(struct cxl_port *endpoint)
  	if (!cxlds->bi_capable)
  		return 0;
  
+	/*
+	 * A locked decoder already has this device's BI-ID routed and no
+	 * new BI device is being enabled, so nothing below is owed a
+	 * commit (CXL 4.0 Tables 8-152 and 8-156).
+	 */
+	if (cxlds->bi_locked) {
+		dev_dbg(cxlds->dev, "BI held by a locked decoder\n");
+		return 0;
+	}
+
  	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
  	if (rc)
  		return rc;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index d0f03f305072..6bdf02e92aa7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -171,6 +171,7 @@ struct cxl_dpa_partition {
   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
   * @bi: device is BI (Back-Invalidate) enabled
   * @bi_capable: device and topology path are BI capable
+ * @bi_locked: a locked HDM decoder has BI set, so BI outlives each binding
   * @media_ready: Indicate whether the device media is usable
   * @dpa_res: Overall DPA resource tree for the device
   * @part: DPA partition array
@@ -192,6 +193,7 @@ struct cxl_dev_state {
  	bool rcd;
  	bool bi;
  	bool bi_capable;
+	bool bi_locked;
  	bool media_ready;
  	struct resource dpa_res;
  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
