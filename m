Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118625EF98
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778009; cv=none; b=D/c2VxNl2CT84MAkcBJYytDhmL/MtkxKNjxhoZkfgwWQ2bZv0MKvo18r+r/9/7+Gwz6RUmKLZkf6uU2zb7Iaqz0+6BxNbzfpnY2SffUAhM95+TzOisyGL+IQ17qNSxKhH74QBkCdWSOmwToe9+Dw22u7uRiML/nczyMcKYlwVhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778009; c=relaxed/simple;
	bh=c8atCJ3U/7wFGQs4Q+7WRAWiKALNQF/8CBLfr+twfZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOznpd2F/ALRQAv+JPCpfm5bW2qR6v8CJFPAX/6Xze6SA9FbL9vCLpSVN6MLq8qwiKt68ta7XvOQbifFHpyRuMqH5cDwoMK1VeaIhMB0ht9tSBqwOtizrUvpbPdKUttMusJC/rUHwhGVs9yHGiwgvl8fj5KziwjJ8/FvhGfBFQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hm5jaseT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hm5jaseT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747778007; x=1779314007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c8atCJ3U/7wFGQs4Q+7WRAWiKALNQF/8CBLfr+twfZ8=;
  b=hm5jaseTQ7IZ/i9wOhA9EnjkqXwp2EFQUnSLbIvHq9gkKsS5tS6fzOPF
   uflgcFivsaTgkZQtaYhrYRcdshzeJT1AO8VGcpvsgM4zS0cZSet2fjYo6
   TjuRr+X3fWGXAGNB8Yy8S7JD0bz445GdzODutAq+Kd53ny37V7kDsI9kI
   KldmT0jARuGbN60eWQe/9i0jnfMnHV64rPEK8Cpen1RcuenLg9wu8ppoA
   OwVn8n6Ish+1XU2pDwarL8KNv/uykztMkAgZb1+/acmDUwJLgo37DBI3r
   4szUftpGHELS3uFwMiYI/+kS3/Fonh7eh7Ge5vmQCI+vyejxv7+2A9xTF
   g==;
X-CSE-ConnectionGUID: ycfV5IJ2Tmik5haa2MRFzw==
X-CSE-MsgGUID: VZZTu3ZtQO+OYP7qyCJQ1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="60371103"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="60371103"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:53:26 -0700
X-CSE-ConnectionGUID: wFnr6vNiSNa3V+oWkMspQg==
X-CSE-MsgGUID: ysgA84ICRCGXh0vuGwoo3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139535269"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.109.92]) ([10.125.109.92])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 14:53:26 -0700
Message-ID: <a0b83d99-d0e2-4bb3-8571-1293540c0b45@intel.com>
Date: Tue, 20 May 2025 14:53:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] cxl: Change sslbis handler to only handle single
 dport
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, alison.schofield@intel.com, ira.weiny@intel.com,
 rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-8-dave.jiang@intel.com>
 <20250520133244.00004cc4@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250520133244.00004cc4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/25 5:32 AM, Jonathan Cameron wrote:
> On Tue, 6 May 2025 17:43:07 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> While cxl_switch_parse_cdat() is harmless to be run multiple times, it is
>> not efficient in the current scheme where one dport is being updated at
>> a time by the memdev probe path. Change the input parameter to the
>> specific dport being updated to pick up the SSLBIS information for just
>> that dport.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Seems reasonable.  Any reason not to yank this one out before
> the rest of the series as a bit of cleanup?

Well given it's only necessary because of the new behavior, probably should leave with the series. Previously it made sense because all the dports have arrived already.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

