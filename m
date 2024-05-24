Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B28EC7
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716563786; cv=none; b=qaqWUHvkfUmzu+fNTNEkOxq1mR5oEafVE+tC8TTRlzuSVylmFmJJVj8OzgRbXqQBVA96HQ37Guz2QkT0/HFzeuM7mSUKz1oPuGBNlSpi30g44vFF+EKzTYn4uaJddhb9QU4Jm6almfi2c1cJ6MDOjbT6HtzbbIvGbb8VgPu+23g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716563786; c=relaxed/simple;
	bh=xoZ003bwIPu31/pbCrkVADY8cXcgI7OucFW47GX4d4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uofYXI36Lcnknu/GxbrEYLAEpQaYrwHQ+tvBmfFHjyHclVWwQ3BLEpz/cNzRXgir/dwX7AkHYS4QurNLzjQtI6pnX2xVrisQr/xklbGmhUuBCZn7jgtZjEerhLxsyyaD1IpR2F1aiboJidiOfTT3s/8hoeyBLWMqo7C+VAuZ7OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DkKWGXg4; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DkKWGXg4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1716563783; x=1748099783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xoZ003bwIPu31/pbCrkVADY8cXcgI7OucFW47GX4d4U=;
  b=DkKWGXg423g2xqrvNoqW3gIOn72P9F2x0YQYrA4xFbCaE0WaghUBTfGN
   +6DNojbvwORBImjGQItIFuO6E98vymAwbAFBbJJvaX0UI5RM0xbJgrhrD
   wpyzvFpH3x0sTwE8UHSrkyN27zXofl0qs+DqQ1B45ynQR8dW9zD5ss8zD
   RTmSszdF6jZNiX0oMRDjI43PxXB9upFvkBfMdgdHhx7BfEE2hr1fsW71i
   /p3UVpv8Ky1OmcC3FrhbhDx79K4qjqmov36XMy56xGQUfclzl3OL9jRfa
   VP5i1IbBmwaYoMKKycwKS9xvWat+ZYi4ctpcqe2qGiOeCUsTHGTRxpx+x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="160016404"
X-IronPort-AV: E=Sophos;i="6.08,185,1712588400"; 
   d="scan'208";a="160016404"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2024 00:15:12 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id A1032E8523
	for <linux-cxl@vger.kernel.org>; Sat, 25 May 2024 00:15:10 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DB590D3F13
	for <linux-cxl@vger.kernel.org>; Sat, 25 May 2024 00:15:09 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 63EA0202DB1A9
	for <linux-cxl@vger.kernel.org>; Sat, 25 May 2024 00:15:09 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 58ABB1A000B;
	Fri, 24 May 2024 23:15:08 +0800 (CST)
Message-ID: <28c92491-a892-4c9a-8c92-5d039681f817@fujitsu.com>
Date: Fri, 24 May 2024 23:15:07 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] cxl/core: add poison creation event handler
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 alison.schofield@intel.com
References: <20240417075053.3273543-1-ruansy.fnst@fujitsu.com>
 <20240417075053.3273543-3-ruansy.fnst@fujitsu.com>
 <6628008c39e80_a96f29415@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <b5eb1017-5f0a-4d68-bb63-41e628706a78@fujitsu.com>
 <b14ed74c-7fc5-461a-9c5f-fbb94df50e7d@fujitsu.com>
 <664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28408.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28408.000
