Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA212D77E2
	for <linux-cxl@vger.kernel.org>; Wed,  3 Dec 2025 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752961; cv=none; b=OM52DMAb0qirDS9dap305PjYdzZjGVvKsp9Pl0RPKnDXo9OXhfVpG2AJ6DWI8OC939kn1kfkncXBZ5VnSCzrPV1BvoAcRnTl1iPcrex7Zfr+GhmkXHTx5M2E5VImB/+gB7Yt6zm84uetrBOLMn812BJpHPm2aliNtKGszCDSbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752961; c=relaxed/simple;
	bh=k+2Etm99JbSEA+WCnKtBPF/mWFi9cMFd2NJl1bxp5Xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N84iZObArPtr1EN/WVHhFE8kMM0yucUrvp2Zmvybq66Px2NMc0H5ZHozoyIDUbw8EdEqaIWvuXGfEwTXEcfcObBKZAG+hKJ2ylvu4cNv38SMl+REHiuB2N4iWs8HsDTqUmSvYeZQ3CnxeqxrsdFjxBYoZMdhZE81Qn8OTOoiL/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2C3nNIt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2C3nNIt"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b76b5afdf04so1114754766b.1
        for <linux-cxl@vger.kernel.org>; Wed, 03 Dec 2025 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764752958; x=1765357758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DWBGLCFBomVbrDoB7b+HIef+8KhLxHYFNcq2HKmvMnY=;
        b=h2C3nNItV41VPqBi00ryO0hvMGkgPE2bKHlAtBt85EZpD9r8Cc4JJ1qDbPOf1FwlTy
         EH9pbfV1If/SPoUfchej0Q/Zkp1fryp8RM5R4Vv1OaLcTlLXdP/eMXWGh7AxwboEUZPQ
         UdeFwZTmi5fzBFupw8scmEbra+PlrafSa56R7j/zO5OuV7TYUHnDn9n5S/DQMU3W/T7X
         HVHl18tIBlt4vt/+NBpxm0f0HZ76Aj9YLcdhwqu9tu7SA0a2Uvw0XBPLtOs8anwf9ZJ4
         GkHWCiztwl9YSUAo0F828PsvJCCfUfAHgHtA5JUyXRxQTR+qatBry4sTMYRmH9DxVsAs
         kdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764752958; x=1765357758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWBGLCFBomVbrDoB7b+HIef+8KhLxHYFNcq2HKmvMnY=;
        b=aJUh6xJX71SUzzYuFvELgTYTFRwN4jIL9xbcnkUb3x74CDp6l10+y1GlXIR7k9NTgx
         6BciwgF+exxL4c8pQyVhdFcf9USHlLDq8OHgyZtoKEGZh8hqm2FvYYygJtAWWIR6CaxX
         o3lK5qO4LVBbcwQCxyyWYY6WU9xOnbg1qSeId7qRwdx9gQjRJ12DBNuyyoTQfe58cGHb
         FP5K3N7vx793SVznsSui2IUfNO/Fq5yyvyMe+BkEj6ZHJTzIgoIX3mHCEndmk5lHgWHZ
         YFbX5kFynHbN0swFKU+U/s9mMjet9ZMJ/Qm1kG/EYquz1GbuoKtj85/Ol+s1r1zmqbOp
         RZdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4nIOf2fI0kq3Xx46jHhgk1aLrwLZvVdzFO+7b9IEtdHC7B9wgA4ooJEO9TKzgF1ZcYHg3D7vgvfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnUxoObRHps6PeLQo4ipzClSAmDdvamOiuegt9KR9Zar5r5Gv
	SAnD1++jU+D6ZmYYsxWhsjdXMLszGTFUrePOeGlrk3QbyoPfmyGqVZQ8
X-Gm-Gg: ASbGncvSbWvojEZl5Ie4cRoUynag12IKqRNDlS6l3pRB9YXL0Zhzz0/OBrp2pA3BMYv
	HTGEvybZOAOFFc9f6RuFDeBecr3/uFwnw5v0M2/BvPBmOgKzEfBYBHRDKhVAPkddG1OKsW61EZg
	t+RtkRXUO+kKzrK3333GMW1eKYuuWCbOYTMBEOj2BcB87wzC3pouMpl6ysSrvINzACn/pF4lnJl
	+NqxoyQtsYOqqGKDYoF4segwd93GIGHegVdzKkudAOLWVC1Y2h98haQchg78nAGG3OEP1EtRS+C
	8kXQUF3SfjnpiQUrPXiF7O/GvuLObITSTZzoYnYHBz/pfmAUvjlrIx2OsowrgnlcnSgYKY5pQ6E
	ROhu1P269MmVzkKStH3Rv0mr4KGeWBfPEvzcp2h9J3aaydN3o4H4pwicOa4qnLKjCRTUsXn/+IB
	WWpAOK+nQPhuxzWeGpsmqZizyNM+WXVXD0Ssc18COXzK9GbZA4fA==
X-Google-Smtp-Source: AGHT+IHZT7vIFKQKX1rZhpQrBa6Ofod91g5bav7DiW3HcI/VLhFVFE7y0i47aGVT8p7OquV3UCNv/g==
X-Received: by 2002:a17:906:730d:b0:b79:b910:fd45 with SMTP id a640c23a62f3a-b79dc72f82bmr137044366b.38.1764752957417;
        Wed, 03 Dec 2025 01:09:17 -0800 (PST)
