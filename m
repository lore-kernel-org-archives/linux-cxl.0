Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6644F7262B
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327140; cv=none; b=kz8DH2s+4ssCaSGIeYhjJG5zggM7e0XzPqmZGySC4gafy+bh8zWpXq7zkS5FlS7CsNMMmoKyl4Aa/+vZwQI5LMilDl0tyb75ZChfw7eXzVQy2YEpSGHFxBmrJAqSI8k+RYnAABk0+mDPfNx92PORUZ1MQ/FdAQVZQvlPBbkIn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327140; c=relaxed/simple;
	bh=ksYNVX1Vg/uBg8OSsBWGU+XEFNjSiCjgpKOHmtt84fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gj8J2HAsQXgWvTKYRZHi917wQi3OKwcdCkPcXzSGTIb+gW1rDI3wwoyHmczBXo/gU5doybxSmrNO8kThUKVTolt2BM7vFs+56G3UErgcSnF9w00BootwuduHiZ/x0wzZEnDDkePiM4gx8SfoLC5+o/rbNqBpNCcbdZjhxANzgug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gT+j1BRD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gT+j1BRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747327139; x=1778863139;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ksYNVX1Vg/uBg8OSsBWGU+XEFNjSiCjgpKOHmtt84fk=;
  b=gT+j1BRDJCzyhg+CCM+3GghL+yftlMyPPyzFirelcqbIZ4jOZ4AyfbWN
   cUHiRbXQU8sKHaDwaDuiTPenhNO35XL5pm2BHKU2an/eGjiAj2Coq9S2k
   AiKC0UZNvCO7zxEm9+5T0xVb1Y9Kd2lWp3ifQOX/Qy33mHH1/rxvG2scZ
   uVaK805wiSX9UeqSSaa46ntDEV3zMdDqRI/8ruoXigSt4gX1wKRiIceEw
   E9mW9FpzNh4C0XoOECV9bbJGhjYIwhilloisv5JCEi4TyWd1GuQ5H+qnH
   qiKYTEbN6poy665139xVKz3gdcC/eoRRlie8/JhdBb1Q1GDwgmVwg7Loi
   Q==;
X-CSE-ConnectionGUID: +9/eMCzlRdWq9jIP/dGk0w==
X-CSE-MsgGUID: G+i44HYRT8OPJn0ggR3YTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="71788129"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="71788129"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:38:51 -0700
X-CSE-ConnectionGUID: iQ3wv4oJS6K5TXnXU2M5Ww==
X-CSE-MsgGUID: L5ZjTtx3S8q1ijXD9M1HMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138307577"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 09:38:49 -0700
Message-ID: <cf0a7968-07fd-4a26-bb40-3d410f73408a@intel.com>
Date: Thu, 15 May 2025 09:38:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
 <aCLS3rQxkjxiDLDx@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCLS3rQxkjxiDLDx@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/12/25 10:04 PM, Gregory Price wrote:
> On Tue, May 06, 2025 at 05:43:02PM -0700, Dave Jiang wrote:
>> In preparation to allow dport to be allocated without being active, make
>> dport->id to be Linux id that enumerates the dport objects per port.
>> Keep the hardware id under dport->port_num to maintain compatibility and
>> introduce a dport->id as the enumeration id.
>>
> 
> This is more for the sake of clarity/documentation than anything else.
> 
> dport->port_num is the `hardware id` - i.e. what we'd find in an ACPI
> table or something.  This number may not necessarily be unique
> 
> dport->port_id is now a Linux ID that is unique to the device.

Yes. dport->id is guaranteed to be unique. While dport->port_num theoretically should be, but if a port is not active, it may have some bogus number in the register that clash with existing active port_num. I think Robert may have ran into this issue.

DJ


> 
> For example, on my existing test system, i have this
> 
> [/sys/bus/cxl/devices]# ls port1/dport*
> dport0  dport113  dport2 
> [/sys/bus/cxl/devices]# ls port2/dport*
> dport113  dport2
> [/sys/bus/cxl/devices]# ls port3/dport*
> dport0
> 
> I should now expect the following:
> 
> [/sys/bus/cxl/devices]# ls port1/dport*
> dport0  dport1  dport2 
> [/sys/bus/cxl/devices]# ls port2/dport*
> dport0  dport1
> [/sys/bus/cxl/devices]# ls port3/dport*
> dport0
> 
> 
> This should also apply to the root, whose dports were previously
> dictated by the host bridge numbers defined in the CHBS/DSDT.
> 
> [/sys/bus/cxl/devices/root0]# ls
> dport0  dport1  dport4  dport5
> 
> turns into
> 
> [/sys/bus/cxl/devices/root0]# ls
> dport0  dport1  dport2  dport3
> 
> 
> and my decoder0.0 target list ends up similarly changed
> 
> from
> [/sys/bus/cxl/devices/root0/decoder0.0]# cat target_list
> 5,4
> 
> to
> 
> [/sys/bus/cxl/devices/root0/decoder0.0]# cat target_list
> 3,2
> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> If this is all correct, I like this.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
> ~Gregory

