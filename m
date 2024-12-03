Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF1F207A01
	for <linux-cxl@vger.kernel.org>; Tue,  3 Dec 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733260095; cv=none; b=HNnOq/KF5Og2Dl3p1Osbmprpf8Se0dAwWxowZnAP9EQiu71EL66w2K1nrBOgYJ9FaEI0jdP9avcxbgV21MCZ0h3CUfkSpAiXwPUMhjh1cGpJPLnXj+X1VM+kct5GSIZoXyypdhfhtnlfBDgXs53hpRaG6h7Ut8KwsBW+4IoE+vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733260095; c=relaxed/simple;
	bh=IY4XD/vy89LazVmv3e3/73IWifDG5ua0/zxr9O0d2hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrOd/shA0iMxh88k9mXFcM/uDMFiv5CJA9YUmpGiWRiOme9lEx5JDKiBqMZk4XQwwt4Aw489eiMoJUQPQx4if4uJuTAqOoqaH8Obv/9VvaWwmNfoOrW/KwmHWFwN67R9e+dSFd85siTg1MHZ4dFafKoIvc+vErAKkxAjZYYL75w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FJEtrIbY; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FJEtrIbY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733260093; x=1764796093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IY4XD/vy89LazVmv3e3/73IWifDG5ua0/zxr9O0d2hM=;
  b=FJEtrIbYUSV3Vjks6GTc2CJozwJ239JubX1CjUFu/EY1oCo7oAMuE6Y4
   EF5tY9r5yVmpiiKZ1DXLb8+JhHLHF+LG2khiZzNBEnn9LWzRoWL5cLYKE
   0S4huSWwQKB/iYvWOTJiHeAf15Tz8wZKSN43WL+kffQp6zb6VJphqt/0U
   64ouOkBLVI89vdrCQYxrqStxrdQ5e24mjG6nFq8GqX/+jRNLDKWXeIbJU
   HEH0X65a0St7XLxRXF71WZtdADwyd0wNgZDJIPBSICNLebS+n831el1dr
   mnkpwxlGvbIchh2/x7SuH39ZzxZSVEBQoP6IdvY4FuqkeLL3rpAKAT+KJ
   Q==;
X-CSE-ConnectionGUID: Q93NQ+X6SgW5JCNGWqC4Qg==
X-CSE-MsgGUID: EQebUzVBQfqcXzkqn4UH4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44894174"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="44894174"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:07:59 -0800
X-CSE-ConnectionGUID: MMc3/tiMQlmYbQWNZWPSLQ==
X-CSE-MsgGUID: UG3BUli/S72drUNFL0oqIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="131010581"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.111.238]) ([10.125.111.238])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:07:58 -0800
Message-ID: <26d8e8fc-e631-4ef4-9e04-e1e4fda03ea5@intel.com>
Date: Tue, 3 Dec 2024 14:07:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 20/20] fwctl/cxl: Add documentation to FWCTL CXL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net,
 jgg@nvidia.com, shiju.jose@huawei.com
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-21-dave.jiang@intel.com>
 <20241122152655.0000717d@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241122152655.0000717d@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/22/24 8:26 AM, Jonathan Cameron wrote:
> On Fri, 15 Nov 2024 14:25:53 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> Add policy and operational documentation for FWCTL CXL.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  .../userspace-api/fwctl/fwctl-cxl.rst         | 91 +++++++++++++++++++
>>  Documentation/userspace-api/fwctl/index.rst   |  1 +
>>  2 files changed, 92 insertions(+)
>>  create mode 100644 Documentation/userspace-api/fwctl/fwctl-cxl.rst
>>
>> diff --git a/Documentation/userspace-api/fwctl/fwctl-cxl.rst b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
>> new file mode 100644
>> index 000000000000..158e9aa45609
>> --- /dev/null
>> +++ b/Documentation/userspace-api/fwctl/fwctl-cxl.rst
>> @@ -0,0 +1,91 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +================
>> +fwctl cxl driver
>> +================
>> +
>> +:Author: Dave Jiang
>> +
>> +Overview
>> +========
>> +
>> +The CXL spec defines a set of commands that can be issued to the mailbox of a
>> +CXL device or switch. It also left room for vendor specific commands to be
>> +issued to the mailbox as well. fwctl provides a path to issue a set of allowed
>> +mailbox commands from user space to the device moderated by the kernel driver.
>> +
>> +While there are a large set of mailbox commands, only the feature related
>> +commands will be allowed to be issued through fwctl initially. No background
>> +commands will be supported at this time.
>> +
>> +CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
>> +CXL spec r3.1 8.2.9.6.2 Get Feature (Opcode 0501h)
>> +CXL spec r3.1 8.2.9.6.3 Set Feature (Opcode 0502h)
>> +
>> +The "Get Supported Features" return data may be filtered by the kernel driver to
>> +drop any features that are forbidden by the kernel or being exclusively used by
>> +the kernel. The "Get Supported Featuers" command falls under the fwctl policy
> spell check. Features
> 
>> +of FWCTL_RPC_CONFIGURATION.
> As per earlier feedback I think we need to reject get/set even if they are not
> listed in get supported features so that bad userspace doesn't get away
> with sending them anyway.  This is particularly necessary as I suspect we'll
> be removing features in the long run from what we let be accessed this way.
> 
> I'm not sure how we document the potential for removal of a feature that
> was reported by an earlier kernel.

Userspace should query the driver for whatever features that are "available". Given one feature may exist for a device while another does not? So maybe the expectation from the app should be feature does not exist unless reported by the driver that it exists. 

> 
> Jonathan
> 
> 
> 
> 

