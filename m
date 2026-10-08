Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33012DCC13
	for <linux-cxl@vger.kernel.org>; Thu,  8 Oct 2026 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429658; cv=none; b=HK8dVeF+fHYW8Ol50d09UlNA7aMFX3snQVlttDWU5GVu/a1n0qOwEpMebsQvb3jMxCUEovTP9OEnTwwMFwaCQxuJYZfk7/RXtFsyr0IvlK6Cfrdw99q/MSU4ARjdkKE5Hmr3PMI8DHNX3sG3LHVAZd48sdAC2xjW1Nmbf/KENdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429658; c=relaxed/simple;
	bh=g5QNIkjkbiE5jMcARFc4U5ibbFIaV3dxdaQlfdpP0XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLqzbmWx8SKu/31/J0X75pg4Srunqb3A8Z1llG/2dSiXSP0Z7As181xSm/1UtMzZd4DanCXubWcOChyFGcAwmf0nkoqV15/X2X0Nei8Cs69JxyF0kB9JQOiUhmHuqLLxK4kNcjQymndN9rGsYwAkYmNhvCnGZ8fCb3QU+f/XcVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wjgt6jvk; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wjgt6jvk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791429645; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o/TdXkvtYgp6fVrJeG1fTeXAu/IpzH6GXZvLWbKfRHc=;
	b=wjgt6jvkJ1/3N12uyD6sXvNks4fyK6vxRlha7kAYhw86Aw7dQMA8L5hvhWfTjvt7GIABycchcrVyL8BRy/V0+T8HaUPh9NEMH/gj/cFxVEaZJZ/VPpvr/2+FnHsLoXX2E/CzKScO7jqRAPvQR1pm8tq4wTfW7O4h9R5UV9+W9Nk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCJEmAI_1791429323;
Received: from 30.178.83.244(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCJEmAI_1791429323 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Oct 2026 11:15:24 +0800
Message-ID: <a53c2eeb-be8f-486c-9739-68f31ffb161e@linux.alibaba.com>
Date: Thu, 8 Oct 2026 11:15:22 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cxl/pci: Update only the Port GPF timeout fields
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
References: <20260922100026.3742401-1-kanie@linux.alibaba.com>
 <20260922100026.3742401-4-kanie@linux.alibaba.com>
 <20260926004430.42e9cec3@jic23-hlaptop>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260926004430.42e9cec3@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/26 07:44, Jonathan Cameron 写道:
> On Tue, 22 Sep 2026 18:00:13 +0800
> Guixin Liu <kanie@linux.alibaba.com> wrote:
>
>> update_gpf_port_dvsec() rebuilds the phase control register from just
>> the timeout base and scale, so the rest of the register is cleared by
>> the write. The other bits are reserved today and nothing is lost, but
>> the full-register rewrite would clobber any field the spec defines
>> there later.
>>
>> Read-modify-write the register and change only the two timeout
>> fields.
>>
>> Fixes: a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")
>> Assisted-by: LLM
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>  drivers/cxl/core/pci.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 1f470ab0df3b..72e54facafe8 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -846,8 +846,9 @@ static int update_gpf_port_dvsec(struct pci_dev *pdev, int dvsec, int phase)
>>  	    FIELD_GET(scale, ctrl) == GPF_TIMEOUT_SCALE_MAX)
>>  		return 0;
>>  
>> -	ctrl = FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX);
>> -	ctrl |= FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
>> +	ctrl &= ~(base | scale);
>> +	ctrl |= FIELD_PREP(base, GPF_TIMEOUT_BASE_MAX) |
>> +		FIELD_PREP(scale, GPF_TIMEOUT_SCALE_MAX);
> I think a little nicer if you use a pair of FIELD_MODIFY() and let
> the compiler figure out that it can combine things.
Sure, changed in v2 thanks.

Best Regards,
Guixin Liu
>>  
>>  	rc = pci_write_config_word(pdev, dvsec + offset, ctrl);
>>  	if (rc) {

