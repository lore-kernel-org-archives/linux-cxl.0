Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260427BF78
	for <linux-cxl@vger.kernel.org>; Fri, 11 Apr 2025 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744338076; cv=pass; b=ersAFzTY3jJrCy6dPpPyThqF058Rwb6mRKkmtFAGRoiUPh6oDwwlGfJX325yaXJ2Fx3fTFBMwYTtPhXrMexyAIUsK49siwXdWUeO//AotDghIYRJxJCyRL24yWxC1DP3c9mTPyZ4ADAo+lMjtxh9KQ33yBvYjyC082UFHpcEepo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744338076; c=relaxed/simple;
	bh=IVjiiNmnmz3g/TKrqy7ClAaZmTCNQ+osaTwJCOsyDH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svDsTbJFv4egWEiNKGqCke1kW+LW+lJKrN+qb9gGzatvg1jNYAahBdln9a9YiMYvyopX3rhAoXDGzqO/0hQENMzgZCFLnDz9M9WpldMgbcUx5kyxTvygNz8R3ChXuyn1PgDPBmKj3a/VfOn2i6XsFsLyICYdMq58ve5UzDijxAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=PZxwmG8O; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="PZxwmG8O"
ARC-Seal: i=1; a=rsa-sha256; t=1744338061; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kwhIQLpPuFOXo4QK6oppb27EwWOVCi9bTo7f04Zju588BN19ARyhRarED5dyus1Z5UtCwjkOkMi4kpBR1fnTvDCQdzDE0nxFOc6HBVbW7v984eM564sX2yG5RHQ2tc8KJNpjkWLKySr5M+XH6bBn3e9kk16om+5f00JVFF/E5gI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744338061; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=41Z77AVSrFCAqmTTjTRzH2ndWL8wsU+7YTMtN8Qh76c=; 
	b=YK1rx4xbJ9P59HR05sfR5n/npuL3ZlkdcaaT8sMh47g9vQQ0xnhJjZtf56yYuuxZnADUpyvo8cGoRoYpnOyj/8ks4zmnqwAcZjQvtpcx15wduSEXuz0x0G61TSOyh6IcbrsqMNYo9kvgM8WVBTUimmJoVYRtGv7OeRVVR0RZbbk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744338061;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=41Z77AVSrFCAqmTTjTRzH2ndWL8wsU+7YTMtN8Qh76c=;
	b=PZxwmG8OY3Lu+br3O9eHJ5rdV1QcwYiOLek7k4JrD7Zf499Vfe6g5z2X0+dbuJCK
	auzQfn04ihaull+GSO+dydJ+CI45gIwcmFjxOYBPrp21ODTL+qZqibhO7q4cAjVM0a+
	ZirIodEhM5hC0qNUgrIPg7VOOHffeXroexTbKg04=
Received: by mx.zohomail.com with SMTPS id 1744338059610547.4801842820748;
	Thu, 10 Apr 2025 19:20:59 -0700 (PDT)
Message-ID: <651172c0-8a5c-4aa4-98cf-073ff425d291@zohomail.com>
Date: Fri, 11 Apr 2025 10:20:57 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl: Defer hardware dport->port_id assignment and
 registers probing
To: Dave Jiang <dave.jiang@intel.com>
Cc: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
 linux-cxl@vger.kernel.org
References: <20250404230049.3578835-1-dave.jiang@intel.com>
 <20250404230049.3578835-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250404230049.3578835-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122719ab1c0b2f09132399b755ee0000410bdbf2c2ba5d36413ef88310ef7608e74da327ab6638dcf7:zu08011227b60173762f1fda52759dd43f0000396e3cf7fedae6a1f902cbe20a9489dd652b07584cfc3b48ac:rf0801122dca02f3670a611bbcd00bc2080000807159c7e16410562193fd0ed7c262ffd3e4452db96aad66c4f9ce0cc8e951:ZohoMail
X-ZohoMailClient: External

