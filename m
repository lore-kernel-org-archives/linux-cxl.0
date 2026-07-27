Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676CD378D8E
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195425; cv=none; b=jYMeIGd2VrW7ch0PQ5iTrcbubO/LNCf+2/vWywzqZi2MtQLoPf7ou1vBmrMK5NCrqi4dTLRLff2DfKGg5Fk5M+jGVPXD81gmtkphi178DpF9yRezLzf7EoL6a7cXGxRhIitpcWnh+4pLGJEn9nqfaFtCBR7n5msdixeeD6/Sqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195425; c=relaxed/simple;
	bh=INO2RnqkQfU7F2hEedFhkI4vqt3eNomx+tUYO4YEELA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K29TkLibyHyXLGVYT3NfGt1GmUDelCYuUpusOnUHORtW5BznRCJ2HOQ9ABh5NVzNS7Xc4c9SPYa03/eM4aHgovRCSN8GBNjWAud1miHb78rRsyCK5D6pw0dZzNCwbjc+GIMawDF85bTDn+yMZfqgUrnF6FfGPfbXEAsYRWOs1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMVyQoj5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMVyQoj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785195424; x=1816731424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=INO2RnqkQfU7F2hEedFhkI4vqt3eNomx+tUYO4YEELA=;
  b=SMVyQoj5I6To4j50kfELPq+MGfnhO1I8Pg1oedlOU4huU57Ty9kT0l8r
   9DPVCVAJDBUC5uGz5Qr/c//3nwYCAD93aTYVjOjNKxuhHHF6n/9YjL4fS
   VAJNZlFD+uqxvzFlSDo8v4Mzwav7rOqWXTfF6Ol8oeAIdA1Y4ViFYpkXt
   7tav8mknR5RrGl0ME56clbMMaNe2gCyRiniZr/8uyDBOjAHeM+PRNl+eQ
   CuKLOQ+EBVc+NlXKAUqy+OTMr2lVcA80bswfA6C/o2zyvh3TSH1Dj8qAD
   geQmBtg/xjQA00iaqsbre3c5lBbblgX5+woFVkz5nMk+g5I9PKBZ8xW7B
   w==;
X-CSE-ConnectionGUID: yWRBZmQ4QhWlWaJGFBSN7g==
X-CSE-MsgGUID: AcqkhM2MSvKHcDd5rX929g==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="85961349"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="85961349"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 16:37:01 -0700
X-CSE-ConnectionGUID: Xry3sSs7TXWCvzVu+uw1ZA==
X-CSE-MsgGUID: p2u2D6qATXqvQEyM+TR9IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="259602060"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.47]) ([10.125.111.47])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 16:37:00 -0700
Message-ID: <9b3d1137-bc36-4abb-9b29-c17b0efe64ef@intel.com>
Date: Mon, 27 Jul 2026 16:36:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl: Allow passthrough decoders with >16K
 granularity
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1784940306.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <cover.1784940306.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/24/26 6:08 PM, Alison Schofield wrote:
> Changes in v3:
> - Program the real IG encoding for an encodable non-interleaving granularity
>   instead of always writing EIG=0 (RichardC, Sashiko)
> - Update Patch 1 commit msg text and this cover letter text per above change
> Link to v2:
> https://lore.kernel.org/linux-cxl/cover.1783795720.git.alison.schofield@intel.com/
> 

For the series:
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

DJ

> Changes in v2:
> - Rebased on Linux 7.2-rc1
> - Only v1 feedback was from Sashiko and that was not an issue
> Link to v1:
> https://lore.kernel.org/linux-cxl/cover.1781136281.git.alison.schofield@intel.com/
> 
> Sashiko reported [1] that region setup rejects valid topologies
> containing a passthrough decoder beneath a wide parent interleave. In
> these configurations, a passthrough decoder can compute a granularity
> above the 16K maximum encodable in the interleave granularity (IG)
> field even though non-interleaving decoders do not consume that field.
> 
> The first patch avoids validating the interleave granularity of
> non-interleaving decoders, encodes the IG field as a don't-care
> only when the computed granularity is not encodable, and updates
> the sysfs ABI documentation accordingly.
> 
> The second patch extends cxl-test with a topology that allows a CXL
> unit test to cover this case.
> 
> A unit test update for this case is posted for review [2].
> 
> [1] https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
> [2] https://lore.kernel.org/all/cover.1781136221.git.alison.schofield@intel.com/
> 
> 
> Alison Schofield (2):
>   cxl/region: Allow passthrough decoders with >16K granularity
>   cxl/test: Add a 2-way 16K root decoder for passthrough testing
> 
>  Documentation/ABI/testing/sysfs-bus-cxl |  5 ++-
>  drivers/cxl/core/hdm.c                  |  8 ++++-
>  drivers/cxl/core/region.c               | 47 ++++++++++++++----------
>  tools/testing/cxl/test/cxl.c            | 48 +++++++++++++++++++++++--
>  4 files changed, 85 insertions(+), 23 deletions(-)
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482

