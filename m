Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824F203706
	for <linux-cxl@vger.kernel.org>; Tue,  8 Jul 2025 06:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955704; cv=pass; b=n5s78BNygYrFsg6e9b+/5xVQHmzMtxFMRALKs2ONDSio3mEL8DijcRrFtRlYoblFaXsL5SMlKK9up38sJQlE0QzHiA8jyJLDlC6KIEyWhdd4HxWo33q5iIDUwzepGeF+A32SieNQGDgNs0QYKQWWI5iUC5BnvJDxPvFZ7Knwe0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955704; c=relaxed/simple;
	bh=p/HdCsMISzpxP4ocym3Zp+mv1m0dFNhXwqUxpMtIg2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmfxlLDeA7p4FkWaRSMlDr4VPKdjFDYZxBmS4oAmfa5LAnQE+dIcVM25w+x8W9fcShltROcD1Y+3d/Z3dL0oGaOQ25Hj7mAYXTk1GGK1gGFY7SQnhHszJA7OZ233rXXZwriN+BmBzUgEYElDInDTEh1wKSFZbXCXPEW4/KUqYZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=eHLMOCFS; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="eHLMOCFS"
ARC-Seal: i=1; a=rsa-sha256; t=1751955687; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CXXKbe0tTEUuZT582dgAKIP9j0CuyxSXzWMn2L42VXtPoEp/3pGVj88tWRew6N6Zi92mXDvLsqb2h6YOS+5y7q8lszbz7odLR0JJw6losrT4vczlcmPK3YyiA5Eq222b6DlnSSG4R0/wBXkZ7tnavwzbLHJ7hIf+kI62iCT948I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751955687; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IDXq2qLCrbksq68GWsehGLDB5re/kaLHFCLwWG+B3hw=; 
	b=OV2GzLhm+Jcs6pQNAhWHBqUspijzJOpiyL6TB8Qa+2M9QSHXotBxxrymIOf7mW1i3kTjHcWOa69nsgNf1aIAK8yRx7QJ+6jaFo9A+VSN4c925XDpZFcwVhrfvYawsyr3sbJaPpxpRDp+xl+PjR157tXXlKdAgVA/jQ/Www1rJ9o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751955687;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=IDXq2qLCrbksq68GWsehGLDB5re/kaLHFCLwWG+B3hw=;
	b=eHLMOCFSXvRVmSfUrMpiHVPhsYTBVnFOO/BWtKuDHHHYNCTiF+leBjkYWpvBB2R+
	4qJnUZpAqK0ofXkwYxG+SZJCq5KYSvyJGHXpQJFVKP2RJWAHT+WrxAKKKSjC2NzAFK2
	tkgZ9op+y1F6fdUiGyYVkNLBT1WKSxX0G5w7TAf0=
Received: by mx.zohomail.com with SMTPS id 1751955685633673.0331114324216;
	Mon, 7 Jul 2025 23:21:25 -0700 (PDT)
Message-ID: <32e809fe-ff98-4b27-96e3-119b8e83414f@zohomail.com>
Date: Tue, 8 Jul 2025 14:21:18 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] cxl: Defer dport allocation for switch ports
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250703232710.3141436-1-dave.jiang@intel.com>
 <20250703232710.3141436-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250703232710.3141436-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112276700503485ac82163a215a6e00002277ae8aa0ece0d31ab89dea0a911b085d4a3f1bf184a5c48b:zu0801122788a4869b346040519568aece0000c75c09aaebcecfef475ab511840324c160acab47e4b279f02e:rf0801122d5ede52686a03dc669addb60d0000e3637c40277ba1853ef7e5e2331d6ac43dd85e3d5c0b88ae7b5f1b81592e22:ZohoMail
X-ZohoMailClient: External

