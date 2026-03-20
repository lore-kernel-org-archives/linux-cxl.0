Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C773ACA48;
	Fri, 20 Mar 2026 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774011224; cv=pass; b=iyMIwXlNkVnLMf8wnlVWnm7sUD05hQYfC4GxYAc7WlGVCvTpjUwNNsSj1UD2pPDc6rdfrJjkdFz7JJOSQS7GLq5TMTuz226NQwXmOrk6aTK5IJqi1hoU7bxsdNEVWtn+WLE76BQLkCFi6XAHhwLqpwaEbiFriM3Y0g1cCm7e3RA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774011224; c=relaxed/simple;
	bh=AzVNf2Vo48RUhqfNJajrbFu+2FwFoDL5QbPC25CXVtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flgCsqhrdIvnmrZQibXMNqwyZS/BsVwNsMQ0P9drYEvU2/GbPlab1guVhEedg0RXjMjGUPujxn227g9OVmKnTm6YsUFCwt83qIhFR7T1otu08GGJ5lnJPfVcgtkrfwPsm5bMGk3f/5afp8S51tSrDqnTJb7apRVbTa5kHRgHslk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=KFd+TIlC; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="KFd+TIlC"
ARC-Seal: i=1; a=rsa-sha256; t=1774011210; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eiq5Q0IIzJPPPuePIpHOr03eoiuZSDblxn4HTONZY9QVngTaUh9I906xcvDllrGUMWgcRi0ou+UI5djHdeu62YggePcCByhLGCMPVkB2Vkzf9B94N3A8/bjtrE7DhBU+jthzPnpyHfqY21/WiLepom/WX2epYFL68+Ri+189BX0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774011210; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rqRosnIWdbmkDwsYzGVumDl+6FomNcbCprBha93Btnw=; 
	b=Nv8zTOixdnUg/V9fxsYzjPZoYnB+OsD8Ob7/+tRzpe5OTSlKHOrheR+udMorQ0TcUGJSYXWjLtz+7bEripdLn7flLiqawk6MOKw8jKRjaSLUodV7hVnW6Je61KGdUxvmGvWSAHnhWT9CIC11JGjOjNarK7u7T3xsHoQ6fEVjsig=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774011210;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=rqRosnIWdbmkDwsYzGVumDl+6FomNcbCprBha93Btnw=;
	b=KFd+TIlCqz301fqcATTMjkBPUfgiNSIKY+OZwmH5M1DuJVO7Z9l/Yz3oJnE4PZvv
	GVFtI+OLYB9vNOdRJWU8AmfSDkZV2qiYDWcXZa2Ly2w+KERiLkTjRXTAJM1SnYfflpt
	F+5uFZ24xK4eZr3CXRGV/NN7qiWnM4smk/5G31lY=
Received: by mx.zohomail.com with SMTPS id 1774011209015576.2638459202847;
	Fri, 20 Mar 2026 05:53:29 -0700 (PDT)
Message-ID: <7d455f0d-551a-43cb-8873-6f341ae6b93d@zohomail.com>
Date: Fri, 20 Mar 2026 20:53:25 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Hold memdev lock during region poison
 injection/clear
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20260319-hold_memdev_lock_for_region_poison_inject-clear-v1-1-05243c5a9572@zohomail.com>
 <f31a9a08-27dd-4cf1-bf35-d1b992e2f75e@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <f31a9a08-27dd-4cf1-bf35-d1b992e2f75e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112280eebbd1ce170aa11cd7e7f69000095a24efe02b15c56c71c1ad168c635b56dcb49f9b1df46623365:zu080112274eba63246ba4771280bf4bec0000c22da0c7af303651475e0a9453f6bc06bb84f0057206c4692e:rf0801122defa5015da5f6b310895a2ae0000092524fd50250789aa0d47fa082d85e371d8d0166f0332889bc1f83c16305f9:ZohoMail
X-ZohoMailClient: External


在 2026/3/19 22:47, Dave Jiang 写道:
>
> On 3/19/26 7:12 AM, Li Ming wrote:
>> cxl_dpa_to_region() has expectations that cxlmd->endpoint remains valid
>> for the duration of the call. When userspace performs poison injection
>> or clearing on a region via debugfs, holding cxl_rwsem.region and
>> cxl_rwsem.dpa alone is insufficient, these locks do not prevent the
>> retrieved CXL memdev from being destroyed, nor do they protect against
>> concurrent driver detachment. Therefore, hold CXL memdev lock in the
>> debugfs callbacks to ensure the cxlmd->dev.driver remains stable for the
>> entire execution of the callback functions.
>>
>> To keep lock sequence(cxlmd.dev -> cxl_rwsem.region -> cxl_rwsem.dpa)
>> for avoiding deadlock. the interfaces have to find out the correct CXL
>> memdev at first, holding lock in the sequence then checking if the DPA
>> data has been changed before holding locks.
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Li Ming <ming.li@zohomail.com>
> This is the patch I dropped right? I see the review tags are dropped. Does it need to be re-reviewed? Are there new changes?
>
> DJ

It is not, the patch you dropped is for ensuring memdev poison 
injection/clearing would not access an invalid cxlmd->endpoint.

The changes in this patch is for region poison injection/clearing.

But you can keep dropping the patch you mentioned at present, I will 
tell you after confirming the solution.


Thanks

Ming


