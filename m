Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9B53BADB5
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622313; cv=none; b=Xoz5VLW/66o5xGdhGKaCD+Z3rDj5J2JJtMgzvb7rDvwKuqkiJhAl0FMVfLLGHJuKX0k80pHhJXj56EN2aTxaHZYHruzmefEj9GbIx0uvIJqovxNAz+Eb6LDywVS5emBNT9EJl8/biqiljHaqRnxfJjqm/SqWR0n+R8F3R+cWMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622313; c=relaxed/simple;
	bh=9v818Ky96X3kKvfhq8lmP5FL0SmE7tB4uBWxn4HqJwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrhO3PikUF5cBvfe8s251ybzJK1ROHGl8+UOu9xBotuBceSFiTC8HWbbf6EsYA4sej7dm0WjWFKvHYT4HrMVEJWtSJKd7dGiVX2vn99iHY0RGKqAlEXx6+y8tLQAC8cCwtg3xWvkhL+y3kEPOme1PelfpnkoIEJnHrjeuG/A1FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpArWJNf; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpArWJNf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-464ba2bb3aeso1279403b6e.1
        for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 07:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774622306; x=1775227106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVAYAgb5FKWZkJuctDg9ra0Rbmkh6Srijd12FXQPO3k=;
        b=QpArWJNfONb3S3BpLt7h3V/ziDV+jQY0wAAtNT3qRUKEOm+Rc0yDQ7UpJZsK1hzvA9
         2MrEy4sPhsz/v3cLvrv3xUNb6Z4yXRnvTofthuqAcBC9Wm2tDJpxtsZDBDs1FOY+fM7J
         o8/msJrTf0NcU/u8z6pHb6m6zSWsZtFB+UlDKQaZQ4nBvYQ/LYoDiKewfNbahB++tqln
         zdYp6eYPJ+jmJEfpImsNGUHepvlTCBUcpfV4SID7CZhEw9J97wj84cotgAsqSbmzXTh6
         ylYu/ARF59DMYGz6HpRL9dxYJU5eCtGGQHznOXD21B8/GsmLn0RckYHlEunFHdRCPGj7
         J/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622306; x=1775227106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVAYAgb5FKWZkJuctDg9ra0Rbmkh6Srijd12FXQPO3k=;
        b=SzQSmKrWzD+PXCr5RtE+szrp8RYr4DkVqQ8U4gzy67GNCJ05uuDkl3+1kBeUjZ2DwG
         D/VLoZA0FCPfkAwZubwlbj7ZntnIqKh2OKPGPmenXKexrRSePeLNc3SbXRQO0JRs+bdY
         lxf3yy+lOy7JB2VqoxNomEtX4IQexUHzzdQqN5sqX5zK5STO+MOHkbRocyJcT6/mzzLM
         ha6hnYEvil5oF9btlS0EYT8AUYDqEr1h/9tOyhD9+/PngXZWJTwyVhZI+Sr6noTtPIhS
         h5rxPR5DusnmYOCn4BDs9PoglYjPUaPvAbZzmLxTeqGkv7+ciYOmKye6Oha/BqRTxhqy
         C/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUOyCrcWrjG3xjmAmd3uxHSbshwyk8YDOrdSqWVx3lp86FUPDDFb+ioyGOBFsn7dvb6efozOGZSwrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRDjGsv9Qe2OTLPxFL2zesRnHBMfuHN5a1YQR64piW/6xhyNOv
	qiZdbtMzCsmZzvB4rBmJJT0T899Eae79RIJf1EF1uO8gKRgGiwhHtJI1
X-Gm-Gg: ATEYQzw31CoGavEgFBqj9dw+lEDPAkjZ0aIQfKx1RRiyQilIILem7a104ZiBP+BQgsm
	90mF71/6EZtjc9aghyo3HXt2ON1LVY0/WVNzzkTmRAGvXCC487b3gQC9HE6L7EFg9rhjrcQ0PGa
	NllVZ00PbZ5Q5+tXiJ9/2xaTY2NycUY/YaBF/W90wvrQmY4GEyTM+jFd2XMwZ8p2tmR0/Ha1H+f
	k4MtRL9/wOm/pM3xyAKTgS87czQFuXfy7DujnpdWnYaschANccR7gDNbU28wS1MEx16tLZ79Bsx
	RhlKp2K4mtCAjmehNRfn7URIYvV6MdZGNOF7vxzfKN4XMXDrzThCo1wjBMi52+SC97hWaoLRVja
	idacno2/74Abt3hQ2hSiEve8h+TK/kiMRuB8CJI85YZLonTW38ZxRQcdOhgZRE/QEaXQKd9sQqM
	+ScWZnDz80FlNcuHDROcUqSQ==
