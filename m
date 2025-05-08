Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13741ACED9
	for <linux-cxl@vger.kernel.org>; Thu,  8 May 2025 04:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746679870; cv=pass; b=bAF5zjZrFt5AC4dyZCkIddFkttGfF6GQwMm6wmz2WpizE/Cp3ovFOmvjwFDoFpTmHcNsHhW7hVxnzjwJ2wpUcyDgTeedw7E/jDt968Cm4W5976dhTA1VHscu0dYdiyEVs5BAWzKNjX/2lwZVmrHVlkYHd/dLJXND64wkxJgGLUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746679870; c=relaxed/simple;
	bh=tR5KL1at/9snMfS7IKFaEG1DNq6kbi6q2LpufhXB+vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqqJj8h+5r0Ekbr5RJK9UtvnHA6rKSOaelEKzD5ge4NCCVbOfIIrBxhtPuiyC3Is5MEvYnyfklOH5sseTRS4HeZcshUnooGHsdtmkp0KtXNAagri9/IVC9daJKc5bbVrB5nkz+vBBW4tb5aSJK+jBfb2yz8YT7OMNoAjLRK1Iss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=KewErmpm; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="KewErmpm"
ARC-Seal: i=1; a=rsa-sha256; t=1746679854; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DWH4dF5yGul9ffSnnV5hHe5hUmKoNbgghSHEh3BN33Ww8HXamr0SrUoEzG3mW2FRUxagpxMuoyhd52JqX8H65nIws2SwsEbC4h/6gcBF7bLop0YvsLKQdgWjKNq6o5kaHsTMRTi1hgCPWo7DNAXL6etNhYCcF1nCtkYNXPihYdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746679854; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vIT3A0xNUjz/IpznAuoHWpxXBPNCYTUczCVvMzCh1sc=; 
	b=lvGjKZpskm2A8hHi6RMDIcSw+Mrl3KwZlTqioyLtWbNZwvdQaSuyeTUfCseF9bBxAQrmUBHtj6MeEDteJfa4ugriuUvIGTJG+P+4tJ/xBj7MeazPvMZs9coR+7JTkCQjhw85W7P8VjBGH3+d3u0XvQn4tF23iqBftKdnMb0ITxY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746679854;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=vIT3A0xNUjz/IpznAuoHWpxXBPNCYTUczCVvMzCh1sc=;
	b=KewErmpmCNR/GPAoz3o8AJm+XLKgZYr+oEzK5laz+i4DCIY86KFQD/ZXVTamCapR
	2tbYupt0nzWaeLL3+3b9doX7Pu3r+20qs+j+a9zevi3eSsvgP1aTqkD6Om28RHeXOc5
	OBSeseff9jSZwGSid8dduZmpoUVHAfwt+iMx2CxI=
Received: by mx.zohomail.com with SMTPS id 1746679851415665.1585881764859;
	Wed, 7 May 2025 21:50:51 -0700 (PDT)
Message-ID: <9aefbf37-c648-4662-a459-29eea2c9947d@zohomail.com>
Date: Thu, 8 May 2025 12:50:46 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment
 and registers probing
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, linux-cxl@vger.kernel.org
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-6-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250507004310.3536991-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227a7c9ee36d7d03c841a3d375c000081378bb6929c8d678f7f8709adf324dfc67c3aec931b29b163:zu08011227710fffbc2326e53a9701064c0000c32a13679d506f0e8c7f2edb859095dfbc60d9025511ad4706:rf0801122d78c450cf97ea4e1fd20b021d0000eabeff9a9471e49d832abf7e98646f826261b5633b48801f94035df97b62ce:ZohoMail
X-ZohoMailClient: External

On 5/7/2025 8:43 AM, Dave Jiang wrote:
> Current implementation only enumerates the dports during the port probe.
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
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport.
>
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Fix spelling error in commit message. (Ming)
> - Move probing to the specific dport. (Ming)
> - Add decoder update.
> - Return errors when setup dports. (Jonathan)
> - Add driver check before setup dport. (Dan)
> - Add comment on why location to do dport update. (Dan)
> ---
>  drivers/cxl/core/core.h |   4 ++
>  drivers/cxl/core/pci.c  |  60 ++++++++++++----
>  drivers/cxl/core/port.c | 152 +++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h       |   4 ++
>  drivers/cxl/port.c      |  20 +-----
>  5 files changed, 192 insertions(+), 48 deletions(-)
>
[snip]
>  
> +static int port_probe_dport(struct cxl_port *port, struct device *dport_dev,
> +			    struct cxl_dport **probed_dport)
> +{
> +	struct cxl_dport *dport;
> +	unsigned long index;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +	xa_for_each(&port->dports, index, dport) {
> +		if (dport->dport_dev == dport_dev) {
> +			rc = cxl_dport_setup(dport);
> +			if (rc)
> +				return rc;
> +			*probed_dport = dport;
> +			return 0;
> +		}
> +	}
> +
> +	*probed_dport = NULL;
> +
> +	return -ENODEV;
> +}

feels like the parameter struct cxl_dport **probed_dport is not needed, the function can return the struct cxl_dport on success, return errno on failure.


> +
> +static int update_switch_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	int i;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	for (i = 0; i < cxld->interleave_ways; i++) {
> +		if (cxlsd->target_map[i] == dport->port_num) {
> +			cxlsd->target[i] = dport;
> +			return 0;
> +		}
> +	}
> +
> +	dev_dbg(dev, "Updating decoder target_map with %s and none found\n",
> +		dev_name(dport->dport_dev));
> +
> +	return 0;
> +}
> +
> +static int update_decoders_with_dport(struct cxl_port *port, struct cxl_dport *dport)
> +{
> +	device_lock_assert(&port->dev);
> +	return device_for_each_child(&port->dev, dport, update_switch_decoder);
> +}
> +
> +int devm_cxl_port_setup_decoders(struct cxl_port *port)
> +{
> +	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
> +	unsigned long index;
> +	int dports = 0;
> +
> +	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> +	if (!IS_ERR(cxlhdm))
> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +
> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
> +		return PTR_ERR(cxlhdm);
> +	}
> +
> +	xa_for_each(&port->dports, index, dport)
> +		dports++;
> +
> +	if (dports == 1) {
> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> +		return devm_cxl_add_passthrough_decoder(port);
> +	}
> +
> +	dev_err(&port->dev, "HDM decoder capability not found\n");
> +	return -ENXIO;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_setup_decoders, "CXL");
> +
> +static int cxl_switch_port_dport_setup(struct cxl_port *port,
> +				       struct device *dport_dev)
> +{
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	device_lock_assert(&port->dev);
> +
> +	if (!port->dev.driver)
> +		return -ENODEV;
> +
> +	rc = port_probe_dport(port, dport_dev, &dport);
> +	if (rc)
> +		return rc;
> +
> +	cxl_switch_parse_cdat(port);
> +
> +	/* Make sure that no decoders have been allocated before proceeding. */
> +	if (ida_is_empty(&port->decoder_ida))
> +		rc = devm_cxl_port_setup_decoders(port);
> +	else
> +		rc = update_decoders_with_dport(port, dport);
> +	if (rc)
> +		return rc;
> +
> +	return 0;

Can return rc directly here, no need to check rc before return 0.


Ming

[snip]

