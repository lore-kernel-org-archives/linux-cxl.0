Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2D346A14
	for <linux-cxl@vger.kernel.org>; Fri, 28 Aug 2026 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908029; cv=none; b=YbTUJj58w67wDmsiRaEnYeOVZxv2yiROhHp+ovNW8TwdTEODqh+HPztwiQf7oH7BOj3h0KnWK3TBoKY96DoXWTaP2Lda1BRkCYry5DRRjCDv4JuEO5VtwhpeT5kA8WU03Ni0worAmDQg2pDJg+sRXfJZEr/dZ+d9Rf4BuisWmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908029; c=relaxed/simple;
	bh=pHo1cNo4zDic+waxKvuK4bm5iQwlFXMLzD+S24TlLDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUAHWcwbxsLXmq28T+vgabMDLcjqnUAoZZ//y4tfC/D8DcFDMOgAOLwtpYh4O9zswPN+DHC6/7OzUESpELhZ+srOJxDzHI76j6jpZ5aqeo0jsHCeQ+qJ16Pz/VG7kyW+LIbyTpQfDMsCxoR6q+QhjsVxo1ATHA5UFGMTuHkSZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ww2oC7C7; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ww2oC7C7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787908018; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qQgIi6UmQ26xjRxbhBQsWi9fIvV18PATK6qyycyeeEQ=;
	b=ww2oC7C7/Z/GU2WKpQU3EPy4u60CCBRaF23sPW2/0YUksXhO4SWdiK4j8EbmayoZ5/uIILGnRGLOg1L81mvKYWOfgIaPF7ACfkut8sWnKZIjQa4Sa7had3R+md2zHHVpgmZgO4XFwP78+8bK76lB08Jqu+kiqHYLq/i0sA6zg5U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9m2EWT_1787908016;
Received: from 30.178.68.240(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9m2EWT_1787908016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 28 Aug 2026 17:06:57 +0800
Message-ID: <6487b454-ac7a-41c8-af9d-e2f17743f30e@linux.alibaba.com>
Date: Fri, 28 Aug 2026 17:06:55 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/region: Unregister the pmem region bridge on setup
 failure
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org
References: <20260812061043.57319-1-kanie@linux.alibaba.com>
 <anzo3j2nWsGlZIw_@aschofie-mobl2.lan>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <anzo3j2nWsGlZIw_@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/13 05:42, Alison Schofield 写道:
> On Wed, Aug 12, 2026 at 02:10:43PM +0800, Guixin Liu wrote:
>
> About the subject line:
>
> Do we unregister the bridge or do we unregister the pmem
> region when the bridge is unboound?
>
Unregister the pmem region, sorry for the confusing description.
>> devm_cxl_add_pmem_region() publishes the cxl_pmem_region with device_add()
>> and only afterwards, under the nvdimm bridge's device lock, arranges for
>> its removal - and only if the bridge has a driver bound. If it does not,
>> the function sets -ENXIO and leaves through err_bridge, which drops the
>> reference this function took on the bridge and returns. The device that
>> was just added has no owner at that point: no device_del(), no
>> put_device(), and no devm action to do either later. The sibling failure,
>> a devm_add_action_or_reset() that cannot allocate, is already covered,
>> because devm_add_action_or_reset() runs cxlr_pmem_unregister() itself on
>> that path.
>>
>> An unbound bridge is a normal state, not an error state. The bridge is
>> unbound whenever cxl_pmem is unloaded or its device is detached through
>> sysfs, and a region can be probed in that window.
>>
>> The added device then stays in sysfs, along with the reference it holds on
>> the region, until the module is unloaded. cxlr->cxlr_pmem still points at
>> it, and worse, the name is still taken: a later probe of the same region
>> allocates a second cxl_pmem_region and fails in device_add() on the
>> duplicate "pmem_region%d", so once this has happened the region can no
>> longer be brought up at all.
> Is above an observed behavior?  ie can you reproduce this, apply
> the fix, see it go away?  That would be far more valuable than this
> excessive narration as proof of repair.
>
> More below...
I'm so sorry, I thought that we should add cleanup in
failure branch, but now I realize that this branch is never actually 
reached.

Please ignore this patch, sorry again.

Best Regards,
Guixin Liu

