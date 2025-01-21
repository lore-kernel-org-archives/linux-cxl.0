Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769441B808
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jan 2025 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491692; cv=none; b=hkTYNHNlFNdWjAy+Xrc/oIM2rza6qBlxCBHKo2HRVDHnQ73iv4UyQZSuqknIMnOooh72+ucSltYE9AzPkLHchlmauI5rKOL8EBO8DXS64/cemPDIYIfhqjuLb5Qj65en1jhoghHGx1X9opgQKGjdJLj0swWP4E4kY/DP7EQ7+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491692; c=relaxed/simple;
	bh=mO0vcmMv6ZHnkaTrUXWNrUk1o5ivRojqGvLu5ZDAIkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kp3CybDjpm7i76BK6BJEILodXNbk3kn0c3fvvwDvcktLp9QTRLN/uE+RA/qpBS26s4TmEtaw30YzA26EiY85C1mapgtAdx/2c+38P5xhixMKZjXhKYWUeBFYWb4t2dS/IJ3Y3lxw4AyIHih9KxjyBE2crvLlHM2e20eJM0gle+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y1FMGvlE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y1FMGvlE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737491691; x=1769027691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mO0vcmMv6ZHnkaTrUXWNrUk1o5ivRojqGvLu5ZDAIkQ=;
  b=Y1FMGvlEo4S7Achu9LCkVwU4UQIfj+qRNgHGw0mTNSTsHgXwSwPFSXJu
   +0qWiyIu1F/AJXRj1Tc83Vxf0soO94ZVQFsDBbmg33zvVQEF476CyS6om
   1iUYip1xcApFKyAERlWsmW7gdafPOip0mX77ZH2DRHoPwa7+3BUguGn7L
   mumZcjBAUqTZnzkdLClqqqBhOqtc8Fbzy2lomS34F9HQgUSMfKlSStteS
   zKoQeFVVik7skxVE33t9bAwMhWXTNVmpqkzoB7tAMwd0tywyv5dni+sp6
   3jQVlKdf4YUSvZU7tX8zpXXgrW3TAJnIhpxqgC2IDXLUZCaSsT8/A7id1
   w==;
X-CSE-ConnectionGUID: svIBYizATbe/XpVAVorlRw==
X-CSE-MsgGUID: mTGtFIKTQSu6B+n9jfALqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48917892"
X-IronPort-AV: E=Sophos;i="6.13,223,1732608000"; 
   d="scan'208";a="48917892"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:34:50 -0800
X-CSE-ConnectionGUID: Pyhap5qpTlucz66CjXnrPQ==
X-CSE-MsgGUID: yUA0hczLS4ij6dxYUBLYPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111537672"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 12:34:49 -0800
Message-ID: <98d5371d-6663-43e4-ae60-92880c173037@intel.com>
Date: Tue, 21 Jan 2025 13:34:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/20] fwctl/cxl: Add CXL feature commands support
 via fwctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20250121203016.GA5556@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250121203016.GA5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/21/25 1:30 PM, Jason Gunthorpe wrote:
> On Fri, Nov 15, 2024 at 02:25:33PM -0700, Dave Jiang wrote:
> 
>> This series add support for CXL feature commands using the FWCTL framework [1].
>> The code is untested and I'm looking for architectural and implementation feedback.
>> While CXL currently has a chardev for user ioctls to send some mailbox
>> commands to a memory device, the fwctl framework provides more security policies
>> that can be a potential vehicle to move CXL ioctl path to that.
> 
> How are things going on the CXL side here? Do we want to make a push
> to get this done in 6.14? (ie starting in two weeks?) This is approx
> the timeline I had in mind for people to get their drivers ready.

Really close. I'm trying to finish testing and wrap up the unit tests on the user side. I'm hoping I can post the v1 post RFC this or next week.

> 
> Thanks,
> Jason
> 

