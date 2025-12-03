Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF82E7F0B
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764756795; cv=none; b=rGY64z74V8daMnfSh6/jum1VMuVscRhZzXR21Ji1RpLGWie3UIv69id7CZfew12hWUdtChmHEOjraUerlKFRQsci8fFgz164rhm/JavJ9haeDLY8LgEsS2cd2t6TufMvfjFPwdqzOuWqLwvRbewGxgjMu1y8eIDBHtDRjZi7fCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764756795; c=relaxed/simple;
	bh=BiT+d5qc8C4RsGYH+SCaa+oeC3Yav6s+/ZzqrsgmzJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDCLX+6GgmOELg3YlKsdDdUZM4NX/ajmE22im2TCfM82m3YMuNgz5zz9NytQiaRRbvOihRwN9FFYxb2fbEldNy32dWR6gY3Uubm2yvlYuu25C7C7N1w+/Bqb6S934bcPHuO+bgaqqJJUrdpm5TkfbmU+b4rmKcVNZ8vh9kDHrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1bUHkZL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1bUHkZL"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so12267844a12.1
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 02:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764756792; x=1765361592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25t6xy0yqULv0JiwkJYiO6xQv5aKUXjoZCh/BoUPI5E=;
        b=J1bUHkZLgmtNcm/WtVt5c8Kzeuw9wZf7N4YMnOEi4dgW8Z6DDWrttcX1E4/WviG8Kv
         D0hm4iaHr7pcke2Qh5Sod3SIiysD5c9JbR6zP2jOktafbby8kSv/HWDWWaOR45J2Wr1l
         NoiQw++oH9wXVgwFoIPOV2USgPAqeASYfIuYRMdor9EOtqKIgjKvett+byNOQroLDEI2
         jalUCstuMVPEzYlPKIVVSorYvNRhNsxFRYIzN/ZzTAUBsfg2zPBkbynARVgXU4kWQCE7
         WRVZo/W+fC3/C+Tv480zfONwWNILvfMnfUVqXKEp2lfnRTU+9P9ZxlCrRgbw6L6LNoz0
         PHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764756792; x=1765361592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25t6xy0yqULv0JiwkJYiO6xQv5aKUXjoZCh/BoUPI5E=;
        b=ZCUd6G2RoTBz0Z5uAIWHvB/DKYM3kWi2gPEQwlICYocElQgEXfgrrFBc8n1vFM42lt
         FF61ODpeaqIUXjsxLttUVJ1xy92YRy1ysMYJxgN1PbQGUy+VW+cs0utwry+E8zJLGFP1
         yfofpxxa5M8sdKjNoI+TjKMqGckDcY1NUnw69BWvamQblUdhySZvSWc74edtECR9Ps8u
         YUY4HZsQqXMvHvNH7qHnmf6QQ+41oEnmEfFnaVIhyx7FTV4DAlBzW+dvXZmxK2wKREWX
         N7aaQ/EkBgVAsoYW9mdBtARBg3eKYhJ+Nf2QK4eYomvFu4GopfrRxcV7oihlVjNpGbb9
         6MXw==
X-Forwarded-Encrypted: i=1; AJvYcCWQmyx83G14z+e3g1/jLugWAiQmK2D5qNME7Dob5kyMOdoC5VJ/zSJIqi6EoeDBzaf1fK0iUfxWtVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuS2d1g6DWWhdOhyfsKdO94ZnmHfZ7it1iN33rFLWntKDfUt+r
	OVrHNXS1XazY8944xv9j9ym8pqEpAL5571ZnwTjajc4GtulJilHVO60Q
