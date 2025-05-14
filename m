Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D4528CF56
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 19:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747249326; cv=none; b=ickqRXHMJ7FSk6CuUnhDo5pMwGdsJ4mhEse2GDQkjcYqLAZ5USLPV+v28GxjqFe0rnOOkyOzuClSDz8yOdUQnv2b2haxC1Zw3WUDZEeiVMreWcEBlFPmvaizuMEPfNGymxoui+cvdIumRDmsKlkBqZ1bI/V67/LDOzHWrjnGkBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747249326; c=relaxed/simple;
	bh=b/qEH07FkNUQXBrC29O6hpjyYrBOWU4NnwUr6fml8e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/lrWVdm3D9aaSmKqikECwhfEN9q5v/7fmoEF35wkGsxgwEW+MlAGvobYlJCv2S8G8ZnLn2ZTPvlsVgwDlCkmJ/oxGNEU4wCH1MSIfYsS8Kqzjirkd+l3q/Pi0mNaqkZoCFiz7/gkReyqDX3m9mHUPZqA0DiAI1W9CKKSCN9T5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ib4SQPNi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ib4SQPNi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747249324; x=1778785324;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b/qEH07FkNUQXBrC29O6hpjyYrBOWU4NnwUr6fml8e8=;
  b=ib4SQPNilq+uHrMZVHy0P32WYSFHe6iWsHFyj/TIbe8BSm3/xR+QxLW8
   w462N/YpdeLvcPMMiy0OUyle5X7bOurKr7ac1jK9ENLozS7d9bPy2raB6
   E23LX7J00vIch1M83Va8L1Zl6O9Dw/KSl0MjTW65SArOVUS6QEhwGWh6O
   XhpkmfCwLy/CWFsYPr/iPkdXgwr6WtltUWh1pgARZ2EsOavaZ01sKGlRY
   gJejIFIrIIpwTcBsbFZj5wswfZMKxcLuXnQINAPDR0eWB81k+xm9/cegz
   Jfuv3k/b8pGfZBkPFA7zP7Sw/YT2cVhaMS3WWddnleN7dZlH93G52Cjyz
   w==;
X-CSE-ConnectionGUID: 067sEcoTQZmF93Qi8oFA3w==
X-CSE-MsgGUID: wom+sNWlRlG7V/i/A8fuog==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="59390165"
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="59390165"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 12:02:03 -0700
X-CSE-ConnectionGUID: 3CQ81jGgR5y/H+hZKmNlXg==
X-CSE-MsgGUID: Yu7JuodbQOaZ5jn0vd8QVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,289,1739865600"; 
   d="scan'208";a="139129442"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.31]) ([10.125.109.31])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 12:02:02 -0700
Message-ID: <9ca53bc9-2eeb-4490-ac3c-fcb8cec0da78@intel.com>
Date: Wed, 14 May 2025 12:02:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cxl: docs/platform/cdat reference documentation
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-2-dave.jiang@intel.com>
 <aCTA-C9StbfHjCMn@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCTA-C9StbfHjCMn@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/25 9:12 AM, Gregory Price wrote:
> On Tue, May 13, 2025 at 05:31:30PM -0700, Dave Jiang wrote:
>> Add documentation for CDAT sub-tables for CXL usages.
>>
> 
> Mostly wording nits, but i recommend putting allt he subtables in
> cdat.rst directly and adding a terms list at the top so you can
> reference them cleanly on the same page without redefining them
> everywhere.  See below.

Thanks for reviewing. I'll do that.


> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  Documentation/driver-api/cxl/index.rst        |  1 +
>>  .../driver-api/cxl/platform/cdat.rst          | 24 ++++++++++
>>  .../driver-api/cxl/platform/cdat/dslbis.rst   | 33 ++++++++++++++
>>  .../driver-api/cxl/platform/cdat/dsmas.rst    | 23 ++++++++++
>>  .../driver-api/cxl/platform/cdat/sslbis.rst   | 45 +++++++++++++++++++
>>  5 files changed, 126 insertions(+)
>>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
>>  create mode 100644 Documentation/driver-api/cxl/platform/cdat/dslbis.rst
>>  create mode 100644 Documentation/driver-api/cxl/platform/cdat/dsmas.rst
>>  create mode 100644 Documentation/driver-api/cxl/platform/cdat/sslbis.rst
>>
>> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
>> index 366faf851fc7..9e1414ad3357 100644
>> --- a/Documentation/driver-api/cxl/index.rst
>> +++ b/Documentation/driver-api/cxl/index.rst
>> @@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>>  
>>     platform/bios-and-efi
>>     platform/acpi
>> +   platform/cdat
>>     platform/example-configs
>>  
>>  .. toctree::
>> diff --git a/Documentation/driver-api/cxl/platform/cdat.rst b/Documentation/driver-api/cxl/platform/cdat.rst
>> new file mode 100644
>> index 000000000000..3e0ce7099db3
>> --- /dev/null
>> +++ b/Documentation/driver-api/cxl/platform/cdat.rst
>> @@ -0,0 +1,24 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===========
>> +CDAT Tables
>> +===========
> 
> "Coherent Device Attribute Table Tables" :]
> 
> I would name this 
> 
> ======================================
> Coherent Device Attribute Table (CDAT)
> ======================================
> 
>> +
>> +The Coherent Device Attribute Table (CDAT) is created to provide a standard way to
>> +expose the properties of a device such as an CXL accelerator or switch. The table
>> +formatting is similar to ACPI tables. The tables are created to provide performance
>> +calculation of a hot-plugged device where ACPI HMAT+SRAT tables are not able to
>> +enumerate the performance by the BIOS ahead of time.
> 
> I may suggest something like...
> 
> The CDAT provides functional and performance attributes of devices such
> as CXL accelerators, switches, or endpoints.  The table formatting is
> similar to ACPI tables. CDAT data may be parsed by BIOS at boot or may
> be enumerated at runtime (after device hotplug, for example).
> 
>> +
>> +The following CDAT tables contain *static* configuration and performance data about CXL devices.
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   cdat/dsmas.rst
>> +   cdat/dslbis.rst
>> +   cdat/sslbis.rst
>> +
>> +The Linux CXL driver uses these tables in addition to attributes of the CXL links and
>                                                       ^^^^^^^^^^^^^
> 						      provided by what?
>> +Generic Target performance data provided by HMAT+SRAT to create the whole path performance
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    The is provided by SRAT right?

SRAT only provide the association of a device handle and proximity domain for a generic target. The HMAT provides the performance numbers based on the PXM.

DJ

