Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA412E7F
	for <linux-cxl@vger.kernel.org>; Thu, 15 May 2025 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747353085; cv=none; b=to1LgA6QgTxLI9fN33jAqAsNTAJdabWq6jYk/MRPT5iT/BdoH6szy07T1XILdJxQaHITNZmR6zAqK7G8ygCmNt1zQqlOBmX9v+ngtJQqSLw8UjXt/36eu84AfM6ckKmOeNiaJccOutackWjhL8vd6LGHkCyLUUV42hf2Qlf5oWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747353085; c=relaxed/simple;
	bh=DyL1WS0mdtOnvJJzTQ6AI6246GpvmD3ljQkISzMIekI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fhpcr9TF+bAJpRaX8L/VRGWsgEgimbzHR7c+zxse8Njqna0Qt9sRUZrQWHwfdmk4Emzsz/1AF6vfGhNDHYdtLvmH5YNB7uoB38UtJApeudL+1jXMSBSgHd6g6Hqzyvbv7KjKprdDXLUcgmNrKrVMbARxeXAfAlX40qkYmvEMlfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzGRKKfC; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzGRKKfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747353083; x=1778889083;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DyL1WS0mdtOnvJJzTQ6AI6246GpvmD3ljQkISzMIekI=;
  b=lzGRKKfCFy9ZIU01J/ncIY+fhy1RQCfOA/Jfu86m/o7x0+6gfIm9Mjdu
   vi5GGFisEtrb5mtkMwcW+Pj30wUKSnu5uCJ+cXswEMnjc2eLr6ILmSYi4
   xvD/1lsRhaYTENEgcyw43C+LHBkZYG22C6nTrkG/2rg8EYW7L2MeJaxAr
   XWYDuKq09Za2nE72kMC0sut/h6C5MPLGsLQ70/ncj2qJuY4+s7grY8Wzj
   xV/530IMDYrdPlOq85u+aBWJ5mD03ZfdjWdgC9Kg8GDyXg2a4jIQMmVoj
   gGLJ2r042OKugBSuSU02b9fkNme7TbXufmTNSsK4N5xltzibVV2+pkB1L
   A==;
X-CSE-ConnectionGUID: W5ZNPT3sQy6Kw2D4GIBwVw==
X-CSE-MsgGUID: sK92T7w8QGCmJ1C9cJvaMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49471718"
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="49471718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 16:51:23 -0700
X-CSE-ConnectionGUID: 75yXQPu/TRGrLpFoxED/TQ==
X-CSE-MsgGUID: WK1DaqmXTBGSdlKTGLGPvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,292,1739865600"; 
   d="scan'208";a="161829818"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.109.47]) ([10.125.109.47])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 16:51:20 -0700
Message-ID: <cbc7a205-af89-4d13-900b-6fde2df5536e@intel.com>
Date: Thu, 15 May 2025 16:51:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] cxl: Update CXL documentation for access
 coordinates calculation
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, gourry@gourry.net
References: <20250515000923.2590820-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250515000923.2590820-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/14/25 5:09 PM, Dave Jiang wrote:
> v2:
> - Language clarifications (Gregory)
> - Move all CDAT bits into single document. (Gregory)
> - Define CDAT terms. (Gregory)
> 
> Add CXL access coordinates calculation documentation including CDAT details.
> 
> 
> Dave Jiang (3):
>   cxl: docs/platform/cdat reference documentation
>   cxl: docs/platform/acpi/srat Add generic target documentation
>   cxl: doc/linux/access-coordinates Update access coordinates
>     calculation methods
> 
>  Documentation/driver-api/cxl/index.rst        |   1 +
>  .../cxl/linux/access-coordinates.rst          |  86 +++++++++++++
>  .../driver-api/cxl/platform/acpi/srat.rst     |  27 ++++
>  .../driver-api/cxl/platform/cdat.rst          | 118 ++++++++++++++++++
>  4 files changed, 232 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
> 
> 
> base-commit: 7855bc1362518673103bd9357827572207e6f6d9

Applied to cxl/next
