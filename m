Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FD1D5AB7
	for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510683; cv=none; b=jDjamGQs42jRrB9m+sSjXxiUN7rqLAQK9FX5r0SG/iTOt27h8BM1twYiSv0hiPKgsg3+7jvBXieT/GzXrdVs1crEjm72CMN71Iw7V016us4MjmcUnHChCZFf4vksUK6PGNqiion0Hsc5y7GTy+aVDVe8sRLbIVoz/roM4Y0je+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510683; c=relaxed/simple;
	bh=ruD90fmD45BZjpBmCszzza9dEygahhyzuZFLh8fMlYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocWVpOQUePiH+i9HcQ8ntPsbLGOfiZ3CxUZ1c+uDxDyijBwfGBC4rula9reDLZVQpIWlywBKUEEwA3nNQgEcgzfroWLtQY87sx3cwdSwqCto3ies98bLYafi4iyhIXSPkjHgJ5RzOq5N3cfgwKCpiyx1EJzYsHRuWPyx2bKWr5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QzQajJCK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QzQajJCK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755510680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lJ19cF2qHS7qAecDWBARhPKr/77IMYO29rQr0c/HTVQ=;
	b=QzQajJCKwVsbpW5EcpklZAVyj96nTYMUcnYF35ziGxUv05zqFQIyg7iTgv5z0On9FosdwJ
	3EDsJ35PlVVL+2J486PS4kWnzMLN8+iMgPamAJy+4ka/p47dqwAEBrv3JuP3IyvxGj7i67
	qLn4mpzNsjh3Pzn1lZqh1ThC5m5jUTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-4PCAOy0JO02nfESLhA4JmQ-1; Mon, 18 Aug 2025 05:49:44 -0400
X-MC-Unique: 4PCAOy0JO02nfESLhA4JmQ-1
X-Mimecast-MFC-AGG-ID: 4PCAOy0JO02nfESLhA4JmQ_1755510584
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41b82beso3272114f8f.0
        for <linux-cxl@vger.kernel.org>; Mon, 18 Aug 2025 02:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510584; x=1756115384;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ19cF2qHS7qAecDWBARhPKr/77IMYO29rQr0c/HTVQ=;
        b=afJwF1qHwg7wt6DS3ZjYTaxWeuMyfNX15Y3kNLJvS8OSy6fsOcTFS4nNOj/f1atvOw
         T0LOrah+EzTWj+gUvP2ZtQPOsPEsWt3QqPjenskQROZRvbxDB+QJiIC5xAfTq/dwWVP0
         U52OdNUGAzmRap62I6UGaqBG8EjTwejjl/qN8PIh+QHdSdpcto2x8OW6H0CiX9okIee+
         1ycyO3bW34GOYXa4eYxwTLLJrrQR3m3Wa6URyc6zodOijhkuOP9FZCb4WfxVMYpxYf1K
         By23fFvZlAtFcJTb4239gMk1cAE6CxZoJtFmV7igyce9VB5MfhoVUwQbLrYKfxy1eZ9i
         5Mig==
X-Forwarded-Encrypted: i=1; AJvYcCXVo8QT9kEVfBYSW5IW5GdY8a+82+RKTgRgm/Y46qpcchQOR7QG9OZ+zS5cbtVHtQFzopY4Y3qtf0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaDoJjolFU2FbKB3qLb0Tl5twuZcAsKBqOR4MQBUhgc3BvWVL
	GhqU1hgtoOqIlkpSQGw37CIXeQL0XkIzKyz1e8/S7g4JBeUEkZlcaLWmfG6JqhZiI9aibKMmQ7w
	Ec16v2yo/pROjnnuQ8xPWoDCckvV9E3QpgQJOYGpDA5YCn08cHmNt+YLdcqKtgw==
