Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0240341063
	for <linux-cxl@vger.kernel.org>; Wed, 18 Feb 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428616; cv=none; b=i0xmq3bjPWz58U4KTX7CdqQIZQkI2AieBI2gxW+21khmE9dRUCDuqLhaiK9EBJfZvzdvUegZBkrlgYqa1MRSO4Ew4Ua9ACeFWp83Ve452q36ey292azDvTUiLvF4+vgl7Yi2+AdyAiBq4pW17T8jZNmZqEZNbQ384RP8ePad3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428616; c=relaxed/simple;
	bh=4yi99t5DYNY9mwKM9ThR5qLNcAlbOvLDjnf7ET/Rz88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYpZSFf2YNS1ccfjKGYcCHe5tw9ohbS7D+t2ET2DmDGdtxbeaGu90RRa5hRK3T5v/qzNFtmM81EVUGBOyOGZZtKeHAhqb2iZxAdzpTvYxxmLrDrKol4/DPNjr08RTEGD5hKLsMycHBAVbA2SnRXzSp+1kl3Asu5lRClJB4u/bfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsoIB2BM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsoIB2BM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771428612; x=1802964612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4yi99t5DYNY9mwKM9ThR5qLNcAlbOvLDjnf7ET/Rz88=;
  b=hsoIB2BME4AKO+w12Df1MBR6I85lmu0oVV8xkiSr3vFP2S4KzVr5u3qS
   jbVQKEgLdmy6LYVPEtrqT7EbuRfzpHkHrYlkVQU/z5TLj4wgL6zyuAbJb
   lzylnllJQV9MUgzLdXqDDeQOUsIMdtQMWDihRSMvhXXlGfRd7wgw4xfTS
   qWBDC7/Fh93FOEFqW/62Gowednc7A2bS20qX6xNynT5zYzBNxa/OqZlZ2
   JNgwMxMR3WH0J++E3rTCNi6bDoNujfgTU27jNB/Nlyc5DCZ0GqPTXl4Rt
   R1qA/lr4nyPLouR8dDSU+Pb3T5RqFLGcS1UMpzCGdheNUa5cZ9SdP7143
   Q==;
X-CSE-ConnectionGUID: KgbTTUr5R8uzt/NqYfuqMA==
X-CSE-MsgGUID: mcEgqMlPS7mT/+5VCsCuCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="72495584"
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="72495584"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:30:12 -0800
X-CSE-ConnectionGUID: VcYITW/MSZ6HRRTv/zgtBg==
X-CSE-MsgGUID: SRveEf2vSzyEAgB//AVDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,298,1763452800"; 
   d="scan'208";a="213303225"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.212]) ([10.125.109.212])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 07:30:10 -0800
Message-ID: <f796c5b1-5149-4a51-b939-d278e5f7fd35@intel.com>
Date: Wed, 18 Feb 2026 08:30:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260218061532.1461436-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260218061532.1461436-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/17/26 11:15 PM, Alison Schofield wrote:
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
> Fix this first case by adding a check for port->dead after acquiring
> both locks. Unlock and release the parent reference before continuing.
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
> Fix this second issue by taking an extra reference on parent_port
> before locking it, preventing the memory from being freed across
> delete_switch_port(). Release it after device_unlock().
> 
> These easily reproduce with a reload of cxl_acpi in QEMU environment
> with CXL devices present.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Fixes tag?

> ---
> 
> 
> This was found while trying out unit test cases to backstop DaveJ's
> latest finding where QEMU devices with CXL unit tests exposed an
> nvdimm bus race. I post this with a bit of skepticism of the
> likelihood it appears in the wild. Maybe it would but just not in the
> way my test invokes it. A Fixes tag was not obvious, but I can find
> the best tag, if any, in a v2.
> 
> 
>  drivers/cxl/core/port.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fea8d5f5f331..94cf6b248e0d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1533,8 +1533,18 @@ static void cxl_detach_ep(void *data)
>  		port = to_cxl_port(dev);
>  
>  		parent_port = to_cxl_port(port->dev.parent);
> +		get_device(&parent_port->dev);
>  		device_lock(&parent_port->dev);
>  		device_lock(&port->dev);
> +
> +		/* A concurrent detach may have already removed this port */
> +		if (port->dead) {
> +			device_unlock(&port->dev);
> +			device_unlock(&parent_port->dev);
> +			put_device(&parent_port->dev);
> +			continue;
> +		}
> +
>  		ep = cxl_ep_load(port, cxlmd);
>  		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
>  			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
> @@ -1553,11 +1563,19 @@ static void cxl_detach_ep(void *data)
>  		device_unlock(&port->dev);
>  
>  		if (died) {
> +			/*
> +			 * Hold an extra reference to parent_port across
s/Hold/Holding/

Or at least that makes more sense to me reading it. 

> +			 * delete_switch_port() since unregister_port(port)
> +			 * may cascade and unregister parent_port, freeing
> +			 * it before the call to device_unlock().
> +			 */

>  			dev_dbg(&cxlmd->dev, "delete %s\n",
>  				dev_name(&port->dev));
>  			delete_switch_port(port);
>  		}
> +

Stray blank line
>  		device_unlock(&parent_port->dev);
> +		put_device(&parent_port->dev);
>  	}
>  }
>  
> 
> base-commit: 49d273f81f3dad288b7748c6cfb973705ae026d2

