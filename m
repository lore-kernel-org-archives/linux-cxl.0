Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE422D7DFE;
	Wed, 18 Mar 2026 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848198; cv=none; b=pgdWB3s2/0JLGESR0rtgk3s7VvzRKYPLZ+ahZHB8d1Yz5yrxJVhqpK0fu68rYxvLvyI03xX05UJR+ScY7KYSE8tpER0GoPhE+qPlieVHjnePKBXNsdDbJojheNyEkKj/fBnhEDHlEWYCEb5/GWn6gic167lEcadvaJA+xgcoJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848198; c=relaxed/simple;
	bh=chZYyE6hrMdw9v7LMhfqbhyRHomXT6H7c48K9IGf3/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4b0bnazSNqOosp1sw8OZL60fbPdZh8q0IbHnTRmNRWNFQKzV+iddI0wfApCNUcTffscd7VKXb9cRpMgmB15pAJu0Z4i9UnkoM2UMrjionum4+A8wvVenu8betXvxbxW++I4jaflTLTvXn0hDUnE+EaDhmHp7Y7a7vZYshxZDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7Gmp21Z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7Gmp21Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773848195; x=1805384195;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=chZYyE6hrMdw9v7LMhfqbhyRHomXT6H7c48K9IGf3/g=;
  b=S7Gmp21Zd2mshdnbto/qi8GgmRCgPKoQq7/m5TdRM4OIU4HWWzTGKuB7
   j5+7PtqNLzK2FRZBr5gZcQbSkjLQgq7qm+g0WOR5t/qLjjG0IyLzoQ1ai
   etIqAGErseGONkZq5Itj1ohTDVly005jFC8KQb/ow+IdRw8+MHJ8Q1uzq
   umTJy2+7d4I3QToVvmJ3uxfeFWOLToko7EgvbQ1hteVBJbVz4Lzens6/+
   IiBXBDO665Cegh7rcVkCXhb/f/gczFccG/ZpCMmkaa+VAs2d3h1KZVCWh
   A7DzHRrdVsw+/XZjmcGQ2t60t+VxOjP5bCvCGCDmLbO/SJ8GIyj2Yz2EC
   Q==;
X-CSE-ConnectionGUID: LIzg0McfTku6WsFNxQlOUA==
X-CSE-MsgGUID: DqL3yClvQ/a3VChLCSxJFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="97515727"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="97515727"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:36:34 -0700
X-CSE-ConnectionGUID: qmUk7wztSfCy+qozkrFSBg==
X-CSE-MsgGUID: RyESH96FQuC5d8FOEHZu8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="216840653"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.108.242]) ([10.125.108.242])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 08:36:32 -0700
Message-ID: <dfc0979a-b01a-4c90-8bc8-7a60fb795dc7@intel.com>
Date: Wed, 18 Mar 2026 08:36:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20260314-fix_access_endpoint_without_drv_check-v2-0-4c09edf2e1db@zohomail.com>
 <20260314-fix_access_endpoint_without_drv_check-v2-2-4c09edf2e1db@zohomail.com>
 <c784d84c-e8ac-4c87-abec-3d4e64f074a2@intel.com>
 <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <d2ed94ec-e5c7-4b6b-9fe8-68f22bd632ad@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/18/26 4:59 AM, Li Ming wrote:
> 
> 在 2026/3/17 23:00, Dave Jiang 写道:
>>
>> On 3/14/26 12:06 AM, Li Ming wrote:
>>> CXL memdev poison injection/clearing debugfs interfaces are visible
>>> before the CXL memdev endpoint initialization, If user accesses the
>>> interfaces before cxlmd->endpoint updated, it is possible to access an
>>> invalid endpoint in cxl_dpa_to_region().
>>>
>>> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
>>> interfaces until CXL memdev probing completed.
>>>
>>> The following patch will check the given endpoint validity in
>>> cxl_dpa_to_region().
>>>
>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>> Hi Ming, I dropped this patch with Dan's comments [1] and updated cxl/next. Please check and make sure everything looks ok to you. Thanks!
>>
>> [1]: https://lore.kernel.org/linux-cxl/69b8b81621e16_452b100e@dwillia2-mobl4.notmuch/
> 
> Hi Dave,
> 
> I think there is no change needed in this patch, just need a independent patch for holding memdev lock in cxl_region_debugfs_poison_inject/clear.
> 
> Or you want to review this patch again?

No. Maybe I misunderstood the comment from Dan. So we should keep this patch?

DJ
