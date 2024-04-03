Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7F1494DF
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156235; cv=none; b=myCCp19lmMK5hwS0RzncvZphed2vcMkLquabG3NyetC93atvQd9aezUN7f0jdIQPalZ1bS24DjfzbiBwujpqLIsrDqqVrY+S9nqTBUyGXqcl8w0xzA4U1yGN3TOqOQvUSQg8RqWtk12tNm/KUEtJDDwMi+6/aeMU3Bxtrex/Z9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156235; c=relaxed/simple;
	bh=wGVG9UoQIH9HATg63O7PLJz1eHZyUcRz7fmo8PRFMm0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rg/PyTNSe0mdy676VLaQMXlwI+txOisQ7Y59MKNdAgcAW5diJkZKN/zH2eS3Z0VTVoqM0c/SEZ152ipTsasdNb0ctawqHoKSJP6PZs4PH/wkFExfjcwzXOgHO/eLtzf5EEFqYOtjjbwntcobxOHpAJb+QlM0I8C4eZhM2NCqy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=ZHeoxFrV; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="ZHeoxFrV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712156232; x=1743692232;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=wGVG9UoQIH9HATg63O7PLJz1eHZyUcRz7fmo8PRFMm0=;
  b=ZHeoxFrVm+rT3vmzkDCzeNl32KV9aPhIvreo/OelhpQbGmLIEn9mmQbJ
   gd+9GHQT5Ga8ja+F3HOo3FauAFfje1HWQTZYJFDqk4DE4MeJ1LX6rBsGz
   eb/yFXFRLxkfOnyc9ZVZdZuiZVAVcfiI9JlzhKGbLX+BCf84ajavZcHAY
   2joRVjbWF1NzH7kJx+vCbSb3l36NxDCfLERl1gl6W0ZmQOG8KNtcim+9x
   DZ7TLojstfhxJ1LNs7+L1eftOo9doQxkweiUha/+oOftHX8TrynQm5q/q
   32gxboQR6lqgiw9VXuk2zPMTcb+lXIQJelEdEd3mr2v8zn0LoWRt1BInl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="154780912"
X-IronPort-AV: E=Sophos;i="6.07,177,1708354800"; 
   d="scan'208";a="154780912"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 23:57:04 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id DB730D3EA9
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 23:57:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1A8B11B867
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 23:57:01 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8DDDA20083884
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 23:57:00 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 95B881A000A;
	Wed,  3 Apr 2024 22:56:59 +0800 (CST)
Message-ID: <7c8e36f1-4c16-43cd-a39b-fe02fa1756cd@fujitsu.com>
Date: Wed, 3 Apr 2024 22:56:58 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: Re: [RFC PATCH v2 3/6] cxl/core: add report option for
 cxl_mem_get_poison()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, dave@stgolabs.net, ira.weiny@intel.com,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-4-ruansy.fnst@fujitsu.com>
 <66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <66076fd957c4b_19e0294c1@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28296.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28296.000
X-TMASE-Result: 10--16.441900-10.000000
X-TMASE-MatchedRID: 9xvWjox81uOPvrMjLFD6eJTQgFTHgkhZQTMEQWnELEU61nHU3L1mvwYE
	LASKZobWjhyWkMlRInD9k/FBDAgpqGRByQkQLdDaN70wXhI0DX6Uq+GQ/zyJdOjMOEZ5AL0SDBr
	boYDj/cng2LxpMMc9Px6xprZaWb235AnOPTFB1DiZUG41i0Kjm20Zqaz0+DLChg/Tt7otYdhpik
	/9hPBw3c+43AGKwmcORX+6bCskindQ6gu3nooYNzo39wOA02LhNpy6NoTePCFD9iPiuXvzgYUOm
	GTb5yG/WjOVO3UV6ptftuJwrFEhTbeQq6mF2S4/udR/NJw2JHcNYpvo9xW+mI6HM5rqDwqt3Slh
	3kNKPebQS/EOAE16XukMOPzp0BhG/M8Or3cw2XfpN/z5pkap7A==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/3/30 9:50, Dan Williams 写道:
> Shiyang Ruan wrote:
>> The GMER only has "Physical Address" field, no such one indicates length.
>> So, when a poison event is received, we could use GET_POISON_LIST command
>> to get the poison list.  Now driver has cxl_mem_get_poison(), so
>> reuse it and add a parameter 'bool report', report poison record to MCE
>> if set true.
> 
> I am not sure I agree with the rationale here because there is no
> correlation between the event being signaled and the current state of
> the poison list. It also establishes race between multiple GMER events,
> i.e. imagine the hardware sends 4 GMER events to communicate a 256B
> poison discovery event. Does the driver need logic to support GMER event
> 2, 3, and 4 if it already say all 256B of poison after processing GMER
> event 1?

Yes, I didn't thought about that.

> 
> I think the best the driver can do is assume at least 64B of poison
> per-event and depend on multiple notifications to handle larger poison
> lengths.

Agree.  This also makes things easier.

And for qemu, I'm thinking of making a patch to limit the length of a 
poison record when injecting.  The length should between 64B to 4KiB per 
GMER. And emit many GMERs if length > 4KiB.

> 
> Otherwise, the poison list is really only useful for pre-populating
> pages to offline after a reboot, i.e. to catch the kernel up with the
> state of poison pages after a reboot.

Got it.


--
Thanks,
Ruan.
