Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBCB3955CF
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143624; cv=pass; b=jcecG4KJJGNk9JWCYCpPOZpKdK4y5D0Y8TPHftWOijRSZTeF4z1w0QmUInNhXvem3pufVg1yZm3JIwqszTsK3gjQjSd5XA/I/qjo3ZOl/3MkEKwW480Azl9DWtMSVnzqn7zpSbaByOqg5dawdEbH2n5cyoj5YW5D7HcaYXKox0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143624; c=relaxed/simple;
	bh=Ye/SGgi0SE2Lp3bxsZf9SBN2UWqQwnj3I39W7gR7/tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUSI7R9wXASZT3Gpp8pjF2ND2HhdauGnVPDjyB1CmAaB49x3JZvENkmiBZQ1/J4J6x6eJXqrG1KeaY589jnBQH4ZBpKASqbPHIFVZWyh1+Xra1n6HQOTmq09jH3xGRDD7FYbxEeTi2MEZXh4+m7C5aZbaemq6QO5bR6s/VQ8jOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=LFXnzz5I; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="LFXnzz5I"
ARC-Seal: i=1; a=rsa-sha256; t=1790143612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eRlP6J2KXUp4DMu2TH5av4+mB7a9U48zYy637brSxEUNsRqR+uziEFKPjz5X8Fn7b3FwLdhrG88Gko7f0xLfKEIxNz8GnFBnscDMGmHa880U01Z3ly6ikX99V50tzomndoFByQGy9BN5G2l/zhxkoKrZ2TrbTw149vGWKdUVCGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790143612; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/7xn8s91vgpRYkAk/xUWCGQhnGjOl1Apcekn5yopVHc=; 
	b=SAp6MJU+S8pNMF8Cy5VoqtSO1F/rAmidhpYnM/1t8oQ9PAB2Nn/dne4UZBjIlTmKRMUIPvBAUYk42j60qqS/Ao4Q7tL5zotp8gbAn2u1EGpXZhROzQEZ6oTvFGjs8UY745JF4Zk6nZkhRKcFlWMg7AG9Ykx0LhDljjM9C1zoom4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790143612;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=/7xn8s91vgpRYkAk/xUWCGQhnGjOl1Apcekn5yopVHc=;
	b=LFXnzz5IHk1qzx7CK28qIvWZ7/qvUaqcYx7EsqD4empNIxruu97+70IawLRZRoIv
	5Otq7HMo4AeuybJ/W5eD2yzTlk0ulYARbWxTp8rnx7d9yxPQK06tfZLKU4lNXVUOz9Q
	6izd20QXLS156HI4v31PlkuRAMA6s0zJCB8idm70=
Received: by smtp.zohomail.com with SMTPS id 1790143611174194.58057088860164;
	Tue, 22 Sep 2026 23:06:51 -0700 (PDT)
Message-ID: <1e681988-e64a-4ab5-97f6-5b595d029a93@zohomail.com>
Date: Wed, 23 Sep 2026 14:06:44 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/10] cxl/hdm: Add BI coherency support for endpoint
 decoders
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1790103847.git.dave@stgolabs.net>
 <ebc907df26d229138fb46051e5b9f4a2299b6432.1790103847.git.dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <ebc907df26d229138fb46051e5b9f4a2299b6432.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227a4cfedbd156ed37675e64b630000affe8d42339a1705d47a7d3c4333d759a1f7b878cd043cf2f3:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/9/23 07:38, Davidlohr Bueso 写道:
> Cache the HDM decoder's Supported Coherency Models on struct cxl_hdm.
> A later patch has region attach consult it to verify the HDM supports
> the region's coherency type.
>
> For uncommitted endpoint decoders, init_hdm_decoder() defaults
> target_type from supported_coherency: Type 3 devices default to
> HDM-DB when the HDM is device-coherent-only, HDM-H otherwise.
>
> Pre-committed decoders with the BI bit set are refused. cxl_bi_setup()
> does not yet take over a path firmware already enabled, so nothing
> verifies that such a decoder's topology can route BISnp.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>

