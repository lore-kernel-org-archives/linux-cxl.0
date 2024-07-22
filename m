Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8B4965E
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 23:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721690599; cv=none; b=TkxqYaROukD73I0MRC3AjnoRg2ugtZ4duOX2nPGwijAl69MuxiKvJGJVVl6CbY+ZpINupSCzPckBIXfz2D6YNxgpqV3t13SDG9km4+AzpctNTYFttMzA/uLO4saFL5Nb4os7IinAxQ+bAYni47CySxGv4BkzyWNdCyp/Zi45cyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721690599; c=relaxed/simple;
	bh=a1P273GH7Cfp6EdWfW371IofVE7593Y9KyjK4q1xk9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5Jb5W8vR6YOGVn1g1NEQVC138/AL5X3NvbDSPmSVpRybiXX+hStLt2nNFsFBMfew+JRU7ERd1l8m4U9U7ExBzQLwmNjiJsuRKZ/3Pj/TIq5cZjBt3IiE0CnQqKxrFHZXEEG/h2mnNnqiMqx71KnxwpjBtZfwSKYo+3Pk+Dhtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4QCYI6p; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4QCYI6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721690596; x=1753226596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a1P273GH7Cfp6EdWfW371IofVE7593Y9KyjK4q1xk9M=;
  b=K4QCYI6p1yRSQa9GX3WD2REMy/wn+k3bu8JQKisTmjP1a5uZL6uhDgIr
   Aw1W9VWINP6I4D2eY+dEG//zlMpyW8DrqGXAjsRVsAqdr3DFOsB9JdkUp
   he/VaFnyJwmornYetMuNe7R/SnYMej7YmLqimUXW4/kY24fVoS7/YKXNj
   uA0OBVxyqACfwgbHxzzEslSXZVFCDFwjRpBsydRNz6PLkEyOmsdaNPwaa
   CHfSQTTSpeH8o5TWB8/SAJKXYq7IUIwm4vpNjq2y4xg86sQ8HqNHfXLGP
   ZR3oBbRa61xU/4zv+Sxk6zaaGXrm4kesrqnS3tbuE8s2QMo38dhElMliH
   g==;
X-CSE-ConnectionGUID: WIPfrIFVQ2GKwB2b2vJOPQ==
X-CSE-MsgGUID: uQdJ5Vs2QlewAPI8vEFEyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19415163"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="19415163"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 16:23:16 -0700
X-CSE-ConnectionGUID: HguDxq7QTvaRXrgVEAQv+Q==
X-CSE-MsgGUID: Xc5bn3c0RjibCt5d94Z6nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; 
   d="scan'208";a="89496702"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.188]) ([10.125.109.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 16:23:15 -0700
Message-ID: <f3cd9a95-470f-4db5-97f0-04bd3ff70cf6@intel.com>
Date: Mon, 22 Jul 2024 16:23:14 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 11/13] fwctl/cxl: Add query commands software command
 for ->fw_rpc()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-12-dave.jiang@intel.com>
 <20240722152401.GC3371438@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240722152401.GC3371438@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/24 8:24 AM, Jason Gunthorpe wrote:
> On Thu, Jul 18, 2024 at 02:32:29PM -0700, Dave Jiang wrote:
>> Add a software command through the ->fw_rpc() in order for the user to
>> retrieve information about the commands that are supported. In this
>> instance only 3 commands are supported: Get Supported Features, Get
>> Feature, and Set Feature.
> 
> I wonder if we should try to have a seperate API for this, knowing
> what command numbers are supported seems sort of general to me?

Probably a reasonable thing to add. Will you add something in the fwctl v3 or should I try to add something in my series for fwctl?

Wonder if we should also return some sort of fwctl commonly defined effects field for each command.

> 
> Jason
