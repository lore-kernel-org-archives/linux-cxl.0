Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37D1DC994
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 11:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751369585; cv=none; b=i5XHl6SxvnTc4GuoF9yXBh5T19c7aDsU0ZAdl8IQPfRiD+q+ILgU6Diyi6JvHyLaGq0W3L/BVpOoMjVmz66k0sh07y6Iw+Mgb3dhRKQRvC65FDGdoxQUhEa8V+VSn57RpdGHCiiK+u416KcTJ9KlhKntbcSvWmI+SdqLfzH/a/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751369585; c=relaxed/simple;
	bh=cTmrd2rrITY9GquXy9f1bJ/fkV2DRCtT/ym1xzOp6zk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTeupVssQNLrRwUerCxcxPtLrft1htNZzjBTgVo/5HqfmtqSlO8/GHSLCl2mAnxWMztJe5WP1QtIxWQea7M8RKoAf0KeD3KtiM+VTcpUn5BmnbnSsQgTl9OR+vbGF3ZU3GPFLSqgscwYC4ygl8iKj8gferN21U9iqXQgaurfBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWgq95ggQz6M4tH;
	Tue,  1 Jul 2025 19:32:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CCB211402F5;
	Tue,  1 Jul 2025 19:32:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 13:32:59 +0200
Date: Tue, 1 Jul 2025 12:32:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v4 9/9] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
Message-ID: <20250701123257.000055a2@huawei.com>
In-Reply-To: <20250624213916.1665889-10-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
	<20250624213916.1665889-10-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 14:39:16 -0700
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
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v4:
> - Reworked against new delayed dport allocation mechanism

One comment inline.

This whole things is complex enough I'm not feeling particularly confident
in my reviewing - so definitely needs a lot more eyes.  With that in mind.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 20d2f834bf94..b1d19c609dde 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

> +
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

I'm not certain that there isn't a path to dport being uninitialized
if !port.  Maybe we always get passed the early checks in match_port_by_dport()
at least once.  Event if it is safe, I suspect we might get false positive
reports as a compiler or static analysis tool is going to struggle to figure
that out.


> +	if (!port)
> +		port = find_cxl_port_by_uport(hb_uport_dev);
> +
> +	/* Port already established, add the associated dport if needed. */
> +	if (port) {
> +		if (dport)
> +			return 0;
> +
> +		guard(device)(&port->dev);
> +		return devm_cxl_port_add_dport(port, hb_dport_dev, &dport);
> +	}
> +
> +	/* No port found, setup a port via the root port ops */
> +	if (!cxl_root->ops || !cxl_root->ops->setup_hostbridge_uport)
> +		return -EOPNOTSUPP;
> +
> +	rc = cxl_root->ops->setup_hostbridge_uport(cxl_root, hb_uport_dev);
> +	if (rc)
> +		return rc;
> +
> +	/* Add the dport that goes with the newly created port */
> +	return devm_cxl_add_dport_by_uport(hb_uport_dev, hb_dport_dev, &dport);
> +}
> +
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  {
>  	struct device *dev = &cxlmd->dev;
> @@ -1826,6 +1889,10 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	if (cxlmd->cxlds->rcd)
>  		return 0;
>  
> +	rc = cxl_hostbridge_port_setup(cxlmd);
> +	if (rc)
> +		return rc;
> +
>  	rc = devm_add_action_or_reset(&cxlmd->dev, cxl_detach_ep, cxlmd);
>  	if (rc)
>  		return rc;


