Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0351607B4
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737760793; cv=fail; b=Co/DW2R7zZ8OJmiIWQ54mnb90a2NAFf9XxhB5UN7A/b9tAhpitVe1xXWK5RfEYoW8i4s0HBEHSQZpuAW5neXXvTPkBRLFd/4rxnLxTYe+vnkuHYvwzKi0Lnm/SlnuQLqcaUJWVDkatYdu+t6x53WNjS4HEt3gTJhLUuBP4Ggrws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737760793; c=relaxed/simple;
	bh=IqWQstYi3TCDBE7oKADCtNgZR6lhLM5p9bqM6LukroU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q11X75hlh0imRRUTwU5xo/qdk7NsIlJ7KgV/cyNiJQJy7iikBSvu9YTI7O1Whg6hlycNcYUG48a0z+HjoA+5ObZ8CdMkPhUOYPn4Z21DtAZ08lFqZt9N9urm1jK2lGtDW2t2V2QRRaseYG7zx/WpTtMwng+yJ2SaLZUcAe0lag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=TWOVnH6i; arc=fail smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="TWOVnH6i"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AA8F382166;
	Fri, 24 Jan 2025 23:19:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a309.dreamhost.com (100-118-213-203.trex-nlb.outbound.svc.cluster.local [100.118.213.203])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 192F881E63;
	Fri, 24 Jan 2025 23:19:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1737760790; a=rsa-sha256;
	cv=none;
	b=c++NrTwxjVYQqYcbUsmeoqWBaNrYa4uNl9MCpRS22NPXmRRaaRVX9IlzfXbd5+dS6x6meH
	Tp6d4OwkzjnhFvFTjJOAIwEjfTTgQJvYfh8AOQRoqDKk/ZV2fvSsg/X9OZ4/t1Cvsdnte8
	iDZXv4CoGNjc/xK+YUj9qU0sqUD+9hIdYgst63CFDclzyDA0abZb7anWIQgL2gSUGlaVZ2
	oqbzhdRznoCiOLDyYVn6ovPsM6+JQxKYg9npKsvVDEfxQBdlbMIO7CSQn8pTltAYkeeuQp
	tsja770KED/JvkNGnbZb8ekrbLv7eE4qNEsk4jSUVh7/Duu5Hlv4ZfS1wW0I9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1737760790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=swj/VNwqkAvJ3ug9nU0NDeBQTKRYu2Kpfmu61tIOTTY=;
	b=IQEbrqBYpFinaX9awNKnAKQXex7mE5PAswYzKnJtn/ZpwSU89tJI5iF0WA/O0vrzN2imcX
	khtzCqDowakTMtaTPmQs/ZgpAe7DS1n0Wc1DPSxXhhpIVh7vMMQa9MD9c8wX92mqqn00RJ
	su8bWjicr+q1n7yNHH/i8/45kNFm5fxeN70bhd3ybtl4A70hncxObSnZF3KNjwMZFiaQaW
	ugqmJP0vTtA5hXB0TJ+gwBmw1ju2Lgni5rW5F+T5JxIafvObT2dGXGHxn8KhEhTIsopjFM
	uoeciBx9RiDPf8lFPtvwKvbuN6M1Aix00MZXxIuHHPYEha9FaYxvuC1F35XHXw==
ARC-Authentication-Results: i=1;
	rspamd-66b8d7c865-q2mwm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Quick: 246a03ed2466876d_1737760790432_529832772
X-MC-Loop-Signature: 1737760790431:1877652665
X-MC-Ingress-Time: 1737760790431
Received: from pdx1-sub0-mail-a309.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.213.203 (trex/7.0.2);
	Fri, 24 Jan 2025 23:19:50 +0000
