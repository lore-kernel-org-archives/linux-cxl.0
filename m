Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF2222599
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790210994; cv=pass; b=RqWb/AYP5baOd68SvRXKKzB73BZW8EwrehyDAtOVLy1XtNsBzGMyrEszvWVroEkxUzuW8bzF6A/pgAx/36Q94f1QVUci5EG1tilsHpA24Fwur3htj7grmgdoUhSalKLsNFA1hBtigxAcZcm5N5iMPnykcA4oqxr5KBDx5JGOpVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790210994; c=relaxed/simple;
	bh=jUnauJ5Ec7Lzts8nKH2r5xt5B0yC+VNyZ83TS+Xm2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mk9wfJpX/v34eN0s9rKm9WVAvDnheaVCOpjssT0Unv14lO9xbVxNcgfO6hZjBp+f97gGusznbub7lcTiY1U542ha2fOesMPm92XvCCf3uAigw5vzzvbP779+8RKgm1jOJRbtLbQ1Kghl+4kfXMbrdJbD1S1K+0RltYQf0OuKXEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WWqV7uMG; arc=pass smtp.client-ip=165.173.182.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WWqV7uMG"
ARC-Seal: i=1; a=rsa-sha256; t=1790210983; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n6AOzhwHW6XrWWLfdvzRCX3CnGRcbz5NbEaEmcdOejcwvaYTK3fAaYe/AAHA+KlF8nf71rI8fUCk437/3+yjMeORY6aiunIdH/vNXza/TQ4dTucKxl9MsvbArCoceiRzvqnbUA+zWYnJUd9Xw4uaK/zFf/qgSbxOUiFq6lMRu+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790210983; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LWh7M8rcCgM2DmkGAV9dpVPX2AYN8Z36ni6nLaTLGsU=; 
	b=EKVhijAn0xKnim2cZ338SBzK+wV6+sI922RAF8wKlmLEJSTS/noQj9uf0Mmp0dXmH2eWB4TZzqTqnz06POf6x+3ttXnk5SjArCyBRD/oteIJcmzciGfE+qjRYq64FHNw8z9ED8ScsuTyb//OYIepU2+6bKtKwyh3lKPFVMapJ5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790210983;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=LWh7M8rcCgM2DmkGAV9dpVPX2AYN8Z36ni6nLaTLGsU=;
	b=WWqV7uMGkCHJWw4aJEETZRCBOmtakiljhsqz5XEkRiMkp3qpC1H4ZgYE8XMtf2CV
	FPVLIVA4wUdxhxIgST0Qcehj910o/W1xbQxwcSGaXRJrSFmLKARFPeVYbI8E2cRS1c1
	PUJTCVcXcIYu8gCVpKs6dabm4IXXGKBkgzmMEhfo=
Received: by smtp.zohomail.com with SMTPS id 1790210981492647.5971778267209;
	Wed, 23 Sep 2026 17:49:41 -0700 (PDT)
Message-ID: <13c2684b-87fc-42cc-b4fd-98406ccb6c20@zohomail.com>
Date: Thu, 24 Sep 2026 08:49:36 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/10] cxl/pci: Split BI capability probe from setup
To: Davidlohr Bueso <dave@stgolabs.net>, dave.jiang@intel.com
Cc: jic23@kernel.org, alison.schofield@intel.com, icheng@nvidia.com,
 benjamin.cheatham@amd.com, alucerop@amd.com, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1790103847.git.dave@stgolabs.net>
 <c61a057a45837e29c53cc8cd4e15df8712439011.1790103847.git.dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <c61a057a45837e29c53cc8cd4e15df8712439011.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu0801122762a85c0089922a12b23bbfc40000c8aec61c77cae8689a9fa9ff050eceac823c7d3c257a6e9627:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 9/23/2026 7:38 AM, Davidlohr Bueso wrote:
> Decouple the topology read-only capability verification phase from
> cxl_bi_setup() into cxl_bi_probe_capable(), recording the result in
> cxlds->bi_capable.
>
> This allows further dealing with auto-committed BI hdm decoders;
> having such knowledge upon decoder enumeration time.
>
> No functional change intended.
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/pci.c | 40 +++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h      |  1 +
>  drivers/cxl/port.c     |  1 +
>  include/cxl/cxl.h      |  2 ++
>  4 files changed, 33 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f3ca9861a7ba..9bf05820c142 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -1332,34 +1332,38 @@ void cxl_bi_reset_detected(struct cxl_port *endpoint)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_bi_reset_detected, "CXL");
>  
> -int cxl_bi_setup(struct cxl_port *endpoint)
> +/*
> + * Verify the device and every component in the path up to the root
> + * are BI capable.
> + */
> +void cxl_bi_probe_capable(struct cxl_port *endpoint)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	struct cxl_dport *dport = endpoint->parent_dport;
>  	struct cxl_dport *dport_iter;
>  	struct cxl_port *port_iter;
> -	int rc;
> +
> +	cxlds->bi_capable = false;
>  
>  	if (!dev_is_pci(cxlds->dev))
> -		return 0;
> +		return;
>  
>  	/* BI is VH-only */
>  	if (cxlds->rcd)
> -		return 0;
> +		return;
>  
>  	if (!cxl_is_bi_capable(to_pci_dev(cxlds->dev),
>  			       endpoint->regs.bi_decoder))
> -		return 0;
> +		return;
>  
> -	port_iter = dport->port;
> -	dport_iter = dport;
> +	dport_iter = endpoint->parent_dport;
> +	port_iter = dport_iter->port;
>  	while (!is_cxl_root(port_iter)) {
>  		/* check rp, dsp */
>  		if (!cxl_is_bi_capable(to_pci_dev(dport_iter->dport_dev),
>  				       dport_iter->regs.bi_decoder)) {
>  			dev_dbg(cxlds->dev, "BI not supported by topology\n");
> -			return 0;
> +			return;
>  		}
>  
>  		/* check usp */
> @@ -1370,13 +1374,13 @@ int cxl_bi_setup(struct cxl_port *endpoint)
>  					       NULL)) {
>  				dev_dbg(cxlds->dev,
>  					"BI not supported by USP\n");
> -				return 0;
> +				return;
>  			}
>  			if (port_iter->reg_map.component_map.bi_rt.valid &&
>  			    !port_iter->regs.bi_rt) {
>  				dev_dbg(cxlds->dev,
>  					"BI RT advertised but unmapped\n");
> -				return 0;
> +				return;
>  			}
>  		}
>  
> @@ -1384,6 +1388,20 @@ int cxl_bi_setup(struct cxl_port *endpoint)
>  		port_iter = dport_iter->port;
>  	}
>  
> +	cxlds->bi_capable = true;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_bi_probe_capable, "CXL");
> +
> +int cxl_bi_setup(struct cxl_port *endpoint)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
> +	struct cxl_dport *dport = endpoint->parent_dport;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	int rc;
> +
> +	if (!cxlds->bi_capable)
> +		return 0;
> +
>  	rc = cxl_bi_enable_path(cxlds, dport->port, dport);
>  	if (rc)
>  		return rc;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3639cd2daf0c..5ab2f9c39f5c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -962,6 +962,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
>  			     struct access_coordinate *c2);
>  
>  bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> +void cxl_bi_probe_capable(struct cxl_port *endpoint);
>  int cxl_bi_setup(struct cxl_port *endpoint);
>  void cxl_bi_reset_detected(struct cxl_port *endpoint);
>  struct cxl_dport *devm_cxl_add_dport_by_dev(struct cxl_port *port,
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index eab935eca9b1..8e58adbc2e29 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -170,6 +170,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	cxl_endpoint_parse_cdat(port);
>  
>  	devm_cxl_port_bi_setup(port);
> +	cxl_bi_probe_capable(port);
>  
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index f9e9058a85da..d0f03f305072 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -170,6 +170,7 @@ struct cxl_dpa_partition {
>   * @cxl_dvsec: Offset to the PCIe device DVSEC
>   * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>   * @bi: device is BI (Back-Invalidate) enabled
> + * @bi_capable: device and topology path are BI capable
>   * @media_ready: Indicate whether the device media is usable
>   * @dpa_res: Overall DPA resource tree for the device
>   * @part: DPA partition array
> @@ -190,6 +191,7 @@ struct cxl_dev_state {
>  	int cxl_dvsec;
>  	bool rcd;
>  	bool bi;
> +	bool bi_capable;
>  	bool media_ready;
>  	struct resource dpa_res;
>  	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];


