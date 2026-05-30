Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20A730F523
	for <linux-cxl@vger.kernel.org>; Sat, 30 May 2026 14:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780152887; cv=pass; b=WUQXbSJCReEVW7pDup49gcESZW84EqicYsuUMjnf53VynwLoDyU7kBj9fIoR9/YUiR5CkS5QncGvyAWRHRwLifdoR+6F2IzyLY3vDuh8ytBt60YCoRBrt2d7PzzEvhyUf1T+33wnduu9xzW0E70Oaq/dIzEpmP3iA7ISQEHfXPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780152887; c=relaxed/simple;
	bh=NEWOlMAu410uV1hUmN0g180JTqrHYGhQLVPTbISijB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQv+aF3Lum9P9TG5smhUyNlK6qC82UQND0/jwso2h1fATIglOUDtWDJnIsaaNkzVunAnFVaTBE0y+T79SVG1QVRKiEp3OUzY5a8Jilcsh5ZtqxlVQHPlT2sUfPfjNB6yLdIm26jfeXGDMbyyefge16s4HX9WU72bQMdf+GcTi+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AyZTCWKC; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AyZTCWKC"
ARC-Seal: i=1; a=rsa-sha256; t=1780152878; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B4OlXL4fkxx9ufpJOKroumUR6W/gqi4R7ULff0OO8HYCwdW070LccWTpNX3IK+FCtjHgclKERDnvQgpWRhC5PWXgDepMI8Zgd95JYDDbE+gJco6TUAwMUXQw59c56dpZMFwQSCGcYBXhqn+hFyZDtwoHxOAaKgQM96q8ENC4dLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780152878; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ynwi3+7XRbORpJmPigiF/fOJS108lYUUrR2cq2JUGsg=; 
	b=RL7VbQpCzKPIwnVCbxrTcJ4agH6s/TlFkLGMmxCvZ+5mTbHGwUJsLGsqmPpazUZdwp2HAof/nJQyUsjQjwTKZN7wj3hvi9bTQGyXJs/BRVbrVwygIg6OxvzT5WV/WATZXCN1v4DRQ0ymk6JBz/3Ngeyupa0nxcmXGHh9gW9FeIc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780152878;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=Ynwi3+7XRbORpJmPigiF/fOJS108lYUUrR2cq2JUGsg=;
	b=AyZTCWKCU6lg0lH0EvgrW/5UqjYcAYmMY0XnKAVAConwgby5PCUQtrsdCe4wDjUC
	lIqXmcZNmf9Wg3okuwS1TZ9Fi2d3uNQa4RMOOftz7bC31mcuyiWPYlVSag4dqdpyzue
	yrU5t4KXblNCqg+WP/zmWjxmvhD8nc926fP7M8Hs=
Received: by mx.zohomail.com with SMTPS id 1780152876273530.2144817260835;
	Sat, 30 May 2026 07:54:36 -0700 (PDT)
Message-ID: <42e1dbc3-58f2-434d-b83e-388855160369@zohomail.com>
Date: Sat, 30 May 2026 22:54:31 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix NULL pointer within p->targets[]
To: "alison.schofield" <alison.schofield@intel.com>,
 "dave.jiang" <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, dave <dave@stgolabs.net>,
 "vishal.l.verma" <vishal.l.verma@intel.com>, "ira.weiny"
 <ira.weiny@intel.com>
Cc: linux-cxl@vger.kernel.org, sashiko-reviews@lists.linux.dev
References: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
 <20260530050649.EBFCD1F00893@smtp.kernel.org>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260530050649.EBFCD1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227b91e9adc0f72173a6bfc15cd0000ee3c728238e0f88fc7e76f733379c11a76a825e238468692ca:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/5/30 13:06, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] __cxl_decoder_detach() suffers from the exact same p->targets hole vulnerability for fully assembled auto-discovered regions, which will cause a NULL pointer dereference upon re-attachment.

I can reproduce it by the following sequence.

Environment: CFMWS lock flag is set, interleave_ways of an 
auto-discovery region is 4.

1. echo -n {one of cxl device} > /sys/bus/pci/drivers/cxl_pci/unbind

2. echo -n {same device} > /sys/bus/pci/drivers/cxl_pci/bind

Will see something like

[  113.444191] Oops: general protection fault, probably for 
non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN PTI
[  113.444506] KASAN: null-ptr-deref in range 
[0x0000000000000040-0x0000000000000047]
[  113.444506] RIP: 0010:cxl_calc_interleave_pos+0x26/0x810 [cxl_core]
[  113.444506] Call Trace:
[  113.444506]  <TASK>
[  113.444506]  cxl_region_attach+0xc50/0x2140 [cxl_core]
[  113.444506]  cxl_add_to_region+0x321/0x2310 [cxl_core]
[  113.444506]  discover_region+0x92/0x150 [cxl_port]


Seems like we also need to compact p->targets array in that case, but I 
believe it will trigger below warning aftaer compacting.

