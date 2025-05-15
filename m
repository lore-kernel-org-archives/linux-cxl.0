Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750CB1487ED
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747329961; cv=none; b=WsTx1wkr7AbsL5TfhPRAhp7sH2PRfc+W7jTSnmtKa/nKxQvTmQ1SUrrelqngLauHgu994rGTmNUinVbEmbqUiYiMvVxopB2Cz/DToQRxaBNWBTITpHcq4QufI/gF+pVVFrBjwOP45lo2tnmcgRrJjkVUwwu7vq+9vYv21r4APQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747329961; c=relaxed/simple;
	bh=nZFFmPKduRDcZeeSjBBqR5O4eN/yEn9j5m7lWz+axeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fu1xeULTnH6l6rs6OK99AvmSAYsxOC0FcjfbFZYuf/7xduntoBYxaz/IstkVoAypgdjyaKPk1jbOaT0qE8jHjA4qO5B/D/wB266f3YljlL7MwqpKHGkt8uTp4EVXmUKrPmB+GNKsEkouo6tMF14m21VHo/QODnlR4Ffse4IC3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaAZzH5D; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaAZzH5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747329959; x=1778865959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nZFFmPKduRDcZeeSjBBqR5O4eN/yEn9j5m7lWz+axeI=;
  b=AaAZzH5DT4bc9IxTnCQLVTOjrZpFkB3/r8zSv5HIEV63zTZsai4HcH6U
   4UjCTZKVA9w0CGZBvAhdgB8rrTFByxxdrZi8CbKUzHGp3DcmmG8QIQ2F0
   23stJ3alxnRpwMuQUA2IMal63wSxzC2F+TT8rTrcwZy+swc8KLYA0cxIW
   2lXc8ho18jR2Bj3Qv8afoB6NBLF9gzPR/cPYxFfwqXkQ9jvzu+T0eQFnJ
   zLjbwoq5/uEgyC0s/wJaUFiQT8HTo8IYguVg2H9BTZj8TIhCSC2RLEz6q
   eD8kB07MLnS+yaG3eOLGmF2aepWY5tVT/JXigxDn4Ut+OsA7uRXpl7Pqp
   g==;
X-CSE-ConnectionGUID: FPEraUo6Q1+H2MF8Uy6SDA==
X-CSE-MsgGUID: yq2fugqLRymJAZFT9ep3jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="66832816"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="66832816"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:25:58 -0700
X-CSE-ConnectionGUID: KpATJFDwSw6HiKtQHFURqA==
X-CSE-MsgGUID: zM9EbxabQL2aGfN+29AB2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138171786"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 10:25:58 -0700
Message-ID: <97aa4fee-1f3c-4817-95cb-5393a800432c@intel.com>
Date: Thu, 15 May 2025 10:25:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cxl: Update CXL documentation for access
 coordinates calculation
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, gourry@gourry.net
References: <20250515000923.2590820-1-dave.jiang@intel.com>
 <aCYhFjRzZNNlFfvJ@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aCYhFjRzZNNlFfvJ@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/25 10:15 AM, Alison Schofield wrote:
> On Wed, May 14, 2025 at 05:09:20PM -0700, Dave Jiang wrote:
>> v2:
>> - Language clarifications (Gregory)
>> - Move all CDAT bits into single document. (Gregory)
>> - Define CDAT terms. (Gregory)
>>
>> Add CXL access coordinates calculation documentation including CDAT details.
> 
> I appreciate this documentation and it makes me half-smart on this
> stuff which leads to my possibly annoying questions:
> 
> Say I have a BIOS defined region. Can I look at the result of these
> calcs and see, or judge, whether BIOS set up the most efficient
> region?

Yes I think you can, since we do the calculation for all devices, not just the hot-plugged ones.

> 
> For a user created region where the topology offers some flexibility,
> can a user predict these numbers before creating a region? Can the
> user create a region, evaluate its 'perf characteristics', then destroy
> it and try another flavor?

I think so. If the QOS class mismatches, I believe you'll get a warning from CXL CLI, but you can override.

> 
> I realize this is internal docs on driver behavior and not user
> space documentation. I'm looking for info to improve my understanding
> not suggesting this info belongs in these docs.
> 
> Thanks - and, for the series:
> 
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> 
>>
>>
>> Dave Jiang (3):
>>   cxl: docs/platform/cdat reference documentation
>>   cxl: docs/platform/acpi/srat Add generic target documentation
>>   cxl: doc/linux/access-coordinates Update access coordinates
>>     calculation methods
>>
>>  Documentation/driver-api/cxl/index.rst        |   1 +
>>  .../cxl/linux/access-coordinates.rst          |  86 +++++++++++++
>>  .../driver-api/cxl/platform/acpi/srat.rst     |  27 ++++
>>  .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
>>  4 files changed, 232 insertions(+)
>>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
>>
>>
>> base-commit: 7855bc1362518673103bd9357827572207e6f6d9
>> -- 
>> 2.49.0
>>