X-Gm-Gg: ASbGncvKaicVhOfZKXPNguhoAqOQl/L/w0G69mwaRhormIQg+3y5HNyuQQ0qJxEzH8K
	oI4F0HSB+GcO9SWpt9JdA2ir+D21A+RtVLcnGXspD4UG0DWIbRGcsls4f7+xc4eibTSUb+GKfeL
	7g21s97Q4PRFjyy9pspXeSJtjjJ3wVC0S74XcZQ7fpTFPthtEXGrDCVKnY56HBrYVOqLwgfNyvS
	ZlrG/9I1IC39TrZ3RJJRpwbmrdz4f84FCJBY+MhrUp5j7ETfvT1KTOkQv6Fxb3X26wYizrEpIj9
	CVuQ6u8KHz4QqjPdlkG7syfPJGJvgrskJsrGvoLrNONVF+cp+sUa8PUoED5w3723dBfGPcnnWvo
	tM4zVEF3VZR4S73IQ1XZP57hUBVLq4HsYHxyn5Vb6smkOiA0PCJMA4OaEUwow8LZb+zATBskJLa
	v3J4rt+zSF34oYuolUyooZ70BgfgXtf0TNVOWR6Z9Xq+/YU+PZ8Q==
X-Google-Smtp-Source: AGHT+IHTMMMGbyG3xoxSU5KF7TdsFbHPq8VHtexaM2213sNX8hNsAco+kYiqaZeWu8gHFrIEPy/iYg==
X-Received: by 2002:a05:6402:5cd:b0:643:8183:7912 with SMTP id 4fb4d7f45d1cf-6479c468083mr1301257a12.9.1764756791360;
        Wed, 03 Dec 2025 02:13:11 -0800 (PST)
Received: from [192.168.99.24] (78-9-233-67.static.inetia.pl. [78.9.233.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751062709sm17985810a12.35.2025.12.03.02.13.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 02:13:10 -0800 (PST)
Message-ID: <360de9fe-75eb-4327-a35a-8811fa2d1201@gmail.com>
Date: Wed, 3 Dec 2025 11:13:10 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH v1 2/2] cxl/cli: enforce HPA-descending teardown order for
 destroy-region
To: Alison Schofield <alison.schofield@intel.com>,
 Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
Cc: dan.j.williams@intel.com, Smita.KoralahalliChannabasappa@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20251125143826.282312-3-pawel.mielimonka@fujitsu.com>
 <aS-5Zjhz-5Mkdqpy@aschofie-mobl2.lan>
Content-Language: en-US
From: =?UTF-8?Q?Pawe=C5=82_Mielimonka?= <pawel.mielimonka@gmail.com>
In-Reply-To: <aS-5Zjhz-5Mkdqpy@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


W dniu 3.12.2025 o 05:15, Alison Schofield pisze:
> On Tue, Nov 25, 2025 at 11:38:24PM +0900, Pawel Mielimonka wrote:
>> Implement destroy_multiple_regions() and bypass the generic
>> do_region_xable() path for ACTION_DESTROY. Regions are collected and
>> sorted by HPA, then destroyed from highest to lowest, stopping at the
>> first "matching after skipped" to provide user with better error log.
>> This prevents attempts on non-last regions and aligns destroy-region
>> with required decoder programming order.
> It would be useful to add a sample bad spew or what happens now
> on attempt to destroy out of order.  Folks sometimes search on
> those strings.
In all cases in which I reproduced this misbehavior, in log i could find:

"write(3</sys/devices/platform/ACPI0017:00/root0/port1/endpoint2/decoder2.0/dpa_size>, 
"0\n\0", 3) = -1 EBUSY (Device or resource busy)"

And the cli returned:

"cxl region: destroy_region: decoder 2.0: set_dpa_size failed: Device or 
resource busy"