X-Received: by 2002:a05:6808:1918:b0:45c:85fa:5a3e with SMTP id 5614622812f47-46a7aa021d9mr2688406b6e.25.1774622306023;
        Fri, 27 Mar 2026 07:38:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d9e71f5abdsm4847756a34.13.2026.03.27.07.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:38:25 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Hao Li <hao.li@linux.dev>
Cc: david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during hotplug
Date: Fri, 27 Mar 2026 07:38:23 -0700
Message-ID: <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327124412.469833-1-hao.li@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 20:42:47 +0800 Hao Li <hao.li@linux.dev> wrote:

Hello Hao,

I hope you are doing well, thank you for the patch!

> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> hotplug currently only updates N_MEMORY. As a result, a node that gains
> normal memory via hotplug can remain invisible to users iterating over
> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> incorrectly marked as such.

The second part feels more important than the second part, doing a quick
glance through the code I can see a few N_NORMAL_MEMORY iterators that
are in some hot paths like shrink_memcg. Iterating over nodes that don't
contain any NORMAL memory seems like an inefficiency rather than a bug
though. 

> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> offline_pages(). Set the bit when a node that currently lacks normal
> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> offlining removes the last present pages from zones <= ZONE_NORMAL.
> 
> This restores the intended semantics without bringing back the old
> status_change_nid_normal notifier plumbing which was removed in
> 8d2882a8edb8.
> 
> Current users that benefit include list_lru, zswap, nfsd filecache,
> hugetlb_cgroup, and has_normal_memory sysfs reporting.
> 
> Signed-off-by: Hao Li <hao.li@linux.dev>
> ---
> 
> This patch also prepares for a subsequent SLUB change that makes
> can_free_to_pcs() rely on N_NORMAL_MEMORY to decide whether an object can be
> freed to the sheaf.
> 
> ---
>  mm/memory_hotplug.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index bc805029da51..5498744aa1f1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1155,6 +1155,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>  	int need_zonelists_rebuild = 0;
>  	unsigned long flags;
>  	int ret;
> +	bool need_set_normal_memory = false;
>  
>  	/*
>  	 * {on,off}lining is constrained to full memory sections (or more
> @@ -1180,6 +1181,9 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>  		if (ret)
>  			goto failed_addition;
>  	}
> +	/* Adding normal memory to the node for the first time */
> +	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> +		need_set_normal_memory = true;
>  
>  	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
>  	ret = notifier_to_errno(ret);
> @@ -1209,6 +1213,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>  
>  	if (node_arg.nid >= 0)
>  		node_set_state(nid, N_MEMORY);
> +	if (need_set_normal_memory)
> +		node_set_state(nid, N_NORMAL_MEMORY);
>  	if (need_zonelists_rebuild)
>  		build_all_zonelists(NULL);

Do we need the flag here? As far as I can tell, we can just skip this and just
directly check whether this is the first normal memory we are adding to the
node here and set the bit. Then we can remove the flag and the extraneous
check. We won't do any notifier work so I think it should be OK.

> @@ -1908,6 +1914,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	unsigned long flags;
>  	char *reason;
>  	int ret;
> +	bool need_clear_normal_memory = false;
> +	unsigned long node_normal_pages = 0;
> +	enum zone_type zt;
>  
>  	/*
>  	 * {on,off}lining is constrained to full memory sections (or more
> @@ -1977,6 +1986,13 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  			goto failed_removal_isolated;
>  		}
>  	}
> +	/*
> +	 * Check whether this operation removes the node's last normal memory.
> +	 */
> +	for (zt = 0; zt <= ZONE_NORMAL; zt++)
> +		node_normal_pages += pgdat->node_zones[zt].present_pages;
> +	if (nr_pages >= node_normal_pages && zone_idx(zone) <= ZONE_NORMAL)
> +		need_clear_normal_memory = true;
>  
>  	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
>  	ret = notifier_to_errno(ret);
> @@ -2055,6 +2071,12 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	/* reinitialise watermarks and update pcp limits */
>  	init_per_zone_wmark_min();

Same here, couldn't we just iterate through the paegs here and accumulate
node_normal_pages and clear the memory here? We can get rid of the bool and
also keep node_normal_pages defined inside an if (zone_idx(zone) <= ZONE_NORMAL)
check as well. 

> +	/*
> +	 * Clear N_NORMAL_MEMORY first to avoid the transient state
> +	 * "!N_MEMORY && N_NORMAL_MEMORY".
> +	 */
> +	if (need_clear_normal_memory)
> +		node_clear_state(node, N_NORMAL_MEMORY);
>  	/*
>  	 * Make sure to mark the node as memory-less before rebuilding the zone
>  	 * list. Otherwise this node would still appear in the fallback lists.
> -- 
> 2.50.1
> 
> 

Thank you for the patch. The rest looks good to me! Have a great day : -)
Joshua