Received: from offworld (unknown [104.36.29.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a309.dreamhost.com (Postfix) with ESMTPSA id 4Yfv0h5qC3z36;
	Fri, 24 Jan 2025 15:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1737760789;
	bh=1jqElMEwMae15EVuEbzFytWKTnClKwDbN5ViKetAPVQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=TWOVnH6i2nZTUQJrJtUHvDENfsvmIvfnqXgWLQSwEeEe+WrOvmzMyWQQ76nCVII2e
	 MjUPOjJ/ub0s7CvVtexn+q4Ke46QhD6kh01Ow2RjvCw7WktknwfKr9sQ/Nw/Z8oXgO
	 vPBf9SY2032QfF8kkKY/Z7uPJYJtNxqhN9OWNZCuxfIAajuK/p02Uc0yZNPOh9b45r
	 qyl+jB8Pd6tAq0eKsr6LV2Ha7D8GHQ9ZFtRjxmf+02bg+DcAO/lBwdPTJx4WLRWLI2
	 z++Pjb4kMGESd/kXiSAntKFLKkNNTIjYc91HlfEUNtBfvyaLFKd2vpRjmovaKQHWo3
	 q9QLB6AtzCHtw==
Date: Fri, 24 Jan 2025 15:19:45 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Dan Williams <dan.j.williams@intel.com>
Cc: dave.jiang@intel.com, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, seven.yi.lee@gmail.com, hch@infradead.org,
	a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3] cxl/pci: Support Global Persistent Flush (GPF)
Message-ID: <20250124231945.77pnqslva7qesxws@offworld>
References: <20250121042531.776377-1-dave@stgolabs.net>
 <67901f97e604d_20fa29489@dwillia2-xfh.jf.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <67901f97e604d_20fa29489@dwillia2-xfh.jf.intel.com.notmuch>
User-Agent: NeoMutt/20220429

On Tue, 21 Jan 2025, Dan Williams wrote:

>Davidlohr Bueso wrote:
>> +int cxl_setup_gpf_port(struct device *dport_dev)
>> +{
>> +	int dvsec;
>> +	struct pci_dev *pdev;
>> +
>> +	if (!dev_is_pci(dport_dev))
>> +		return 0;
>> +
>> +	pdev = to_pci_dev(dport_dev);
>> +
>> +	if (is_cxl_restricted(pdev))
>> +		return 0;
>
>Given this is called from devm_cxl_enumerate_ports() after it is already
>clear that @dport_dev is in a VH topology, no need to worry about
>RCH/RCD details here.

Yeah I realized that the second after sending this out.

>
>> +
>> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>> +					  CXL_DVSEC_PORT_GPF);
>
>I think this ok for now, but perhaps this should be enumerated once
>per-port and cached in 'struct cxl_port', otherwise this can potentially
>be called multiple times for shared ports in deeper VH topologies.

Right so I've cached this and moved the whole cxl_setup_gpf_port() call
down into once we find the respective port.

>
>> +	if (!dvsec) {
>> +		dev_warn(&pdev->dev, "Port GPF DVSEC not present\n");
>
>Could be pci_warn() to use @pdev directly.

Sure, but afaict the pci_ flavors aren't used throughout the cxl driver.

...

>> @@ -1038,6 +1029,18 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>  	if (cxl_pci_ras_unmask(pdev))
>>  		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
>>
>> +	/*
>> +	 * Set dirty shutdown now, with the expectation that the device
>> +	 * clear it upon a successful GPF flow. The exception to this
>> +	 * is upon Viral detection, per CXL 3.2 section 12.4.2.
>> +	 */
>> +	if (resource_size(&cxlds->pmem_res)) {
>> +		rc = cxl_dirty_shutdown_state(mds);
>> +		if (rc)
>> +			dev_warn(&pdev->dev,
>> +				 "GPF: could not dirty shutdown state\n");
>
>I think the proper place for this call is in cxl_nvdimm_probe(). That
>happens after the device has succeeded cxl_mem_probe() and successfully
>enumerated pmem capacity, but before the kernel commits to using pmem
>through the nvdimm subsystem.
>
>Had shutdown_state been part of cxl_nvdimm_probe() since day one, the
>policy could have been: "if cxl_dirty_shutdown_state() fails,
>cxl_nvdimm_probe() fails". However, I know that would regress cxl-test
>and qemu if not devices in the wild that do not meet that spec mandatory
>requirement where Linux has been lenient for a long while now.

So qemu has patches out there and I will also send a patch for the mock device.

But yes, I agree with your approach to failing the dirty shutdown.

There is a similar consideration to have with failing to set the port
dvsec (ie: not there); should we fail the enumeration altogether? So far
I have been lenient, and considering that you did not mention this, I *think*
you agree. For users that know they will never need pmem that doesn't matter,
but overall the platform would be considered to be exposed to data corruption
(and afaict gpf dvsecs are mandatory). Perhaps another potential sysfs
file that would alert users of quirky hardware?

Thanks,
Davidlohr
