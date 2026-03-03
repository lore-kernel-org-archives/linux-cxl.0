Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DD35F160
	for <linux-cxl@vger.kernel.org>; Tue,  3 Mar 2026 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570208; cv=none; b=d/3UFuKTZLgswDu4YbggKBedNgqMhoDvY7HeW6oxxKocWHpwijrLQg6gzuaeSnrZZjzoWV7ao1f1cPa+9FKbcrd8rNLvpQUO1OWFmUp49WZZJGZ6+YopdOgRBQ6NPxrT1Ny4BKIh+5J8La1sadbLZ2igf1sNDitAsYS1LWQ7uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570208; c=relaxed/simple;
	bh=DW3SqRPiOyqnstbTyvLfPjxyalqIEFjs6qBzy/NbNK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTSX6zvCDWBeUtfAeyZB/HTz4LJDkHJpHGq649ludbuJeIe6UHuELQl9VwuXnAANnuw5Orqkya9yaCsDnROT8w4ULpdc+s5Wikv8xd9wLl92zs0W7QU8TD1LUxYJZzb1HAT/rHre0LSUhVE2pNj9j6kFeRrgNJVIm5reHqiQ6Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZxodsD5H; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZxodsD5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772570207; x=1804106207;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DW3SqRPiOyqnstbTyvLfPjxyalqIEFjs6qBzy/NbNK8=;
  b=ZxodsD5HB0EbAob1JMcNnWWrr7gQThOs7QojtajoUBzqwlGjj6Jg3ZK9
   UjFJBK58zO8RiMbxjc3vMWxch11NhZmkwDZfQd0oxy+OSWPasuakLo9nX
   4nFgK+2i1gccZUfatIrCkT2mN6cLyxp3Y6871GbSg5AbBrpnPXjbyaDp4
   n3BHMTkDyo0akdkvUOOLv9dAF9fWiMxU74V56xvB8r9oQGRjqRGn3Lji0
   942N2hgQQgd9VOuXAXsbQLQZdP6+QZuh2PpQlIITx0f7reoDnuqNFA2ON
   Am1t/jzstnO7FvzHgKFrtTv5UeBEj5kuTkkqb2bn/QCfaP/w+DjHQ94E0
   w==;
X-CSE-ConnectionGUID: t8HboeMYSZ2QShYOcIs7ig==
X-CSE-MsgGUID: KMycZug7Tn2X1JV205lQSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="96232426"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="96232426"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 12:36:43 -0800
X-CSE-ConnectionGUID: hRkO5cElTE66wS14BqUh+Q==
X-CSE-MsgGUID: n/jBH2ZVRsOc9pY8wAun/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="217279317"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.108.145]) ([10.125.108.145])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 12:36:42 -0800
Message-ID: <dcf65c56-0f2c-468f-81ab-77a3cd3ea2b9@intel.com>
Date: Tue, 3 Mar 2026 13:36:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/port: Fix use after free of parent_port in
 cxl_detach_ep()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Li Ming <ming.li@zohomail.com>
References: <20260226184439.1732841-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260226184439.1732841-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/26 11:44 AM, Alison Schofield wrote:
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
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Changes in v4:
> Move the put_device() into existing if-else logic (Ming)
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
>  drivers/cxl/core/port.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b69c2529744c..a004da8fbe55 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -552,10 +552,13 @@ static void cxl_port_release(struct device *dev)
>  	xa_destroy(&port->dports);
>  	xa_destroy(&port->regions);
>  	ida_free(&cxl_port_ida, port->id);
> -	if (is_cxl_root(port))
> +
> +	if (is_cxl_root(port)) {
>  		kfree(to_cxl_root(port));
> -	else
> +	} else {
> +		put_device(dev->parent);
>  		kfree(port);
> +	}
>  }
>  
>  static ssize_t decoders_committed_show(struct device *dev,
> @@ -721,6 +724,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>  		struct cxl_port *iter;
>  
>  		dev->parent = &parent_port->dev;
> +		get_device(dev->parent);
>  		port->depth = parent_port->depth + 1;
>  		port->parent_dport = parent_dport;
>  
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

v4 applied to cxl/fixes
19d2f0b97a131198efc2c4ca3eb7f980bba8c2b4


