Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280620F072;
	Mon, 13 Jan 2025 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736787317; cv=none; b=S0kqVzPCJ23i22qcvvRH1EmV4EBktiCsL6q2iyIOFuqoJ5z/dxDM8O/H99X9gbdGljfTp5qD/Pm93Kj8X8S+YIWhKwLYsAtNRsjhtJpOh0fIjVoJOsvyfI6NrlbhWTBvGPWiUOQL3+jEx4iLN96Enm3AC2YRuVFpB43E1A1LYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736787317; c=relaxed/simple;
	bh=s9d2gDx0TpW0Khiae17zFw+yL4e1OATprQNO+K8osq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZME2alDc499V4fO6t+VJ3d8NltgPL8ZQsGu0zFCtgAqrs78Tnazd5WszBjnHJg5ShRA6LGybJHq0yyHE0l0fgQmW8Qn6VXydKvm2vG3JbPdzLLXvNs1qQB5MJxeFzjajGgUW2qefvWI6ZmE/6iJqlrATnbpq7vRzWdGyf5WeMaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JNnREEvv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JNnREEvv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736787315; x=1768323315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s9d2gDx0TpW0Khiae17zFw+yL4e1OATprQNO+K8osq4=;
  b=JNnREEvvEo3Kz50RAD382Kic1sqiNcRE7vl288H7U4YLQoKrb9KYw0L6
   A//60Lg+UgUuhZmyflIquzYF4bqkLXPSRV++TKKoIiLMDf9QBuFJ3w3bl
   kAvWUJg7n7+hT3H+lrstiTfa1mI+jOvaxwZDMeOAYEXs7O7VOg6ZyXAcS
   TVTHgrBfdx3Sopo3io1jV+AjC1OCgXj72JSSOp6FXGmKWofrMehLBJDOG
   T9WTQIDDv/ccILe9fRHF4GxL/r+v8jKN9iExY5D8rcI/iQ2cYAk7HngbX
   zDrtUxUxxNgWCHNh1Q5B3rSVL2DKBstoT8CINiLkWBZBDdAShOY+RFHHs
   Q==;
X-CSE-ConnectionGUID: Cd+omv6fTGOE+k5CEtaGyg==
X-CSE-MsgGUID: MwBWPCahQ5KZeXq5lyLgcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47551385"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47551385"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 08:55:14 -0800
X-CSE-ConnectionGUID: 3DBmW6OqTP+/OMscY5Tpgw==
X-CSE-MsgGUID: jiuFzCK/SAS1zXMYDrbhIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104495778"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.41]) ([10.125.108.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 08:55:13 -0800
Message-ID: <6238f100-16c4-42d1-8dc6-320e116a7b55@intel.com>
Date: Mon, 13 Jan 2025 09:55:12 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Update Event Records to CXL spec rev 3.1
To: shiju.jose@huawei.com, dan.j.williams@intel.com,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 nifan.cxl@gmail.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxarm@huawei.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com
References: <20250111091756.1682-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250111091756.1682-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/25 2:17 AM, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add updates in the CXL events records and CXL trace events implementations
> for the changes in CXL spec rev 3.1.
> 
> Shiju Jose (6):
>   cxl/events: Update Common Event Record to CXL spec rev 3.1
>   cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
>   cxl/events: Update General Media Event Record to CXL spec rev 3.1
>   cxl/events: Update DRAM Event Record to CXL spec rev 3.1
>   cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
>   cxl/test: Update test code for event records to CXL spec rev 3.1
> 
> Changes:
> V5 -> V6
> 1. Modified for feedbacks from Ira Weiny.
>    - Reordered new fields added in trace events cxl_general_media,
>      cxl_dram and (cxl_memory_module to pack the records.  
>    - Added a suggested note in the patch description of patch
>      cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
> 	 
> V4 -> V5
> 1. Reverted changes made in v4 for overcoming parsing error when
> libtraceevent in userspace parses the CXL trace events, for rasdaemon.
> This was due to trace event's format file is larger than PAGE_SIZE, not
> supported reading complete format file in one go in the kernel and thus
> fixed in the rasdaemon.
> 2. Rebased to v6.13-rc5, in which cxl.git/next is based.
> 3. Tested with rasdaemon and ras-mc-ctl tools updated for CXL spec rev 3.1
>    event record changes.
> 
> V3 -> V4
> 1. Changes for the parsing error parsing error when libtraceevent in
> userspace parses the CXL trace events, for rasdaemon.
> It was found that long decoded strings of field values in the TP_printk()
> caused the issue, looks like due to buffer overflow/corruption.
> Increasing known buffer sizes in userspace and kernel did not help.
> As a solution, decoding of some fields in the TP_printk() are removed
> to accommodate the new fields.
> Decoding of these fields is added in the userspace tool rasdaemon.
> 
> V2 -> V3
> 1. Changes for the feedbacks from Jonathan.
>  - Added printing component Id format bit in show_valid_flags()
>  - Modified parsing component ID in patch [2] and added logging
>    of raw comp-id, comp_id_pldm_flags, PLDM entity id and
>    PLDM resource id in patches 3 to 4.
>  
> V1 -> V2
> 1. Changes for the feedbacks from Jonathan.
>   - Separate patch for Component Identifier formatting.
>   - Moved printing of event sub type after event type.
>   - For memory module event, rename sub_type to event_sub_type. 
> 2. Changes for the feedbacks from Alison.
>   - Updated patch's subject
>   - Updated CXL test code for CXL spec rev 3.1 event records.
> 3. Changed logic for Component Identifier formatting and other improvements.
> 
>  drivers/cxl/core/trace.h     | 259 +++++++++++++++++++++++++++++------
>  include/cxl/event.h          |  28 ++--
>  tools/testing/cxl/test/mem.c |  23 +++-
>  3 files changed, 257 insertions(+), 53 deletions(-)
> 

Applied to next
