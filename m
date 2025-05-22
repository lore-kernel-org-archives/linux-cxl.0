Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188533DB
	for <linux-cxl@vger.kernel.org>; Thu, 22 May 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747911360; cv=pass; b=ukkvP7xAHKdyOWT/1HNlTg/J0buBNZZSnvrM2mQIxZsKYvHGOQgVqQZ8xr4E+/xx+8UmMpc0FTWZ5VgF4aJl1jxscK39TJxr/9OvxF1Pel+hxgJNMw+Tyfl67K0zhgdRPFY182gWIZASOoobdPWNdTnsrS9rQLgIdJo8DK/0J6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747911360; c=relaxed/simple;
	bh=Zk6ujc4OMU4NxP4wt3FCUWjyDu29nR3G+Xd1qRaaSZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9NnvY3HqrbLuo7rA3AE+NvjIElUyxwq42A2W3ofF+wnjpQOkLCTSOVjB5PdgUCnmgnAF0MfFgWwrZz+MY/yDoX2/WsFyZ/wKIRtMjTNHZ+thdFuI2LzMQ5GmYlvbZCmks1DWO0smBDRKaqCNVQiNEg4F54txNuRMyxDI7wOqRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=BMbx5hbg; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="BMbx5hbg"
ARC-Seal: i=1; a=rsa-sha256; t=1747911349; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WBhMqLFc6iEZ4iZxqQ6hQHX76mVf6TM+MGWxpty0EIM1vVIsa8UImu4TZxThRzCm0k0ahBjmtndK7gfM8Mt586DocAUHFELOLgG/cSWM3wC+XR3S88b5wYWC5BA7QWTEOm5LA7qr/rmXGB6r4thuRNroJ4a2hi8BxTx9bUlIBmU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747911349; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/9NIu7PHLwtli5MCKSPR4Tdp9l42XHea8CNOuHxB3FQ=; 
	b=YKl2CSfquPRBduT6NuOUzpECE2mTiZ4RzZaL5Nibn5zWKWwB6n0GFv6iyAeUEQx5nDHmA4PYAwgqGXfCfC6lVj88ObJXr/KyNUO9dfl5q7sRtVboKyOCTNja+8P9Lz6XLfA3/3Qz+P5JSCWVvPe7ieLRoBn05RBxqUjOI/yWqiI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747911349;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=/9NIu7PHLwtli5MCKSPR4Tdp9l42XHea8CNOuHxB3FQ=;
	b=BMbx5hbgo3hNJQVCG0h8e5OKbjoeIFpi7eVxXe0RErH3tTpPx4481Gp4BnyoNbR2
	/tFrkVweIQZmkmxsYpUnxSB2m02NvvSUNo4ipoykaTLRCxL59GWrOTSLIxqrtOYd0ie
	jiGTQcXMV+iwjnXN106DcLd4wqT8Dg+EnLY3Griw=
Received: by mx.zohomail.com with SMTPS id 1747911347578901.4094277563157;
	Thu, 22 May 2025 03:55:47 -0700 (PDT)
Message-ID: <475052ab-f85b-448b-8a5b-4e0b59a8d282@zohomail.com>
Date: Thu, 22 May 2025 18:55:44 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] cxl: Defer hardware dport->port_id assignment and
 registers probing
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-6-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250521183443.3828320-6-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227ecd93627a0297456e6ee5ca300008a5b4df40ccfd94a88ab66e9ae5efd3d3bfb11d99f362ff109:zu080112272c09ac5d84e086a3b5fc5a4c0000a2ab48611764d534593f59772aa221c1622d3c0b2ca9cf7f98:rf0801122d9d8398a6fde8bab99b3a05150000fa35b681083c242583b759390305777af8b7083955e754ed776e78537ab544:ZohoMail
X-ZohoMailClient: External

On 5/22/2025 2:34 AM, Dave Jiang wrote:
> Current implementation only enumerates the dports during the port probe.
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
>
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a root port from the
> ACPI0017.N device. Through that it enumerate downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> use add_host_bridge_uport() to create the ports that enumerates the PCI
> root ports as the dports of these ports. Every time a port is created,
> the port driver is attached and drv->probe() is called and
> devm_cxl_port_enumerate_dports() is envoked to enumerate and probe
> the dports.
>
> The second phase is if there are any CXL switches. When the pci endpoint
> device driver (cxl_pci) calls probe, it will add a mem device and triggers
> the cxl_mem->probe(). cxl_mem->probe() calls devm_cxl_enumerate_ports()
> and attempts to discovery and create all the ports represent CXL switches.
> During this phase, a port is created per switch and the attached dports
> are also enumerated and probed.
>
> The last phase is creating endpoint port which happens for all endpoint
> devices.
>
> In this commit, the port create and its dport probing in cxl_acpi is not
> changed. That will be handled in a different patch later on. The behavior
> change is only for CXL switch ports. Only the dport that is part of the
> path for an endpoint device to the RP will be probed and marked as active
> by having a valid dport->port_num. This happens naturally by the code
> walking up the device hierarchy and identifying the upstream device and
> the downstream device.
>
> Locking of port device wraps the cxl_switch_port_dport_setup() to
> protect modifications against the port and its dports while multiple
> endpoints can be probing at the same time and the same port is being
> modified concurrently.
>
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant. With this behavior, only a dport that points to a valid
> endpoint path would be probed. Of course the decoder enumeration and
> SSLBIS parsing is also delayed until the dport is probed since it needs to
> know the port_num and also be able to read the registers.
>
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
>
> The success return value of devm_cxl_port_enumerate_dports() has been
> changed to always 0 since no caller is using the return value of dports
> enumerated for anything in the current code now.
>
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
[snip]
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

There is a nr_dports in cxl_port, maybe we can use it instead of this xa_for_each().

Other looks good to me.

Reviewed-by: Li Ming <ming.li@zohomail.com>


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

