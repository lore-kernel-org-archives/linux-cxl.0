Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F1182D7
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751942; cv=pass; b=uP3jgQyZUa3EtHrgYPf32phE+j7QxpIoew3dfiIq+m3gJqnengfIJ38B4dYsmniOi+KnErKQifutPKXzJp9gOn+wqWIhV6tzFhb8NJ1gfNJwdKcOC+8ZGxjh3yXut81lt3ebOYQ9Cv036L4p0DBVmVHI6eKgvqTShp6d3qc3s+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751942; c=relaxed/simple;
	bh=xFqx45g+6NJoEtfEQ8pKmFDnFhW+0VEa6Mkk104Vyhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmExC1TiJ6ioTeZHrUqhRuZIuc8sCBWBAdIPCkZHrqBp2EFF2Z9kjHSozzNW5V9bSLBeqRA5rtmEKzIkdODaCBAOn0NTKWtWtdwQIjNTjWCAOXiD8UYZopWFTE3wvk/He12BBCugLf4noeTX5WDFjuNT0skredtiFtVQa0VKExU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=NECDgPDV; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="NECDgPDV"
ARC-Seal: i=1; a=rsa-sha256; t=1746751925; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=me2wErQCiQ8y8dcFYYb1VJsHjeG0HyL+MwYlc185Wmin27NJaJoixiPKHU2E++iUaeivJkV4g5or63kDF9hlSBUCG5vufd6vi0zOcVd7sacesGn4sHY/CdmClEG/z2TvzM17UEz2Jql/3k+U6THaVvLuIRRWsdMC8ReWTUK9jmI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746751925; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Qbv2DWJKvIt+O4wWUFK6GfBSByOH1lJ4L42eRUG1SCs=; 
	b=WDST2Jjlck2QJVFWYdtSkvP+0s3ZHFasJAMnmHfqEsGCL9QInyxLKOaoHDybMMjRxpeOwlN6tKwC02EA8eEiwDw0nfI2tFnpkVXq0xaB6iz0y7XwqW33utzYIht6rSJVATZOOEu4R9UXtTcaDUarkr9JdvvtitiEdQ1V/nRANSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746751925;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Qbv2DWJKvIt+O4wWUFK6GfBSByOH1lJ4L42eRUG1SCs=;
	b=NECDgPDVOO/lhoYdQkLPFq0RHtttK2bJAG0H0auieNs97zvtE5ELP3pX8Ou2MTfr
	+jZRJ2ZiVAOKv1v99eReuo3LJACZUtzcHFkuw9l3+k8we2ioigjdESjNv2gRHZo2egW
	qv9XwdHRS9fZRUs4K9mh3zSjXAqoGS1c5T9U7S8E=
Received: by mx.zohomail.com with SMTPS id 1746751922224438.1993326104216;
	Thu, 8 May 2025 17:52:02 -0700 (PDT)
Message-ID: <399c1afb-35be-4706-b4d8-43260cf6743f@zohomail.com>
Date: Fri, 9 May 2025 08:51:58 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, linux-cxl@vger.kernel.org
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250507004310.3536991-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227135c9f16c1520baa84aaf154000049ce0c6c7440013363b48ef87d5ab2a74857198ba6a8a94eb3:zu08011227d60bed321509777fc1ab0f31000049624f3717a6cdc5608b4824fe070be4e9cbf6bcc90dcc3625:rf0801122ded11f9ab3fb7e0e0bd6343e90000319989a01f31e6d3b21ce2ef897ab387e5177aa02a8ff6d89f4fed9624d367:ZohoMail
X-ZohoMailClient: External

On 5/7/2025 8:43 AM, Dave Jiang wrote:
> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_num to maintain compatibility and
> introduce a dport->id as the enumeration id.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Rename port_id to port_num. (Dan)
> - Use a dport allocator to deal with ida allocation. (Dan, Jonathan)
> ---
>  drivers/cxl/core/cdat.c |  2 +-
>  drivers/cxl/core/hdm.c  | 18 +++++-----
>  drivers/cxl/core/port.c | 73 ++++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h       | 12 ++++---
>  4 files changed, 71 insertions(+), 34 deletions(-)
>
[snip]
>  static struct cxl_dport *
>  __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> -		     int port_id, resource_size_t component_reg_phys,
> +		     int port_num, resource_size_t component_reg_phys,
>  		     resource_size_t rcrb)
>  {
>  	char link_name[CXL_TARGET_STRLEN];
> @@ -1139,17 +1170,19 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> +	dport = cxl_alloc_dport(port, dport_dev);
> +	if (!dport)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = devm_add_action_or_reset(&port->dev, free_dport, dport);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", dport->id) >=
>  	    CXL_TARGET_STRLEN)
>  		return ERR_PTR(-EINVAL);
Is it better to call devm_release_action(&port->dev, free_dport, dport) here if snprintf() failed?

