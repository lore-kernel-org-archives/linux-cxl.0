Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACE202997
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747326910; cv=none; b=WXmGS+LgnC/y43D6tTkNWyp3XYuCn1AzsxFw8b9OhFtWHEFGQasHrNbQ98h36xPV5eQjExPv46KWzZ5LtDIL7VaO3VeiqSXqhOvpHbfTx9ab1j2jtioCyyuu24hZnEP63qVPB3ioxax3/3Bn7djrMqwrGWGmfcKk2VJSbMCnCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747326910; c=relaxed/simple;
	bh=ilRIRiQ4C7ML6GAhRvq3OgvH6t3fTVQYmrrkfxflg/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYM7P5odMxshzzdrj9PZSG4SvMGLJJqQXWVKteYeYtVBr2HWWvds21Lzo7ygxd3RjKEuonvmU8oT1Qr+gYyXLXjHTwRIOhJCuv9fJOcS4KVO0vLjNWDhfRCiViCBxNQMcrAwGvsXJDH1r0bOrLVXD8QhaBZwXihPhfikqLTVAjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hd0oBRCy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hd0oBRCy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747326909; x=1778862909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ilRIRiQ4C7ML6GAhRvq3OgvH6t3fTVQYmrrkfxflg/M=;
  b=hd0oBRCyZ3jlync7pfM/zoEbdUEmnqMFje3I8WA+wO9nzgaMLxpJ3yUo
   A9gIUnljlrZt8eDmKndd0jmjo/P5EXoniMJdzMxS4jPEtqplfzDWp809K
   +DniJlGFm/iqRIt3W70XQzblyXvd611UOXxU+Dpd8+6CCi19cYrZWQjk4
   VUBNYT+hZkrYrRalQ4ufNit3wzLxMvjRQ/Igy3UDgpsjImk8ejjShqifP
   CRBaQQ7ElRYSw0yoO/jXNhpWayTme5LMI6c5ay6+JRvuJC64qf5uMJ+Nr
   aoKg6NUfCeJfb5ll4DLz6pLR/wwwuIpHNR4XpKQBKQwMHW1NIz/t7E09T
   w==;
X-CSE-ConnectionGUID: 5GAEDWReSumlZJ6ecw+ijg==
X-CSE-MsgGUID: Nh70k+oGTc6xA1sLE5zhuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49345482"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="49345482"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:35:08 -0700
X-CSE-ConnectionGUID: PV/CifqvS2aUQnHEHXP0VA==
X-CSE-MsgGUID: V4YFcRnFQhGtaNIdMvPd4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138299334"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:35:08 -0700
Message-ID: <865896eb-1ffd-4e6d-9745-1dbe480b1b02@intel.com>
Date: Thu, 15 May 2025 09:35:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, ira.weiny@intel.com,
 rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
 <aB0PO6n2Hr4ZFt9G@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aB0PO6n2Hr4ZFt9G@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/25 1:08 PM, Alison Schofield wrote:
> On Tue, May 06, 2025 at 05:43:02PM -0700, Dave Jiang wrote:
> 
> s/saperate/separate
> 
>> In preparation to allow dport to be allocated without being active, make
>> dport->id to be Linux id that enumerates the dport objects per port.
>> Keep the hardware id under dport->port_num to maintain compatibility and
>> introduce a dport->id as the enumeration id.
> 
> I think the 'and introduce...' end of the second sentence is repeating
> what the first sentence declared an can be omitted.
> 

Thank you. Will fix.

> With that-
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 

