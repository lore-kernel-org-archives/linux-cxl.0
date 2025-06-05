Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3C13AD3F
	for <linux-cxl@vger.kernel.org>; Thu,  5 Jun 2025 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136641; cv=none; b=LIwNA9PZJ60UG55D0bKxHBa4pyx4nq3yW+pvTjLE3/VUID+NjuR0Kgvp0U1uTsVwYO403+BBVmmBHaeYSFc9Jm7eW959qALwH5zy6aHwJtzpunqlyapVC+YLe+nEGWcvCXY0O4TtGP5qHesJ6xE44T550tpaIQRcwZYM66ULE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136641; c=relaxed/simple;
	bh=k2xroU2RoMmNO6azH+HvmYEW2u2yBxyCydzug1G+dMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/24+CwB84l22Vk2p6WfyPsqdzAslGgwtJdSwkpOukGioL9EdSJ89UdjCxnda4AIHXPT8077edqN6j5pfg5LwpYOR/Tp902lCiuojRwI4Izplc0Q2MXT4B9lD+SQNN9Zi0602QuVKJJDKltskL0iznyC0mxeHEVHtHU9Dd88a9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=daXOS5WZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="daXOS5WZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749136640; x=1780672640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k2xroU2RoMmNO6azH+HvmYEW2u2yBxyCydzug1G+dMw=;
  b=daXOS5WZd3NGYWATfkEaR2eCNVt5+pobOOsWdw1BbNlrezaETQsdhDpe
   c0pn1TSan0mhdChVU7eBJsMSA3zTRQMh4ndir68rKqxvjsbf1KGPQcCKk
   QAhx4JzOAqnla4K2WpYWstNTB2xJeT271yIoJHvh4XZVOAcilRXlpFG/9
   pwpibDquN8GGkKnr79rQGApYaMQGMfydZ5fDNvtYwhrEhB83tPObZ3fbn
   wWobyRtv+NL2kAwBFb5gIrYez9Wda2IMchiYpDodqQF1PxskorrsrpYac
   mzvfBJ/D0/crMQf1bVZw6jOXltdWkCIXbFyOx++/E45A/DERFFc3dKQmt
   w==;
X-CSE-ConnectionGUID: DOj9gWeHR+yJSru6L+NWjQ==
X-CSE-MsgGUID: FtbB1T6FToSEnvckXE11OA==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="54925410"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="54925410"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 08:17:19 -0700
X-CSE-ConnectionGUID: at/dRnfpQyuo48ZVNJnoTQ==
X-CSE-MsgGUID: QdJ2nG9vSwy51VRkKz+cEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="145505649"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.7]) ([10.125.111.7])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 08:17:18 -0700
Message-ID: <026e7506-b248-43bb-9118-5e3c3d817c90@intel.com>
Date: Thu, 5 Jun 2025 08:17:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 Alejandro Lucero <alucerop@amd.com>, Gregory Price <gourry@gourry.net>,
 Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
 Li Ming <ming.li@zohomail.com>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
 <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
 <aEBp30k03GP46eBd@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aEBp30k03GP46eBd@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/25 8:44 AM, Robert Richter wrote:
> On 03.06.25 06:55:15, Dave Jiang wrote:
>> On 5/30/25 6:51 AM, Robert Richter wrote:
> 
>>> The port_num can no longer retrieved using sysfs. Previously, the X in
>>> dportX could be used to identify the port number (former port_id)
>>> which was identical to the numbers in the sysfs target_list entries.
>>> This is esp. useful to reconstruct the decoder tree and map pci child
>>> devices and its decoders to a parent decoder including its positions
>>> in the target list. Maybe create a targetX symlink from the decoder
>>> device to the child decoders of it?
>>
> 
>> The numbers in the target_list are dport->id and should reflect the
>> dportX. Is this not what you are seeing?
> 
> Exactly, but I would prefer real numbers for the target list, that is,
> uid and port_num.

Does it help if we export the port_num sysfs attribute? Is there any specific usage that you need the actual hardware port_num?

> 
>>>
>>> Due to the different initialization order there is an odd port
>>> numbering now showing up with unexpected, out-of-order sequence
>>> numbers, e.g.:
>>>
>>> /sys/bus/cxl/devices/port1/endpoint2
>>> /sys/bus/cxl/devices/port1/endpoint3
>>> /sys/bus/cxl/devices/port1/endpoint6
>>> /sys/bus/cxl/devices/port4/endpoint5
>>> /sys/bus/cxl/devices/port4/endpoint7
>>> /sys/bus/cxl/devices/port4/endpoint10
>>> /sys/bus/cxl/devices/port4/endpoint11
>>> /sys/bus/cxl/devices/port8/endpoint9
>>> /sys/bus/cxl/devices/port12/endpoint13
>>> /sys/bus/cxl/devices/port12/endpoint14
>>>
>>> Still, this is correct, but maybe we could force a specific order
>>> during initialization, such as per-port initialization which should
>>> result in a defined order? Note the shared numbering of ports and
>>> endpoints is also confusing, maybe that could be changed here too?
>>
> 
>> I think the upstream expectation WRT sysfs device number enumeration
>> (for all Linux kernel devices) is that no ordering should be
>> expected as the devices are initialized async. And previous ordering
>> appearance is merely coincidence and not the expectation. And the
>> expectation for user tools is that they should not depend on device
>> numbering order and identify the devices by other stable means.
> 
> sysfs still is human readable and for good reasons not some binary
> blob you need a viewer for. Avoiding un-ordered enumeration where
> possible helps understanding the topology. So let's think about it and
> if possible find a way to get a defined numbering.

I'm trying to understand your pain point WRT to why ordering is necessary. Is it somehow breaking your user tooling? I'm not sure I agree with the thinking that we should try to design the enumeration to make sure that the device id number should be in a certain predictable order, especially with the async nature of multiple device enumeration. 'cxl list' should provide the human readable hierarchy view for user understanding, not sysfs.   

> 
> Thanks,
> 
> -Robert

