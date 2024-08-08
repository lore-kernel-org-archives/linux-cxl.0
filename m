Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50681487FE
	for <linux-cxl@vger.kernel.org>; Thu,  8 Aug 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141221; cv=none; b=JjK1mqxflaC5k3PCO6Fyxg7ahWcGwN9b16J9NZezh8pdUfDipBXiU9gjLnFI8NR7rcEbpJaEBJYj0i0CBeOheWw+V2UEk4iKdiB1dYSAVADbNLEK5EOHPXWmdanVEhPlwEczceGWC/iFGJc5XsJfgsf/svMFB3KacmxaBUlypw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141221; c=relaxed/simple;
	bh=fbbdNZBzSF/WuHsXmguIomCFKleKENLU9H4qnqLW6vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DD5CImAmKJkoAQju4mP+PRxs4Z9cfYYajQE64bFH5PLAWdlhbFaxuYyYRZbc3Phkvtx0Xw8/HhwvUz9IUJy0ZIFNoB03eUnglSNuw92Yi7z6vbSrao1XRsCMk2ppFS9P5sZy7XiUB6hgdIUI7fND4LyrTgvjJ/clecpuYGm5dPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXlEn7mD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXlEn7mD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723141218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yhh798F00IGb/P9Brjnr/Acx9NEQw+ylcnAcMgbOAhQ=;
	b=NXlEn7mDEyvLcqHg8zJzAGbsWgKpDSaCXJhuPIEnc1oOW3AERVtIgpk6z34xu9Isr/NneB
	LRyUmShBTboz44t2rVwxWilzT0FEQVd7iJt6ntb6LyFiM+gdqijxdIh2dWv4KT5heTFG02
	BMZ/jc7xgBCFdZEy3W/weU4Nuw04rmM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-4CQ0wtRBPOSpTGlo_9rPmw-1; Thu, 08 Aug 2024 14:20:17 -0400
X-MC-Unique: 4CQ0wtRBPOSpTGlo_9rPmw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36848f30d39so709576f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 08 Aug 2024 11:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723141216; x=1723746016;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yhh798F00IGb/P9Brjnr/Acx9NEQw+ylcnAcMgbOAhQ=;
        b=xOefX21tmcymjWB9QARvMZeM7gF7QffxzrI3xZ3DIb3O6OyWRZl4qTyXS/lKHvzuM8
         0HAqxyHo+pReyTgOKmsQ96uyHQgfoKIC9zsThBbPFJ8OwFmqjzx8a/rIhbK+nzjLBlZ3
         vLVB4/4imLqJVVyN1x0bQlIXoKG4mVJVskw3A6EMXuryVq1gI8Huz8DAx2Mgid2ZlugS
         I4m/+p4UFffQUBLZyWXYplf73IIMZewRmsG6eO+soUA+Ab0TNd15A1x5u9pzVrwmER0B
         U9ghNHflIapVPQGYVs9cfyOtQI6thHI7/3Zd99mmMwWsCEvXL+Q+O57BPoqzsm5ZMl3u
         njTw==
X-Forwarded-Encrypted: i=1; AJvYcCUtdeqdp+vrqeOdjlsQac1vxbBYSgr7J5Nkr55CjO4rm1cpLIClzQ2MbM3EhQ2P06JpAzlMdJ1c7x8xyM/L384vQK7YGIZBEXb/
X-Gm-Message-State: AOJu0YyeNDUUjdVUO58KDEYENP8G/XouNxioh9Wf9ThYZSFWeC+ac8sh
	fT0skTbSrMQ0+un0/6DI5TbFPj3aBXaGIrrkcsjGjSiHUMdyP9oyIRVjAnmAhQ11XvHY47edEZQ
	OoCAsAhF8DWXT8uP+UoN0GNtPYe6+XZ4oWZiNq2jmXCl7one6C4hjmXRYeg==
X-Received: by 2002:adf:a347:0:b0:368:72c6:99c4 with SMTP id ffacd0b85a97d-36d273c5b95mr2018445f8f.10.1723141216032;
        Thu, 08 Aug 2024 11:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESrorva4QsWIF+egBfKKR37XiDxHSf9o0VsaI/BKwZ5lbsPtQrd6UuYw0NjIaH7YkKOhT1kw==
