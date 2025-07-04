Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E100239E6B
	for <linux-cxl@vger.kernel.org>; Fri,  4 Jul 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623668; cv=none; b=MD056tLbpP3yck+JJjk6YrGFYNB2nqjexs/JZyp/LUly6b25Y7wocZ8T0lxzIUeooKjbcnfz7mVDTglsM1J2YvV3STZijPa+zGK9OAFD/oENwo9QSj0YuY77NY+88RWAtnp24B0OrTBNUILuHVXETnciZ6byaWTVTzoZT4MqE0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623668; c=relaxed/simple;
	bh=26UzZ5E2G8jLJjQnsgxoxjLKrNTYYiWrEygiEGIC1NU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDkF8AMmTQE78bHXaPLdddZfFOZ9c8yfl2htKobvyz4LXINTa4T195TvX72BFzQ8NvRrzCC5iKW4aChO05PiF20h7oquvtyd3JziDOXkH0OhlDrRr42rsHm9QmG/G0jHIc7tzwjrkOMcFHE7AJT5k5Va1Jv5teGUWunKodnSmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bYTnq0pBQz6L4xD;
	Fri,  4 Jul 2025 18:07:11 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 076FD1402F1;
	Fri,  4 Jul 2025 18:07:43 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Jul
 2025 12:07:42 +0200
Date: Fri, 4 Jul 2025 11:07:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 09/10] cxl: Move enumeration of hostbridge ports to
 the memdev probe path
Message-ID: <20250704110741.00006737@huawei.com>
In-Reply-To: <20250703232710.3141436-10-dave.jiang@intel.com>
References: <20250703232710.3141436-1-dave.jiang@intel.com>
	<20250703232710.3141436-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 3 Jul 2025 16:27:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Current enuemration scheme in cxl_acpi module creates the ports under the
> root port by enumerating the hostbridges after the dports under the root
> port is created. However error messages "cxl portN: Couldn't locate the
> CXL.cache and CXL.mem capability array header" is observed when certain
> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
> probe is running before the CXL link between the endpoint device and the
> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
> DVSEC ID 7 blocks which will trigger the error message. This behavior
> is defined by the spec and not a hardware quirk.
> 
> Setup an association in cxl_port to tie the host bridge device to the
> associated cxl_root. The cxl_root provides a callback that's setup
> by the cxl_acpi probe function in order to create a port per host bridge
> that was previously done during cxl_acpi probe. Add the calling of the
> callback in devm_cxl_enumerate_ports(). The observed behavior is that
> ports that are not connected to endpoint device(s) are no longer
> enumerated. This should also remove any excessive noise of port probe
> failing on those inactive ports.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Updated with new devm_cxl_port_add_dport() and friends.
Hi Dave,

One of the bits of code that I was confused by in the patch that
added devm_cxl_port_add_dport() goes away in here. I'm not
sure why.

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1089fce24293..c624f4801b68 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1789,14 +1789,8 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  
>  		guard(device)(&port->dev);
>  		new_dport = devm_cxl_port_add_dport(port, dport_dev);
> -		if (IS_ERR(new_dport)) {
> -			if (PTR_ERR(new_dport) != -EEXIST)
> -				return PTR_ERR(new_dport);

Interesting. Is this in the wrong patch?

> -
> -			new_dport = cxl_find_dport_by_dev(port, dport_dev);
> -			if (!new_dport)
> -				return -ENODEV;
> -		}
> +		if (IS_ERR(new_dport))
> +			return PTR_ERR(new_dport);
>  
>  		dport = new_dport;
>  	}

> +static int cxl_hostbridge_port_setup(struct cxl_memdev *cxlmd)
> +{
> +	struct device *hb_uport_dev, *hb_dport_dev;
> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	rc = get_hostbridge_port_devices(cxlmd, &hb_uport_dev, &hb_dport_dev);
> +	if (rc)
> +		return -ENODEV;
> +
> +	struct cxl_root *cxl_root __free(put_cxl_root) =
> +		cxl_hb_uport_dev_to_root(hb_uport_dev);
> +	if (!cxl_root)
> +		return -ENODEV;
> +
> +	guard(device)(&cxl_root->port.dev);
> +	struct cxl_port *port __free(put_cxl_port) =
> +		find_cxl_port(hb_dport_dev, &dport);
> +	if (!port)
> +		port = find_cxl_port_by_uport(hb_uport_dev);
> +
> +	/* Port already established, add the associated dport if needed. */
> +	if (port) {
> +		if (dport)
> +			return 0;

The sequence I badly explained on v4 still bothers me here as I think
it might be possible to hit that if (dport) with dport never initialized.
Even if it isn't, I'd be surprised if the compiler / static analysis can
see that there is no such path.  So if we think it can't happen, just initialize
dport at declaration. If it can happen, I think it being null is still the
right answer, but maybe I'm missing something.


> +
> +		guard(device)(&port->dev);
> +		dport = devm_cxl_port_add_dport(port, hb_dport_dev);
> +		if (IS_ERR(dport)) {
> +			dev_dbg(&cxlmd->dev,
> +				"failed to add dport %s to port %s: %ld\n",
> +				dev_name(hb_dport_dev), dev_name(&port->dev),
> +				PTR_ERR(dport));
> +			return PTR_ERR(dport);
> +		}
> +		return 0;
> +	}