X-TMASE-Result: 10--25.799500-10.000000
X-TMASE-MatchedRID: xnGAJ48IopiPvrMjLFD6eJTQgFTHgkhZw5PXDQWptSnHr4PSWTXSLMWl
	hj9iHeVppQJHQvYIR1VvedD3CYSjHdgW4k6aveo4TbFVCYPBTqYimo23ixY4DgUcMWdRj2fqZVh
	gLjSOksa18VsV6lgC4J+qZRE5XDC8dvvbftTsJScLwUwfdPoXvoiuaoNXJrK/rSPg4ph0OILDwJ
	S0XWHAkDLFcdqm3RNLokHVVVZ21OIuRdmDWOweyvwCyINrEjhruoYFb0nRiqPJxEA95JnWHmJo6
	KW+BOMMJK3weEsceTpJ9iwir5XT1WsV28ESZOe8DstQFfLVA/ATzLWUAQyt6P2Pg1z7MRXYtE9h
	falO+MqEju6+OLyeK+8j2/Qpcz48hpgZAljFgxOVOwZbcOalS26Pap1MPdtHMZJ6fLab4266PD0
	Fdea44H3NbsWb+gRT7qiScGBNfGZ3q5Rm8/DlxaoXHZz/dXlxEq8VpxNVVIliJsO4rdorwcygAl
	+yObROEq9A6JF9rFlftuJwrFEhTbew1twePJJB2KDPNsqphTL6C0ePs7A07QKmARN5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/5/22 14:45, Dan Williams 写道:
> Shiyang Ruan wrote:
> [..]
>>>> My expectation is MF_ACTION_REQUIRED is not appropriate for CXL event
>>>> reported errors since action is only required for direct consumption
>>>> events and those need not be reported through the device event queue.
>>> Got it.
>>
>> I'm not very sure about 'Host write/read' type.  In my opinion, these
>> two types of event should be sent from device when CPU is accessing a
>> bad memory address, they could be thought of a sync event which needs
> 
> Hmm, no that's not my understanding of a sync event. I expect when error
> notifications are synchronous the CPU is guaranteed not to make forward
> progress past the point of encountering the error. MSI-signaled
> component-events are always asynchronous by that definition because the
> CPU is free running while the interrupt is in-flight.

Understood.  In OS-First path, it couldn't be a sync event.

> 
>> the 'MF_ACTION_REQUIRED' flag.  Then, we can determine the flag by the
>> types like this:
>> - CXL_EVENT_TRANSACTION_READ | CXL_EVENT_TRANSACTION_WRITE
>>                                                 => MF_ACTION_REQUIRED
>> - CXL_EVENT_TRANSACTION_INJECT_POISON         => MF_SW_SIMULATED
>> - others                                      => 0
> 
> I doubt any reasonable policy can be inferred from the transaction type.
> Consider that the CPU itself does not take a sychronous exception when
> writes encounter poison. At most those are flagged via CMCI
> (corrected machine check interrupt). The only events that cause
> exceptions are CPU reads that consume poison. The device has no idea
> whether read events are coming from a CPU or a DMA event.
> 
> MF_SW_SIMULATED is purely for software simulated poison events as
> injected poison can stil cause system fatal damage if the poison is
> ingested in an unrecoverable path.
> 
> So, I think all CXL poison notification events should trigger an action
> optional memory_failure(). I expect this needs to make sure that
> duplicates re not a problem. I.e. in the case of CPU consumption of CXL
> poison, that causes a synchronous MF_ACTION_REQUIRED event via the MCE
> path *and* it may trigger the device to send an error record for the
> same page. As far as I can see, duplicate reports (MCE + CXL device) are
> unavoidable.

I think my previous understanding about MCE was wrong.  Here is my 
current understanding after some research:

Since CXL device is a memory device, while CPU consumes a poison page of 
CXL device, it always triggers a MCE by interrupt (INT18), no matter 
which-First path is configured.  This is the first report.  Then 
currently, in FW-First path, the poison event is transferred according 
to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
-> MCE.  This is the second one.  These two MCEs represent the same 
poisoning page, which is the so-called "duplicate report", right?  Now, 
the memory_failure() handling I'm trying to add in OS-First path, is 
also another duplicate report.

So, the primary issue to be solved is the second MCE report.  As you 
suggested, make it a optional action.

Please correct me if I'm wrong.  Thank you very much!

--
Ruan.
