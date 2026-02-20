Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C12E7BB4
	for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771608243; cv=none; b=mkfkqeNxDQ8jPAXHxS3JbjZZxala6jNcnzRWLLLyqLRpg1q8lZQkkxe/zPZORoiBYCw3sAJi0MnjS748VL48DUL5urLejb0xlJSShqdUnaOzCQuckH1yczxCj2GaSk80y4bbM4/uXg12ogdTo9uRvYbx9eIAOb5QGUCI6x2bzLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771608243; c=relaxed/simple;
	bh=epMyLdEr3FKDyQU44JQxlW8vimAz3rteNSQ7bFLrqzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5geQ/MIGeLLvqcb2/9ITg3qw4kRrwZglj+MRWPQo/C07mmqQmWiGeu/KpajKVRGLpyMO6BrdxvU9y2OGjMrpM5F4BLXLVA8X2xE4VuINyLWZSxVmaqfSYqZY16KcdbHTsiQpJx7XnogcCeSPqTwcCOW1b/fJ7k9RUaEMtkHESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJKh6skq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJKh6skq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771608242; x=1803144242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=epMyLdEr3FKDyQU44JQxlW8vimAz3rteNSQ7bFLrqzM=;
  b=QJKh6skq9D0wK7cbCyvFjEu5mYrqsP1dOeVslMef7fLo6RupkB6ElZYh
   e5FD7HQpAyRc6l4IUSzj3W9Upr7pFw96g3u6dxUaYJEQJrkwGcO4esuKI
   i3O1oZrD6rBJtEtHdyJY1e4CYxsmwGRa+7c0vb/mJIbrcfArV3DB/7fgC
   hn/oEp++KlRSSzWhSx6AAaVpp9OljvLe1U3dxgegNUueLaMy3Uhd8o2cI
   yOmEe6YtdZlFhVem7JZnOpuaN25rNl+P6tIA+kxEDmdNmJxXh2C7a515Y
   FlvxEjNEdgGuLK2mFaCwWqAHzwAdl1Y/5oPv1Qxm8EIFBRQ06lVTArXpX
   Q==;
X-CSE-ConnectionGUID: aGMYNyrySbCpvozTwW7T+w==
X-CSE-MsgGUID: WCkt1ztZRIKDgeGkSIuBOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="84063885"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="84063885"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 09:24:01 -0800
X-CSE-ConnectionGUID: QDmzk9tdTeOzUvKHebspZA==
X-CSE-MsgGUID: Xb18hIX0RracSB1T+gkHIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219407259"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.83]) ([10.125.110.83])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 09:24:00 -0800
Message-ID: <b981e259-ee48-43a8-96ff-bf7f46c71174@intel.com>
Date: Fri, 20 Feb 2026 10:23:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] cxl/mbox: fix undersized payload handling in
 cxl_payload_from_user_allowed()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org
References: <20260220001618.963490-1-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260220001618.963490-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/26 5:16 PM, Davidlohr Bueso wrote:
> Hi,
> 
> The first patch fixes a KSAN splat uncovered by cxl fuzzying, the second
> is a follow up for maintain proper error code semantics.
> 
> Applies against 'next' from cxl.git.
> 
> Thanks!
> 
> Davidlohr Bueso (2):
>   cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()
>   cxl/mbox: return appropriate error in cxl_payload_from_user_allowed()
> 
>  drivers/cxl/core/mbox.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> --
> 2.39.5
> 
> 

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
for the series
