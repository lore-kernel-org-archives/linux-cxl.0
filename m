Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935AF2737E0
	for <linux-cxl@vger.kernel.org>; Tue, 24 Feb 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947340; cv=none; b=pNMOxvptesyx6XE23Ew4JBBKzkx5QnqQxXdhSRopBx47ZFHnsqyi+njFbalFMmDicXZTjwPGnCmPDzkhYirdhQ7HANX4UUaDl1j7BY6qyVw5g53/LBjbTziPCpAO0wnbF+5mIlnDvSygI8zjkoU5S52inM3HtGND/FiBLpkY4/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947340; c=relaxed/simple;
	bh=gR0sp3vQ/EC7g/yFtp8PHy39d293LOqwB70Bf6roxz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLTIuVf13DH9cbVqBia8FUk9gBYBAEDAu7Ho0rsXjzB15nUAa2pd5tuBh+s2bLtn2ZKkqNwFOJ7ItGjsWEkoePFNxrS6HlSPMCX183IRH9ZDQb9lz+nZaoNgR5JBdSbEJ+eMYTn1Z2ODzxyXTpb2VFzof+yu5Hi7gcyVWl36xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuxGWb05; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuxGWb05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771947338; x=1803483338;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gR0sp3vQ/EC7g/yFtp8PHy39d293LOqwB70Bf6roxz8=;
  b=UuxGWb05i5NcXMRHOHTKM7NCRKUevYgWA0HLAUaSH7wjbSplu3XSiftH
   /2rWxhxBo7juU20APBaubjPhvmDRaUrTp/InUTLQaN7nSGnDFaOPJCXtv
   b9rwRM/PJn8yrbDBUqWM64YuaVvTOvdY+Qdw5YLB26axLyPN8HOoTD4nl
   avdfMvfma8kZ1vI5Yy2YabPahRJ+2VgicmOLmaYg+fbRoJOHeKro644o4
   2+Mx5+BqzbAccIBLKVgtc49UZAiyt5+Flzg0GHbPhLCsM5U5d0S/NDYyi
   GG/wRcCgtfy6cn8i0MbNi8hswwxMtSynqFJPCbCngtAy0IsucZp3fkwPv
   A==;
X-CSE-ConnectionGUID: rgX4/5M9TRukFmKlnFpVSQ==
X-CSE-MsgGUID: yzPqblMPRdSw/0e5eNoIPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72876255"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72876255"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:35:38 -0800
X-CSE-ConnectionGUID: mdvWpOJHQq6QsaLnaL5tXg==
X-CSE-MsgGUID: InUabX8BTNWVhdR54hw7Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="253687171"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.22]) ([10.125.111.22])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 07:35:38 -0800
Message-ID: <03fd10b3-9fd3-4f6d-983c-a0fe1491463a@intel.com>
Date: Tue, 24 Feb 2026 08:35:36 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl: Fix race of nvdimm_bus object when creating
 nvdimm objects
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20260213224038.549798-1-dave.jiang@intel.com>
 <20260213224038.549798-3-dave.jiang@intel.com>
 <aZzSMwc2evqS8uBc@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aZzSMwc2evqS8uBc@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/23/26 3:18 PM, Gregory Price wrote:
> On Fri, Feb 13, 2026 at 03:40:38PM -0700, Dave Jiang wrote:
>> @@ -248,6 +262,19 @@ int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
>>  	if (!cxl_nvb)
>>  		return -ENODEV;
>>  
>> +	/*
>> +	 * Take the uport_dev lock to guard against race of nvdimm_bus object.
>> +	 * cxl_acpi_probe() registers the nvdimm_bus and is done under the
>> +	 * root port uport_dev lock.
>> +	 *
>> +	 * Take the cxl_nvb device lock to ensure that cxl_nvb driver is in a
>> +	 * consistent state. And the driver registers nvdimm_bus.
>> +	 */
>> +	guard(device)(cxl_nvb->port->uport_dev);
>> +	guard(device)(&cxl_nvb->dev);
>> +	if (!cxl_nvb->nvdimm_bus)
>> +		return -ENODEV;
>> +
> 
> I think this leaks the reference on cxl_nvb taken by 
> 
> 	devm_cxl_add_nvdimm()
> 		device_find_child()
> 
> Maybe:
>      if (!cxl_nvb->nvdimm_bus) {
>              rc = -ENODEV;
>              goto err_alloc;
>      }
> 
> 
> Reported-by: kreview-0811365

Thanks! I've fixed it up in place in cxl/fixes.

> 
> ~Gregory

