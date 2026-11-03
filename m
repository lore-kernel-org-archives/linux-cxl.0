Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747710;
	b=inkKAGVMylPRVsuOmmHZSJeOReasx4LPl1T/F0ArtWFRUN88jbMKmQ97HblkzfWwTU+2
	 PdY2bMddczZmQhu3ZkQsRM761vdrmmiAAoNS/bwAURSJ8M366LSfugjRow6vT4tmGF4kt
	 i4xHpJygMWkA5F9ZALsUtE74G8C8sQAXi7O00s7c3yz0p/yW3mUU15pKCy16Zt1JSASYs
	 sn8nJ2ITkG/RZjaot1WdmAUHsQJOxsb35UBlflncNMRkn7fPd3gN9UU6TaLihXbnjBuHv
	 vI0PfYCox3dazmdKbXzxTJtQbegnwNPfLW/A9aJkLQzdgpRGHEtAmdrN+H+qLWxtsTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747710;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TjIDhsiNoFKT7GQmQmy1LEfKMzTPVQcje4l0m+vQabw=;
	b=vrBFzZZ/hLVZQvlNtu/BHoDq0KqRoJsWSPVtgca0yCdM7qMHFUzA2bn86Q+nEIrhZvFK
	 uRg7yVZWD9QVzU3lMJkcYUTdi3qrAxuUWU9qHM6uvz5+hq0+aocEfAk5EjVh5gC73SDk0
	 qZjtg6+ra2x0mWiVi3Di2iV0EZZylA4GJBsFua9cAxBE/Jk33oRLWa1etqPn5iLAGDxLu
	 VvbUNQb95Fnrknj3i/MNXSadzXQuNELppUCFm39zDXBz/qHUvezTMhn5AKNIUNWSDz6/3
	 iIRkT/GGn3e5bYzEu60dFiGE2MZzcQX3cnIsobLi1FBW2TFBF6FhqOS7VxTYYkxb9Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4IXI2VB;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BFB606A329;
	Tue,  3 Nov 2026 23:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1BFB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=A4IXI2VB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793747707; x=1825283707;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ER/uMytXcuQ7Jd0o5RZpa2P+OWAuTpzUwNLe2Mx1RiE=;
  b=A4IXI2VBAYvSE97mesG41GOr0k5cOk3uebFinwQJDp0wUvakOU/kR1WQ
   rlrl2tfOiKyJ37JovzSMdzoEUKbnnjik8snvsBhIlhv1iAokHWGDvwu1z
   5zwZH3u0bBdW7PEH+8ALx3r6uwqdBrmNIPBat4oTXWgepRIp6pj4fUyHR
   yaMmWSRpzg72Z3GdQwzdBsEv93irEJUrIC5GqGy12cUAIb+ONZvGnx09B
   U1QjzMVy0eetZKbEUiK2l8a5oa3kGn6DamL5az/0dpUciH27OOCXb+z/h
   oIwIqMLIOVI//tGA4MFQJ2mko6g6nMwbt8LZg7V4VvkB6zxwO4qkDVRYS
   A==;
X-CSE-ConnectionGUID: vP7qVmsgSkqLzlqH/aTP6A==
X-CSE-MsgGUID: nzjyTcFZQj61j1ziRrHlGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2400514"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2400514"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:15:07 -0800
X-CSE-ConnectionGUID: eyTkesYrTsyFImYIFruE2Q==
X-CSE-MsgGUID: EDcOyBTIR52uXcFvs3ydjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6941073"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.235]) ([10.125.109.235])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 15:15:05 -0800
Message-ID: <f1e51d7f-645b-490e-b67c-36732b6db644@intel.com>
Date: Tue, 3 Nov 2026 16:15:05 -0700
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
Subject: Re: [PATCH v2] cxl/port: Fix endpoint RAS error unmasking
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kaihengf@nvidia.com, kobak@nvidia.com,
 newtonl@nvidia.com, kristinc@nvidia.com
References: <20261103063409.18275-1-icheng@nvidia.com>
 <aaa772ba-554a-4bef-8910-e271580c2a5b@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aaa772ba-554a-4bef-8910-e271580c2a5b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/26 11:35 AM, Cheatham, Benjamin wrote:
> On 11/3/2026 12:34 AM, Richard Cheng wrote:
>> Moving endpoint RAS handling from cxl_pci to cxl_port left
>> cxl_ras_unmask() checking whether port->uport_dev is a PCI device.
>> Endpoint ports always use a cxl_memdev as uport_dev, so this check
>> returns early and leaves the CXL RAS error masks unchanged.
>>
>> Resolve the PCI device directly through the memdev's parent. Rename
>> helper to cxl_endpoint_ras_unmask() and its param to endpoint to make
>> its endpoint-only scope explicit.
>>
>> Fixes: dab7162d0ae7 ("cxl/port: Move endpoint component register management to cxl_port")
>> Signed-off-by: Richard Cheng <icheng@nvidia.com>
>> ---
> 
> ...
> 
>> -static int cxl_ras_unmask(struct cxl_port *port)
>> +static int cxl_endpoint_ras_unmask(struct cxl_port *endpoint)
>>  {
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(endpoint->uport_dev);
>> +	struct device *parent = cxlmd->dev.parent;
> 
> Two small nits:
> 
> 1. Maybe just use endpoint->uport_dev.parent directly and drop the cxlmd part? It's less
> readable, but it's future proofing for when/if CXL.cache devices come along.
> 
> 2. I don't think you need to rename the port parameter if you change the name to endpoint. It's
> self-explanatory at that point and cuts down on the diff.

I asked for that change. Since we are making changes on that line already, may as well make it explicit for readability. Or at least satisfies my OCD :)

DJ

> 
> Both are really up to you on whether you think they're worthwhile, and the change makes sense as-is,
> so regardless of whether you implement the above:
> 
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> 
> Thanks,
> Ben