Received: from [192.168.99.24] (78-9-233-67.static.inetia.pl. [78.9.233.67])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f519e2f0sm1764864366b.21.2025.12.03.01.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 01:09:16 -0800 (PST)
Message-ID: <7eaf281d-6b92-4d8b-a633-e81925116364@gmail.com>
Date: Wed, 3 Dec 2025 10:09:15 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC PATCH v1 1/2] cxl/cli: add helpers to collect and sort regions
 by HPA
To: Alison Schofield <alison.schofield@intel.com>,
 Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
Cc: dan.j.williams@intel.com, Smita.KoralahalliChannabasappa@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com
References: <20251125143826.282312-1-pawel.mielimonka@fujitsu.com>
 <20251125143826.282312-2-pawel.mielimonka@fujitsu.com>
 <aS-0DNw3Jnw4ZR-y@aschofie-mobl2.lan>
Content-Language: en-US
From: =?UTF-8?Q?Pawe=C5=82_Mielimonka?= <pawel.mielimonka@gmail.com>
In-Reply-To: <aS-0DNw3Jnw4ZR-y@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


W dniu 3.12.2025 o 04:52, Alison Schofield pisze:
> On Tue, Nov 25, 2025 at 11:38:23PM +0900, Pawel Mielimonka wrote:
>> Introduce cmp_region_hpa() and collect_regions_sorted() helpers to
>> enumerate CXL regions under a given decoder and sort them by their host
>> physical address.
>> These helpers will be used by the "cxl destroy-region" command to tear
>> down regions in HPA-descending order, i.e. in the reverse order of
>> region creation. This matches the decoder programming requirements from
>> the CXL specification (8.2.4.20.12 - continuous HPA coverage at all
>> times when Lock On Commit is used) and avoids teardown sequences that
>> can leve decoder state inconsistent when the decoder is fully populated
>> (known problem).
>> This patch only adds the helpers; no functional changes is intended yet.
>>
>> Signed-off-by: Pawel Mielimonka <pawel.mielimonka@fujitsu.com>
>> ---
>>   cxl/region.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/cxl/region.c b/cxl/region.c
>> index 207cf2d0..58765b3d 100644
>> --- a/cxl/region.c
>> +++ b/cxl/region.c
>> @@ -831,6 +831,61 @@ out:
>>   	return cxl_region_disable(region);
>>   }
>>   
>> +static int cmp_region_hpa(const void *l, const void *r)
>> +{
>> +	const struct cxl_region *const *left = l;
>> +	const struct cxl_region *const *right = r;
>> +	u64 left_start = cxl_region_get_resource((struct cxl_region *) *left);
>> +	u64 right_start = cxl_region_get_resource((struct cxl_region *) *right);
>> +
>> +	if (left_start < right_start)
>> +		return -1;
>> +	if (left_start > right_start)
>> +		return 1;
> Suggest calling them hpa's and using this more common kernel compare pattern.
> (yeah, in ndctl, cxl/cli, we try to be like kernel)
>
> static int cmp_region_hpa(const void *a, const void *b)
> {
>          const struct cxl_region *const *r1 = a;
>          const struct cxl_region *const *r2 = b;
>          u64 hpa1 = cxl_region_get_resource((struct cxl_region *) *r1);
>          u64 hpa2 = cxl_region_get_resource((struct cxl_region *) *r2);
>
>          return (hpa1 > hpa2) - (hpa1 < hpa2);
> }
I followed the pattern in region.c but you're right, I'll fix it in v2.
>
>> +	return 0;
>> +}
>> +
>> +static int collect_regions_sorted(struct cxl_decoder *root,
>> +								  const char *filter,
>> +								  struct cxl_region ***out,
>> +								  int *out_nr)
>> +{
> I think there is an alignment issue above.
> The filter parameter is always called w NULL in patcht 2.
> If it's not going to be used, remove it.
>
>> +	struct cxl_region *region;
>> +	struct cxl_region **list = NULL;
>> +	int nr = 0, alloc = 0;
>> +
>> +	cxl_region_foreach(root, region) {
>> +		if (filter && !util_cxl_region_filter(region, filter))
>> +			continue;
>> +		if (nr == alloc) {
>> +			int new_alloc = alloc ? alloc * 2 : 8;
>> +			int new_size = (size_t)new_alloc * sizeof(*list);
> Looks like new_size should be size_t to match what realloc() expects.
Both changes I'll make in v2. Thanks for noticing.
>
>> +			struct cxl_region **tmp;
>> +
>> +			tmp = realloc(list, new_size);
>> +			if (!tmp) {
>> +				free(list);
>> +				return -ENOMEM;
>> +			}
>> +			list = tmp;
>> +			alloc = new_alloc;
>> +		}
>> +		list[nr++] = region;
>> +	}
>> +
>> +	if (!nr) {
>> +		free(list);
>> +		*out = NULL;
>> +		*out_nr = 0;
>> +		return 0;
>> +	}
>> +
>> +	qsort(list, nr, sizeof(*list), cmp_region_hpa);
>> +	*out = list;
>> +	*out_nr = nr;
>> +	return 0;
>> +}
>> +
>>   static int destroy_region(struct cxl_region *region)
>>   {
>>   	const char *devname = cxl_region_get_devname(region);
>> -- 
>> 2.45.1.windows.1
>>