On 7/4/2025 7:27 AM, Dave Jiang wrote:
> The current implementation enumerates the dports during the cxl_port
> driver probe. Without an endpoint connected, the dport may not be
> active during port probe. This scheme may prevent a valid hardware
> dport id to be retrieved and MMIO registers to be read when an endpoint
> is hot-plugged. Move the dport allocation and setup to behind memdev
> probe so the endpoint is guaranteed to be connected.
>
> In the original enumeration behavior, there are 3 phases (or 2 if no CXL
> switches) for port creation. cxl_acpi() creates a Root Port (RP) from the
> ACPI0017.N device. Through that it enumerate downstream ports composed
> of ACPI0016.N devices through add_host_bridge_dport(). Once done, it
> use add_host_bridge_uport() to create the ports that enumerates the PCI
> RPs as the dports of these ports. Every time a port is created, the port
> driver is attached and drv->probe() is called and
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
> path for an endpoint device to the RP will be probed. This happens
> naturally by the code walking up the device hierarchy and identifying the
> upstream device and the downstream device.
>
> There are two points where the interception of dport creation happens
> during the devm_cxl_enumerate_ports() path. The first location is right
> before the function calls add_port_attach_ep() where it does the dport
> allocation for the RP. Once the dport is allocated, the iteration path
> is reset to the beginning to try again. The second location happens
> in add_port_attach_ep() after the location where either the port is
> discovered or allocated new if it does not exist.
>
> Locking of port device during __cxl_port_add_dport() protects modifications
> against the port and its dports while multiple endpoints can be probing at
> the same time and the same port is being modified concurrently.
>
> While the decoders are allocated during the port driver probe,
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport. A
> guard(rwsem_write) is used to update decoder targets. This is similar to
> when decoder_populate_target() is called and the decoder programming
> must be protected.
>
> Link: https://lore.kernel.org/linux-cxl/20250305100123.3077031-1-rrichter@amd.com/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Change cxl_port_get_total_dports() to cxl_port_update_total_dports(). (Jonathan)
> - Return dport for the devm_cxl_port_add_dport() and friends. (Jonathan)
> ---
>  drivers/cxl/core/core.h |   2 +
>  drivers/cxl/core/pci.c  |  88 +++++++++++++++++++
>  drivers/cxl/core/port.c | 184 ++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h       |   5 ++
>  drivers/cxl/port.c      |   8 +-
>  5 files changed, 273 insertions(+), 14 deletions(-)
>
[snip]
> +#define CXL_ITER_LEVEL_SWITCH	1
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
>  	struct device *iter;
> -	int rc;
> +	int rc, i;
>  
>  	/*
>  	 * Skip intermediate port enumeration in the RCH case, there
> @@ -1643,7 +1787,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	 * attempt fails.
>  	 */
>  retry:
> -	for (iter = dev; iter; iter = grandparent(iter)) {
> +	for (i = 0, iter = dev; iter; i++, iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
>  		struct cxl_dport *dport;
> @@ -1686,9 +1830,28 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			if (!dev_is_cxl_root_child(&port->dev))
>  				continue;
>  
> +			/*
> +			 * This is a corner case where the rootport is setup but
> +			 * the switch dport is not. It needs to go back to the
> +			 * beginning to setup the switch port.
> +			 */
> +			if (i >= CXL_ITER_LEVEL_SWITCH) {
> +				struct cxl_port *pport __free(put_cxl_port) =
> +					cxl_mem_find_port(cxlmd, &dport);
> +				if (!port)
> +					goto retry;
should be "if (!pport)" here?
> +			}
> +
>  			return 0;
>  		}
>  
> +		dport = devm_cxl_add_dport_for_rp(uport_dev, dport_dev);
> +		/* Added a dport, restart enumeration */
> +		if (!IS_ERR_OR_NULL(dport))
> +			goto retry;
> +		if (IS_ERR(dport))
> +			return PTR_ERR(dport);
> +

This part is a little bit complicated. My understanding is that devm_cxl_add_dport_for_rp() is invoked only for uport_dev == cxl host bridge case, and below add_port_attach_ep() is invoked only for uport_dev == cxl switch USP case, is it?

If yes, maybe it is better to use a if {} else {} block here? like

if (uport_dev is host bridge) {

    devm_cxl_add_dport_for_rp();

} else {

    add_switch_port_attach_ep();

}


Ming

[snip]

