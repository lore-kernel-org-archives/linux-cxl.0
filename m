Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DA839EA
	for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406212; cv=none; b=K0N1P7fJyUS2QPTwsQa6dAEbwQ7YzwXwPfZSwZQZIh9809YuGXND2q8fdP9+uzsmdL5PJyRIj2s6YqCMKyyAL4+3GbOCijFlGqC3GToT3Rwe4gFlxw54Vycz3r0zBQNghuNhhFmAhke7C+WldEKiMZDRv5Ts1f0F2qjHLR0lOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406212; c=relaxed/simple;
	bh=YwOg4ayY78ryEUnWV7nlBnhFtEdnL/QxILI7x3zF8es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeUAcPpY2Q0OKwwdEO9fYPb6+bJQ0agHOiC9vANz8MjoRCJuyLCWmqssq6Z4F0KlZW10jJgxGES5Agvx7sKatuLqtT91AlI8Cz7nAfACXLaDq1/eH0H75WeVjUNBHJyUaRRsfIk7qr2ZFoeH6xbHJN1T7yvQYmnZ8fKcJyQgeAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJZYhE9w; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJZYhE9w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714406210; x=1745942210;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YwOg4ayY78ryEUnWV7nlBnhFtEdnL/QxILI7x3zF8es=;
  b=mJZYhE9wp1ZWYZhkZkDJC9R7+Y+qq+fxCPgtWrJKeRARc9KtrFTPJU5q
   ZdEecceiws37PpEmXEKyMBdE9mGZT1paYWnWxMfs9fp8jYWHwOFUnveNT
   AjWz4uAt7naASubGvQ2fYk0P90KCB1W00W36S6hpfieGkP2Hrul9MV7lv
   KD6z0Xr/GQIjT1bnXwJl5KofwSHy4+tHJrwanTb/5iLY37QNZ/0I+vpT4
   MaKuSWBAuTtQURhz1qf1f3QTZCenp2HvCXhrmyvedK0t6IoYCQhCKLUF9
   Pse77vXNomY32np3AZ6kSJPs9diwD5kMlBMkAumGrrb5BHIO1vHTaFOIk
   A==;
X-CSE-ConnectionGUID: NNQG3dvdRrGbisQajx2h9A==
X-CSE-MsgGUID: 60Guhh9kR4C5/3G+H73gnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="32580367"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="32580367"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 08:56:50 -0700
X-CSE-ConnectionGUID: XUx2eldWRX+dZG4/z3JvGQ==
X-CSE-MsgGUID: xchPCgIGTWCwrTsc6Yng9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26229453"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.141]) ([10.212.1.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 08:56:49 -0700
Message-ID: <929b7b3c-4676-468c-8ba2-8028bb05479c@intel.com>
Date: Mon, 29 Apr 2024 08:56:48 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix cxl_endpoint_get_perf_coordinate() support for
 RCH
To: Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20240426224913.1027420-1-dave.jiang@intel.com>
 <Zi-LzgrCVHDlIBpB@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Zi-LzgrCVHDlIBpB@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 5:00 AM, Robert Richter wrote:
> On 26.04.24 15:47:56, Dave Jiang wrote:
>> Robert reported the following when booting a CXL host with Restricted CXL
>> Host (RCH) topology:
>>  [   39.815379] cxl_acpi ACPI0017:00: not a cxl_port device
>>  [   39.827123] WARNING: CPU: 46 PID: 1754 at drivers/cxl/core/port.c:592 to_cxl_port+0x56/0x70 [cxl_core]
>>
>> ... plus some related subsequent NULL pointer dereference:
>>
>>  [   40.718708] BUG: kernel NULL pointer dereference, address: 00000000000002d8
>>
>> The iterator to walk the PCIe path did not account for RCH topology.
>> However RCH does not support hotplug and the memory exported by the
>> Restricted CXL Device (RCD) should be covered by HMAT and therefore no
>> access_coordinate is needed. Add check to see if the endpoint device is
>> RCD and skip calculation.
>>
>> Also add a call to cxl_endpoint_get_perf_coordinates() in cxl_test in order
>> to exercise the topology iterator. The dev_is_pci() check added is to help
>> with this test and should be harmless for normal operation.
>>
>> Reported-by: Robert Richter <rrichter@amd.com>
>> Closes: https://lore.kernel.org/all/Ziv8GfSMSbvlBB0h@rric.localdomain/
>> Fixes: 592780b8391f ("cxl: Fix retrieving of access_coordinates in PCIe path")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> This patch fixes the issue.
> 
> Tested-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Robert Richter <rrichter@amd.com>