X-Received: by 2002:adf:a347:0:b0:368:72c6:99c4 with SMTP id ffacd0b85a97d-36d273c5b95mr2018419f8f.10.1723141215439;
        Thu, 08 Aug 2024 11:20:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6? (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de. [2003:cb:c713:2a00:f151:50f1:7164:32e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d2724c654sm2692884f8f.115.2024.08.08.11.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 11:20:15 -0700 (PDT)
Message-ID: <9cf6cbc1-67c0-4ae5-ae5e-5033631e61b6@redhat.com>
Date: Thu, 8 Aug 2024 20:20:13 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] mm: add system wide stats items category
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com,
 lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com,
 rientjes@google.com, rppt@kernel.org, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org, dan.j.williams@intel.com,
 yi.zhang@redhat.com, alison.schofield@intel.com, yosryahmed@google.com
References: <20240808154237.220029-1-pasha.tatashin@soleen.com>
 <20240808154237.220029-4-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808154237.220029-4-pasha.tatashin@soleen.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 17:42, Pasha Tatashin wrote:
> /proc/vmstat contains events and stats, events can only grow, but stats
> can grow and srhink.

s/shrink/

I think we discussed exposing this in /proc/meminfo. There, it would be 
much easier to simply have a global variable, print it, and be done with 
it. Like we do with TotalCma.

For /proc/vmstat that's likely the right approach what you have here.

> 
> vmstat has the following:
> -------------------------
> NR_VM_ZONE_STAT_ITEMS:	per-zone stats
> NR_VM_NUMA_EVENT_ITEMS:	per-numa events
> NR_VM_NODE_STAT_ITEMS:	per-numa stats
> NR_VM_WRITEBACK_STAT_ITEMS:	system-wide background-writeback and
> 				dirty-throttling tresholds.
> NR_VM_EVENT_ITEMS:	system-wide events
> -------------------------
> 
> Rename NR_VM_WRITEBACK_STAT_ITEMS to NR_VM_STAT_ITEMS, to track the
> system-wide stats, we are going to add per-page metadata stats to this
> category in the next patch.
> 
> Also delete unused writeback_stat_name() function.
> 
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>   include/linux/vmstat.h | 15 ++++-----------
>   mm/vmstat.c            |  6 +++---
>   2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index 23cd17942036..9ab4fa5e09b5 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -34,10 +34,11 @@ struct reclaim_stat {
>   	unsigned nr_lazyfree_fail;
>   };
>   
> -enum writeback_stat_item {
> +/* Stat data for system wide items */
> +enum vm_stat_item {
>   	NR_DIRTY_THRESHOLD,
>   	NR_DIRTY_BG_THRESHOLD,
> -	NR_VM_WRITEBACK_STAT_ITEMS,
> +	NR_VM_STAT_ITEMS,
>   };
>   
>   #ifdef CONFIG_VM_EVENT_COUNTERS
> @@ -514,21 +515,13 @@ static inline const char *lru_list_name(enum lru_list lru)
>   	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>   }
>   
> -static inline const char *writeback_stat_name(enum writeback_stat_item item)
> -{
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> -			   NR_VM_NUMA_EVENT_ITEMS +
> -			   NR_VM_NODE_STAT_ITEMS +
> -			   item];
> -}
> -
>   #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
>   static inline const char *vm_event_name(enum vm_event_item item)
>   {
>   	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>   			   NR_VM_NUMA_EVENT_ITEMS +
>   			   NR_VM_NODE_STAT_ITEMS +
> -			   NR_VM_WRITEBACK_STAT_ITEMS +
> +			   NR_VM_STAT_ITEMS +
>   			   item];
>   }
>   #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 04a1cb6cc636..6f8aa4766f16 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1257,7 +1257,7 @@ const char * const vmstat_text[] = {
>   	"pgdemote_khugepaged",
>   	"nr_memmap",
>   	"nr_memmap_boot",
> -	/* enum writeback_stat_item counters */
> +	/* system-wide enum vm_stat_item counters */
>   	"nr_dirty_threshold",
>   	"nr_dirty_background_threshold",
>   
> @@ -1790,7 +1790,7 @@ static const struct seq_operations zoneinfo_op = {
>   #define NR_VMSTAT_ITEMS (NR_VM_ZONE_STAT_ITEMS + \
>   			 NR_VM_NUMA_EVENT_ITEMS + \
>   			 NR_VM_NODE_STAT_ITEMS + \
> -			 NR_VM_WRITEBACK_STAT_ITEMS + \
> +			 NR_VM_STAT_ITEMS + \
>   			 (IS_ENABLED(CONFIG_VM_EVENT_COUNTERS) ? \
>   			  NR_VM_EVENT_ITEMS : 0))
>   
> @@ -1827,7 +1827,7 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
>   
>   	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
>   			    v + NR_DIRTY_THRESHOLD);
> -	v += NR_VM_WRITEBACK_STAT_ITEMS;
> +	v += NR_VM_STAT_ITEMS;
>   
>   #ifdef CONFIG_VM_EVENT_COUNTERS
>   	all_vm_events(v);

-- 
Cheers,

David / dhildenb

