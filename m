Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254C5224AE1;
	Fri, 10 Jan 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540297; cv=none; b=r2Jqa1xx/J7cFpIbUFwvnO8zr3BCPhFO9Txw2nPFiBFumnTqMP1Wl7FnnqFR9HWNIfH+MR5cegGyj4IUiblLk3/YCjQCXqkf67rCUcYOF/rbLzvrkwZuNlRQZk410pDrbSKxGEZfevNkIckg+QcaAaABcp6xLyLIbgKcgJU5F70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540297; c=relaxed/simple;
	bh=HnTf4myMKb5ekz0cFfVdAqosTnJsDphuocoPlzgRb2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZLbI67/skjxCcobAvLFfFYA9dhpdvmbWBKdrq4k3mYZuPkZMGIAUlZSUtrIiG79jfeKlDbb/iAhT0z9xwHG75/6aLfF/NURD/l4Utj3cPj2uvX6j3fiIUojprerK+btWutCgY9hHdZCTWMNtmRfbfvItylhgGmo4wk7hFtQ+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N2aPoYl2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N2aPoYl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736540295; x=1768076295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnTf4myMKb5ekz0cFfVdAqosTnJsDphuocoPlzgRb2A=;
  b=N2aPoYl2OHIEGhCGz12VWMOdEVWfMBAC4PyLEevrmiJFzgTf8Kuld8Sn
   1JGxArxX+tOvp5cpaKw6FY1e54cxaa+eqv2eCOp0ncbD6g5KX1mRxcII5
   /d/dKlHfz98/bO62dqpXQF09c41gvbt/svKc71W/aiyeWq2mCwe56DBSV
   zkj0hUxKYm/nqLtorM+P///LGtT5EyGpW403snvpPfiItcM9bUOKd8FSN
   j8CJoQsdfzu+TtY4hLMSFozCx0MUbNu1BeswRZlxatyTvsEibiSYmcQZM
   iIVfnIWvSQ4CFTZKdpUd7ngMG1u3PqGy13vLzmiq5aW9bc2CPEyLpw8Mr
   g==;
X-CSE-ConnectionGUID: VQV5Pc0qSSyMAShk1zZQjA==
X-CSE-MsgGUID: PD1TtrSwRMyU1BYZThWxpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="36130852"
X-IronPort-AV: E=Sophos;i="6.12,305,1728975600"; 
   d="scan'208";a="36130852"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 12:18:14 -0800
X-CSE-ConnectionGUID: yHUk3sfkTaqn7f1XJd8c2g==
X-CSE-MsgGUID: 41JT+VQ6T5+W7y1e59Em3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127115138"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 12:18:13 -0800
Message-ID: <ba35a66c-2dcc-4bb6-a0bb-163f4209449e@intel.com>
Date: Fri, 10 Jan 2025 13:18:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
To: Shiju Jose <shiju.jose@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>, tanxiaofei <tanxiaofei@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>
References: <20250110115556.1654-1-shiju.jose@huawei.com>
 <20250110160645.00007b74@huawei.com>
 <1b090d80a49a47e7b220aca07dce4cae@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1b090d80a49a47e7b220aca07dce4cae@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/25 9:46 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>> Sent: 10 January 2025 16:07
>> To: Shiju Jose <shiju.jose@huawei.com>
>> Cc: dave.jiang@intel.com; dan.j.williams@intel.com; alison.schofield@intel.com;
>> nifan.cxl@gmail.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>> dave@stgolabs.net; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Linuxarm <linuxarm@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
>> Zengtao (B) <prime.zeng@hisilicon.com>
>> Subject: Re: [PATCH v5 0/6] Update Event Records to CXL spec rev 3.1
>>
>> On Fri, 10 Jan 2025 11:55:50 +0000
>> <shiju.jose@huawei.com> wrote:
>>
>>> From: Shiju Jose <shiju.jose@huawei.com>
>>>
>>> Add updates in the CXL events records and CXL trace events
>>> implementations for the changes in CXL spec rev 3.1.
>>>
>>> Shiju Jose (6):
>>>   cxl/events: Update Common Event Record to CXL spec rev 3.1
>>>   cxl/events: Add Component Identifier formatting for CXL spec rev 3.1
>>>   cxl/events: Update General Media Event Record to CXL spec rev 3.1
>>>   cxl/events: Update DRAM Event Record to CXL spec rev 3.1
>>>   cxl/events: Update Memory Module Event Record to CXL spec rev 3.1
>>>   cxl/test: Update test code for event records to CXL spec rev 3.1
>>>
>>> Changes:
>>> V4 -> V5
>>> 1. Reverted changes made in v4 for overcoming parsing error when
>>> libtraceevent in userspace parses the CXL trace events, for rasdaemon.
>>> This was due to trace event's format file is larger than PAGE_SIZE,
>>> not supported reading complete format file in one go in the kernel and
>>> thus fixed in the rasdaemon.
>>
>> Great to see that resolved.
>>
>>> 2. Rebased to v6.13-rc5.
>>
>> Should probably say why when doing a rebase to something other than rc1.
>> In this case this is what cxl.git/next is based on after some fixes earlier in the
>> cycle so a sensible choice for this set.
> 
> I checked. These patches applied cleanly in cxl.git/next and buid okay. 

Hi Shiju,
Can you please apply Ira's suggestions and respin a v6? Thanks!

> 
> Thanks,
> Shiju
>>
>> As far as I'm concerned this set is ready to go, but more eyes always good if
>> anyone has time! Same for the ras-daemon series once this is queued for the
>> kernel.
>>
>> Jonathan
>>
>>> 3. Tested with rasdaemon and ras-mc-ctl tools updated for CXL spec rev 3.1
>>>    event record changes.
> 

