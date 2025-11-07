Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE332E142;
	Fri,  7 Nov 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530631; cv=none; b=tcXQ7vYUbZL+kG7WepA3xKIsgyW4lghye6vHek3mRCCoXjfQS86y4XNLlLE4qX3u0l9s5Du/WeaLIvTcVSg5k2U6NalHK6puf39G9Zjdel34wr9PEGCm+5tVqfFW5ISBoq4XpWuSZ4/zlAH/n9yyGb9e3C6UrPlhfSJKQBVNVkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530631; c=relaxed/simple;
	bh=3ZTyuc+Wp4bQ82h+11yPVh1PjxZeJ7ckgHVQT3F+M64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=py9S/fj5HmWJx1n7vO4jCrKeSBafnMFBgpu7O++3fjEAhijypTjlRa70uHNaLjIg7rUBdnXa9QwvXvqoVprw8WaJXSnV+ZtgtJlLv4svDBZUGEr4iBlvrdV5bUJlDHgpMU4HQVV0I6mH40WJvdNtCnd+AnHP9Qmw6ugO4SKFlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aKVVNeBD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aKVVNeBD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762530630; x=1794066630;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3ZTyuc+Wp4bQ82h+11yPVh1PjxZeJ7ckgHVQT3F+M64=;
  b=aKVVNeBDMfltVL0ovcKpzDzoG/YdyqJWpZT+lx3Lsmhs9IELHf1RJd/p
   nbUmVUZsycPmCTageg9tkfvWeUhYoHHSyAfuwrTqf1wqn0a3Q5bI3MQi6
   FxWwPp3V+qGMJj+PxTwNpA5Dx2j2ZqZm2t7lY0QBzXosk5cVMDQzrqm2U
   Fe3Pq7qjVgmhpsuX3p1JuDGPv2gNwaTv6FGbWQC4SN+57Zd0l+yf9+XB4
   pmKcXcOt2WIY0x1bJ94rvbUrjjSxsykt9NY8hjA+A37J1AFYFDXsEl50O
   Kk+uG1/yNUJaQRK06abL7BgWU/LNdU9E2yHuIptBMuTE4YTJ3qoBtTLA/
   w==;
X-CSE-ConnectionGUID: 8VcU9cb4QLeDRd3EYLQOEQ==
X-CSE-MsgGUID: ZdA6tHEjRNufODlC4JoVbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151800"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="90151800"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 07:50:29 -0800
X-CSE-ConnectionGUID: uvcb/xkXRPiTvOzkOdITOg==
X-CSE-MsgGUID: m2vckvMPR2CKkOEn/kN/Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; 
   d="scan'208";a="187321587"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.112]) ([10.125.111.112])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 07:50:28 -0800
Message-ID: <ce7569d5-e3fb-42b8-8dee-dd1fcf76a733@intel.com>
Date: Fri, 7 Nov 2025 08:50:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/14] cxl: Simplify cxl_root_ops allocation and
 handling
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-6-rrichter@amd.com>
 <1ef139d0-2a27-40aa-8b08-09d9ec89791d@intel.com>
 <b361d492-1cc1-4057-8114-851240dd64d6@intel.com>
 <aQ4UADgeq6NH1lwl@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aQ4UADgeq6NH1lwl@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/25 8:45 AM, Robert Richter wrote:
> On 04.11.25 16:02:04, Dave Jiang wrote:
>>
>>
>> On 11/3/25 2:53 PM, Dave Jiang wrote:
>>>
>>>
>>> On 11/3/25 11:47 AM, Robert Richter wrote:
>>>> A root port's callback handlers are collected in struct cxl_root_ops.
>>>> The structure is dynamically allocated, though it contains only a
>>>> single pointer in it. This also requires to check two pointers to
>>>> check for the existance of a callback.
>>>>
>>>> Simplify the allocation, release and handler check by embedding the
>>>> ops statical in struct cxl_root.
>>>>
>>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>>
> 
>> Thought about it for a bit, should the callback be with 'cxl_rd_ops'
>> and the rest of the translation functions under the root decoder
>> rather than cxl_root_ops with the cxl root? That seems to be the
>> better fit.
> 
> The handler for address translation is needed to determine the root
> decoders. Because of that the cxl_rd_ops cannot be used to hold the
> callback reference. The use of cxl_root_ops works since the pci tree
> can be walked to get the cxl root without any cxl specific knowledge.
> A description of that is already in the patch that adds the callback.

Ok that is fair.

> 
> I haven't evaluated moving qos to cxl_rd_ops as this is not the scope
> of the series.

The qos callback belongs with the cxl_root since the ACPI query is against the host bridge.> 
> -Robert

