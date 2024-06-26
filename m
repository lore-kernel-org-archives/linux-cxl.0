Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031B18E75D;
	Wed, 26 Jun 2024 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420091; cv=none; b=Q6kiacOQmis36Su6A8NJfCx6ogogG+cO8hyGe5tKU5qBXU2sEZ9LBRR6DgvXOtccrYEvVBYQfAcIHd2BBAl9QkUVyDYJTP7loZtkTBq1tA+rrtFhXA+N2DzuYFirqH/jkqUqX2o4yG/kuOZqJVlwzP6GhXueZNvmOlJN+UvGJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420091; c=relaxed/simple;
	bh=Ng3JmspzaUJJb1ZBh8cyB3xxKd0+Oed2sYqKaTzLd6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DoanOuG4r78XRxJc1X98nyXJpYjvx/JnHi9081pWzJ+lDsz2d2d9Q5WDMlDToa7XUVmgbrc5bP1/Yf3BF2wsxqVA9h/hLZEnQENdL6610bdJ29qf8jw3yT73THoTjKLaL/ehfcsz3Ld43sAzyJzujJJXW3g5hmhta/2d6Z4FrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+4M+nxl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+4M+nxl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719420090; x=1750956090;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ng3JmspzaUJJb1ZBh8cyB3xxKd0+Oed2sYqKaTzLd6I=;
  b=n+4M+nxlQgRYe7sTLxe97O4JXyfHOq99aZ86Zkn1F2f2UOo0oBcktU9+
   i/CNP6c5UTGYDMEdD7/wsrxHluw+BQbQNPEkTsNFdWU+SsFDIezulpVr6
   tFmvYeZbzZdbqETkHIIGEW58U8gtSUoJ20JAcLJLWKsuZW27HWtigHraH
   bIyUXUFzJMxNjzS76GMDjKLwpLZl6NwaIgau/saCWGA+Cn9FbpDOp1oiC
   V2l0d/FOyOAzOEXvC+F3eTvyFgHATQaLB+fdWuVTEtyIGxcH0NVbnwTIT
   Ss99koTvnVP4pOE7k8rQ1jQNBkZpKSOEnm9cNV18iMo4Qbl9eNqLVwUDj
   g==;
X-CSE-ConnectionGUID: a7MljIhzTLqy5jIYpQd2Rg==
X-CSE-MsgGUID: ZjTbdLvfQ0GyMi2RVINbCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16731591"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16731591"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:41:29 -0700
X-CSE-ConnectionGUID: /6wgtqOCTNipk71msqBlDQ==
X-CSE-MsgGUID: iTCNQAUSR0KEjIrE/eG4Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="44778573"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.183]) ([10.125.109.183])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 09:41:28 -0700
Message-ID: <73d13869-cb80-4226-b8fe-3e45fb7d2518@intel.com>
Date: Wed, 26 Jun 2024 09:41:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20240607-md-drivers-cxl-v2-1-0c61d95ee7a7@quicinc.com>
 <20240607151046.00002ae2@Huawei.com>
 <aef7c12f-cefa-4823-b3a2-920c12990afa@quicinc.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aef7c12f-cefa-4823-b3a2-920c12990afa@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/24 9:02 AM, Jeff Johnson wrote:
> On 6/7/2024 7:10 AM, Jonathan Cameron wrote:
>> On Fri, 7 Jun 2024 06:57:15 -0700
>> Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>>
>>> make allmodconfig && make W=1 C=1 reports:
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/core/cxl_core.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pci.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_mem.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_acpi.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_pmem.o
>>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/cxl/cxl_port.o
>>>
>>> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>>>
>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Thanks,
> 
> Following up to see if anything else is needed from me. Hoping to see this in
> linux-next so I can remove it from my tracking spreadsheet :)

I have it locally queued, but will probably push to linux-next after rc6 drops. 
> 
> /jeff
