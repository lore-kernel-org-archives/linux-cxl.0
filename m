Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D990B1D554
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 18:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988039; cv=none; b=btSvXwrSYohR1cYH8K6fwDwmbcsBEXNc3SJYpJLhymiApbvU3HRwMquQzgauM2JPQUmNW7nk77E09kwNS6yXtyGbZR566Hqg9Dxfpc0VLWd1UwdG1RoB6t89KOo5RvnvI9mbMsF6cg3dHejY4IQyw6sXSjXssW3xbj9pMw1QcgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988039; c=relaxed/simple;
	bh=DJOG0eH01tRiWwTflmhA7jMWqa5VUWoJSQZielcyjlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unEf161oVBClOPRm8X3xU7DICFu4R9VkFkaXR1K/y3NhGmZ/rb71FlvWi2d9EF4CTUIpZyxhyL73Dw2wulZBB6QZj4L3VcgQjrluAfy71F5stQ3GHl6vVVTRnTX4QDg8reWScUogGdeY7EQQE1C884gy17gAgMfBEFpsh3Q2BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C6bwV55Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C6bwV55Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739988038; x=1771524038;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DJOG0eH01tRiWwTflmhA7jMWqa5VUWoJSQZielcyjlo=;
  b=C6bwV55QUWMblJQ/fXZzXwNcRCx0EPllSe/aO+sYpsZpDLTZZmmHlnB2
   LW9tWAnl17UHfIUmV0sAkGl8KK8fsgbxxtngcekHJXcFoU6BxdNEC3yp/
   OtsXikIYxw85wacIxIlYeXMBJtYkKuDvsxog3vJa3dWYnR7+YHXpYkI3V
   /71nfVdIWYzmkLwxq4vwL5QHEUYM5WsMC5sb/6/TM5BIYrjWeAzHQEJZx
   X1Q1kjTgYJf8ZAu3jY8VEDGOh5tNkEXRpR1ltWoFIdShZHiAnhnHJjidK
   jp4klDFUZYhQiteH7u/JsdW7l+ED36gskXQlJyTGGiRDzDdC6QQVugxyt
   g==;
X-CSE-ConnectionGUID: 9y6bZU7BQ5+h3b1mBDTOVA==
X-CSE-MsgGUID: 94BNL7AQSnutxq12sdfeAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40862943"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="40862943"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:00:38 -0800
X-CSE-ConnectionGUID: 9nTHMdo6QjOC5gIuBW+NAQ==
X-CSE-MsgGUID: R2CFYuh0Sluc0ka5vTGUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119765974"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:00:34 -0800
Message-ID: <06a82d3c-b962-49dc-80a2-e34c942fe86c@intel.com>
Date: Wed, 19 Feb 2025 11:00:32 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] cxl: Add support for fwctl RPC command to enable
 CXL feature commands
To: Jason Gunthorpe <jgg@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 shiju.jose@huawei.com, saeed@kernel.org
References: <20250218225721.2682235-1-dave.jiang@intel.com>
 <20250218225721.2682235-10-dave.jiang@intel.com>
 <20250219175312.000070ec@huawei.com> <20250219175635.GB28076@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219175635.GB28076@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/19/25 10:56 AM, Jason Gunthorpe wrote:
> On Wed, Feb 19, 2025 at 05:53:12PM +0000, Jonathan Cameron wrote:
> 
>> I'm probably missing something but I don't understand the need for
>> __DECLARE_FLEXIBLE_ARRAY() in the unions.  We always seem to use one of
>> the structs (some of which have trailing flexible arrays).
> 
> Can you even use those defines in a uapi header???

Yes. It's defined in uapi/linux/stddef.h. I compiled and tested against the unit test in userspace. No issues.

> 
> Jason
> 

