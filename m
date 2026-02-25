Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FA3195FB
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059626; cv=none; b=vDY8ey1rpjoqH06gVdfRq5UDKWSu1LxlbegEbK/QPXY+1gJs79jU4CvlFesKNX1Q2+r5/jDiQesowkOQ8WgbXb9l/11ivNE5U+b6jM2Zsdjw1bl87oxI1kMuZQUfw60UjNGb6xBaxB0Tw3hz2Z7pXVg+nQmVCwFM90KUdmlfj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059626; c=relaxed/simple;
	bh=E0TavFMPmGTkcPtEcGiSazDlByA8P6hNkwg75oZY2dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3bXe2jqO/AnHaRy/+YUJ5YWk400uGdzkrq+BRx4oHyqiBLos8iePSmXZDvpiInmhUs7TQlOgI8x83VXkyM6eVn4pk7DMMSz1hw34MJ4qTmVdKNKdc9CZpHHt9ozgTfMpYYb55/8cTuL+dY2Dqpj1ETAMcrBpOs0507qTjA5pQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIuP4rpk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIuP4rpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772059624; x=1803595624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E0TavFMPmGTkcPtEcGiSazDlByA8P6hNkwg75oZY2dw=;
  b=TIuP4rpk68cNV/eOHrdnw5UIpltqrcQdT6/+psLy2KeQu6qbtD/mNO9G
   iJyYRf7AWmxrUiowtmJ4t47xMxRANI+FrJpWq191UT4MpC4hyCCnhsoYW
   inLDvLig8ohKNrR7I4ygXfmMtJBVgX44iig1Nnh/KdlN2AOB8fxF2x6DO
   n0h8jvRYJzgBunp3yvhWYOfHKigX5j9dWKAQ7aQ1e7dfJdAFaP+kqfBpL
   +Em22q2PIq04zqhuKPZIk8imKitHr0CvvJCr+vPP13GMM5POYMDpobdfD
   EguCMz6Okx5fDexnGrUlvkmoGUmg5IeW+uJ2eoWaQLXMXk9NLP1aKpNCr
   A==;
X-CSE-ConnectionGUID: VsePcsoOQvKMR4OlQe40tw==
X-CSE-MsgGUID: jzQp5CnsQSK1Y5zTdgHOPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="83739337"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="83739337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:47:03 -0800
X-CSE-ConnectionGUID: eh25oxcqQgW9zqHQdHi9lg==
X-CSE-MsgGUID: Otr6uUroRrOVK3R1eAE2KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="220504796"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.98]) ([10.125.111.98])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 14:47:02 -0800
Message-ID: <7d1f61c1-0a0f-4533-bc2a-36b7268da503@intel.com>
Date: Wed, 25 Feb 2026 15:47:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260225220251.1708089-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260225220251.1708089-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/25/26 3:02 PM, Alison Schofield wrote:
> cxl_detach_ep() is called during bottom-up removal when all CXL memory
> devices beneath a switch port have been removed. For each port in the
> hierarchy it locks both the port and its parent, removes the endpoint,
> and if the port is now empty, marks it dead and unregisters the port
> by calling delete_switch_port(). There are two places during this work
> where the parent_port may be used after freeing:
> 
> First, a concurrent detach may have already processed a port by the
> time a second worker finds it via bus_find_device(). Without pinning
> parent_port, it may already be freed when we discover port->dead and
> attempt to unlock the parent_port. In a production kernel that's a
> silent memory corruption, with lock debug, it looks like this:
> 
> []DEBUG_LOCKS_WARN_ON(__owner_task(owner) != get_current())
> []WARNING: kernel/locking/mutex.c:949 at __mutex_unlock_slowpath+0x1ee/0x310
> []Call Trace:
> []mutex_unlock+0xd/0x20
> []cxl_detach_ep+0x180/0x400 [cxl_core]
> []devm_action_release+0x10/0x20
> []devres_release_all+0xa8/0xe0
> []device_unbind_cleanup+0xd/0xa0
> []really_probe+0x1a6/0x3e0
> 
> Second, delete_switch_port() releases three devm actions registered
> against parent_port. The last of those is unregister_port() and it
> calls device_unregister() on the child port, which can cascade. If
> parent_port is now also empty the device core may unregister and free
> it too. So by the time delete_switch_port() returns, parent_port may
> be free, and the subsequent device_unlock(&parent_port->dev) operates
> on freed memory. The kernel log looks same as above, with a different
> offset in cxl_detach_ep().
> 
> Both of these issues stem from the absence of a lifetime guarantee
> between a child port and its parent port.
> 
> Establish a lifetime rule for ports: child ports hold a reference to
> their parent device until release. Take the reference when the port
> is allocated and drop it when released. This ensures the parent is
> valid for the full lifetime of the child and eliminates the use after
> free window in cxl_detach_ep().
> 
> This is easily reproduced with a reload of cxl_acpi in QEMU with CXL
> devices present.
> 
> Fixes: 2345df54249c ("cxl/memdev: Fix endpoint port removal")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> 
> Changes in v3:
> Scope fix as a lifetime guarantee btw child port & parent (Dan)
> 
> Changes in v2:
> Remove stray blank line (DaveJ)
> Rebase on 7.0-rc1
> Add Fixes Tag (DaveJ)
> 
> 
>  drivers/cxl/core/port.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b69c2529744c..09fc08205ed5 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -552,6 +552,10 @@ static void cxl_port_release(struct device *dev)
>  	xa_destroy(&port->dports);
>  	xa_destroy(&port->regions);
>  	ida_free(&cxl_port_ida, port->id);
> +
> +	if (!is_cxl_root(port))
> +		put_device(dev->parent);
> +
>  	if (is_cxl_root(port))
>  		kfree(to_cxl_root(port));
>  	else
> @@ -721,6 +725,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		struct cxl_port *iter;
>  
>  		dev->parent = &parent_port->dev;
> +		get_device(dev->parent);
>  		port->depth = parent_port->depth + 1;
>  		port->parent_dport = parent_dport;
>  
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