__cxl_decoder_detach():

   ...

   if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
       p->targets[cxled->pos] != cxled) {
     struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);

     dev_WARN_ONCE(&cxlr->dev, 1, "expected %s:%s at position %d\n",
                                dev_name(&cxlmd->dev), 
dev_name(&cxled->cxld.dev),
                                cxled->pos);
     return NULL;
   }

   ...

I think maybe we can also walk p->targets array to confirm if the given 
cxled belongs to the region?


> - [High] Failed auto-discovery decoders are left in the region targets array if failure occurs after endpoint port attachment, leading to a Use-After-Free (UAF).

For this issue, my understanding is that we need a separate patch to 
reset cxled->state to CXL_DECODER_STATE_AUTO in cxl_rr_free_decoder(). 
like that

@@ -1068,6 +1068,12 @@ static void cxl_rr_free_decoder(struct 
cxl_region_ref *cxl_rr)

         dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region 
mismatch\n");
         if (cxld->region == cxlr) {
+               if (is_endpoint_decoder(&cxld->dev)) {
+                       struct cxl_endpoint_decoder *cxled = 
to_cxl_endpoint_decoder(&cxld->dev);
+
+                       if (cxled->state == CXL_DECODER_STATE_AUTO_STAGED)
+                               cxled->state = CXL_DECODER_STATE_AUTO;
+               }
                 cxld->region = NULL;
                 put_device(&cxlr->dev);
         }


Ming

> --
>
> commit 8beb15c55def2c0ba7cda46a708f6b3d2ab5e643
> Author: Li Ming <ming.li@zohomail.com>
>
> cxl/region: Fix NULL pointer within p->targets[]
>
> This patch fixes a NULL pointer issue in p->targets[] during endpoint
> decoder removal. It ensures the last valid endpoint decoder pointer is
> swapped into the removed slot, avoiding gaps in the valid targets array.
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e90c024c80365..54018db87a4c9 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2220,7 +2220,15 @@ static int cxl_region_remove_target(struct device *dev, void *data)
>>   			p->nr_targets--;
>>   			cxled->state = CXL_DECODER_STATE_AUTO;
>>   			cxled->pos = -1;
>> -			p->targets[i] = NULL;
>> +
>> +			/*
>> +			 * Swap the last valid target into the slot to
>> +			 * ensure no invalid target in p->nr_targets range.
>> +			 * The targets array will be re-sorted during the
>> +			 * last endpoint decoder attaching again.
>> +			 */
>> +			p->targets[i] = p->targets[p->nr_targets];
>> +			p->targets[p->nr_targets] = NULL;
> [Severity: High]
> This isn't a bug introduced by this patch, but does __cxl_decoder_detach()
> suffer from the exact same p->targets hole vulnerability for fully assembled
> auto-discovered regions?
>
> When a target is detached from an auto-discovered region:
>
> drivers/cxl/core/region.c:__cxl_decoder_detach() {
>      ...
> 	p->targets[cxled->pos] = NULL;
> 	p->nr_targets--;
>      ...
> }
>
> For auto-discovered regions, new targets are appended at
> p->targets[p->nr_targets] by cxl_region_attach_auto(). This leaves the NULL
> hole intact while overwriting a valid endpoint pointer that was previously
> positioned at the end of the array. Once p->nr_targets reaches
> p->interleave_ways again, cxl_region_sort_targets() iterates through the
> array and attempts to dereference the NULL pointer, which could cause a
> kernel panic.
>
>
> [Severity: High]
> This isn't a bug introduced by this patch, but are failed auto-discovery
> decoders left in the region targets array if failure occurs after endpoint
> port attachment, leading to a Use-After-Free?
>
> cxl_rr_ep_add() correctly upgrades an endpoint's staging state to
> CXL_DECODER_STATE_AUTO:
>
> drivers/cxl/core/region.c:cxl_rr_ep_add() {
>      ...
> 		if (cxld == &cxled->cxld &&
> 		    cxled->state == CXL_DECODER_STATE_AUTO_STAGED)
> 			cxled->state = CXL_DECODER_STATE_AUTO;
>      ...
> }
>
> However, if subsequent topology validation fails, the error path calls
> cxl_port_detach_region(), which clears the region pointer but neglects to
> restore the endpoint's state back to CXL_DECODER_STATE_AUTO_STAGED. Because
> of this, when __cxl_decoder_detach() invokes cxl_cancel_auto_attach(), it
> silently skips removal due to the state mismatch:
>
> drivers/cxl/core/region.c:cxl_cancel_auto_attach() {
>      ...
> 	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
> 		return;
>      ...
> }
>
> The endpoint decoder remains in the p->targets array and is subsequently
> freed upon removal, resulting in a persistent Use-After-Free vulnerability
> when the sysfs region targets are read or the array is otherwise accessed.
>
>>   
>>   			return 1;
>>   		}
