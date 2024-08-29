Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9B518A950
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968635; cv=none; b=Unia/yp042kG87t0JJetKfPBsWm4wzow6ehGQJZ3T/7IHs08r7Ej0HZVIB89TnxdyE2HCfc6l5tVS54rorSZOVm1Re8j3XNHCLfaynpafzcBXI/w2Ze9/OHqEDTKjdVqhbFdwBCTCVvNK2Lrw5OjyPZcpzVvoaQs3G2+WTIZR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968635; c=relaxed/simple;
	bh=b8pIShDFojbQkortud6inyehJVZAkt21ul6ezHCNJqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGvBLNmK4LD9zN2PMh9Ip4EmTgKN7OHrT6AHyQhqonjHJU5auTw+dwragXd6t18z7Ye6t7VYWf0gWFqsVjLTuzCG6Nth75mAOvCGT1KKyBw6NO50BsdPoyHM5liXgbWt5OQSq5MzB86wgbfeu2Du/heoXzDz7uzJttTmDv8cgwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kbt2EgFk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kbt2EgFk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724968633; x=1756504633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b8pIShDFojbQkortud6inyehJVZAkt21ul6ezHCNJqA=;
  b=Kbt2EgFk1lvHiAlN6yucbUBAcz3UT4F1cgdtgNoEpbvZIrvQcACMlK+b
   qm+/7nhah8ufwlKU5DhNYcIzlGpKW4uA+Xm96fW6xhCIkdg04dmKHsVIe
   z/pukoraEvUthKVLnOixKfoKVWLqv0RIZnxDaoedu3BYeynmMb3YCtW+d
   MJz2wfk87GgAAGI3EytlO1z6re3rD+7H57mbLye3SXqi36us+gUNFWnBV
   v7bfiRVizV7PFOV7M1iVY3ATPCTHFL/DSwaXU5itOJQdMgeJovb99XlaW
   9RZ61b4A69KlXt+1sBRXTZwoyLEbpZkU4slHsbemNczcN6WqDBjnz0vLi
   g==;
X-CSE-ConnectionGUID: AyLWLOUzSJul6BKtbIYjLw==
X-CSE-MsgGUID: 3IvBtjVzQfSR61v+vxDgdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34757962"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34757962"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:57:13 -0700
X-CSE-ConnectionGUID: UspNAqQMSJKh3RubjB2rhA==
X-CSE-MsgGUID: g2Bn8oOiSEac9iSTDogA5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="64449238"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:57:14 -0700
Date: Thu, 29 Aug 2024 14:57:11 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, ming4.li@intel.com
Subject: Re: [v4 2/4] cxl/pci: Remove duplicated implementation of waiting
 for memory_info_valid
Message-ID: <ZtDut8P95M82JREZ@aschofie-mobl2.lan>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
 <20240828084231.1378789-3-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828084231.1378789-3-yanfei.xu@intel.com>

On Wed, Aug 28, 2024 at 04:42:29PM +0800, Yanfei Xu wrote:
> commit ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory
> related info") added another implementation, which is
> cxl_dvsec_mem_range_valid(), of waiting for memory_info_valid without
> realizing it duplicated wait_for_valid(). Remove wait_for_valid() and
> retain cxl_dvsec_mem_range_valid() as the former is hardcoded to check
> only the Memory_Info_Valid bit of DVSEC range 1, while the latter allows
> for selection between DVSEC range 1 or 2 via parameter.
> 

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---

snip

