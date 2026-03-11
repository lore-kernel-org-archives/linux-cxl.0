Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EA339934D;
	Wed, 11 Mar 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225724; cv=pass; b=R6UfBRIYL7SzVVxTt0o8hA2xy1GfDPp2U2JkiDFYNxA2xLEnPknQkiZLwsO0hqwy6Rof8bGKYF4N7NXnMlQbFdxZAAx7yqAtyC4sCMYep9G0s1ouL/I+GKiJB4iv8nagNXk1rpTm+/6IBCbCMV3a0fggUq2zCa+EyRRJayFskMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225724; c=relaxed/simple;
	bh=yn2QWesQF2KGro7dlOdkc3OuabZre7900T5HQAivrIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQLO6yCa7QiJ6fTAiqwILgZL2qdO20Qb2DrbPUj0GUV+kdM7P91BS2i/edCQCnSoOZSsjr59bXpuGTXURn3+gr2pFdEfkOeOTaPE5aIwK2ij1AeEswz3D3ZbqhatVw9QErBcCevVW6v/e2SV32bSm2MUXSLaCR8O6zX2GgOyahw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=S8d4CT8y; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="S8d4CT8y"
ARC-Seal: i=1; a=rsa-sha256; t=1773225703; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K1ZnFL4E70AA76akZCHcMzX+kyOz5VeYUkoBK6IqWHMdRjqCAY4rhAz1Fj08LYoanQCZTfCxr/0/f2P2ogeYGSE6mklH7lwInly2eBxcivRzaySQLaf1YK/Mqy+ic7LAbAqDrGkLkYfOvF1wM/B8qRq7wBnujCApVAJ5/RDOqPc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773225703; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UI4QYc9qSqLNYE+pCihDa6IBMSEjC2+FWK/Cr+c5huQ=; 
	b=Fn+WWsdb98xn9PcZ/uNCykxI3icAEd+QSl6KfTx5ziL54Np/Fhd91Mf0TUDX2Z+zUca8t04qKwEyZZv38/psLod0LwHcpHc3hdlW20GagM/rUfETJeL/nDG7hhrJqMztWa4ahNCykbX8RLFt71Hmc0iURUeg7lfnB8BPBQI9BW0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773225703;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UI4QYc9qSqLNYE+pCihDa6IBMSEjC2+FWK/Cr+c5huQ=;
	b=S8d4CT8yE0yxH/2KWchGCzMLIKNR+1iRkNLIkehDY2cF/N+eT5rTcpJUJqCZQfpb
	7iS6/cLDVuMf5fPjeGghWops9u1w79X2FD53ElV6G7uPOUa8RbTVkfUBjORo5IqFG/r
	jjCKjaMAZnQjs/lKCvgz7uYHw7LlqlHbl7+nNxQE=
Received: by mx.zohomail.com with SMTPS id 177322570073235.594823742662925;
	Wed, 11 Mar 2026 03:41:40 -0700 (PDT)
Message-ID: <8c2fce20-8f8f-4005-87df-07accd3e065a@zohomail.com>
Date: Wed, 11 Mar 2026 18:41:35 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cxl: Consolidate cxlmd->endpoint accessing
To: Alison Schofield <alison.schofield@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Ben Cheatham
 <benjamin.cheatham@amd.com>, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <abBu898S136I1u25@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <abBu898S136I1u25@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122873c2dd7ed8733e1724a5110500001c99c9fa350ad3a9a07976c2a22960a67b3a8ab4b8a25d67a249:zu08011227bffdfa2273c73e3cf20737f700002aba52b1befeaf486c42e4f90fec77f7aaff7ec857c4961fa1:rf0801122d1bced158686664ed1e12f54e00006b8e28cbfabf3f183462bc7ef3c5a96a66c5cb7efaa9769c9a14a1edd540a6:ZohoMail
X-ZohoMailClient: External


