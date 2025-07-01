Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DE8821
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368667; cv=none; b=SSFgUMGOuDip4gq4muGr33GiwdeHQR6qqvrYG7lhAEzRkRdB6KOWNw0u8yqWRLShCDW1LWlsdSMLvimraDHcC5eOr9FqpGSW/Ck0Lirpa1a2AG+hvLsKq41rCeRpf0IkRkfwzj2wpVpHc06Y1GC9sQj1Hx1AXWHnbDqk+gyB+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368667; c=relaxed/simple;
	bh=GJ3lcSAyY5dp4/LzeBc1I9O0LTYvAaDHF86hgBn7wNI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEJosozsXcwcWhjKh0yO3NemCMckMb0PAnvq37nPnVQfnsimJa83oyLEYaJm1BdRxMCpPfcMTUpEjs33xEiUGz1Mf08FVSJKK9JNbTjkehfWEySZ/KyOxbdK1X3RrzZsu1fZ8mlAomHt56LCrX1qcxmmhAXVtQcqjsAlN7Xa1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bWgV824SRz6L5ZF;
	Tue,  1 Jul 2025 19:17:20 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BD569140427;
	Tue,  1 Jul 2025 19:17:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 1 Jul
 2025 13:17:42 +0200
Date: Tue, 1 Jul 2025 12:17:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>, <rrichter@amd.com>
Subject: Re: [PATCH v4 6/9] cxl/test: Add mock version of
 devm_cxl_add_dport_by_dev()
Message-ID: <20250701121740.000011ed@huawei.com>
In-Reply-To: <20250624213916.1665889-7-dave.jiang@intel.com>
References: <20250624213916.1665889-1-dave.jiang@intel.com>
	<20250624213916.1665889-7-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 24 Jun 2025 14:39:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> devm_cxl_add_dport_by_dev() outside of cxl_test is done through PCI
> hierarchy. However with cxl_test, it needs to be done through the
> platform device hierarchy. Add the mock function for
> devm_cxl_add_dport_by_dev().
> 
> When cxl_core calls a cxl_core exported function and that function is
> mocked by cxl_test, the call chain causes a circular dependency issue. Dan
> provided a workaround to avoid this issue. Apply the method to changes from
> the late dport allocation changes in order to enable cxl-test.
> 
> In cxl_core they are defined with "__" added in front of the function. A
> macro is used to define the original function names for when non-test
> version of the kernel is built. A bit of macros and typedefs are used to
> allow mocking of those functions in cxl_test.
> 
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One comment inline.  I'm not fond of the macro dance in here but don't have
a better suggestion, so fair enough.

> index 5d6585d4b15e..b13f9796687c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -1037,6 +1037,64 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
>  	return 0;
>  }
>  
> +static struct cxl_dport *mock_cxl_add_dport_by_dev(struct cxl_port *port,
> +						   struct device *dport_dev)
> +{
> +	struct platform_device **array;
> +	int i, array_size;
> +
> +	if (port->depth == 1) {
> +		if (is_multi_bridge(port->uport_dev)) {
> +			array_size = ARRAY_SIZE(cxl_root_port);
> +			array = cxl_root_port;
> +		} else if (is_single_bridge(port->uport_dev)) {
> +			array_size = ARRAY_SIZE(cxl_root_single);
> +			array = cxl_root_single;
> +		} else {
> +			dev_dbg(&port->dev, "%s: unknown bridge type\n",
> +				dev_name(port->uport_dev));
> +			return ERR_PTR(-ENXIO);
> +		}

This is all duplicating code in mock_cxl_port_get_total_dports.  
Helper to at least get the array_size and array?  Probably not
worth combining the final loops.

> +	} else if (port->depth == 2) {
> +		struct cxl_port *parent = to_cxl_port(port->dev.parent);
> +
> +		if (is_multi_bridge(parent->uport_dev)) {
> +			array_size = ARRAY_SIZE(cxl_switch_dport);
> +			array = cxl_switch_dport;
> +		} else if (is_single_bridge(parent->uport_dev)) {
> +			array_size = ARRAY_SIZE(cxl_swd_single);
> +			array = cxl_swd_single;
> +		} else {
> +			dev_dbg(&port->dev, "%s: unknown bridge type\n",
> +				dev_name(port->uport_dev));
> +			return ERR_PTR(-ENXIO);
> +		}
> +	} else {
> +		dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
> +			      port->depth);
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	for (i = 0; i < array_size; i++) {
> +		struct platform_device *pdev = array[i];
> +
> +		if (pdev->dev.parent != port->uport_dev) {
> +			dev_dbg(&port->dev, "%s: mismatch parent %s\n",
> +				dev_name(port->uport_dev),
> +				dev_name(pdev->dev.parent));
> +			continue;
> +		}
> +
> +		if (&pdev->dev != dport_dev)
> +			continue;
> +
> +		return devm_cxl_add_dport(port, &pdev->dev, pdev->id,
> +					  CXL_RESOURCE_NONE);
> +	}
> +
> +	return ERR_PTR(-ENODEV);
> +}