Thank you Robert! I'll get this queued for rc7. 
> 
> But see below for a question...
> 
>> ---
>>
>> Hi Robert,
>> Can you please try this patch and see if it addresses the issue you saw
>> on your RCH platform? Thanks!
>>
>>  drivers/cxl/core/port.c      | 15 ++++++++++++++-
>>  tools/testing/cxl/test/cxl.c |  3 +++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 762783bb091a..887ed6e358fb 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -2184,6 +2184,7 @@ static bool parent_port_is_cxl_root(struct cxl_port *port)
>>  int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  				      struct access_coordinate *coord)
>>  {
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>  	struct access_coordinate c[] = {
>>  		{
>>  			.read_bandwidth = UINT_MAX,
>> @@ -2197,12 +2198,20 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  	struct cxl_port *iter = port;
>>  	struct cxl_dport *dport;
>>  	struct pci_dev *pdev;
>> +	struct device *dev;
>>  	unsigned int bw;
>>  	bool is_cxl_root;
>>  
>>  	if (!is_cxl_endpoint(port))
>>  		return -EINVAL;
>>  
>> +	/*
>> +	 * Skip calculation for RCD. Expectation is HMAT already covers RCD case
>> +	 * since RCH does not support hotplug.
>> +	 */
>> +	if (cxlmd->cxlds->rcd)
>> +		return 0;
>> +
>>  	/*
>>  	 * Exit the loop when the parent port of the current iter port is cxl
>>  	 * root. The iterative loop starts at the endpoint and gathers the
>> @@ -2232,8 +2241,12 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>>  		return -EINVAL;
>>  	cxl_coordinates_combine(c, c, dport->coord);
>>  
>> +	dev = port->uport_dev->parent;
>> +	if (!dev_is_pci(dev))
>> +		return -ENODEV;
>> +
>>  	/* Get the calculated PCI paths bandwidth */
>> -	pdev = to_pci_dev(port->uport_dev->parent);
>> +	pdev = to_pci_dev(dev);
>>  	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
>>  	if (bw == 0)
>>  		return -ENXIO;
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index 61c69297e797..72e2ce58e1dc 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -1001,6 +1001,7 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>> +	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
>>  	struct range pmem_range = {
>>  		.start = cxlds->pmem_res.start,
>>  		.end = cxlds->pmem_res.end,
>> @@ -1020,6 +1021,8 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>  		dpa_perf_setup(port, &pmem_range, &mds->pmem_perf);
>>  
>>  	cxl_memdev_update_perf(cxlmd);
>> +
>> +	cxl_endpoint_get_perf_coordinates(port, ep_c);
> 
> I don't see what this is for as ep_c is unused later? The only reason
> is for error checking to see if that throws some kernel message in the
> logs but return code is unused.

Right. The results are thrown away. The call is there to specifically test the iterator and making sure we don't crash or fail. It has no other purpose. I looked into plumbing this function for usage in cxl-test but found it not possible to override the PCI API function that retrieves bandwidth. So for now we'll just have it just test the topology iterator. I'll add a comment. 
> 
> Thanks,
> 
> -Robert
> 
>>  }
>>  
>>  static struct cxl_mock_ops cxl_mock_ops = {
>> -- 
>> 2.44.0
>>
