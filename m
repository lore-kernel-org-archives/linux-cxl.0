Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83B526A8D
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876212; cv=none; b=hxF9tn1LQmQuj/sGs9Ji9Grp13OfgIiqUhVss7ouLKyXS6uuEqOSg1CUT8a4MP6ZksVafaHofSlNfBoHVQ60i+AhOCcmg2hkwXI8nnnuQ2khcymIRmPtEHceDAj43I6GZ1Ys58Hc4HsfmNu85dV77DNK9XJrGlZPeVEqatlhyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876212; c=relaxed/simple;
	bh=DvEKW4qQtXK8wx2eeKFFlLjmHpvwdW30UhnZH8q+cEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvhrwwqjPLwYfy+pPHGrka8xqVQLTy9kUlO3K+CGjBuUtlPX7yv3Fe1wzP70hl3DpKLzvUQBKug787DbCNUHJj40evenY8ZlljAaR2S1m9YuzbbSc7g0p/GMENv3muvQS4YiXqhP1gWvgzS27bi4gEgrqDCd2mb5nJgc24gqItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4DfB8o4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4DfB8o4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790876209; x=1822412209;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DvEKW4qQtXK8wx2eeKFFlLjmHpvwdW30UhnZH8q+cEI=;
  b=b4DfB8o4k6tQ5Q45kSyawyyBv3WG1JgfQLvusdFe6UnAJItLYkLhQIYH
   /T3HxrAluAsXJk2MIQ8dmI3BWdzcIBUfZmUsK+3c+SkvXR0ChfLG3/6pF
   MgLLuW8KNnMkCWiqg8n8KM2XxnF7No7apZRQJgJVEIzULfSbOq/Vc9aCo
   bRfXcPZgiEE3tkb97tr5R/ywNmxy6LDg6U6RGSG4ROrCCpaK/EDSJSniX
   W3w4Zl4xYRrwDa0OKZsakrasVLQG97qTuHRDYwP3O3oPB1Rflec9vZ2BZ
   XFq74pLe8ME+HlQtnxnXfqaIlXcte2xKiEDu9CIjOT2hB6pj9/ooiGV83
   g==;
X-CSE-ConnectionGUID: 32pUOspxTcKGoWfFIzgKNQ==
X-CSE-MsgGUID: UaX9N/n+S6GMXA5AnnQFjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="94523806"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="94523806"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:36:49 -0700
X-CSE-ConnectionGUID: INJ4DAUKSeGEGKX5JWxGwA==
X-CSE-MsgGUID: JAdSJhuSRzGvMvIVhRCxLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="314013369"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:36:48 -0700
Message-ID: <71282f45-a103-4e72-8b94-f0b2400f9188@intel.com>
Date: Thu, 1 Oct 2026 10:36:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] cxl/core: Hold the dport host lock across dport
 lookup and use
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20261001154744.1095902-1-dave.jiang@intel.com>
 <20261001154744.1095902-3-dave.jiang@intel.com>
 <20261001160257.E0BEC1F000FF@smtp.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261001160257.E0BEC1F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/1/26 9:02 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] cxl/core: AB-BA deadlock in RCH topologies due to child-to-parent lock inversion
> --
> 
> commit 689adbac9a3f5c00d58408df886ec90fd00ca46d
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> cxl/core: Hold the dport host lock across dport lookup and use
> 
> Callers of cxl_pci_find_port() and cxl_mem_find_port() can be handed a
> struct cxl_dport that is already freed, and all four dereference it
> without the lock that would prevent that.
>     
> A dport is kzalloc()'d into a devres group on its host device, so it dies
> when that host unbinds. The host is &port->dev for a switch port and
> port->uport_dev for the root port.
> 
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9d807c1a002ca..55a571f86d477 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -734,10 +734,16 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>  	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>>  		struct cxl_dport *dport;
>>  		struct cxl_port *port __free(put_cxl_port) =
>> -			cxl_pci_find_port(pdev, &dport);
>> +			cxl_pci_find_port(pdev);
>>  		if (!port)
>>  			return -EPROBE_DEFER;
>>  
>> +		guard(device)(cxl_port_dport_host(port));
> 
> [Severity: High]
> Does acquiring the ancestor host bridge lock here while the driver core holds
> the descendant (pdev) device lock cause an AB-BA deadlock?
> 
> If concurrent device removal locks the parent device and then iterates to lock
> children, could it deadlock against this path in cxl_pci_setup_regs() during
> device probe?

No. The lock taken is not the host bridge and not an ancestor of pdev.

These paths only run for an RCH, where cxl_pci_find_port() returns the CXL
root port. cxl_port_dport_host() of a root port is root->uport_dev, the
ACPI0017 platform device. The host bridge is only the dport device.

On x86 the PCI root bus is created with a NULL parent, so the RCiEP and its
memdev live under /sys/devices/pci0000:xx, and ACPI0017 lives under the
platform bus. A parent-to-child walk from either tree never reaches the
other.

The order is also not new. cxl_mem_probe() already locks root->uport_dev
for an RCH endpoint, and cxl_mem probes synchronously from cxl_pci_probe().
That establishes:

	pdev -> cxlmd -> ACPI0017

cxl_pci_setup_regs() adds pdev -> ACPI0017, which that chain already
implies.

Nothing takes these locks in the reverse order:

  - delete_endpoint() runs from cxlmd devm teardown: cxlmd -> ACPI0017.
  - unregister_port() of the endpoint takes only the endpoint's own lock.
  - detach_memdev() locks cxlmd from cxl_bus_wq, and nothing waits on that
    work under the ACPI0017 lock.
  - PCI hot-remove goes pdev -> cxlmd -> ACPI0017.

> 
>> +
>> +		dport = cxl_pci_find_dport(pdev, port);
>> +		if (!dport)
>> +			return -EPROBE_DEFER;
>> +
>>  		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>>  		if (rc)
>>  			return rc;
> 
> [ ... ]
> 
>> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
>> index e0e01aa5eba6c..3c6aae26deedd 100644
>> --- a/drivers/cxl/core/ras_rch.c
>> +++ b/drivers/cxl/core/ras_rch.c
>> @@ -118,10 +118,20 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>>  	int severity;
>>  
>>  	struct cxl_port *port __free(put_cxl_port) =
>> -		cxl_pci_find_port(pdev, &dport);
>> +		cxl_pci_find_port(pdev);
>>  	if (!port)
>>  		return;
>>  
>> +	/*
>> +	 * The dport may have been freed since the lookup above, so take the
>> +	 * lock that pins it and find it again.
>> +	 */
>> +	guard(device)(cxl_port_dport_host(port));
> 
> [Severity: High]
> Could this also lead to an AB-BA deadlock on Restricted CXL Host (RCH)
> topologies?
> 
> This acquires the ancestor host bridge lock while the caller holds the
> descendant (&cxlmd->dev) device lock. Concurrent device hot-remove paths
> typically lock from parent to child, which seems like it would deadlock against
> this AER handling path.

Same answer. This is cxlmd -> ACPI0017, the pair cxl_mem_probe() takes in
the same order. Hot-remove takes them in that order too.

> 
>> +
>> +	dport = cxl_pci_find_dport(pdev, port);
>> +	if (!dport)
>> +		return;
>> +
>>  	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
>>  		return;
>>
> 

