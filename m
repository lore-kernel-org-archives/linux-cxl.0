Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942958;
	b=FGq6kmT4beNki+dudevzkbXr0+LZectBHHZlqRbbG06peI14Yl2F1ZM91UHRzVTIU+LK
	 Jqmr/+bW+PKtHQU0Y3nK4uVpfQDtn8G+EIwaTuI325j8h3SaBL1Fq0ogmSMpwZJIOYIUK
	 DrFxFnV9cRKrXdSUaAA1YHxftaIip9X6plyCyxkYWkVztdLntdfd2UnvGsL7DKWCmM6D5
	 hoZlHRa82PNxDGBE5/Jy62gNFI/9SjEEFm+j0Wjg7ycYB/pyUp3uoeYcmOf4GGBz1WBpU
	 8nZoH3QU03hPwyqeMZ39iRSPCJ5BEwXnHY619GH4XXMbE7kVaM5aInNXQIg+N2/vXIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942958;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=z1XIj3u2p+B7xtdNhsp7bEFDolOSVUBzrZKzKIAnaTY=;
	b=a4mXga35cZ/K/nXenoiCUEr2x/leG6+ZNuSOGr//kapUTPpwcbPAc/DOqYd1C835g62M
	 rwHTQa8BrvwPTAcrwmMKAqHrmLu8GTwI6G8wIjGR07dHoOiWqYSs6ZH9PUIAzJh9+/OOl
	 +jDYu5EH9Pam1BmjEi8d6hTPq4KLjRqlpL5rAQCthtrxCaEG+jR0OM+qKdA2VVMDevBID
	 S6DAGE9Abs1+ookE4Lf9BCFCb4CRP59rDMaXJOl8xW8HPlXFdkh9JkYqhOIaXWw+sxutP
	 71nLa/rSHOKgFbRynqThuid3ud/181srcXK3DxYWa5VKaa7rfZ0qrBGMGbwK6QiM1iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N79QE78p;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E9606A32F
	for <linux-cxl@vger.kernel.org>; Tue, 17 Nov 2026 19:15:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 501E9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N79QE78p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794942958; x=1826478958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q1kA3hci/tY3CtbqDZf3Zx6JvETK8Nf5sgH2JqYLSD8=;
  b=N79QE78paBGHC4iDKUkfH243CeJQHKR3B0XARkH83N2PGcwzun42fYq+
   vMLbcfHBFUT6wzJPp+zO+8/JmJ/7UWRrZ2kTl/7MVSRjXV+Qb+XGbMVg1
   FBeLGwpXHfU8pI1M2nD11JI03r4X+md0IRoXvJEABlhP6r4Avn0oJ2Huv
   Ky6WLOEzLF0XUUJvTIFgqZv7mxXgEWfuc0Huq99yaRC48zbjvVH2gYn3h
   Rwd97jFltpdfYFlkj+XHhHUJhu/7ySUZZZaIX766KtcoaVRBjExln/kiF
   MzscuwzxbCI8lfrXHkeECCi8pxo0nevwetm8/P3bAthvNFQe+tTyI7RzQ
   w==;
X-CSE-ConnectionGUID: zjKe7j5NQuafGhVrB3e7NA==
X-CSE-MsgGUID: Fl6QYgX3SAqJcpwnbYxPDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3763183"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3763183"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:15:57 -0800
X-CSE-ConnectionGUID: FOZ5tMvuQpK3ZTnGVKSk1Q==
X-CSE-MsgGUID: Mw6rxSepSOafbfM6OROuKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9994314"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.197]) ([10.125.108.197])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 11:15:56 -0800
Message-ID: <815970dd-f8a1-4815-9eff-5c715441738e@intel.com>
Date: Tue, 17 Nov 2026 12:15:55 -0700
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
Subject: Re: [PATCH v4 2/2] cxl/Documentation: Describe clearing a region
 targetN position
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
References: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
 <4d2fa8561a443d9859ca08c04950e6c15e168f98.1793724885.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <4d2fa8561a443d9859ca08c04950e6c15e168f98.1793724885.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/26 10:07 AM, Alison Schofield wrote:
> The region targetN ABI documents that writing to an occupied position
> returns EBUSY, but does not describe how to clear the position after
> assigning the wrong endpoint decoder.
> 
> Document how to clear a position by writing an empty string, how clearing a
> position decommits a committed region, and how the region can be committed
> again after all positions are filled.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/next:
726d9be5f09e
> ---
> 
> Changes in v4:
> - Minor wordsmithing in commit log
> v3: https://lore.kernel.org/linux-cxl/e87248b8d13d3f07741243a45891365450c66881.1793653629.git.alison.schofield@intel.com/
> 
> Changes in v3:
> - Restore the original entry text and append how to clear a position
> v2: https://lore.kernel.org/linux-cxl/efa1a098550077dc3571796ba0102ddabe1e9b0d.1792989098.git.alison.schofield@intel.com/
> 
> Changes in v2:
> - Say that writing the endpoint decoder already at a position succeeds
> - Split the entry into paragraphs and drop the v1 error code reordering
> v1: https://lore.kernel.org/linux-cxl/a007c751d88ee64c9d0b7bb3c69a486c42358b36.1790829690.git.alison.schofield@intel.com/
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7352dbd70bc7..3629c983f05c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -568,6 +568,10 @@ Description:
>  		not an endpoint decoder. Once all positions have been
>  		successfully written a final validation for decode conflicts is
>  		performed before activating the region.
> +		To clear a position, for example to replace an endpoint
> +		decoder, write an empty string (echo > targetX). Clearing
> +		a position in a committed region also decommits the region.
> +		It can be committed again after all positions are filled.
>  
>  
>  What:		/sys/bus/cxl/devices/regionZ/commit

