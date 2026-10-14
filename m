Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9292D738F;
	Wed, 14 Oct 2026 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995020; cv=none; b=S4CB6rGgdax55+zlq1rSIMJgh3xLhTadU5jUj8DSni6ix9BPAlM5Q//+m7sUkRk83kh0YNmmxkfeI6/JW54lNQdX3ns3Ib4u79oYCUzKuVKNtu6IawbV2woQ2UAA0SYFDDygTVG0Jnv8cHcFCXb60ezkR1o2n8zoX5hYYyxPcJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995020; c=relaxed/simple;
	bh=Sc9czeDu67poAhucBNC67hnNdkGzJdjFqK99IfPlVnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mUDJ2Krhfk2yRBiJvjcBzVW/iXMsKKm4vvaVfG1P3pocVXnIctawq5AnZzUULTorjw+J9nGZnNZUJmDvuWCRzDNmbtDks1/IFG6dx77SkWN1afs/zxY0g3UpXTJCN1/xovuuhNqHjIvqt0chi12GhQRCrArW6R/kg5K2Lx54rSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPYeLOuO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPYeLOuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791995019; x=1823531019;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sc9czeDu67poAhucBNC67hnNdkGzJdjFqK99IfPlVnQ=;
  b=DPYeLOuOau+PSOrew2YOx4FrmRtL8T4WRchUxbngYdwy2BCdeo8h/jv0
   wKHDvx76Hu1XQgBQvSS//9Fp9uVo79IUUJioTR4vga11CtD9AKCNZ429F
   OsQB2ew4j1rM0fBi/a0W61p5uLNBl7UCX6SdpaPPJY1wYJWorCe61j9UV
   dUx+UuSJxzUZL1tWOVJ9S3o1bFpb9YfS/N/jTbiWdfGxMo2yE1zSPdRA5
   tTwXkCBrPfoUr2Rw4Jyz/eDDIMILszKFhzRXzM8asRMci1D35VKxv2Z4z
   HmcY3GyOs95IbvG6bkM/jvPeG58Ll4sesUhTxYOTcgmFy5Op0+to9cQsS
   g==;
X-CSE-ConnectionGUID: xFwDs0EwRmeuxXImTW1qVw==
X-CSE-MsgGUID: YBbGGF2rSSu4+bQfOWGhfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="645828"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="645828"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 09:23:38 -0700
X-CSE-ConnectionGUID: qD9SqOlsR8u4APPZCy6NIg==
X-CSE-MsgGUID: pUXwMxsdRcO+OWpJ5Ztelw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1909041"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.36]) ([10.125.110.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 09:23:37 -0700
Message-ID: <3466e889-82a0-41ac-9013-7d21020b5092@intel.com>
Date: Wed, 14 Oct 2026 09:23:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/3] cxl: Provide explicit RAM region creation for
 Type-2 providers
To: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>,
 Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, iweiny@kernel.org,
 ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
 <1fd14fc6-de0d-4980-ac8b-8138dd5ef17c@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <1fd14fc6-de0d-4980-ac8b-8138dd5ef17c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/14/26 8:34 AM, Lucero Palau, Alejandro wrote:
> 
> On 07/10/2026 10:05, Richard Cheng wrote:
>> A Type-2 provider uses devm_cxl_probe_mem() to register its memdev
>> and obtain an HPA range. This requires an existing committed region,
>> so registration fails when firmware has not configured one.
>>
>> Firmware may provide a suitable CFMWS window without programming a
>> region.
> 
> 
> Hi Richard,
> 
> 
> FWIW, I unsuccessfully  tried to explain this possibility to "BIOS people". The fact is, nowadays for AMD and I think for Intel as well, if there is no CXL device detected with CXL.mem enabled, the BIOS will neither set HDMs  nor there will be a CFMWS.


Hmmmm....don't they have to reserve CFMWS for hotplug?

DJ

> 
> 
> 
>> Hot-added devices can have the same requirement. A provider
>> needs its endpoint topology established before deciding when to
>> create a region and how much memory to map.
> 
> 
> Another unsuccessfully discussion was to avoid BIOS setting HDMs at hotplug time as this could race with host dynamic regions creation.
> 
> 
> I'm commenting these two things here for maybe having a community/kernel discussion with the goal of defining what BIOSes should do and mostly what they should not do if they want to be compatible with kernel expectations.
> 
> 

