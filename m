Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2D239E83
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140332; cv=none; b=PYxGZOLNnPW9AcI9oxBhbqsMHigavfDtJYD4VEty/nEV1y5DRjLylsl+ZQk9BqCpcXkAYiceQEiDto2YExutFMn/6GcbuEZ4ye9Uw/KOaqQuRt1A7Li1EuX6YTPgz/y++sOqoyp9AOGC/9imRlSlkAti4qhIVMuJyEVf+Ap9jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140332; c=relaxed/simple;
	bh=kaAziWisyMijNl9tShFOuYvUQT9571vUPg0HhG0YAlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XG2fENaLhsrWwHuL+eD3DxRm1O+iWtr3ItbnZy1B57p2M4j1wkGIrS0G/YRw+IXJnnF0R9M+8Ky4FCQSJiiNnNMsUyiuecbNLKerj0oY4nvckDHYBSPgHMNOoAfPMgiA/AaxL+LuR1hRZqQKNFwF8MFUDTqRSGVZw2u4reCDZvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/p8vfkj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/p8vfkj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753140330; x=1784676330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kaAziWisyMijNl9tShFOuYvUQT9571vUPg0HhG0YAlg=;
  b=b/p8vfkjHQ84HOmEW8sVQJ9PKNJhcBRsX6ZiG4RJESnJHIQD4Xbv2dZa
   g/qbIoAM7bfz/nZj8PXJhTkpy5b0GPNR/kFivnDKFP23nsnW5X85Xi/0s
   KtObC4lyzxHe+MCY86oIJ+bPOMyQVKXMhiQ6rFGypMRTNgvXoF3Y8fu+1
   u6szzxIltBX/DMXxzTfkHqosmP4nVwoUaUZsvndUcm6csQU8cylTY1DsM
   PZghIdI/7DyU5jtp+5Vnyhg3Ypp4LKlTZMrrvgz40AB45urRFQTFEzxq5
   3Kbk0MHY7JulgRQ1yKl+E/h3BOWe3KR/glSE+zfNP7Fmfc18R29uBihci
   g==;
X-CSE-ConnectionGUID: tJi6QK+4T7a3bu/e7Mw99Q==
X-CSE-MsgGUID: 9QFYSO+bRUWfAKPibnpZ6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="72827526"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="72827526"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:25:29 -0700
X-CSE-ConnectionGUID: TEV7CWKCTsuE+LJaVWlvYQ==
X-CSE-MsgGUID: Zj8wNwOMTxm0X6HVqoxTqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="189960812"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.247.118.153]) ([10.247.118.153])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 16:25:24 -0700
Message-ID: <50fa1adf-7172-4766-8df9-f3ee8966f590@intel.com>
Date: Mon, 21 Jul 2025 16:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] cxl: Change sslbis handler to only handle single
 dport
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Gregory Price <gourry@gourry.net>, Li Ming <ming.li@zohomail.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-8-dave.jiang@intel.com>
 <aH7KsgySE8q6J-wB@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aH7KsgySE8q6J-wB@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 4:18 PM, Robert Richter wrote:
> On 14.07.25 15:35:24, Dave Jiang wrote:
>> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
>> not efficient in the current scheme where one dport is being updated at
>> a time by the memdev probe path. Change the input parameter to the
>> specific dport being updated to pick up the SSLBIS information for just
>> that dport.
> 
> I more like the approach to read the table once that collects all the
> data in a struct as it is done for the xormaps. Have you considered
> this?
>

Ok let me take a look.

>>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/cdat.c | 23 ++++++++++-------------
>>  drivers/cxl/core/port.c |  2 +-
>>  drivers/cxl/cxl.h       |  2 +-
>>  3 files changed, 12 insertions(+), 15 deletions(-)