> ---
>   drivers/cxl/core/core.h |  1 +
>   drivers/cxl/core/hdm.c  | 35 ++++++++++++++++++++++++-----------
>   drivers/cxl/cxl.h       |  8 +++++++-
>   drivers/cxl/cxlmem.h    |  2 ++
>   4 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index ef41632d7b7d..d0f352899903 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -221,6 +221,7 @@ struct cxl_hdm;
>   int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>   			struct cxl_endpoint_dvsec_info *info);
>   int cxl_port_get_possible_dports(struct cxl_port *port);
> +enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled);
>   
>   #ifdef CONFIG_CXL_FEATURES
>   struct cxl_feat_entry *
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0e9d652b568e..18200a8f3f72 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -87,6 +87,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>   		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
>   	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
>   		cxlhdm->iw_cap_mask |= BIT(16);
> +	cxlhdm->supported_coherency =
> +		FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK, hdm_cap);
>   }
>   
>   static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> @@ -968,6 +970,19 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>   	return 0;
>   }
>   
> +enum cxl_decoder_type cxled_default_type(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_dev_state *cxlds = cxled_to_memdev(cxled)->cxlds;
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +
> +	if (cxlds->type == CXL_DEVTYPE_CLASSMEM &&
> +	    cxlhdm->supported_coherency != CXL_HDM_DECODER_COHERENCY_DEV)
> +		return CXL_DECODER_HOSTONLYMEM;
> +
> +	return CXL_DECODER_DEVMEM;
> +}
> +
>   static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			    void __iomem *hdm, int which,
>   			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
> @@ -1023,6 +1038,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		else
>   			cxld->target_type = CXL_DECODER_DEVMEM;
>   
> +		/*
> +		 * Autocommit BI-enabled decoders is not supported. A path
> +		 * firmware enabled is not taken over, so nothing verifies
> +		 * it can route BISnp.
> +		 */
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
> +			return -ENXIO;
> +
>   		guard(rwsem_write)(&cxl_rwsem.region);
>   		if (cxld->id != cxl_num_decoders_committed(port)) {
>   			dev_warn(&port->dev,
> @@ -1040,17 +1063,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		port->commit_end = cxld->id;
>   	} else {
>   		if (cxled) {
> -			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -			struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -
> -			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> -			 */
> -			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> -				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> -			else
> -				cxld->target_type = CXL_DECODER_DEVMEM;
> +			cxld->target_type = cxled_default_type(cxled);
>   		} else {
>   			/* To be overridden by region type at commit time */
>   			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ad7c991f0f9b..a990ed41edef 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -50,7 +50,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   #define CXL_BI_RT_CAPABILITY_LENGTH 0xC
>   #define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
>   
> -/* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
> +/* HDM decoders CXL 4.0 8.2.4.20 CXL HDM Decoder Capability Structure */
>   #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>   #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>   #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> @@ -58,6 +58,11 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
>   #define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
>   #define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
> +#define   CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK GENMASK(22, 21)
> +#define     CXL_HDM_DECODER_COHERENCY_UNKNOWN 0x0
> +#define     CXL_HDM_DECODER_COHERENCY_DEV 0x1
> +#define     CXL_HDM_DECODER_COHERENCY_HOST 0x2
> +#define     CXL_HDM_DECODER_COHERENCY_BOTH 0x3
>   #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>   #define   CXL_HDM_DECODER_ENABLE BIT(1)
>   #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> @@ -72,6 +77,7 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
>   #define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>   #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
> +#define   CXL_HDM_DECODER0_CTRL_BI BIT(13)
>   #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>   #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>   #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..33bac6bbdb59 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -857,6 +857,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>    * @target_count: for switch decoders, max downstream port targets
>    * @interleave_mask: interleave granularity capability, see check_interleave_cap()
>    * @iw_cap_mask: bitmask of supported interleave ways, see check_interleave_cap()
> + * @supported_coherency: HDM Decoder Capability supported coherency models
>    * @port: mapped cxl_port, see devm_cxl_setup_hdm()
>    */
>   struct cxl_hdm {
> @@ -865,6 +866,7 @@ struct cxl_hdm {
>   	unsigned int target_count;
>   	unsigned int interleave_mask;
>   	unsigned long iw_cap_mask;
> +	unsigned int supported_coherency;
>   	struct cxl_port *port;
>   };
>   