On 4/5/2025 6:57 AM, Dave Jiang wrote:
> Current implementation only enuemrates the dports dupring the port probe.
s/dupring/during
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
>
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h |  4 ++
>  drivers/cxl/core/pci.c  | 74 ++++++++++++++++++++++++++++------
>  drivers/cxl/core/port.c | 88 ++++++++++++++++++++++-------------------
>  drivers/cxl/cxl.h       |  1 +
>  drivers/cxl/port.c      |  2 -
>  5 files changed, 114 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15699299dc11..e2822ead6a67 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -134,4 +134,8 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
> +		    resource_size_t rcrb);
> +void cxl_port_probe_dports(struct cxl_port *port);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 96fecb799cbc..a47dd032abd7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -24,6 +24,66 @@ static unsigned short media_ready_timeout = 60;
>  module_param(media_ready_timeout, ushort, 0644);
>  MODULE_PARM_DESC(media_ready_timeout, "seconds to wait for media ready");
>  
> +static int probe_dports(struct cxl_dport *dport)
maybe rename it to probe_dport(), because it just probes one dport.
> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	struct cxl_register_map map;
> +	struct pci_dev *pdev;
> +	u32 lnkcap, port_num;
> +	int rc;
> +
> +	if (!dev_is_pci(dport_dev))
> +		return 0;
> +
> +	/*
> +	 * dport->port_id is valid means that dport has been probed and is
> +	 * setup.
> +	 */
> +	if (dport->port_id != CXL_PORT_ID_INVALID)
> +		return 0;
> +
> +	pdev = to_pci_dev(dport_dev);
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap))
> +		return 0;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc) {
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +		return 0;
> +	}
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +	rc = cxl_dport_probe(dport, map.resource, CXL_RESOURCE_NONE);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * port_id is only set if the register block is also probed
> +	 * successfully.
> +	 */
> +	dport->port_id = port_num;
> +	cxl_switch_parse_cdat(port);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_port_probe_dports - probe downstream ports of the upstream port
> + * @port: cxl_port whose ->uport_dev is the upstream of dports to be probed
> + *
> + */
> +void cxl_port_probe_dports(struct cxl_port *port)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +
> +	device_lock_assert(&port->dev);
> +	xa_for_each(&port->dports, index, dport)
> +		probe_dports(dport);
> +}
> +

This function is called during each endpoint attaching, I am a little confused that it probes all dports under the port at the same time during a new endpoint attaching to the port.

Per commit log, hardware dport id and MMIO registers are available only when an endpoint connects, seems like probing other dports which no endpoint connects is redundant. is it possible to just probe the dport which the attaching endpoint is under?

Maybe I miss some details, please correct me if I am wrong.

