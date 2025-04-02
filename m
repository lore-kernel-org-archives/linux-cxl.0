Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C6232373
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580732; cv=none; b=NoSjXFDUfb8HoQziHynt1+ChmD/sk7yqBJeEKiOxdohMWChpgmVd085Onh5+LHN1Fz0ku+w4wHp6M6PRU1MeLZ+Vilmu22umpNPs9S+uabZJr/d3oBnl6MMk3UZS3jDqnsXJ0OiURUsJeXhux42JGRkjdknj/5rkGIhaIqKnkCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580732; c=relaxed/simple;
	bh=pDGRzcr+Vz616POJpo1zyplccBQpABjKMBcTPZAsCZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSmJdpvupBQKng6vq3NiwN8RTh4v9ikPTGC+ncO31znEqP+IDXSokFdyr/8YvDSaQw0eMtMUEZnegKKkkUf9Xt7OpM+LRLlbYZwFtVcQ+3zyPc9/taoq/AQEpRWZuoKnzixTdS3oA/pCYuLX9ZpUcDYIMiDFMkge82SzZ+CSMk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcFAV2q/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcFAV2q/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743580729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/qzqugcqTgi9VPjAotGENv6vPtewRXyYrP/8HKRxPHM=;
	b=FcFAV2q/YZhCzpY8hd9VDoOw0TlzAuRMNjfNh663I9PNRaKJWc6VoRnMQlg/vf0dlPyhWZ
	V1tWI9K5avYKrBbTI1zvv7NelyToO/3K4oUbFtAW9t66slRsgX2fXljwfMPRa0NHhyiKMo
	6E7W12vEfnnNjZZlzRFdxlRdXQYLuDk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-CPCaFFW1PCCIbOUyWWfnzw-1; Wed, 02 Apr 2025 03:58:48 -0400
X-MC-Unique: CPCaFFW1PCCIbOUyWWfnzw-1
X-Mimecast-MFC-AGG-ID: CPCaFFW1PCCIbOUyWWfnzw_1743580727
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3913aea90b4so2623998f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 00:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743580727; x=1744185527;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/qzqugcqTgi9VPjAotGENv6vPtewRXyYrP/8HKRxPHM=;
        b=pVqK1NlbFqtIGClkTFQRhkB+W68rBe7DRKyvcgW6fmT3ALoOmisytcjpvcEcOMYAB9
         Hk+6LDRXoTwM1Dh8L6kfuWG3mz2r/HGOwU489ZHpbFi+2yrxW9pk1JQj2qZgnFbv23+c
         FwgAUNeAA4YCIfdhJCPw7IAkD/s++6uKVEOp2YbopDsspF2YQ2naXQVIEcsIpOqF5fDj
         UHqHTgCVuuQxHn3pjGu81VwKsO3yUVgNRR25K23s69EuU67jU7JCZq44kesshBxPxgeQ
         IdCxIiA0jk/fMtu+im5iS8wzmJGSy5sQdXYCdGBMZS7dVTnTvKHtgmpqPwzEb/3Ykp7Z
         lGAA==
X-Forwarded-Encrypted: i=1; AJvYcCXMKkjB6eIPGoydldFXbL7BBo1vbONwUF379/WvzoWjv3INVlgSYy3BP3ov6YFSMkeOHLN8bmneU8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZIav/tPa33Irk7MeGhcwJzGRlDskgGvbWawIIYwx56g974Y2
	FFzu0Tv16UPJuguTMGOryHVpG0PqRxSpohU50R9ZOW/2UFdXrsifOV17f9CPGMLLeqIFVmVIIgK
	gKu04inq+CLAi94haRUl3nm5UYoeODql60cI+Y5Nc6x67ScJatnU/jyijRQ==
