Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA12367AC;
	Wed,  2 Jul 2025 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444692; cv=none; b=foNRlBUAUndM8WI4guv/tCjr4AnioUqL5tH9AECyJMuzKjuh959uG7jOL0NkUbJEki44hIxIsDXCpJ3+QuUOMabMWTymLlpk+/W94Hf7Ba3TWUjOFjq5ZUDQdLqqPfq+E8+6tPwdqhjjcroHq+5NxC1F49Okygxd6WQyYKfBt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444692; c=relaxed/simple;
	bh=X96pjU5FylzsfS/7gPB4fZIph/7DEncDPblL1kj4hUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEBpkuChm98uv1en1iAFHvBcUFIVfb1d6ioN3UCoToJRsDtiVKwoMCtSpnbLZGlqZ1CnuVE+KHicnP2j23OhCBqbCDOD8iDdeff2HNc28jEz1CinxiJ2yqJJY9hasigDWefMqsyJQI2cYIyDLHq5mYk7wVcDr+V84gkLFJnIje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MJ12tkxP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MJ12tkxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751444691; x=1782980691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X96pjU5FylzsfS/7gPB4fZIph/7DEncDPblL1kj4hUs=;
  b=MJ12tkxPaJsWxFVboG463lCEh38qDoY5TZwJu9ikxQdRorDwVk2GplAo
   bjxgRNZXT3n603VVH9svJVWl+c2baNNX7b9Ws9wZ8h32YFpTTiZpsmuyB
   lK5RxaHMckKrkcizAm0YhgmdpPO2rskniQ9Wfs4zxD4dKj2vAfEdJOIQA
   sd8UIot44NBmQf0ZMKi4LzCZ52LDz1WFmaIQRCAHX1n8V04kBqFiTpdm9
   aKklxNyNSaxJWVP6bf8P07RNLLvpTB9exAx/0FPwfVN9fj/tYXvsmxeAM
   psObjxLPTCtCwbnENcug0y9/CU1YbhF0Vmr6fuWNGcnx/Wv/4khdGheTH
   w==;
X-CSE-ConnectionGUID: CqoaLLAsT5+kkXMPPOj3ag==
X-CSE-MsgGUID: y1yCokfxTluNUsQUpfJIKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53822435"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53822435"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:24:50 -0700
X-CSE-ConnectionGUID: w3eeiw9mQ+ewBzlwzvSjHg==
X-CSE-MsgGUID: zJsJhhvjTyqqwqCKon4sbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="159526802"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:24:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWsln-0000000Brfz-4BGd;
	Wed, 02 Jul 2025 11:24:43 +0300
Date: Wed, 2 Jul 2025 11:24:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: akpm@linux-foundation.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] cxl/edac: Fix wrong dpa checking for PPR operation
Message-ID: <aGTsyw4iq5mFLDPg@smile.fi.intel.com>
References: <20250702072008.468371-1-ming.li@zohomail.com>
 <20250702072008.468371-2-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702072008.468371-2-ming.li@zohomail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 03:20:07PM +0800, Li Ming wrote:
> DPA 0 is considered invalid in cxl_do_ppr(), but per Table 8-143. "Get
> Partition Info Output Payload" in CXL r3.2 section 8.2.10.9.2.1 "Get
> Partition Info(Opcode 4100h)", it mentions that DPA 0 is a valid address
> of a CXL device. So the correct implementation should be checking if the
> DPA is in the DPA range of the CXL device rather than checking if the
> DPA is equal to 0.

Looking at the use cases, I even like the first patch less. You can do
it locally in the macro or function in cxl code. We may see in the future
if something like this will be needed for others.

-- 
With Best Regards,
Andy Shevchenko