X-Gm-Gg: ASbGncsT9C5hLyS+dM7a6//zcE3+CqIho1JkE2RlPu3KT4Ebs4tSOBtLoujbgEaBeEY
	/wT/lJA/Ez6bhl/VSFWJNOgahY41hcVB3okBesJER2XAxuBPcxpg1p17ZhyDC8RN9W4bsM1oWM6
	kBd5OwNLAsimfvY6ckdXyh2AtSzomW+euwDDmneBC1oJUZbJsLeLRJY8PhJ8QUJiDDzw7AQwzrn
	julw8V4n2PvmFdgXYXLXQkyiGblwSDEE1IXSp1RiJWdwoFL2Dsp5ve9l/YeES3KV/JfUIczqA1b
	tMOo0twGpGd52FS18vrx9skjU62PEFN3WnE+sSiJrEm8o0mmnNAiYSMG8lneEjq40wZvhtag8rG
	xplL/FA+YT7sq2t5vbHitMSjVSqY+3pa9uHAdykJpcQNHPIu3R2LHofrHTpQYnkNv
X-Received: by 2002:a05:6000:2310:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3bc688ab9a7mr5661630f8f.26.1755510583697;
        Mon, 18 Aug 2025 02:49:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJaAWqgw5QTC3l/jewXPtJbxd2DyXWRBJjgRtYobnv0HyqwBobL37m1mf4apF3o86Qm2R/cA==
X-Received: by 2002:a05:6000:2310:b0:3b7:8b64:3107 with SMTP id ffacd0b85a97d-3bc688ab9a7mr5661608f8f.26.1755510583279;
        Mon, 18 Aug 2025 02:49:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm174744525e9.6.2025.08.18.02.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:49:42 -0700 (PDT)
Message-ID: <c0600abd-18fd-4bfa-ba8d-45303ee3a9ee@redhat.com>
Date: Mon, 18 Aug 2025 11:49:41 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drivers/base/node: Add a helper function
 node_update_perf_attrs()
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 marc.herbert@linux.intel.com, akpm@linux-foundation.org
References: <20250814171650.3002930-1-dave.jiang@intel.com>
 <20250814171650.3002930-3-dave.jiang@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250814171650.3002930-3-dave.jiang@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 39mCQnKINcCt6pcQ_tSnXlYi_U2cj81FC0R7p_XfeFY_1755510584
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.08.25 19:16, Dave Jiang wrote:
> Add helper function node_update_perf_attrs() to allow update of node access
> coordinates computed by an external agent such as CXL. The helper allows
> updating of coordinates after the attribute being created by HMAT.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/base/node.c  | 39 +++++++++++++++++++++++++++++++++++++++
>   include/linux/node.h |  8 ++++++++
>   2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 3399594136b2..cf395da18c9b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -248,6 +248,45 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>   }
>   EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>   
> +/**
> + * node_update_perf_attrs - Update the performance values for given access class
> + * @nid: Node identifier to be updated
> + * @coord: Heterogeneous memory performance coordinates
> + * @access: The access class the for the given attributes

"the for": there is probably something missing

> + */
> +void node_update_perf_attrs(unsigned int nid, struct access_coordinate *coord,
> +			    enum access_coordinate_class access)
> +{
> +	struct node_access_nodes *access_node;
> +	struct node *node;
> +	int i;
> +
> +	if (WARN_ON_ONCE(!node_online(nid)))
> +		return;
> +
> +	node = node_devices[nid];
> +	list_for_each_entry(access_node, &node->access_list, list_node) {
> +		if (access_node->access != access)
> +			continue;
> +
> +		access_node->coord = *coord;
> +		for (i = 0; access_attrs[i]; i++) {
> +			sysfs_notify(&access_node->dev.kobj,
> +				     NULL, access_attrs[i]->name);
> +		}
> +		break;
> +	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord)) {
> +			pr_info("failed to set mempolicy attrs for node %d\n",
> +				nid);
> +		}
if (access == ACCESS_COORDINATE_CPU &&
     mempolicy_set_node_perf(nid, coord))
	pr_info("failed to set mempolicy attrs for node %d\n", nid);

or

if (access != ACCESS_COORDINATE_CPU)
	return
if (mempolicy_set_node_perf(nid, coord))
	pr_info("failed to set mempolicy attrs for node %d\n", nid);


With both things sorted

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb

