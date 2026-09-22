Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1689633689D
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 00:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037961; cv=none; b=F/qzD1BG2Ne2ptmSqNmCxqfyNtO6k8FGXajWCaKLkeRSK2Td7/+/DqfvvbDX0QalWP9BX87QCs8hyd35spFNkn4ExL7rlqSoqheVDKLG4Vhfm9p5KH36Ua2UUQEAvr3QCUYUbH/LrrQem6oZYuRCl++vNIo84OkDLT08+1OIR84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037961; c=relaxed/simple;
	bh=4130k4LuiPyuws7zmeOKc+NHb5OH8+IuNpbCvLEt+vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/uB5vIimDvM5z2+0ObAVMAknjZUKVszxKxgqTIs4csSq2ZstOH9XiEWWsknPE6332UbbfXfxfmEiBKlY1bH1NDyPe9mMx45JebbEmzRLWHOVRss7mo9kBe7MnD/vQFdqC4BerFCL2g5D7cFQ+g5l75lR+TCowSG5ilqZx79jM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwshbraU; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwshbraU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790037959; x=1821573959;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4130k4LuiPyuws7zmeOKc+NHb5OH8+IuNpbCvLEt+vw=;
  b=ZwshbraUCKcnGoJk4Pohw8vM5EebsCLNTREMu71V3QBoQYYCJeintUIS
   CYGMlBCX5FfrBE+RAQzSZOOotMYF8eu8Aqnc4glc/0iq6Ete86kxfTnH9
   hv/LhSWBAgr02gMwjkkEE6L/cDDVulaDJibnGXOYpY5pDSAlMcpI+Nt2M
   SAhidfEwu2rpETcjEzfAjz8I3twrUFVOqzNs6A5VrHf5dEHB4usfdsFDv
   gXq0yRiyhhqagB90uR36eqr1JN0HchLVv0mBchjxJ8Y0MZwGAFh4d+HKa
   C3CsyFfAeiCuhsy8gAmSIK9RQK4LxBMGr37y1CCiHO0QnAHyloQYUPW8e
   g==;
X-CSE-ConnectionGUID: Nn0xeUS5SaqaaiWvXQpOGQ==
X-CSE-MsgGUID: LVTwIV5BRz2cUvKT5L5o0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89734933"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="89734933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:45:58 -0700
X-CSE-ConnectionGUID: bwY+PQjlQ1KkSYXYn9RpIw==
X-CSE-MsgGUID: eTdp9kO/R5eU+TerrEQg+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="300831687"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.109.234]) ([10.125.109.234])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 17:45:57 -0700
Message-ID: <a26d002f-1dcf-4bf4-bfd5-dd587c559029@intel.com>
Date: Mon, 21 Sep 2026 17:45:56 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
 Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
 Gregory Price <gourry@gourry.net>, Richard Cheng <icheng@nvidia.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>, Ira Weiny <iweiny@kernel.org>,
 Anisa Su <anisa.su@samsung.com>, Wonjae Lee <wj28.lee@samsung.com>,
 Junhee Park <jh9934.park@samsung.com>, Heesoo Kim <habil.kim@samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
 <da6deab0-de16-43ea-bd13-5861f84a587b@intel.com>
 <20260922004228.5a0c027b@jic23-hlaptop>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260922004228.5a0c027b@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/21/26 4:42 PM, Jonathan Cameron wrote:
> 
>>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
>>> index 7b756000a1a6..6ef47265da10 100644
>>> --- a/tools/testing/cxl/test/mem.c
>>> +++ b/tools/testing/cxl/test/mem.c
>>> @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>>>  	if (rc)
>>>  		dev_dbg(dev, "No CXL FWCTL setup\n");
>>>  
>>> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
>>> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
>>> +				       CXLDEV_EVENT_STATUS_WARN |
>>> +				       CXLDEV_EVENT_STATUS_FAIL |
>>> +				       CXLDEV_EVENT_STATUS_FATAL);  
>>
>> Second time I'm seeing this constructed mask being used in this commit. Maybe create a define for it?
>>
>> s/CXLDEV_EVENT_STATUS_ALL/CXLDEV_EVENT_STATUS_BASE/ perhaps?
> 
> That was Anisa acting on my feedbakc on previous.
> I don't like _ALL because we already have an example of the spec
> expanding and the definition becoming messy. But mainly I was
> pushing back against _ALL + masking with one element we didn't
> want as fragile.  So I'm not against _ALL if it is made up of
> another define + DCD (for now) and that other define can be
> used in places like this.
> 
> Bikeshed time... BASE is usually a define for a reg address and it is
> is hard to come up with a name for that when it is a mixture of
> RAS stuff and INFO which can be a wide range of random nasty
> and nice things.
> 
> So with the right name seems fine to have what Dave suggests.
> I'm just not sure what that name is!  Hence I'd just stick
> to the long hand option.

Yeah if we can't come up with anything good then leave it as is. 

> 
> Jonathan
> 
>>
>>>  	cxl_mock_test_feat_init(mdata);
>>>  
>>>  	return 0;  
>>
>>
> 

