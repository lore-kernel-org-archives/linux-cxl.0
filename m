Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CA4398F0;
	Mon, 20 Jul 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564139; cv=none; b=jPTcPDucPYMNyQg3HwqOENj1O9E1Tlm+CYAFtQ14xUyatGTV8PDqbFwTjNed/qZjv7Z4nrb2zwDPRocTnMR7UDDR5Yi3jYbOX1QyKitgILVYZtYxpM0xdFPrk1w6E+ZpFFjIFt94Z+N6gCbQt/qAQRKEOWCvN0cTAZ1ZoHDqnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564139; c=relaxed/simple;
	bh=ywUI8MUMW3jR7sOn7dHCleA5wuI2cUzVb2ZuGWxx2zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rx2854uKSSPjkohDc5hUQSprrEKIIrSfaCeYbSlzuAgc17tQo7n/Z/gt8uCkjt7dhFHFcZD7UUB3REhmQ3X83sp6/kTiKnj+1XQu3Jit7EdVlrJBapts78rhzVZ4SjGTgugsf/HSGMmClPNSulqlQ7KzfswSTHAdGF5/0Pb5JSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFl1kdK0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFl1kdK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784564116; x=1816100116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ywUI8MUMW3jR7sOn7dHCleA5wuI2cUzVb2ZuGWxx2zk=;
  b=NFl1kdK0NoFQxyY4bge8N0jp5W0xn85g3YPwFFOi/TL9brV2qivA1SuB
   WmLPukSiaZ422K7Cxq7nnQlhQtBA3GfvjzcV2NH6EbaT37QIVEHwb2moW
   n+KZGjFHTbRvRfyDlrRqUy5aKdIGiRo4i/7vSL1NHF1VFejh4ImFt9DtD
   IgfdGHpbgIRIIddxQLIZl+KsS9t12m19dyI1cT1Gg/+7iSNQagdjgWVb8
   +78B2HlYyoLrL3oVSCWm4agFecAO8lgc95wS/dLo9MRkKQQGgUxeBP3Lx
   oVkUVy/PxmYqfVaggTz+KD2f1VFTwQEhuMw0zEegW8XFz4PA2ioc31/df
   A==;
X-CSE-ConnectionGUID: uRkD2yVaTQyfFvzNa1AJBQ==
X-CSE-MsgGUID: v4d1cTKzSvSaJ+ej+Vdyiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95802576"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95802576"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:15:09 -0700
X-CSE-ConnectionGUID: dClC3PdZRC2yLQPoUkFThg==
X-CSE-MsgGUID: ISva/Tn5SXad+GeD2RnM+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255716593"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 09:15:09 -0700
Message-ID: <a8646c38-b23f-4ca9-a521-e7afddd63356@intel.com>
Date: Mon, 20 Jul 2026 09:15:08 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] ACPI: APEI: GHES: Bound CXL event record copy to
 the firmware section length
To: Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org,
 linux-cxl@vger.kernel.org
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, mchehab@kernel.org,
 xueshuai@linux.alibaba.com, terry.bowman@amd.com, sashiko-bot@kernel.org
References: <20260717161647.1493259-1-dave.jiang@intel.com>
 <20260717161647.1493259-2-dave.jiang@intel.com>
 <186d9c27-d4f3-f8f4-122b-041f847dc55c@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <186d9c27-d4f3-f8f4-122b-041f847dc55c@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/20/26 5:21 AM, Hanjun Guo wrote:
> On 2026/7/18 0:16, Dave Jiang wrote:
>> sashiko-bot flagged a missing bounds check that allows an
>> out-of-bounds read of the firmware CPER section.
>>
>> cxl_cper_post_event() copies a fixed sizeof(struct cxl_cper_event_rec)
>> out of the firmware CPER section without checking its length. Pass
>> gdata->error_data_length in and reject a section too small to hold the
>> record before the copy.
>>
>> Reported-by: sashiko-bot@kernel.org
>> Link: https://sashiko.dev/#/patchset/20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=6
>> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 3236a3ce79d6..a752e152a5a0 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -815,10 +815,15 @@ static DEFINE_SPINLOCK(cxl_cper_work_lock);
>>   struct work_struct *cxl_cper_work;
>>     static void cxl_cper_post_event(enum cxl_event_type event_type,
>> -                struct cxl_cper_event_rec *rec)
>> +                struct cxl_cper_event_rec *rec, u32 len)
>>   {
>>       struct cxl_cper_work_data wd;
>>   +    if (len < sizeof(*rec)) {
>> +        pr_err(FW_WARN "CXL CPER section too small (%u)\n", len);
>> +        return;
>> +    }
> 
> [...]
> 
>> +
>>       if (rec->hdr.length <= sizeof(rec->hdr) ||
>>           rec->hdr.length > sizeof(*rec)) {
>>           pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
>> @@ -949,15 +954,18 @@ static void ghes_do_proc(struct ghes *ghes,
>>           } else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
>>               struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   -            cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
>> +            cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec,
>> +                        gdata->error_data_length);
>>           } else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
>>               struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   -            cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
>> +            cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec,
>> +                        gdata->error_data_length);
>>           } else if (guid_equal(sec_type, &CPER_SEC_CXL_MEM_MODULE_GUID)) {
>>               struct cxl_cper_event_rec *rec = acpi_hest_get_payload(gdata);
>>   -            cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
>> +            cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec,
>> +                        gdata->error_data_length);
> 
> There are multi places in this patch set doing the same thing, I was
> thinking if we can do the check in on place but we are facing different
> row error data, any good idea?

There's no easy single place to do this as the reason you stated.

> 
> Thanks
> Hanjun

