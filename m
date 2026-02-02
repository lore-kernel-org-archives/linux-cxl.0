Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0393238150;
	Mon,  2 Feb 2026 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770046773; cv=none; b=ldzu80dWTiH7Yuor8Dm1oqQ87qlMYFEghUojFhMx5V1fHPSwxs/8ZalTR1CQeS/LKwcS8G8GgU89gQmO3xP9glKUHLq6xkI2fjnrJYzq8S7dFhWYGuvNILde+Xefe/moJ+NKR9gycTzcTipPVg60OABq+5RkEDeJFikGiX0joeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770046773; c=relaxed/simple;
	bh=DDvI3Itu5ETLUupo6QCibVrid68Z4c/droYoOexXb60=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YejZ7RxoY6H5gC7YDXYWownd+4FgR+uCqSJQBJL/XOm6H3XcCqPc5++WgX44ZqvqxZhcJ8DeVxTOnv76mQvQ+wntwHiJWiPPZQsUnYuKCvcJn95CMaU5DRrL/PleyHMrhnbHEfkTuKZoNXXvguxcieTINVf1CH+Zaxy0QNkosDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f4W3n2YwVzHnH6q;
	Mon,  2 Feb 2026 23:38:29 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id F1B8240539;
	Mon,  2 Feb 2026 23:39:26 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Feb
 2026 15:39:26 +0000
Date: Mon, 2 Feb 2026 15:39:24 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/core: Hold grandparent port lock while dport
 adding
Message-ID: <20260202153924.00002396@huawei.com>
In-Reply-To: <20260201093002.1281858-3-ming.li@zohomail.com>
References: <20260201093002.1281858-1-ming.li@zohomail.com>
	<20260201093002.1281858-3-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Sun,  1 Feb 2026 17:30:02 +0800
Li Ming <ming.li@zohomail.com> wrote:

> When CXL subsystem adds a cxl port to a hierarchy, there is a small
> window where the new port becomes visible before it is bound to a
> driver. This happens because device_add() adds a device to bus device
> list before bus_probe_device() binds it to a driver.
> So if two cxl memdevs are trying to add a dport to a same port via
> devm_cxl_enumerate_ports(), the second cxl memdev may observe the port
> and attempt to add a dport, but fails because the port has not yet been
> attached to cxl port driver.
> the sequence is like:
> 
> CPU 0					CPU 1
> devm_cxl_enumerate_ports()
>   # port not found, add it
>   add_port_attach_ep()
>     # hold the parent port lock
>     # to add the new port
>     devm_cxl_create_port()
>       device_add()
> 	# Add dev to bus devs list
> 	bus_add_device()
> 					devm_cxl_enumerate_ports()
> 					# found the port

Indenting not consistent here as this call is in devm_cxl_enumerate_ports()

> 					find_cxl_port_by_uport()
> 					# hold port lock to add a dport
> 					device_lock(the port)
> 					find_or_add_dport()
> 					  cxl_port_add_dport()
> 					    return -ENXIO because port->dev.driver is NULL
> 					device_unlock(the port)
> 	bus_probe_device()
> 	  # hold the port lock
> 	  # for attaching
> 	  device_lock(the port)
> 	    attaching the new port
> 	  device_unlock(the port)
> 
> To fix this race, require that dport addition holds the parent port lock
> of the target port. The CXL subsystem already requires holding the
> parent port lock while attaching a new port. Therefore, successfully
> acquiring the parent port lock ganrantees that port attaching has

Spell check. Guarantees

> completed.
> 
> Fixes: 4f06d81e7c6a ("cxl: Defer dport allocation for switch ports")
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Analysis looks reasonable to me, but I'm not hugely confident on this
one so would like others to take a close look as well.
Question inline.


> ---
>  drivers/cxl/core/port.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 54f72452fb06..fef2fe913e1f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1817,8 +1817,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  			/*
>  			 * RP port enumerated by cxl_acpi without dport will
>  			 * have the dport added here.
> +			 *
> +			 * Hold the parent port lock here to in case that the
> +			 * port can be observed but has not been attached yet.
>  			 */
> -			scoped_guard(device, &port->dev) {
> +			scoped_guard(device, &parent_port_of(port)->dev) {
I'm nervous about whether this is the right lock. For unregister_port()
(which is easier to track down that the add path locking) the lock
taken depends on where the port is that is being unregistered.
Specifically root ports are unregistered under parent->uport_dev, not
parent->dev.

> +				guard(device)(&port->dev);
>  				dport = find_or_add_dport(port, dport_dev);
>  				if (IS_ERR(dport)) {
>  					if (PTR_ERR(dport) == -EAGAIN)

