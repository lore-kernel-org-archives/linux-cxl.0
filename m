Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B348F5C;
	Thu,  3 Oct 2024 01:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727918160; cv=none; b=Q6FZKTmmPZJa5dXkMOmzfdhcoQOqGMir3iIXFdLsEk61reEBLyk/knWnVvG5yY4e5b5r+Eh2HEuylJnTzp3/kcZbhe8uRKo6joNNJgnLEoDHYotYvOB0NqFnugeU5ecd32CoPDqKDgjjb8xu9/bHLimdkWoHAwmheO16+1NLRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727918160; c=relaxed/simple;
	bh=KQqO6td/bXrQZAGtOvhFbUpNMxYktrv6PEdKJCe4gQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=luDXsTFSuwSnNkeeCb5OMyB2PeQ6L4BZEvtTV1GN+BJ3D5HG8kI5uiXjfXiIws9w9+3AkSk9VkZbKU9/JSzuKyU1vAteIVh76e7I/QynT0DDZZ1GEMvjku60ECwqoGcRJxAEaEci98WCUdOodtlS1T58eNJbfPnVSXWZnimSTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHPO+0HE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHPO+0HE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727918158; x=1759454158;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=KQqO6td/bXrQZAGtOvhFbUpNMxYktrv6PEdKJCe4gQw=;
  b=EHPO+0HE7etQYkU4cacbcB0wIibfR4CJPM4CEWwfsKxljsOwjIxomNyB
   hYcr7K4FxtThaZ6kMyRzRedU6YDSdRV6N56PBW47NJY/gLIn7OJbEfsih
   GbWstf216lK8iaU84By2cLcNd3qww7rSyxA+eA7HYoqllYSQ+nL786MXg
   gFTaSwAXEWE84vtM6cqBh6SDxkI17lfidQhRV1z7YjecIvo86Zk6q6mdX
   ele+n9KgmtVY9tN8/T7IapleF+Fjvj5lQRCQv2iv9+L/8jcgPDcwQ0kY8
   ++8hthXiS6vWcMeAtih5oc9hLiI0KvBk+vgUPZs0hWnGyjnFAVMBi61G7
   Q==;
X-CSE-ConnectionGUID: MVDdsgbeRwKR+DS2m+9aTA==
X-CSE-MsgGUID: Cssp1JfKSjKhJM3pcG2XZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="38462116"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="38462116"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 18:15:56 -0700
X-CSE-ConnectionGUID: 0nvmkPXPRQ2dc0n/24acng==
X-CSE-MsgGUID: ECJq84YkRc6tysJGIFKGpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="73865522"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 18:15:41 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: <linux-cxl@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,  "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>,  Davidlohr Bueso
 <dave@stgolabs.net>,  Alison Schofield <alison.schofield@intel.com>,
  Vishal Verma <vishal.l.verma@intel.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Alejandro Lucero <alucerop@amd.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Dave Jiang <dave.jiang@intel.com>
Subject: Re: [RFC 4/5] cxl: Set type of region to that of the first endpoint
In-Reply-To: <85a73846-4d8d-4f28-b748-24904b749bca@amd.com> (Ben Cheatham's
	message of "Wed, 2 Oct 2024 16:15:42 -0500")
References: <20240925024647.46735-1-ying.huang@intel.com>
	<20240925024647.46735-5-ying.huang@intel.com>
	<85a73846-4d8d-4f28-b748-24904b749bca@amd.com>
Date: Thu, 03 Oct 2024 09:12:08 +0800
Message-ID: <87a5fmng5z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Ben,

Ben Cheatham <benjamin.cheatham@amd.com> writes:

> On 9/24/24 9:46 PM, Huang Ying wrote:

[snip]

>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 2dee78e9b90c..5633b7316cb3 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
>>  		return sysfs_emit(buf, "accelerator\n");
>>  	case CXL_DECODER_EXPANDER:
>>  		return sysfs_emit(buf, "expander\n");
>> +	default:
>> +		break;
>
> You can drop this imo. It doesn't change anything functionally considering
> the break is immediately followed by a return.

Sorry, I cannot do that.  Otherwise, there will be build error.

> Thanks,
> Ben
>
>>  	}
>>  	return -ENXIO;
>>  }

[snip]

--
Best Regards,
Huang, Ying
