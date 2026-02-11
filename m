Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713C281525;
	Wed, 11 Feb 2026 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770810611; cv=pass; b=iSeuO+UEy7jhpv7q7RbSJlSbZI1HSGqkZPzjcI1zXzTe6zCzxsvYae2tPjNolhpKBR2T8w1gI9ykWd/GV19neRlPEz01CDYXQCSewbev23Sb14xDwIZFfVUgUQDLnwvvamXZKuv4MTSV8s51ZXrV8CQyenzYeQ5Vdt26+iExr3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770810611; c=relaxed/simple;
	bh=xaysXfZ121u+cHr29mBJUmbld0EDFJk7ZMcYI1XAj7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDzAWfJV7TcylpxKR0xJSZwa3RdF9kkQTrNP2k91WdR4yYOzfjVNbCT1QXjpmKM90xU+MCVsNNFN53IbzL4OwpikUPFrx5+xNKTbzoEqTh/Bx5ASCduEz3aj2+LIFYNMKquBLnFjSkpCfpYkcnSHbAhdxy+Em/Slaxc0QtVZdwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Q37JNKVt; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Q37JNKVt"
ARC-Seal: i=1; a=rsa-sha256; t=1770810594; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gJWI32xSXYzPbvVfYhWFNA5smOyy/zmvcBeN32bPWKnq82I149eddVmi9PMGVXqbSUIIvVqnYjFSbdttc/W5Vo1gJgXaB5fCjyFzg08pMq/9cfMHZEmUmnOUq2pAWyoTLxVSwaL3sjqTRY3i02o3U4vn3A51k29ZGD1itJo7QtY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770810594; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xaysXfZ121u+cHr29mBJUmbld0EDFJk7ZMcYI1XAj7o=; 
	b=agk69Q4Y3lgAcwdLRmae/Pg6M/UffgsBpPUpNqXRaVS6FpNZEPPD8QyrThiMR4rom9uiUGNnvXbvdTHD3IQzafGjTKLI0oysIwx53JT/7Oop+g+ofDv8Sax8o5HVsfEzM4Nw8i0x8QJiPk7F8z4FRG8eM39OpdfxYsAX0Not4No=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770810594;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=xaysXfZ121u+cHr29mBJUmbld0EDFJk7ZMcYI1XAj7o=;
	b=Q37JNKVt40a0TUkWIEdnMD3DQMl6H6jFuakxD9V2OVoA5J6gTuay4mmTl4fhVo2C
	Bdz1KSmPYUlRtEX59M24bDHZG8CBMqxWvIZrp3V5NQHNPaCRD2K14MdC5GovD+nKtJ9
	omIhMmTa4qrWg4mhAKl7kbXDAYti1cvyGiI56oes=
Received: by mx.zohomail.com with SMTPS id 1770810591238295.5868504651447;
	Wed, 11 Feb 2026 03:49:51 -0800 (PST)
Message-ID: <f2cba5b0-9f87-4787-b2fb-6a4756abad99@zohomail.com>
Date: Wed, 11 Feb 2026 19:49:35 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix port enumeration failure
To: Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260207133512.306128-1-ming.li@zohomail.com>
 <aYqgQ3QgaedMhNny@aschofie-mobl2.lan>
 <4eefdae3-125e-4c80-9968-8d20648f33bd@zohomail.com>
 <6cc9d925-0aea-4104-b58c-984f455b157f@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <6cc9d925-0aea-4104-b58c-984f455b157f@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011228e687024fb06d9ebad2454fb5000002a456dd00930f424f7a5edf43113672f4c52c9eba634698eb51:zu08011227a0eb23bfc66184bf790e619b00006f9a97d7125b8265169e0ed679b8ebc0623b688334b76be61d:rf0801122d2157d3b8ce4c7a82c69cc2fe0000e0330558e60a3421b662275881a37a0088201be0674269c17e265e977a92d4:ZohoMail
X-ZohoMailClient: External


在 2026/2/10 23:00, Dave Jiang 写道:
>
> On 2/10/26 4:56 AM, Li Ming wrote:
>> 在 2026/2/10 11:04, Alison Schofield 写道:
>>> On Sat, Feb 07, 2026 at 09:35:10PM +0800, Li Ming wrote:
>>>> I ran CXL mock testing with next branch, I usually hit the following
>>>> call trace.
>>> Hi Ming,
>>> I started hitting this after you first posted, however it takes me a
>>> long time to hit it. Do you have a method to reproduce that is better
>>> than running on repeat as I do? Thanks!
>>> -- Alison
>>>
>>> snip
>> Hi Alison,
>>
>> My environment is a VM with 2 CPUs, maybe you can try it.
>>
>> I use a script to run "meson test --suite=cxl" again and again in the VM.
> The other day Alison showed me the --repeat=N parameter for meson test. You can use that instead of script unless it does something special.
>
Good to know that, thanks. I tried it and it can also hit the issue.


Ming

