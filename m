Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E962303CAB
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781275762; cv=pass; b=WYCkHEjHCqh5wMsatNpElT1aSTFcQLif4V3/ClQ7b6uuuXVBL9/t5r0cEqJidJeYWgtMlZetl672Sp4Y3NYCmb6L0gG+kmJBO0Myc9YgLEffvy3p+wFDVTGQndrouNnDr6gppOjSlR2dTrto9mscLBJQWA7RPJ/p/Mg99FH94xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781275762; c=relaxed/simple;
	bh=YvZbeodMtxNM4p+GxE8XiEE/76vFpjJx428pQsuE8ws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlBmWTULLVRcS3NnXtbWR5kAGjIaITXHx6QoIZF4K7gmhw3WFkVnlXKIQEnAjhYmPH1MM2bonTLYgGhAOOPPEKC115pNtBdTgrv4ys+RaNPpwVJGdFSu7cRKCLLbHpMPF5VEc4wuiuKEfZotzLQUrxQylV7e5/pmI/EBxegLxqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=FrmzYkbh; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="FrmzYkbh"
ARC-Seal: i=1; a=rsa-sha256; t=1781275753; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UT/6lVhm6WyfD/r5yHWQtPFaeZ/EkKRBetQaJ6Ii9udWyWmz2T7/DQyDdqMYXL6h7qf2A9Ok8qdgfO8U4fqFVDtaE5Lw+ZqJ2CjA0++LbxFqKjT/OUxceNKjcXdxm1gyqgGvy/u1UgxncK6KFDlKkfB9IQFTiZ75R7f/t6bYejs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781275753; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3QLITU0XWv/B2Tl3b3UeSW2f3daeM1nIj8RN+jR8r9A=; 
	b=WJdsut+erDdwFEBVnWBikwdY3G3+AR8WSswn9CTrBXB9qlcSMUck0WOa6yMjCLiojzyVZprWAbnl03CgTnBC2ojJGGp3hs8YzYxcYqZyZzal+xvxK4sCzws5y3qRyl/PGkNgqANvvw9CWlIa28RFkbHQHY+yBcMEjHqNXVNCS88=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781275753;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=3QLITU0XWv/B2Tl3b3UeSW2f3daeM1nIj8RN+jR8r9A=;
	b=FrmzYkbhqNd8/f5/TmoXlZ8gCRyscOIHmkcYiNOkh2wSLTO25HeztvT9dPfxMRBU
	jdJ80Kle5Y3v3h2EKia7+BuIhbXMEw+X8Hjy4Sefd0P33ITnVeRSWLmR/GT0e6zApBI
	pC7lQe7Oxio2eWvA+2ZlU/619awewSW7vfMuWoOc=
Received: by mx.zohomail.com with SMTPS id 1781275751791364.68982951426256;
	Fri, 12 Jun 2026 07:49:11 -0700 (PDT)
Message-ID: <b10a77ec-f321-4e95-9347-34df96064d64@zohomail.com>
Date: Fri, 12 Jun 2026 22:49:06 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Align interleave decode/encode helpers with their
 callers
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, Purva Yeshi <purvayeshi550@gmail.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>
References: <20260605040801.865965-1-alison.schofield@intel.com>
 <01f42b02-e050-401d-9b0f-f2b0fc6b8d23@zohomail.com>
 <aitqeGQHdIfKz0j-@aschofie-mobl2.lan>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <aitqeGQHdIfKz0j-@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Feedback-ID: zu0801122783e3ad16d48135af4e6117a800007c5a2a2c0522468e606cd494b6b218d2d03c2d07a886b0dd50:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 6/12/2026 10:10 AM, Alison Schofield wrote:
> On Sat, Jun 06, 2026 at 12:21:04AM +0800, Li Ming wrote:
>> 在 2026/6/5 12:07, Alison Schofield 写道:
>>> The interleave conversion helpers translate between encoded HDM
>>> interleave values and the granularity and way values used by the
>>> driver.
>>>
>>> These helpers have been a recurring source of static analysis
>>> complaints that expose type mismatches and potentially uninitialized
>>> outputs. Fix those issues in the helpers so callers inherit the
>>> consistent behavior automatically.
>>>
>>> The decode and encode helpers have different interface issues.
>>>
>>> The decode helpers return values through unsigned int pointers, but
>>> the decoded values are ultimately represented as int throughout the
>>> driver. Align the helper interfaces with their callers by changing
>>> the out-parameters to int * and updating the handful of affected
>>> locals to match.
>>>
>>> The encode helpers leave their out-parameters unchanged on error. That
>>> means callers that ignore the return value may observe uninitialized
>>> encoded values. Initialize the outputs so failed conversions leave
>>> defined values. This issue was originally reported by Purva and the
>>> helper-side fix was suggested by Dan [1].
>>>
>>> Tidy up a related, pre-existing, printk format specifier mismatch in
>>> cxl_validate_translation_params().
>>>
>>> No functional change for valid interleave parameters.
>>>
>>> [1] https://lore.kernel.org/linux-cxl/20250419203530.45594-1-purvayeshi550@gmail.com/
>>>
>>> Reported-by: Purva Yeshi <purvayeshi550@gmail.com>
>>> Suggested-by: Dan Williams <djbw@kernel.org>
>>> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>> Reviewed-by: Li Ming <ming.li@zohomail.com>
>>
>> Since the types are changed from 'unsigned int' to 'int', maybe we should
>> drop the second parameter of these helpers in the future?
>>
>> A negative return value indicates failure, other value is valid.
> Hi Ming,
>
> Good catch and good idea. Thanks!
> I'd like to address it now, probably turning this into a 2 patch series.
>
> Not exactly as you suggested, see if you agree w this:
>
> I'll convert the two decode helpers eig_to_granularity() and eiw_to_ways(),
> to return the decoded value directly, while keeping out params for the encode
> helpers ways_to_eiw(), granularity_to_eig().
>
> Decode converts cleanly: results are small positives, so a negative return is
> clear, and no caller is made worse. ie ones that must check already do.
>
> Encode I'd leave as is. Those helpers run on two kinds of input: raw sysfs
> values, where the return value must be checked, and already-validated values,
> where the return code is legitimately ignored. Keeping the output param,
> together with the *eiw = 0 / *eig = 0 initialization this patch adds, lets
> both kinds of caller share the encode helpers.
>
> I'll go ahead and code it up so you can see if you like it when you 
> see it.

Hi Alison,

These changes look good to me. Thanks.


Ming

>
> -- Alison
>

