Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794950981;
	b=JahJvHkubMg9jKfmsLNp8iwSFKd0MZnASNcCA0N9/OtrEajqkGFLeYFaCe0ZtovL4eWs
	 2mjy/te5TP09GvgnYTlIIzkmXAZcg+rKjMnwIGq3XTtH/ttYlKe5ncAv5ZPXyKnrvxibV
	 bujipzGu/hpwioBp/z11d6uFlp8Q0X24Xa+jrqxjN45Lfj5ExUsCMDrY4OQ7YRYgv/LuL
	 pxTDbu4SoOhOcT2gBo/65OFVXu5J/M6Ue5g1tQuDizhVgV1Z55JIWRnhDzIQb8n3Sgr9y
	 MJQWb/oEY/IIt94KpkE/zBgIv5JjHg8YD6Rw8rExFr8K8WWTHCu4XN/hys0eRzOJsyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794950981;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=R39jlSRLHuowY1OW2bymJQR0/EvAjOLpuAU1c80ue58=;
	b=5QW7tmcAnfp31HpsS05L/99BNPallsX8BFAe+rlTxRHpkiGpL31veeJ1FR+v1FIUH6Z4
	 fCSe9h2tcBTBsHoC8Lg/5Qj3kGLfYh2rabq7VGu4cpd3MldtypH3hvDmPQPWj6+/2uvGz
	 CQJC3xPPitMEXHDEBxkG/44zdNYj0HdEUOPjMso95kGht3WjjO3cIl9xD4gj3uyLymvnt
	 SPjNqWlAEZLhPt1QHLtklMhWykpF7sVMvdHGnU5s9dfU0MYFkZkynANtXspiJ0jkphTaC
	 n8McXqBuqzcKLyH8p7OVodVTSEd5yXzaK3rBAt6v9fzjxWbPE7UnRIhF+848/X4H9Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gi3LXHFL;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C9606A31C
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 21:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 327C9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Gi3LXHFL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794950981; x=1826486981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7g83xKvr2ya5SeK0no3ZESitQqnlDY1qrxXh4YonjrE=;
  b=Gi3LXHFLYwKEpWExeaVJ+Nf+hUH80fIu2D2NFg7XzPC2tZtqs2abpcRr
   rSxf0DgsxtPIGAuQIBD6TUl/SuIhCRmbdMhaZkQHrs8GJQUs064y62PgW
   oH1th/BOOmMTDp0biRUQ7WBzrHnWktFzQrRm/boEEnCDnJIDwd+WVZyS2
   pEzQvntSoq6hGhKmmRNgPhOyqkhxKmZhSOp7SizMNlXjq/2pgJDjnoBY+
   lOMRgmmF+Rw0JtGG8A2JgPZ4tx2qH1iRpgLTkg/4SG6DCC++7AtP5rlNk
   EID67GGdbYfZNZ/FCxJMd+/a8k2+nhdSnjwjvVIz9q5SiW9NJfW0fnICs
   g==;
X-CSE-ConnectionGUID: TwJTujlwTDSDyGbF51Espg==
X-CSE-MsgGUID: HXMzeFDOQeq0A1U3hw19Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3782045"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3782045"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 13:29:40 -0800
X-CSE-ConnectionGUID: 9jvK7xd6T56cOln8+jkNiw==
X-CSE-MsgGUID: WUOusy6KSymigS06NUV6GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9935500"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 13:29:39 -0800
Message-ID: <8f8f6e8b-02d5-4812-88ea-7cd061659428@intel.com>
Date: Tue, 17 Nov 2026 14:29:38 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cxl/region: Carry the effective interleave state
 through target setup
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1794942093.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <cover.1794942093.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/17/26 12:14 PM, Alison Schofield wrote:
> Changes in v2:
> - Update comment to note a read from register, not firmware (Jonathan)
> v1: https://lore.kernel.org/linux-cxl/cover.1794010889.git.alison.schofield@intel.com/
> 
> 
> This replaces "cxl: Allow passthrough decoders with >16K granularity"[1]
> 
> Review of that series showed the >16K failure was actually a symptom of a
> pre-existing problem. The switch decoder setup used the parent decoder
> object to carry the interleave state down the hierarchy, and a passthrough
> decoder's granularity is a hardware don't-care.
> 
> Patch 1 carries the effective interleave ways and granularity in each
> port's region reference. The approach was discussed here [2].
> 
> Patches 2 and 3 add support for cxl_test coverage.
> 
> Based on cxl/for-7.5/cxl-port-refactor
> 
> [1] https://lore.kernel.org/linux-cxl/cover.1788487020.git.alison.schofield@intel.com/
> [2] https://lore.kernel.org/linux-cxl/aqnWLH-nrXk6BYqM@aschofie-mobl2.lan/
> 
> 
> Alison Schofield (3):
>   cxl/region: Carry the effective interleave state through target setup
>   cxl/test: Add a 2-way 16K root decoder for passthrough testing
>   cxl/test: Program a don't-care granularity into the passthrough host
>     bridge
> 
>  drivers/cxl/core/region.c    | 28 +++++++++++++----
>  drivers/cxl/cxl.h            |  5 +++
>  tools/testing/cxl/test/cxl.c | 61 +++++++++++++++++++++++++++++++-----
>  3 files changed, 81 insertions(+), 13 deletions(-)
> 
> 
> base-commit: 0e3e8b653ca3ab145aced729861cf0d1a06da69e

Applied to cxl/next:
d0b1ef56c8d1 cxl/test: Program a don't-care granularity into the passthrough host bridge
46857d9acd05 cxl/test: Add a 2-way 16K root decoder for passthrough testing
e90734309ce3 cxl/region: Carry the effective interleave state through target setup