在 2026/3/11 03:20, Alison Schofield 写道:
> On Tue, Mar 10, 2026 at 11:57:52PM +0800, Li Ming wrote:
>> Currently, CXL subsystem implementation has some functions that may
>> access CXL memdev's endpoint before the endpoint initialization
>> completed or without checking the CXL memdev endpoint validity.
>> This patchset fixes three scenarios as above description.
> Hi Ming,
>
> I notice you didn't give each patch a fixes tag, I'll comment
> in that per patch.
>
> Below - a couple of questions about reproducing these failures:
Thank you Alison.
>
>> 1. cxl_dpa_to_region() is possible to access an invalid CXL memdev
>>     endpoint.
>>     there are two scenarios that can trigger this issue:
>>     a. memdev poison injection/clearing debugfs interfaces:
>>        devm_cxl_add_endpoint() is used to register CXL memdev endpoint
>>        and update cxlmd->endpoint from -ENXIO to the endpoint structure.
>>        memdev poison injection/clearing debugfs interfaces are registered
>>        before devm_cxl_add_endpoint() is invoked in cxl_mem_probe().
>>        There is a small window where user can use the debugfs interfaces
>>        to access an invalid endpoint.
> Do you have a reproducer for this 1.a above?
> Meson unit test does support parallel execution, so we could create
> a race btw poison inject and region reconfig. It's an interesting task,
> yet low priority considering the debugfs feature is for our expert users.
> If you do have something, please share.

1.a is a theoretical issue, I added a delay between memdev debugfs 
interfaces creating and devm_cxl_add_endpoint() so that I have a chance 
to access the debugfs interfaces before endpoint initialization manually.

Then I can trigger below trace. Maybe use script to write the intetface 
when the interfaces showing up is a choice?


  Oops: general protection fault, probably for non-canonical address 
0xdffffc000000008b: 0000 [#1] SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000458-0x000000000000045f]
  CPU: 1 UID: 0 PID: 811 Comm: bash Tainted: G           O 
7.0.0-rc2-debug-dirty #19 PREEMPT(full)
  Tainted: [O]=OOT_MODULE
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
2024.02-2ubuntu0.7 11/27/2025
  RIP: 0010:cxl_dpa_to_region+0xa2/0x130 [cxl_core]
  Call Trace:
   <TASK>
   cxl_inject_poison_locked+0x1d7/0x620 [cxl_core]
   cxl_inject_poison+0x8a/0xe0 [cxl_core]

   ....
   debugfs_attr_write+0x62/0x90

>
>>     b. cxl_event_config() in the end of cxl_pci_probe():
>>        cxl_event_config() invokes cxl_mem_get_event_record() to get
>>        remain event logs from CXL device during cxl_pci_probe(). If CXL
>>        memdev probing failed before that, it is also possible to access
>>        an invalid endpoint.
> b. is reproducible.
> Since your original find of this, I've been thinking about adding a
> new group of tests, like the 'stressors', so that we can do things
> like this on demand, but not as default in the existing cxl suite.
It sounds good!
>
>>     To fix these two cases, cxl_dpa_to_region() requires callers holding
>>     CXL memdev lock to access it and check if CXL memdev driver bingding
>>     status. Holding CXL memdev lock ensures that CXL memdev probing has
>>     completed, and if CXL memdev driver is bound, it will mean
>>     cxlmd->endpoint is valid. (PATCH #1-#5)
>>
>> 2. cxl_reset_done() callback in cxl_pci module.
>>     cxl_reset_done() callback also accesses cxlmd->endpoint without any
>>     checking. If CXL memdev probing fails, then cxl_reset_done() is
>>     called by PCI subsystem, it will access an invalid endpoint. The
>>     solution is adding a CXL memdev driver binding status inside
>>     cxl_reset_done(). (PATCH #6)
> Is 2. above reproducible, by inspection, or something else?

I reproduced it by forcedly letting cxl_mem_probe() fail before 
devm_cxl_add_endpoint(), and manully write the sysfs reset interface of 
the device to trigger it.


Ming

[snip]