X-Gm-Gg: ASbGncvCiyv5K3TZZ44PF9OEP3qaHqxqEuN9yVbMnHrCb3J8FETFKEfOhW5H3jvjusH
	BgYlKZgiEGfBVL4NEos1Tr3PCE1OnR7Z9LVg+FHeR9tLBKsDPoo/DORVY6HTrzhF7MgIqE9kjMJ
	rUSL7mOHvskVo6glUd8O8CLjMVU5Ty9c2roIHR1H26J41+WKlegQ3PYKNuhhTLfjoG3Mh/YTFeG
	rDCwf5UUWvFc2hATyT+SQkV9BG6OKHM0Z9XFCsKKajLJhX3r9LlCrpzmFgixULCxH2voB0Hba16
	pA2gHIZY/wZgQYg4tIo1llZJvWb7wwaXHe/x8d4g2rxL3rBdzd7BnsTsx1qfkCh9U/LUK7N/YLN
	rao2xp8HCAtrmntxlsAjKjxwwcwavEloWNWWXfUFv
X-Received: by 2002:a05:6000:4210:b0:391:481a:5e75 with SMTP id ffacd0b85a97d-39c29752ecbmr989766f8f.22.1743580727433;
        Wed, 02 Apr 2025 00:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoWuvsfy5xF6bkdlVGypDlh3ubwbzhQVFsDkTtwPKuyMVXi0AWgYf/0f/qDjf7zhTdPGJ7hw==
X-Received: by 2002:a05:6000:4210:b0:391:481a:5e75 with SMTP id ffacd0b85a97d-39c29752ecbmr989745f8f.22.1743580726988;
        Wed, 02 Apr 2025 00:58:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70f:cd00:4066:4674:d08:9535? (p200300cbc70fcd00406646740d089535.dip0.t-ipconnect.de. [2003:cb:c70f:cd00:4066:4674:d08:9535])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e141sm16270730f8f.77.2025.04.02.00.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 00:58:46 -0700 (PDT)
Message-ID: <1789e1cf-ab35-4730-8c75-8ea037e590f6@redhat.com>
Date: Wed, 2 Apr 2025 09:58:45 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] DAX: warn when kmem regions are truncated for memory
 block alignment.
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, dan.j.williams@intel.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com
References: <20250402015920.819077-1-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250402015920.819077-1-gourry@gourry.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9ambOwleGMxnGIRzcdybv12oUtJeNo5kQAzNY_s_Mac_1743580727
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.25 03:59, Gregory Price wrote:
> Device capacity intended for use as system ram should be aligned to the
> archite-defined memory block size or that capacity will be silently
> truncated and capacity stranded.
> 
> As hotplug dax memory becomes more prevelant, the memory block size
> alignment becomes more important for platform and device vendors to
> pay attention to - so this truncation should not be silent.
> 
> This issue is particularly relevant for CXL Dynamic Capacity devices,
> whose capacity may arrive in spec-aligned but block-misaligned chunks.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   drivers/dax/kmem.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index e97d47f42ee2..32fe3215e11e 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -13,6 +13,7 @@
>   #include <linux/mman.h>
>   #include <linux/memory-tiers.h>
>   #include <linux/memory_hotplug.h>
> +#include <linux/string_helpers.h>
>   #include "dax-private.h"
>   #include "bus.h"
>   
> @@ -68,7 +69,7 @@ static void kmem_put_memory_types(void)
>   static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>   {
>   	struct device *dev = &dev_dax->dev;
> -	unsigned long total_len = 0;
> +	unsigned long total_len = 0, orig_len = 0;
>   	struct dax_kmem_data *data;
>   	struct memory_dev_type *mtype;
>   	int i, rc, mapped = 0;
> @@ -97,6 +98,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>   	for (i = 0; i < dev_dax->nr_range; i++) {
>   		struct range range;
>   
> +		orig_len += range_len(&dev_dax->ranges[i].range);
>   		rc = dax_kmem_range(dev_dax, i, &range);
>   		if (rc) {
>   			dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
> @@ -109,6 +111,12 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>   	if (!total_len) {
>   		dev_warn(dev, "rejecting DAX region without any memory after alignment\n");
>   		return -EINVAL;
> +	} else if (total_len != orig_len) {
> +		char buf[16];
> +
> +		string_get_size((orig_len - total_len), 1, STRING_UNITS_2,
> +				buf, sizeof(buf));
> +		dev_warn(dev, "DAX region truncated by %s due to alignment\n", buf);

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

