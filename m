Received: from sender4-pp-o92.zoho.com (sender4-pp-o92.zoho.com [136.143.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8D131578E
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 04:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893509; cv=pass; b=USN1kyEWCJEJshROm2MUgFrDgN08ekBWImxeFM+u+OoKrURA0bV0hcoSpKbWg5ifNJSRu6Zj2RFOi8b8UJZb+ZCCx5c/7U175uU1ALnPGK+C3JX8DTxQS4oFS7Kzgu5cfjraoDLD238+MVNKV6XJyRK6utSclPXZbXkJuNgLuf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893509; c=relaxed/simple;
	bh=Mx33IJ/v+pEW113ZfX248ab0SX6Nrubq1z8uLCPfd0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXxNqLrpig48608CdenFS0GoBngbUoh8hG84Vnytqcngp62oC/Z02Q33h+VrlbTzafzjhHFFxEOocqOpE6n4Gaw0W91/Zpj+vyUCeUJijlXqX/FowKgJuPM9+XRcUx7iZcRUtWaRM8VaPXPAeqgIna+jFpnLcJ+mI067T+Zr8qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=JzrGUuir; arc=pass smtp.client-ip=136.143.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="JzrGUuir"
ARC-Seal: i=1; a=rsa-sha256; t=1780893504; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q6toTLqYkcUQnmgBanVVFtfx4Gv+PLNTTV7ik0AbP6sXmE4/uRQoPe/M3LDMI48zdoC+vK8cH6pRFHY6MozWHy2UR8Sdp9tco3nuvf5oJYoIxiF4TodNsnS6V9yDN6qgueAupTvqCJHhMDtpB7MYGRTDRwMyoFMgSDOPAWMazB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780893504; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UV2OxS8LSBNLw354gLnXg6nAqXQiurzgRxBXW8iX6oY=; 
	b=IOD2Jx3zefheYF5PBRxvgp6iuxMJsZKLr+gV5k/F6Y3Icy4hBdv7Lb/BvyrrjWzKg7T5YkKQK7NpE91ScD9pJvF67UZpmzJNAyjHZHqdPpakjEuvQyDHvJA+HKpqoY19j8xzLPPKcD/atx1PbweA3ZynKvJ2l1IcWvwoUSWRweU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780893504;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UV2OxS8LSBNLw354gLnXg6nAqXQiurzgRxBXW8iX6oY=;
	b=JzrGUuirQz4MhOIPuPaPjRvSDQLbGv5aWH1JlmK0qyoVR1nnyAA7Z6D5o/FdeaD0
	gHcb75EgYEtLqc8Ab2f7txI3WnxVKM/iDEIYeS9hq8YWTUq4HLQQtcWPgKkMV1oTsFM
	Aazgf9pShWc+p98/2dlJRsif40I3SwToUTueAJSE=
Received: by mx.zohomail.com with SMTPS id 1780893500415473.532958800497;
	Sun, 7 Jun 2026 21:38:20 -0700 (PDT)
Message-ID: <0df43a4c-cdb1-443e-a424-33ecc63d6c1d@zohomail.com>
Date: Mon, 8 Jun 2026 12:38:42 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl/region: Fill first free targets[] slot during
 auto-discovery
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-2-5d94ca06c4e4@zohomail.com>
 <20260606081149.1B0F11F00893@smtp.kernel.org>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20260606081149.1B0F11F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: zu08011227762968533e82e869e7c03ddc00002b035325a71c627281c0e950ac19c35042611989f912061156:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

On 6/6/2026 4:11 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Loops iterating over the `p->targets` array up to `p->nr_targets` unconditionally dereference elements, leading to NULL pointer dereferences because the array can be sparse.
> --
>
> commit bf78125f1b0b7a811b9b200d37ed57cc96619a00
> Author: Li Ming <ming.li@zohomail.com>
>
> cxl/region: Fill first free targets[] slot during auto-discovery
>
> This commit adjusts the cxl_region_attach_auto logic to find the first free
> target slot for endpoint decoder attachment, rather than appending to the tail.
> This ensures NULL holes in the target array are filled to avoid accessing an
> endpoint decoder via a NULL pointer and miscounting valid endpoint decoders.
>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index c4335ebf19f7f..532dac77bd003 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1848,8 +1848,21 @@ static int cxl_region_attach_auto(struct cxl_region *cxlr,
>>  	 * this means that userspace can view devices in the wrong position
>>  	 * before the region activates, and must be careful to understand when
>>  	 * it might be racing region autodiscovery.
>> +	 *
>> +	 * The endpoint decoder will be recorded into the first free slot of
>> +	 * the target array.
>>  	 */
>> -	pos = p->nr_targets;
>> +	for (pos = 0; pos < p->interleave_ways; pos++) {
>> +		if (!p->targets[pos])
>> +			break;
>> +	}
>> +
>> +	if (pos == p->interleave_ways) {
>> +		dev_err(&cxlr->dev, "%s: unable to find a free target slot\n",
>> +			dev_name(&cxled->cxld.dev));
>> +		return -ENXIO;
>> +	}
>> +
>>  	p->targets[pos] = cxled;
> [Severity: High]
> This is a pre-existing issue, but since __cxl_decoder_detach() can leave
> sparse holes in p->targets without compacting the array, are the loops
> that iterate up to p->nr_targets still susceptible to NULL pointer
> dereferences?
>
> For instance, in drivers/cxl/core/region.c:cxl_dpa_to_hpa():
>
>     for (int i = 0; i < p->nr_targets; i++) {
>         if (cxlmd == cxled_to_memdev(p->targets[i])) {
>
> If there is a hole at an index less than p->nr_targets, wouldn't
> cxled_to_memdev() dereference a NULL pointer?
>
> Similar unprotected iterations seem to exist in
> cxl_scrub_get_attrbs_region(), unaligned_region_offset_to_dpa_result(),
> and region_offset_to_dpa_result().
>
> Does the array need to be compacted upon detach, or should these loops be
> updated to check for NULL pointers before dereferencing p->targets[i]?

It is not a bug here.

cxl driver always calls cxl_dpa_to_region() for a cxl region checking before involving cxl_dpa_to_hpa(), but if a cxl region is not bound to cxl region driver, driver will not involve cxl_dpa_to_hpa().

But maybe adding cxlr->driver checking in cxl_dpa_to_hpa() is a choice.

>
>>  	cxled->pos = pos;
>>  	cxled->state = CXL_DECODER_STATE_AUTO_STAGED;


