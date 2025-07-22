Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17AC80034
	for <linux-cxl@vger.kernel.org>; Tue, 22 Jul 2025 19:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211257; cv=none; b=A+a50+eJzPsgS53x3HNtiSIqZbTkWlzAfKz1JZqUJ1bCgqfeZ9F0rHd8MiuvL6jZZUN/sTlZJcIMGKu1EsP/ao6nqwvEmXAjyhp0Tpgc96+NZGdm4S4e8KSIbMZBvTQXKolY3Sq8iC3RT5AlmGpODB/y3oZ2kSTtfKUJQK6p4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211257; c=relaxed/simple;
	bh=hMySIL61pCJTu1PkAAzfpWvCuFFuwi9HEyf7b28kXSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sw3gK5gj16s5HA2wPoOwHRWbtad2UOrxQTl6w0rjd9yNBZ6LyTga6CHXEsJACf9Go9xJLXu+qTOl6jscimslSqg/FWPb2K9MBm4N72uWakj4o1PIpaZvf/B2UndAyOvdeuWU0NDWC3lGvHabB0PygrDanlIl64mclOyXa4sizAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AeycjBQO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AeycjBQO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753211255; x=1784747255;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hMySIL61pCJTu1PkAAzfpWvCuFFuwi9HEyf7b28kXSI=;
  b=AeycjBQO6KYD9wp2miXn6kmCQYCsyvM4o/NHNn7SM2m1SK67Nmzb2AFT
   zDfhOt5RIfX6rPxECSOmjI//OxWa4cJ+C9V9XjoTWZ6jzTKzKEJ2EA8fP
   fAYjyYGFpcSRctXD+9mTlxNml+1CXmUatv0rq1h4QsA808XhPinC8JF/I
   C8ZYbJJJHyeVeZ5yyl1qZwPzyC5xut7wqHOoLV7Ng6coODoKo21Xr/3Tf
   2RWycHiya5JOK99QHQBFxiZ/k2kaoAyUxx2Ko+Y3ITU8Ui7NsBIaTzZrC
   pPgCrq3R1hm8w3ZlQ4pAZrA36+GGYosO6UXDSkDHwczRwiiDEnSw9NoVw
   A==;
X-CSE-ConnectionGUID: 3NisBIArRjuk4a6JLz1tUg==
X-CSE-MsgGUID: 9qhGdK+SQWG1MFK+Dg7/wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="78013230"
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="78013230"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:07:35 -0700
X-CSE-ConnectionGUID: AsixOVr9RRmH0hNACS92lA==
X-CSE-MsgGUID: j3b2IrXbSCmepGEVFRw3tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,332,1744095600"; 
   d="scan'208";a="164870610"
Received: from bvivekan-mobl2.gar.corp.intel.com (HELO [10.247.118.172]) ([10.247.118.172])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 12:07:31 -0700
Message-ID: <893e2652-ce0a-4bfe-b601-ab651dcda2ef@intel.com>
Date: Tue, 22 Jul 2025 12:07:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/10] cxl: Move enumeration of hostbridge ports to the
 memdev probe path
To: dan.j.williams@intel.com, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 Li Ming <ming.li@zohomail.com>
References: <20250714223527.461147-1-dave.jiang@intel.com>
 <20250714223527.461147-10-dave.jiang@intel.com>
 <687fd8e884ccb_137e6b10065@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <687fd8e884ccb_137e6b10065@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/25 11:31 AM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
>> Current enuemration scheme in cxl_acpi module creates the ports under the
>> root port by enumerating the hostbridges after the dports under the root
>> port is created. However error messages "cxl portN: Couldn't locate the
>> CXL.cache and CXL.mem capability array header" is observed when certain
>> platform has PCIe hotplug option turned on in BIOS. If the cxl_acpi module
>> probe is running before the CXL link between the endpoint device and the
>> RP is established, then the platform may not have exposed DVSEC ID 3 and/or
>> DVSEC ID 7 blocks which will trigger the error message. This behavior
>> is defined by the spec and not a hardware quirk.
>>
>> Setup an association in cxl_port to tie the host bridge device to the
>> associated cxl_root. The cxl_root provides a callback that's setup
>> by the cxl_acpi probe function in order to create a port per host bridge
>> that was previously done during cxl_acpi probe. Add the calling of the
>> callback in devm_cxl_enumerate_ports(). The observed behavior is that
>> ports that are not connected to endpoint device(s) are no longer
>> enumerated. This should also remove any excessive noise of port probe
>> failing on those inactive ports.
> 
> I do not understand the story here. Why is it necessary to hide host
> bridge ports that do not have endpoints attached? I think that is
> valuable information for hotplug to identify available ports.

It's not going out of the way to hide on purpose. It's more that this is the resulting behavior when we are setting up the hierarchy via the mem probe.

> 
> Now, if the concern is that host bridge CXL component register
> enumeration happens too early then the solution there is delay port
> register setup until the first dport arrival.

Are you saying to just delay the RP register setup until when dports show up, leave the enumeration as is?
> 
> Otherwise this feels like too large of a change for just that small
> ordering constraint and I think this makes some of the hierarchy walking
> redundant. I suspect that moving register init lets the
> devm_cxl_enumerate_ports() walk handle everything without new callbacks
> and new lookup infrastructure (patch8).
> 
> I have long wanted to move cxl_port_setup_regs() out of cxl_port_add().
> It has always been an awkward fit their because register init is usually
> something that belongs in a ->probe() path.

