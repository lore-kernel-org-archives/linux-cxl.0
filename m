Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D8157A7C
	for <linux-cxl@vger.kernel.org>; Sun, 11 Aug 2024 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407982; cv=none; b=RHkkMV1rks4plv5dxG9OKTn4jqAFtZP2b2h8hrGRef8JFd0yZyLLcnwafh8ocGZ3kuoMazqnKwhTcoQp6nFHXuQP4IC3isiiFZrp9KMoHmnXG3VAeQD2jmenFJu2MU6kTtvNrD95uZibuGepRasMbSuO6CbvULGD90y2zxUcWv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407982; c=relaxed/simple;
	bh=L5nlxNBJPsreEVgJgyQlqBxEu2DIYkxEXAYEgjfTBIc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mOnXhojR8xYbTBV4SMD5N7eae0hngElO3EoI5cb0A8JBpTsLuJEiyXffSkzwelnU+aZXyxRf2plUXSzCxhsFnueMn2Xhk4EO2K3CrPXHolYIxH0aPI6nVUgaWEvoqOM66/ejYZRfbLEVY0sefonDR2/F+MlradVKV+SrvrVF/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZ1oEPkI; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZ1oEPkI"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39c3bf0584cso75735ab.1
        for <linux-cxl@vger.kernel.org>; Sun, 11 Aug 2024 13:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407979; x=1724012779; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlExk0c05J5NkENFEJVDSS8e9y+ZVkGFZx53tZxGePI=;
        b=LZ1oEPkIOcWRPtd5vDjrlq+H4qN5xAgABcGmZzyQc7oqwYrhtnX+cFlxsONj9ApLsI
         PvJpqFIofN6Y2RKflKq6IMtT5rUrMUZEKsQxf4ysZVlGeV0O4YXb5vKcg1OKpDht8fgH
         BdrfeuYR9ipXM0c2Jeam2FV4TNGFKE6J8ojh7A2fsAaaaa4qzaR8GfiR3MP7kKgeiwpN
         NPxMuBqbnxydQwNOTPnjM6YZb+QMHEKwdmUx4QNY6KqVt7NHG0Sm67U4NqF2ahViO2Nc
         JfYo94S4jp+m9318OOpgywFt4gXYEgF1qRs/fVQazkWYkhwp30/B8q08D9lb9nHJ71Th
         Vz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407979; x=1724012779;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlExk0c05J5NkENFEJVDSS8e9y+ZVkGFZx53tZxGePI=;
        b=FGTQAfZB07ufKrQE3fo8tZTUQsCiqchWkLgadVzzPMeIS7WK1qzPfgbm6Jbq8NRDx9
         SSUz4eKwgsOwBBDKibZx6l/TE7Bd+9H96jbMBolt0ZzhUk22jIobhOuRYd4G39n3RlKX
         lVt6nmQ46PzWWw58x22n7d0aFEx3W1G8e4PY8M9y+A/TKC8OXZdg3iVWZUUO3eJkPQ/m
         5bCJNdVbCCpvUPji701WGzBgM15VCdAO+ZyQCx8J3fKHnwJ0ElYmtqstURlM9tFKSb1V
         tUgPcfezhXAx3bBOTaFl4yGdupCpfn4KI/0JQqfIl97Nqtt3KxVa5KfGwPTMoFYAyapw
         Cy1g==
X-Forwarded-Encrypted: i=1; AJvYcCV56iu9jndNUVcOtzSbWShCVPVCDHYObhlt5ycm8vJqwjZOSe4fe0HMsfXCOuf5fuLSah1EOhWGMEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgiGgxJuwP0KOzpl5cyep/Ne5XF5Cv8bLVB9ugH7k8wECwa1N
	98quS9aLRWmMYWSff5ICY0JhnBmucNX4RNCHNyq/JWsKsgvdy0kEHQ6sD56K4Q==
X-Google-Smtp-Source: AGHT+IFNQ0p46pnP6bxX/WTrVF/mvF4EBfHhnSN4CI+EuUQ20mscDwAHHXkGESoFnpmkjNh2iN6wIQ==
X-Received: by 2002:a05:6e02:1ca4:b0:39b:b1f:5be1 with SMTP id e9e14a558f8ab-39c3140c826mr3120085ab.1.1723407978557;
        Sun, 11 Aug 2024 13:26:18 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe04bd8sm2895240a12.19.2024.08.11.13.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:26:17 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:26:17 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
    hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
    muchun.song@linux.dev, nphamcs@gmail.com, rppt@kernel.org, 
    souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
    dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
    david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v5 3/3] mm: don't account memmap per-node
In-Reply-To: <20240809191020.1142142-4-pasha.tatashin@soleen.com>
Message-ID: <d28059a0-25af-6d0c-3f6d-7e7bc208a0da@google.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com> <20240809191020.1142142-4-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Pasha Tatashin wrote:

> Fix invalid access to pgdat during hot-remove operation:
> ndctl users reported a GPF when trying to destroy a namespace:
> $ ndctl destroy-namespace all -r all -f
>  Segmentation fault
>  dmesg:
>  Oops: general protection fault, probably for
>  non-canonical address 0xdffffc0000005650: 0000 [#1] PREEMPT SMP KASAN
>  PTI
>  KASAN: probably user-memory-access in range
>  [0x000000000002b280-0x000000000002b287]
>  CPU: 26 UID: 0 PID: 1868 Comm: ndctl Not tainted 6.11.0-rc1 #1
>  Hardware name: Dell Inc. PowerEdge R640/08HT8T, BIOS
>  2.20.1 09/13/2023
>  RIP: 0010:mod_node_page_state+0x2a/0x110
> 
> cxl-test users report a GPF when trying to unload the test module:
> $ modrpobe -r cxl-test
>  dmesg
>  BUG: unable to handle page fault for address: 0000000000004200
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 0 UID: 0 PID: 1076 Comm: modprobe Tainted: G O N 6.11.0-rc1 #197
>  Tainted: [O]=OOT_MODULE, [N]=TEST
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/15
>  RIP: 0010:mod_node_page_state+0x6/0x90
> 
> Currently, when memory is hot-plugged or hot-removed the accounting is
> done based on the assumption that memmap is allocated from the same node
> as the hot-plugged/hot-removed memory, which is not always the case.
> 
> In addition, there are challenges with keeping the node id of the memory
> that is being remove to the time when memmap accounting is actually
> performed: since this is done after remove_pfn_range_from_zone(), and
> also after remove_memory_block_devices(). Meaning that we cannot use
> pgdat nor walking though memblocks to get the nid.
> 
> Given all of that, account the memmap overhead system wide instead.
> 
> For this we are going to be using global atomic counters, but given that
> memmap size is rarely modified, and normally is only modified either
> during early boot when there is only one CPU, or under a hotplug global
> mutex lock, therefore there is no need for per-cpu optimizations.
> 
> Also, while we are here rename nr_memmap to nr_memmap_pages, and
> nr_memmap_boot to nr_memmap_boot_pages to be self explanatory that the
> units are in page count.
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/linux-cxl/CAHj4cs9Ax1=CoJkgBGP_+sNu6-6=6v=_L-ZBZY0bVLD3wUWZQg@mail.gmail.com
> Reported-by: Alison Schofield <alison.schofield@intel.com>
> Closes: https://lore.kernel.org/linux-mm/Zq0tPd2h6alFz8XF@aschofie-mobl2/#t
> 
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Alison Schofield <alison.schofield@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