>
>> Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
>> ---
>>   cxl/region.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 57 insertions(+), 3 deletions(-)
>>
>> diff --git a/cxl/region.c b/cxl/region.c
>> index 58765b3d..1bf1901a 100644
>> --- a/cxl/region.c
>> +++ b/cxl/region.c
>> @@ -950,6 +950,57 @@ static int destroy_region(struct cxl_region *region)
>>   	return cxl_region_delete(region);
>>   }
>>   
>> +static int destroy_multiple_regions(struct parsed_params *p,
>> +				 struct cxl_decoder *decoder,
>> +				 int *count)
>> +{
>> +	struct cxl_region **list;
>> +	int nr, rc, i;
>> +	bool skipped = false;
>> +
>> +	rc = collect_regions_sorted(decoder, NULL, &list, &nr);
>> +	if (rc) {
>> +		log_err(&rl, "failed to allocate region list: %s\n", strerror(-rc));
>> +		return rc;
>> +	}
>> +
>> +	for (i = nr - 1; i >= 0; --i) {
>> +		struct cxl_region *region = NULL;
>> +
> Here is where there is a difference btw 'all' and a decoder. 'All' gets
> passed as an argument and the filter function recognizes it. But for the
> by decoder option: "cxl destroy-region -f -d decoder0.2" argc=0 needs
> special handling
>
> Inserting this here worked for me:
> +               /* If no region arguments provided, match all regions */
> +               if (p->argc == 0)
> +                       region = list[i];
> +
>
> Then with argc == 0 this next loop is a no-op but that is OK because
> region is now assigned.
Thanks for the suggestion.

According to the manual, "cxl destroy-region -f -d decoder0.2" is not a
valid CLI invocation — a region number (or "all") is required:

     SYNOPSIS
         cxl destroy-region <region> [<options>]

So the case you describe would normally be written as
"cxl destroy-region all -f -d decoder0.2". If we want to accept the case
where no region argument is provided, it feels like this should be
handled earlier during parsing and the documentation should explicitly
state that "all" is assumed when <region> is omitted.

Given the current docs, I would lean towards reporting an error when
p->argc == 0, unless we decide to update the documentation to permit the
implicit "all" behavior.

I've also tested various cases with explicit region arguments, e.g.
"cxl destroy-region 1 2 3" with regions 0..7 present, and those paths
behave correctly.

Happy to adjust in whichever direction makes the most sense.
>
>> +		for (int j = 0; j < p->argc; j++) {
>> +			region = util_cxl_region_filter(list[i], p->argv[j]);
>> +			if (region)
>> +				break;
>> +		}
>> +
>> +		if (!region) {
>> +			skipped = true;
>> +			continue;
>> +		}
>> +
>> +		/* if current region matches filter, but previous didn't, destroying would
>> +		 * result in breaking HPA continuity
>> +		 */
> Use kernel comment style. See other samples in this file.
>
>
>> +		if (skipped) {
>> +			log_err(&rl, "failed to destroy %s: not a valid HPA suffix under %s\n",
> I'm not familiar w the usage of 'suffix' in this context.
> How about replace "not a valid HPA suffix under"
> with "out of order decoder reset"
I intended it to mean "the last region in HPA order". Your wording is 
clearer,
so I'll adopt your suggestion in v2.
>
>> +				cxl_region_get_devname(region),
>> +				cxl_decoder_get_devname(decoder));
>> +			rc = -EINVAL;
>> +			break;
>> +		}
>> +
>> +		rc = destroy_region(region);
>> +		if (rc) {
>> +			log_err(&rl, "%s: failed: %s\n",
>> +				cxl_region_get_devname(region), strerror(-rc));
>> +			break;
>> +		}
>> +		++(*count);
>> +	}
>> +	free(list);
>> +	return rc;
>> +}
>> +
>>   static int do_region_xable(struct cxl_region *region, enum region_actions action)
>>   {
>>   	switch (action) {
>> @@ -957,8 +1008,6 @@ static int do_region_xable(struct cxl_region *region, enum region_actions action
>>   		return cxl_region_enable(region);
>>   	case ACTION_DISABLE:
>>   		return disable_region(region);
>> -	case ACTION_DESTROY:
>> -		return destroy_region(region);
>>   	default:
>>   		return -EINVAL;
>>   	}
>> @@ -1026,7 +1075,12 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
>>   			if (!util_cxl_decoder_filter(decoder,
>>   						     param.root_decoder))
>>   				continue;
>> -			rc = decoder_region_action(p, decoder, action, count);
>> +
>> +			if (action == ACTION_DESTROY)
>> +				rc = destroy_multiple_regions(p, decoder, count);
>> +			else
>> +				rc = decoder_region_action(p, decoder, action, count);
>> +
>>   			if (rc)
>>   				err_rc = rc;
>>   		}
>> -- 
>> 2.45.1.windows.1
>>
