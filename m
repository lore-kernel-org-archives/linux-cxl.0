Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CC5D75D
	for <linux-cxl@vger.kernel.org>; Thu, 14 Mar 2024 15:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428502; cv=none; b=HuFWiySG+LNnYJdHRitGbZoa6Vnj7akyF2pdF7ktbslIq/XzFIDB9b/q0ah5stRZLFQp+ElRlMEZaChmf0jPpMgS22DQzm19B9ZXAaHjqSwolv1Wb0Yt7vPa/vCxnD4numvhp5PaYfWVF2S9J4rGBVZHBBS3NgMzeIIe4A3SNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428502; c=relaxed/simple;
	bh=T2g5Yd7YALitTC2Ds+N/7bgA3HC76TP1GfD4fOlxj88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8jGlROOZldOrNGEoZgUi2CO5GXzxNUr56MEjzC3heQN8Mak91bsO++wRh6a/FKef9UD30zQT0lZj2tGklaRlJ+In36212Ggy6qKBRpEFsoXSiK+8pfus6IANAHeQK9g5LMkupfoLSU9PQ+5BXBSESw9ExcnHLnBrpayoAArjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=EbGvwhOr; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="EbGvwhOr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710428498; x=1741964498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T2g5Yd7YALitTC2Ds+N/7bgA3HC76TP1GfD4fOlxj88=;
  b=EbGvwhOrV/mt5Qres/C2YQ8/y7FphEkQDkXuDHLVfDWKh/4yY9w7R8P9
   79JlXY5C9AegXwZCnBZpEyGhubQQTtMu1Y8yCzIziAHGf+sPbc5HrBvK9
   G69xlLYg7E9Vglon2lB/xhqoAO873hnW4GrOWKgD6VGH2m1mqwB3z3Pa3
   TCkKgcxyM/hmyVRyD7Cac94jvRDVRbyrhek8LX/nWjRUEnIOwTROafvGY
   fWNKdINkDDx8sWveJfLltEayft/z6VD2Qo99UPXqGeRHPf9EuPuQeXB94
   BH3TSQCbg0qsKiSRuloSCffJKTE7syIfFJS3O0i214aIw7Wuqr9Rqk+xA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="131583838"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="131583838"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 00:01:35 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8347AEB462
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 00:01:33 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7F6625158
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 00:01:32 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 42C9520097BD5
	for <linux-cxl@vger.kernel.org>; Fri, 15 Mar 2024 00:01:32 +0900 (JST)
Received: from [10.193.128.195] (unknown [10.193.128.195])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 545B51A006A;
	Thu, 14 Mar 2024 23:01:31 +0800 (CST)
Message-ID: <6ffd2214-5309-4e71-b745-ba64c46cdc0e@fujitsu.com>
Date: Thu, 14 Mar 2024 23:01:30 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] cxl/core: add report option for
 cxl_mem_get_poison()
To: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan.Cameron@huawei.com, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-7-ruansy.fnst@fujitsu.com>
 <65c71c6e47244_d2d4294f0@dwillia2-xfh.jf.intel.com.notmuch>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <65c71c6e47244_d2d4294f0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28252.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28252.000
X-TMASE-Result: 10--8.645100-10.000000
X-TMASE-MatchedRID: X+fKKgQJwrGPvrMjLFD6eJTQgFTHgkhZQTMEQWnELEU61nHU3L1mvwYE
	LASKZobWjhyWkMlRInD9k/FBDAgpqGRByQkQLdDaN70wXhI0DX6Uq+GQ/zyJdOjMOEZ5AL0SK2q
	s1bgqDPiFgt2tSPnIRqepbdVIZ/l3v1l2Uvx6idoVD3y1ctYHYd07eT8GLfmrUEhWy9W70AEgBw
	KKRHe+r23IUdaCIBq715B/S7LI1esUTo5EFSG/ld90NZ/UlwhguLwQYjn2sGE=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/2/10 14:49, Dan Williams 写道:
> Shiyang Ruan wrote:
>> When a poison event is received, driver uses GET_POISON_LIST command
>> to get the poison list.  Now driver has cxl_mem_get_poison(), so
>> reuse it and add a parameter 'bool report', report poison record to MCE
>> if set true.
> 
> If the memory error record has the poison event, why does the poison
> list need to be retrieved by the kernel? I would expect it is sufficient
> to just report the single poison event and leave it to userspace to
> react to that event and retrieve more data if it wants.

The GMER has only physical address field, no range/length of the POISON, 
we can't get the poison range from the single event record.  Since the 
POISON range is injected by one command, one GMER is sent to driver, we 
have to use GET_POISON_LIST command to get the length.


--
Thanks,
Ruan.
