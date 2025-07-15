Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617B828C5A9
	for <linux-cxl@vger.kernel.org>; Tue, 15 Jul 2025 01:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752543549; cv=pass; b=Xoq7EeYN0h2eFbRREFV0CH0Rk5JsMyTHkxB6DGoYskzu4IBRGXcg3m8bUy9FqKUhtOvKAcZbfENBK0iFVsrjItzFNcfKpyGmKEKHMzlEIZh/gtAgwiv6Opw/nqiVXVaZCgdZOD0B69W8Otl3mNC1z69a7OOIHUSOQ/Teb+sWj2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752543549; c=relaxed/simple;
	bh=XTpzMK5jDMkx+GNrvfapNqer1lXNdh6OmlXmP01t3Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX/z2VI4NBDu2cHPfZpgmnraxSrcvddggMYAPi9ehVkTP4l6ZoIY24eCfsCetx6pn240qadKToMRjnhOuNnNrpEZvG3bIE2dMQAemzhhf9pG4T6+ceqUFNTMpQOtum7gDWfitPVTiKyPlIMiaDTWon4ZPrmezXpWlAT/Qc12DVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FTbCXxPi; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FTbCXxPi"
ARC-Seal: i=1; a=rsa-sha256; t=1752543535; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=emBD83AaZKSHPLOoVzPVo+UbtnDi1q28aQ1v7SIo+eNwGOwD1YeadoOzhsRFYBlUeRVeRuDGkboRFlpHVICwF3bEI+XbHv44l+LmaJxJf4HyvN5TfbCyXHoT0HCEvGvv25UV/ckqOaqNRcv9Hd1cH+iYU/wr+VltzfygbU6U+GE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752543535; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XTpzMK5jDMkx+GNrvfapNqer1lXNdh6OmlXmP01t3Wk=; 
	b=hZmBYVZI4d7zUvLmaKhXGw20ORWd4kK5zjGAms3alMQewmW8GVDrvjlhX++55yF4mKXG5kQBIGBJFwRCG7GACDwSnSUmwvdZXWFEtDNWKV+sdray8gva8W2lmXhphsTPaQLEC1FJc5Lm4s1HcSdtm3T+/F7teppDKeEyzkFqr/4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752543535;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=XTpzMK5jDMkx+GNrvfapNqer1lXNdh6OmlXmP01t3Wk=;
	b=FTbCXxPi69PDyQb4vphA6SYneKKmugCReRETME5ttO3rxKKdYHCXw5FnrV9IH/Uf
	5IpmmeAhqhjHjrOF8ZmJtFHKbnzg33s4PkwzG/Do5hw0x4AH3HuY5UCyYBtpnesfqsj
	cagnrCK1Avz/K99LnsTO+CfKdwQatRoAC2+qDfGc=
Received: by mx.zohomail.com with SMTPS id 1752543532331873.3725764471425;
	Mon, 14 Jul 2025 18:38:52 -0700 (PDT)
Message-ID: <c25aa2ba-ab5d-46ea-b678-abb9577bc60e@zohomail.com>
Date: Tue, 15 Jul 2025 09:38:49 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/10] cxl: Defer dport allocation for switch ports
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250714223527.461147-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227db6dd2be472d93bc7ee283900000b2aacbc4b4bf59115c94fd00203c6cb5c9b06c05485842c0c8:zu08011227d3d8dcbaed9500def012cf97000001db4915e2075c1644c7665702864a9e3033ac59a766abca59:rf0801122d899839b6cf95b59d4ee1a9140000e27d8b77e770df9366278ca5700a47aeb3bb375dbf21a49ce8a5c010ddfcab:ZohoMail
X-ZohoMailClient: External

On 7/15/2025 6:35 AM, Dave Jiang wrote:
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
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
