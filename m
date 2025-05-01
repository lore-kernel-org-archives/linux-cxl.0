Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650551EEA5A
	for <linux-cxl@vger.kernel.org>; Thu,  1 May 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746067909; cv=pass; b=Cr1Eombh91fEGpSjAO66JNXU5LRO5rZqLhArARN6aRs/5f14c9KWSPArTJFO268m/7iv8al9Qxy3IrS/YiNhA4W+SseCAxZ/nqcdQO0caIq/51mKsXs4YCnpvTbBdftgw4frvJeFNNCFQSSrJjzhUGNM25I5M+oHB3O26x+EN7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746067909; c=relaxed/simple;
	bh=z/VYmZsREnfSJLDIlokbAIMTsU9dghOxEtuTz8VNhkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr2KCpj65jkuolBgCqBPcWjGWALkxBRdpqDdM7S/vpx0/GdqBF/UcjqX2/Ln7Khii6kOjRucLrhWbKPaqSLbdQDtD8bWrX41t9y/Q9r1AIVhvOn98LBZrNvgvdvbFSV2R2Gc3QGZaH25yro3TSi9EK2FgxT6jpE9S7dC50MP990=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=GdhfOvPy; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="GdhfOvPy"
ARC-Seal: i=1; a=rsa-sha256; t=1746067895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IZnSPVMXBCCx5dJJhtUEuXGPEgYYob8dCW2cOTAu5ZqpTs0mLLy6GefzSn5Sdq1hhJe53SLv/4zLW9CnJAJXOeBF0pJuwwXksyJLkrI8XjbIQwDwksu28u10uvVCMarEAkAEWRaAaLvMSb+DDQBjvYUuJYR63F01fOy0sNcw2Ns=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746067895; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z/VYmZsREnfSJLDIlokbAIMTsU9dghOxEtuTz8VNhkw=; 
	b=AbgBEITa9dq2s8PxAtsZOAJWQTIqa9qMOOJ3fz4b6ZwvOK9hHwtgenMzZrQrDo8+ALBZe+S2BeWvcRKRgmjk/o/LXyb4AfbIpAEHovyy2pssAbCbVqfCF9DVyO6MnuzD84oUyYJHRYdV+22z96nFB7d7VzZwZfjqhQKeoSq2NBo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746067895;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=z/VYmZsREnfSJLDIlokbAIMTsU9dghOxEtuTz8VNhkw=;
	b=GdhfOvPyCQQE9b1YbINSRwti2PC7/7kMXPd5oOh8oBHbavhp9CJl9amDv69kL1MF
	ih/Lnhw2QArtex61wNWY2QlHtmZABCgBEEC00VeYq89YlURZrvmj9EMmZY3Cm7RKTY/
	s+mebmGAbYhsgyQK+IZD6mvudbaKoEFwMTDlGjIs=
Received: by mx.zohomail.com with SMTPS id 17460678914521008.0847544666666;
	Wed, 30 Apr 2025 19:51:31 -0700 (PDT)
Message-ID: <9516517f-9d04-423b-bcd0-123a76598c06@zohomail.com>
Date: Thu, 1 May 2025 10:51:29 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Add decoder check to check_commit_order()
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org
References: <20250430213653.1904302-1-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250430213653.1904302-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227c6ab090eaa157e6b4f66a93a00002d87ea1a7fbfde69ae72204a221574ccb964cc407a9a4f65a3:zu08011227955cf6472a96239053673e790000574bf2b5737546bf71f0d6d3dd94225472bc838d2eac177844:rf0801122d215d8b867f79386c6152a1d10000680d67c8a7a501f1dd02f87b1afa7b28d61414d2ba224f8341f4d8b900faa5:ZohoMail
X-ZohoMailClient: External

On 5/1/2025 5:36 AM, Dave Jiang wrote:
> check_commit_order() attempts to convert a device to a decoder without
> making sure the device is a decoder. So far this has been working due
> to pure luck. Issue discovered while doing deferred dport probing when
> child ports are now in the midst of decoders due to ordering change
> of child port additions. Add a check before attempting to do decoder
> conversion.
>
> Fixes: 105b6235ad0f ("cxl/port: Prevent out-of-order decoder allocation")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I also have a patch for this issue during I worked on deferred dport probing.

https://lore.kernel.org/linux-cxl/20250107035708.1134954-4-ming.li@zohomail.com/

I am not sure if we should define it as a bug, my understanding is that it will never happen with current implementation, it only happens when we are trying to delay the switch decoders initialization.

Because current CXL subsystem always initialize switch decoders during switch port probing and child ports are always added after the switch decoders initialization done, so the sequence of children device list of switch port device always like that:

child dev list head - decoder 0 - decoder 1 - decoder 2 ..... - child port dev 0 - child port dev 1.....

Using device_for_each_child_reverse_from(switch_port_dev, current_decoder, NULL, check_commit_order) is not problem for this sequence.


But when have deferred dport probing implementation, the first child port attaching is responsible for triggering switch decoders initialization, the sequence will be changed like that:

child dev list head - child port dev 0 - decoder 0 - decoder 1 - decoder 2 ..... - child port dev 1.....

Always have a child port device ahead of all decoders, it causes the problem.


Anyhow, it is also OK to me if it should be considered as a bug.

Reviewed-by: Li Ming <ming.li@zohomail.com>