>  struct cxl_walk_context {
>  	struct pci_bus *bus;
>  	struct cxl_port *port;
> @@ -37,10 +97,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  	struct cxl_walk_context *ctx = data;
>  	struct cxl_port *port = ctx->port;
>  	int type = pci_pcie_type(pdev);
> -	struct cxl_register_map map;
>  	struct cxl_dport *dport;
> -	u32 lnkcap, port_num;
> -	int rc;
>  
>  	if (pdev->bus != ctx->bus)
>  		return 0;
> @@ -48,16 +105,9 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		return 0;
>  	if (type != ctx->type)
>  		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap))
> -		return 0;
>  
> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	if (rc)
> -		dev_dbg(&port->dev, "failed to find component registers\n");
> -
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
> +	dport = devm_cxl_add_dport(port, &pdev->dev, CXL_PORT_ID_INVALID,
> +				   CXL_RESOURCE_NONE);
>  	if (IS_ERR(dport)) {
>  		ctx->error = PTR_ERR(dport);
>  		return PTR_ERR(dport);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e90e55bc11ac..1c772c516dbe 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1059,18 +1059,9 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)
>  
>  static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>  {
> -	struct cxl_dport *dup;
>  	int rc;
>  
>  	device_lock_assert(&port->dev);
> -	dup = find_dport(port, dport->port_id);
> -	if (dup) {
> -		dev_err(&port->dev,
> -			"unable to add dport%d-%s non-unique port id (%s)\n",
> -			dport->port_id, dev_name(dport->dport_dev),
> -			dev_name(dup->dport_dev));
> -		return -EBUSY;
> -	}
>  
>  	rc = xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
>  		       GFP_KERNEL);
> @@ -1120,6 +1111,45 @@ static void cxl_dport_unlink(void *data)
>  	sysfs_remove_link(&port->dev.kobj, link_name);
>  }
>  
> +int cxl_dport_probe(struct cxl_dport *dport, resource_size_t component_reg_phys,
> +		    resource_size_t rcrb)
> +{
> +	struct device *dport_dev = dport->dport_dev;
> +	struct cxl_port *port = dport->port;
> +	int rc;
> +
> +	if (rcrb == CXL_RESOURCE_NONE) {
> +		rc = cxl_dport_setup_regs(&port->dev, dport,
> +					  component_reg_phys);
> +		if (rc)
> +			return rc;
> +	} else {
> +		dport->rcrb.base = rcrb;
> +		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
> +							 CXL_RCRB_DOWNSTREAM);
> +		if (component_reg_phys == CXL_RESOURCE_NONE) {
> +			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> +			return -ENXIO;
> +		}
> +
> +		/*
> +		 * RCH @dport is not ready to map until associated with its
> +		 * memdev
> +		 */
> +		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> +		if (rc)
> +			return rc;
> +
> +		dport->rch = true;
> +	}
> +
> +	if (component_reg_phys != CXL_RESOURCE_NONE)
> +		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
> +			&component_reg_phys);
> +
> +	return 0;
> +}
> +
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		     int port_id, resource_size_t component_reg_phys,
> @@ -1162,40 +1192,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	dport->port = port;
>  	dport->id = id;
>  
> -	if (rcrb == CXL_RESOURCE_NONE) {
> -		rc = cxl_dport_setup_regs(&port->dev, dport,
> -					  component_reg_phys);
> -		if (rc) {
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(rc);
> -		}
> -	} else {
> -		dport->rcrb.base = rcrb;
> -		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
> -							 CXL_RCRB_DOWNSTREAM);
> -		if (component_reg_phys == CXL_RESOURCE_NONE) {
> -			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(-ENXIO);
> -		}
> -
> -		/*
> -		 * RCH @dport is not ready to map until associated with its
> -		 * memdev
> -		 */
> -		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
> -		if (rc) {
> -			ida_free(&port->dport_ida, id);
> -			return ERR_PTR(rc);
> -		}
> -
> -		dport->rch = true;
> +	rc = cxl_dport_probe(dport, component_reg_phys, rcrb);
> +	if (rc) {
> +		ida_free(&port->dport_ida, id);
> +		return ERR_PTR(rc);
>  	}
>  
> -	if (component_reg_phys != CXL_RESOURCE_NONE)
> -		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
> -			&component_reg_phys);
> -
>  	cond_cxl_root_lock(port);
>  	rc = add_dport(port, dport);
>  	cond_cxl_root_unlock(port);
> @@ -1684,6 +1686,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  				"found already registered port %s:%s\n",
>  				dev_name(&port->dev),
>  				dev_name(port->uport_dev));
> +
> +			scoped_guard(device, &port->dev)
> +				cxl_port_probe_dports(port);
Just like above comment, is it possible to be cxl_port_probe_dport(port, dport) here?
> +
>  			rc = cxl_add_ep(dport, &cxlmd->dev);
>  
>  			/*
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c942fa40c869..0e61b76f5c13 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -345,6 +345,7 @@ enum cxl_decoder_type {
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
>  #define CXL_QOS_CLASS_INVALID -1
> +#define CXL_PORT_ID_INVALID -1
>  
>  /**
>   * struct cxl_decoder - Common CXL HDM Decoder Attributes
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a35fc5552845..30c0335089b9 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -69,8 +69,6 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	if (rc < 0)
>  		return rc;
>  
> -	cxl_switch_parse_cdat(port);
> -
>  	cxlhdm = devm_cxl_setup_hdm(port, NULL);
>  	if (!IS_ERR(cxlhdm))
>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);