>  
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> -		return ERR_PTR(-ENOMEM);
> -
> -	dport->dport_dev = dport_dev;
> -	dport->port_id = port_id;
> -	dport->port = port;
> +	dport->port_num = port_num;
>  
>  	if (rcrb == CXL_RESOURCE_NONE) {
>  		rc = cxl_dport_setup_regs(&port->dev, dport,
> @@ -1211,7 +1244,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   * devm_cxl_add_dport - append VH downstream port data to a cxl_port
>   * @port: the cxl_port that references this dport
>   * @dport_dev: firmware or PCI device representing the dport
> - * @port_id: identifier for this dport in a decoder's target list
> + * @port_num: identifier for this dport in a decoder's target list
>   * @component_reg_phys: optional location of CXL component registers
>   *
>   * Note that dports are appended to the devm release action's of the
> @@ -1219,12 +1252,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   * switch ports)
>   */
>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> -				     struct device *dport_dev, int port_id,
> +				     struct device *dport_dev, int port_num,
>  				     resource_size_t component_reg_phys)
>  {
>  	struct cxl_dport *dport;
>  
> -	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> +	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
>  				     component_reg_phys, CXL_RESOURCE_NONE);
>  	if (IS_ERR(dport)) {
>  		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
> @@ -1455,7 +1488,7 @@ static void reap_dports(struct cxl_port *port)
>  	xa_for_each(&port->dports, index, dport) {
>  		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>  		devm_release_action(&port->dev, cxl_dport_remove, dport);
> -		devm_kfree(&port->dev, dport);
> +		devm_release_action(&port->dev, free_dport, dport);
>  	}
>  }
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a9ab46eb0610..f4fe523aaf12 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -583,6 +583,7 @@ struct cxl_dax_region {
>   * @regions: cxl_region_ref instances, regions mapped by this port
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
> + * @dport_ida: allocator for dport ids
>   * @reg_map: component and ras register mapping parameters
>   * @nr_dports: number of entries in @dports
>   * @hdm_end: track last allocated HDM decoder instance for allocation ordering
> @@ -603,6 +604,7 @@ struct cxl_port {
>  	struct xarray regions;
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
> +	struct ida dport_ida;
>  	struct cxl_register_map reg_map;
>  	int nr_dports;
>  	int hdm_end;
> @@ -655,7 +657,8 @@ struct cxl_rcrb_info {
>   * struct cxl_dport - CXL downstream port
>   * @dport_dev: PCI bridge or firmware device representing the downstream link
>   * @reg_map: component and ras register mapping parameters
> - * @port_id: unique hardware identifier for dport in decoder target list
> + * @id: Linux id to enumerate dport instances per port
> + * @port_num: unique hardware identifier for dport in decoder target list
>   * @rcrb: Data about the Root Complex Register Block layout
>   * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>   * @port: reference to cxl_port that contains this downstream port
> @@ -667,7 +670,8 @@ struct cxl_rcrb_info {
>  struct cxl_dport {
>  	struct device *dport_dev;
>  	struct cxl_register_map reg_map;
> -	int port_id;
> +	int id;
> +	int port_num;
>  	struct cxl_rcrb_info rcrb;
>  	bool rch;
>  	struct cxl_port *port;
> @@ -750,10 +754,10 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>  
>  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> -				     struct device *dport, int port_id,
> +				     struct device *dport, int port_num,
>  				     resource_size_t component_reg_phys);
>  struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
> -					 struct device *dport_dev, int port_id,
> +					 struct device *dport_dev, int port_num,
>  					 resource_size_t rcrb);
>  
>  #ifdef CONFIG_PCIEAER_CXL