>> +for a CXL device.
> 
> Maybe simplified to:
> 
> The CXL driver uses a combination of CDAT, HMAT, SRAT and other data to
> generate "whole path performance" data for a CXL device.
> 
>> diff --git a/Documentation/driver-api/cxl/platform/cdat/dslbis.rst b/Documentation/driver-api/cxl/platform/cdat/dslbis.rst
>> new file mode 100644
>> index 000000000000..91ae426b2e8b
>> --- /dev/null
>> +++ b/Documentation/driver-api/cxl/platform/cdat/dslbis.rst
>> @@ -0,0 +1,33 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==================================================================
>> +DSLBIS - Device Scoped Latency and Bandwidth Information Structure
>> +==================================================================
>> +
>> +The Device Scoped Latency and Bandwidth Information Structure contains latency
>> +and bandwidth information based on DSMADHandle matching.
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 			     What does a DSMADHandle represent?
>> +
>> +This table is used by Linux in conjunction with Device scoped Memory Affinity
>> +Structure to determine the performance attributes of a CXL device.
> 
> swap the order of the last two paragraphs.  Add (DSMAS) after "Device
> Scoped Memory Affinity Structure", introduce what a DSMADHandle is and
> what it represents before you reference it.
> 
>> +
>> +Example ::
>> +
>> +   Structure Type : 01 [DSLBIS]
>> +         Reserved : 00
>> +           Length : 18                     <- 24d, size of structure
>> +           Handle : 0001                   <- DSMAS handle
>> +            Flags : 00                     <- Matches flag field for HMAT SLLBIS
>> +        Data Type : 00                     <- Latency
>> + Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
>> +            Entry : 010000000000           <- First byte used here, CXL LTC
>> +         Reserved : 0000
>> +
>> +   Structure Type : 01 [DSLBIS]
>> +         Reserved : 00
>> +           Length : 18                     <- 24d, size of structure
>> +           Handle : 0001                   <- DSMAS handle
>> +            Flags : 00                     <- Matches flag field for HMAT SLLBIS
>> +        Data Type : 03                     <- Bandwidth
>> + Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
>> +            Entry : 020000000000           <- First byte used here, CXL BW
>> +         Reserved : 0000
>> diff --git a/Documentation/driver-api/cxl/platform/cdat/dsmas.rst b/Documentation/driver-api/cxl/platform/cdat/dsmas.rst
>> new file mode 100644
>> index 000000000000..8c32ddb3381c
>> --- /dev/null
>> +++ b/Documentation/driver-api/cxl/platform/cdat/dsmas.rst
>> @@ -0,0 +1,23 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===============================================
>> +DSMAS - Device Scoped Memory Affinity Structure
>> +===============================================
> 
> Device Scoped Memory Affinity Structure (DSMAS)
> 
>> +
>> +The Device Scoped Memory Affinity Structure contains information such as
>        ^^^^^^        DSMAS               ^^^^^
>        Since you define it in the header, you can use the abbreviation
>  
>> +DSMADHandle, the DPA Base, and DPA Length.
>> +
> 
> It's probably better to put all these subtables in a single document
> (cdat.rst) and add a terms list at the top (such as DSMADHandle)
> 
>> +This table is used by Linux in conjunction with the Device Scoped Latency and
>> +Bandwidth Information Structure (DSLBIS) to determine the performance
>> +attributes of the CXL device itself.
>> +
>> +Example ::
>> +
>> + Structure Type : 00 [DSMAS]
>> +       Reserved : 00
>> +         Length : 0018              <- 24d, size of structure
>> +    DSMADHandle : 01
>> +          Flags : 00
>> +       Reserved : 0000
>> +       DPA Base : 0000000040000000  <- 1GiB base
>> +     DPA Length : 0000000080000000  <- 2GiB size
>> diff --git a/Documentation/driver-api/cxl/platform/cdat/sslbis.rst b/Documentation/driver-api/cxl/platform/cdat/sslbis.rst
>> new file mode 100644
>> index 000000000000..e299575493fa
>> --- /dev/null
>> +++ b/Documentation/driver-api/cxl/platform/cdat/sslbis.rst
>> @@ -0,0 +1,45 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==================================================================
>> +SSLBIS - Switch Scoped Latency and Bandwidth Information Structure
>> +==================================================================
> 
> Switch Scoped Latency and Bandwidth Information Structure (SSLBIS)
> 
>> +
>> +The Switch Scoped Latency Bandwidth Information Structure contains information
>        ^^^^^^^^^^^^^^^^ SSLBIS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +about the latency and bandwidth of a switch.
>> +
>> +The table is used by Linux to compute the performance coordinates of a CXL path
>> +from the device to the root port where a switch is part of the path.
>> +
>> +Example ::
>> +
>> +  Structure Type : 05 [SSLBIS]
>> +        Reserved : 00
>> +          Length : 20                           <- 32d, length of record, including SSLB entries
>> +       Data Type : 00                           <- Latency
>> +        Reserved : 000000
>> + Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
>> +
>> +                                                <- SSLB Entry 0
>> +       Port X ID : 0100                         <- First port, 0100h represents an upstream port
>> +       Port Y ID : 0000                         <- Second port, downstream port 0
>> +         Latency : 0100                         <- Port latency
>> +        Reserved : 0000
>> +                                                <- SSLB Entry 1
>> +       Port X ID : 0100
>> +       Port Y ID : 0001
>> +         Latency : 0100
>> +        Reserved : 0000
>> +
>> +
>> +  Structure Type : 05 [SSLBIS]
>> +        Reserved : 00
>> +          Length : 18                           <- 24d, length of record, including SSLB entry
>> +       Data Type : 03                           <- Bandwidth
>> +        Reserved : 000000
>> + Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
>> +
>> +                                                <- SSLB Entry 0
>> +       Port X ID : 0100                         <- First port, 0100h represents an upstream port
>> +       Port Y ID : FFFF                         <- Second port, FFFFh indicates any port
>> +       Bandwidth : 1200                         <- Port bandwidth
>> +        Reserved : 0000
>> -- 
>> 2.49.0
>>
> 

