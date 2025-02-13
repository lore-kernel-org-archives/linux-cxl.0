Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021826E149
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484700; cv=none; b=Zuo84b/ALyhBXyVWRpZyCxhdtCPxxSyi9qXcaQyJS7MGYxZI+Vr27ck6DZ0WNLV/H/JEH1kRFkUDj6p0Nwf1qSTbhEMzJFYIQD/xjSa9kV8KveSieX0HZXhkquPeDwQ4xpBTU/u+6Me0kX+BCqAhlz4mhevlHsmqk8ZgR2/BL5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484700; c=relaxed/simple;
	bh=QLn0HCDo3El7ELZhOainUECMpPWBdtPyjGJW8Kvg65U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anbI4TJ9OhnsCALmF+S9pAz5YNuaQ7BAr6QSajCazNXmUiBeENwHAD3c4x8XtKRPZCvpWoPLQqIzmHpbF4bFhxA9g+QNngAtOx/h+/MLPcB123S5h/44vsKe4Mu1+a3T/Er/uYT4ToBz6pEP3neiViaL6zA4fuCrzDhwn4vq4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ynaw1pft; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ynaw1pft"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739484699; x=1771020699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QLn0HCDo3El7ELZhOainUECMpPWBdtPyjGJW8Kvg65U=;
  b=Ynaw1pftFckoijXF+InvNMvlxTon+7cY7+l7Dy91zP/sPNwVtpjtehiJ
   +jQB2ji4blP5Kknr5FwVQ3WTH7R8XT27szxAGNsWNPu8Ab+4i5xxmc7LS
   uBPwh1yp8rMKQZXkuiI4TeM4wA0q937m/pfc/J7sy75L2ts+t5rJzzxdQ
   FHQvkucZlHSUAlq7AEC+vUuQXqOFDRpBW6fSJ/Rte+2U3dALrhraNXpbe
   ecPx8FDapbqPUnHTWn5rDrB7wrsV40wTDuVCHygAh7s3OUT6AkA9b/bFh
   Grbiwpg4CUJeI6F8VV6g3uI0nmu7qtRk4DNUtSA/sAH6zJrtFAkYfiYIK
   A==;
X-CSE-ConnectionGUID: byZrbd2YQoWPMkLDZnt/aA==
X-CSE-MsgGUID: 1QTaAy4aT0GkqsUYLklV1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57617827"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="57617827"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:11:38 -0800
X-CSE-ConnectionGUID: v/fXhECiRB2OV2kok3YiyQ==
X-CSE-MsgGUID: Ee7V8wBZTSa0wcJ15pkN8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118288981"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.200]) ([10.125.108.200])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:11:38 -0800
Message-ID: <4001ae63-c1b8-4f9e-8cbd-7017d34779a4@intel.com>
Date: Thu, 13 Feb 2025 15:11:35 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] cxl: Add support for FWCTL get driver
 information callback
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, shiju.jose@huawei.com,
 Li Ming <ming.li@zohomail.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
 <20250211182909.1650096-9-dave.jiang@intel.com>
 <20250213193651.GD3886819@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250213193651.GD3886819@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 12:36 PM, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 11:28:02AM -0700, Dave Jiang wrote:
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Copyright (c) 2024, Intel Corporation
> 
> Please also go through and update the dates, 2024-2025

Ok will do

> 
> Jason
> 

