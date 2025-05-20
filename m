Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAA019DFA2
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 03:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747712343; cv=none; b=tk6cNWHJRaU3mEkA0buU3GDN9bjqWXKVKjxkwql6RGbFx2CXY1JNHDg9zUnMtLtni+44UuqZSeMPVm2lkLFkSfhFMQL+RUfrwiKpAbUKFJEv8ABjNPwDP9MjvOS5RferCO7LgDMNxa32Hvg8HdDeSfgCrEtUlsvnnnfM+1KZ5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747712343; c=relaxed/simple;
	bh=m7YdJZPCd6pvLRFxRYlzfJSGF30i5xk8gKd7IgL2SzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ11L59aO7x4yFksoyhzp15OhMtWj9GVu/J3fbSc6R0JvFCN4SrKl81i5Go9zZ6VrsQlujLfh5Cy6oJHC/mioOz9sCzCcc+F7YdMgP+s9ocfn9AGI45U5+A9JPCliZ01IEVMZynsG03LKph3Lb1ct4oufdj2jKvVtFve/q7ZdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=DPFuM89O; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="DPFuM89O"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1747712342; x=1779248342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m7YdJZPCd6pvLRFxRYlzfJSGF30i5xk8gKd7IgL2SzA=;
  b=DPFuM89O6d4JfA0dBPwMcRsfHOJAMvMaWLwa55seKc1Dfh8mEvovvP8S
   0kJ/CAdIwz4SjwI6JpLGFCds86n2//+WL4nJjHZ+mADRsGo32jaf4M6L8
   IQ8idv7P/8H0Kpdhq5qMy6bj+fbJhkxElQH249HJXyApQwhTvfstQ+266
   QnYpbQTl1N6/535KPjtzy/A1gUaRfB7Z8QKvibF3jVSyAZdDamv8qg8Cg
   59rGrDnIvBZSFdzS+RWqTG+MwWc0CimccGKl2H3QeeXQjAQArS+XNVesl
   X4/EP2pWHmOoAn3LhYYaz+3fnhM063XXqFehZp8toIPDWBZECIeJMxt+V
   A==;
X-CSE-ConnectionGUID: nH5+ZkNWRKahCgiSa+rHJQ==
X-CSE-MsgGUID: qlArqMPyRrWbmT87SXCLbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="199981014"
X-IronPort-AV: E=Sophos;i="6.15,302,1739804400"; 
   d="scan'208";a="199981014"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 12:39:00 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 489C1C2264
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:38:57 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 039EBD8AD8
	for <linux-cxl@vger.kernel.org>; Tue, 20 May 2025 12:38:57 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0914E1A0071;
	Tue, 20 May 2025 11:38:55 +0800 (CST)
Message-ID: <859d8415-5822-4f14-a911-1f1e48e344fe@fujitsu.com>
Date: Tue, 20 May 2025 11:38:55 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test/cxl-xor-region.sh: remove redundant waitting
To: Marc Herbert <marc.herbert@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: vishal.l.verma@intel.com, sunfishho12@gmail.com, linux-cxl@vger.kernel.org
References: <20250514112003.2150272-1-ruansy.fnst@fujitsu.com>
 <6827d6e591443_4ba8f100f1@dwillia2-mobl4.notmuch>
 <3f7bd5b0-4c1b-4a55-bc9b-2b6e75ab9a39@linux.intel.com>
 <682bba2f9ce2b_1626e100dd@dwillia2-xfh.jf.intel.com.notmuch>
 <d9b62e78-52df-4283-9004-18c0bc01f73a@linux.intel.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <d9b62e78-52df-4283-9004-18c0bc01f73a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/20 9:00, Marc Herbert 写道:
> 
> 
> On 2025-05-19 16:09, Dan Williams wrote:
>> Marc Herbert wrote:
> 
>>> PS: while... waiting for such a fast/no-wait/unstable option, I see no
>>> reason why systemd would not work.
>>
>> It does not work due to circular dependency deadlock.
> 
> I just had a quick chat with Dan about this.
> 
> A local, systemd indirection _workaround_ would avoid the
> deadlock. systemd is dealing with processes than "hang" by design:
> daemons! And with even more complex and difficult processes and
> services. udev routinely sends messages and triggers systemd, yet
> systemd has never blocked udev in return, no matter what happens.
> When you connect a USB printer, udev and systemd start the ipp-usb
> process which "hangs" forever. This does not block udev.
> 
> On the other hand, in
> https://lore.kernel.org/linux-cxl/ef46edd7-b492-4124-9cf9-0db104175eac@linux.intel.com/
> I never meant to suggest systemd as a "permanent" solution for every
> user of the cxl command! I was only suggesting systemd as a "private"
> workaround, part of some specific test suite currently stuck with this
> deadlock.
> 
> Hope this clarifies.

Thanks for the advice!  Yes, I have tried to use `systemd-run 
my-original-script.sh` to achieve my goal.  It creates a new process 
which is outside of udev queue so it won't cause the deadlock.

BTW, after you talked with Dan, do you think it is still necessary to 
add the `--no-wait` parameter to avoid waiting for the udev queue empty 
in some specific scenarios?  Do you have any plans to implement this 
feature?


--
Thanks,
Ruan.
