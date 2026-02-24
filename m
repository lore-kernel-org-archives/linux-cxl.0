Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A0A274B5C
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947583; cv=none; b=UM6rlYvxqnf0ix3hHs9GmkjC2oUJ1h8M4afwhfZ+191jnceSwlCbXSXZEpQ3I2B6EkPbi/ZFThNKQtXw2CvDYmHh/fqbIF6GwVI9QH5mVvgSMnDWLODhowjolwcAQWgC6oEQgY9MhD+6lW/fF4fX+ppVZruxNJjv+YKhvoaD56s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947583; c=relaxed/simple;
	bh=q8PV8wZg2ciA5IeIjW2V8xqkieEOI+UqyfdZ+f7RuDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUY2QAqss31D4NI3iTHbQGBM8odb7XFgMT6uew/quJyY76qqYWA823avwcPI7pOJlnPz00ZE1fQKj71p/9Eahj2vD5ttBW0BeTWEIH+3YHOBkxVzTx/MdWcCD3hh+U1aDbvLbWb/9jpVBverzM1DG8kwHqfKJp/CvTSJ6yjHvPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lw7uODdc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lw7uODdc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771947582; x=1803483582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q8PV8wZg2ciA5IeIjW2V8xqkieEOI+UqyfdZ+f7RuDc=;
  b=lw7uODdceeCLWsL6dwyMB8vb2GsFbgeeYNwWZsNB3LzD0+2U23p28RPG
   Vx7VImAEn2cmJHvoFzOOXzdLrRxd72HA1GTh0rwO/uTA7K+VsYFNggfks
   525dB129JgC2gidIfljQBcQSFAx4YmrDCd+IbaFFkHTOrcyVrBZGcyn1e
   o75rfR4bppKr+UD1Ys8E0isWjlApAY3EathsaOa+Nk5AMoBOuJKWFYEJx
   8t/KK1CDnGYybjnv4tOI05MyXkyeVokC7vEFpco6urq4UaOk6dJN8tUt5
   rHn/0JTZAqgmf1X0VGwQYLoQgc2IWIgb+Scd+imKNvMYkd5MwxuKdEJ/8
   Q==;
X-CSE-ConnectionGUID: kf5UNRCbSv+IlVba1YrQug==
X-CSE-MsgGUID: SHT2oyHqSiGnzMGXRQwLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76829779"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76829779"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:39:36 -0800
X-CSE-ConnectionGUID: JUZOLPUbStuaiyXMqWKf8Q==
X-CSE-MsgGUID: L53u6CnoReeAOo6J2+nwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253689112"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.22]) ([10.125.111.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:39:36 -0800
Message-ID: <b785af3a-3c78-46eb-9ced-9dd0723f3ba9@intel.com>
Date: Tue, 24 Feb 2026 08:39:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] cxl region changes for Type2 support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224152645.3441489-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 8:26 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for Type2 devices/drivers support, these next patches
> adapt the cxl region code for required Type2 functionality preserving
> current functionality.
> 
> Alejandro Lucero (3):
>   cxl: Make region type based on endpoint type
>   cxl/region: Factor out interleave ways setup
>   cxl/region: Factor out interleave granularity setup
> 
>  drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
>  1 file changed, 56 insertions(+), 31 deletions(-)
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Does this set depends on the preparation set [1] or is independent?

[1]: https://lore.kernel.org/linux-cxl/20260223142633.2994082-1-alejandro.lucero-palau@amd.com/T/#t
