Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E9145B26;
	Thu,  8 Aug 2024 22:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723156464; cv=none; b=qNVj3m+cL4laXkfttV/gRWUUW3aZkcifALZ9FSoW0qXX1k3AO0BpwR+Z0VI0uQl1Ax3arWZ/mbljeXbBd3hsZMeFO6/2IIpZ4QpWFQPn6TXwpB1sRPimqI8BXx1B/km8jWcdJF6NoFrsjZTULWPs2egvu7b4KspGQtIrLY/7ND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723156464; c=relaxed/simple;
	bh=znbP3E4POuVVVteKuIf7uaDYN7cAmafFUtFsWNHbrXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow0cf+9vn4jlRdbLQsL8v86bJrUT/WaE/5nwD+u0NGWnTdUiUr4tUZXSSM38wzjq8txtYycSFLOG55N8VyhuniyfnqwaWtNlaNCUcVP3soc3ws1FQ+j8HiJ3GQ+V0AyVpCMKcv5P8fywrxO3wPqj6u9lkk/luAWNJarlmHBuc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahpkik/b; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahpkik/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723156463; x=1754692463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=znbP3E4POuVVVteKuIf7uaDYN7cAmafFUtFsWNHbrXs=;
  b=ahpkik/bqjDDsANQ2RxK+s6mvJILKdU4IZeS3jnY8NTBV2c6dlPYbt1Z
   bfeRg0j+6754UoFrFdEo9WPmoe9jGl0FToT2zgKDXnbXp/cY/vcS84Lqa
   4TNJCdPjY9xGdmqdP3EqxWGrmf0RkquujOLtMyDdMRzQRna8/jgaZ9CyB
   huM+v2ewEF+HiYNf+f1JKCruUanfi12dPWumPw9QSc6Ryj10+7lqAzRZe
   dLzOv2V5qaey0WoS0tx20vFyVv2ZX4TDyN2UhlzL9A4FMvrU4unSK7wUF
   YGCR9pZiWP9+5rGulnQ87sRcI6k9Z0ZR+CeWdOABJ5SnO2YGco19EnbTf
   Q==;
X-CSE-ConnectionGUID: Is56jYQCRZ2MuWz2iWc/5A==
X-CSE-MsgGUID: OwCxZVNiQ6im2le4OLp2bQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="25109826"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="25109826"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 15:34:21 -0700
X-CSE-ConnectionGUID: CNri6GbxT2+sV6U071cSAg==
X-CSE-MsgGUID: 932OEs2oQa2vnjn6HMTZTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57443540"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.12.215])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 15:34:19 -0700
Date: Thu, 8 Aug 2024 15:34:17 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	cerasuolodomenico@gmail.com, hannes@cmpxchg.org,
	j.granados@samsung.com, lizhijian@fujitsu.com,
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com,
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz,
	willy@infradead.org, dan.j.williams@intel.com, yi.zhang@redhat.com,
	david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v4 0/3] Fixes for memmap accounting
Message-ID: <ZrVH6Z4CeOAIQ9DS@aschofie-mobl2>
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808213437.682006-1-pasha.tatashin@soleen.com>

On Thu, Aug 08, 2024 at 09:34:33PM +0000, Pasha Tatashin wrote:
> Memmap accounting provides us with observability of how much memory is
> used for per-page metadata: i.e. "struct page"'s and "struct page_ext".
> It also provides with information of how much was allocated using
> boot allocator (i.e. not part of MemTotal), and how much was allocated
> using buddy allocated (i.e. part of MemTotal).
> 
> This small series fixes a few problems that were discovered with the
> original patch.

Thanks Pasha!
These fixups unblock the unit tests for dax, nvdimm, cxl.

Tested-by: Alison Schofield <alison.schofield@intel.com>

snip
> 

