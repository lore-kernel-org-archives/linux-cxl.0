Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F7158529
	for <linux-cxl@vger.kernel.org>; Sun, 11 Aug 2024 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723407881; cv=none; b=X9gOLEdDQNNw0Ll7TqqjgJpHXbkhxAL8Ck3BARufqrRo6BMrJRFRO5Pw2lnvx/IjVJ0PblpENlGaRtaCS3o1fy6wP4wif/6AjSbm5/8d6jxnJZGlkv7FUkeJF3yLoB+s8mpgjV0geE0bQYAIorJqp8wnguY3YBS2/F8iTCBrqZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723407881; c=relaxed/simple;
	bh=NR3Z0pjn4i+rt/jR8LWQ5i7uytcs2FhjP3WxSDuK8D8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gHF7ebrLrgY8wGUIVqyPgatm/w+scUOvk9qWIqj3Fm6AA+VM92+OR0pwnNHaFVXkqSlG0YhZjmZdEL+PhYHQrHwPquPiDr/ElGWzhoJZnXg+4qRHOaUMtVSOUsoO1CiVwPPHZrlWhtb3ENL+Mz+ogNFFmtSi+x0P8QpYp9VgQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oDCCC5Lr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oDCCC5Lr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fed726aefcso175035ad.1
        for <linux-cxl@vger.kernel.org>; Sun, 11 Aug 2024 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723407879; x=1724012679; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QuYp6e/IcFOWO1Lvs+4x5nSa6kYnIOk0v8u1g+wL6ko=;
        b=oDCCC5Lra587rPVs6Pe+17nhNtUq7zhDyIci+fck5rncyQ2s618l6fHLH9gUV6anBu
         VWtDpnRbqHskrRyhu/iBU2eBATz8VN4mzH5I4o9yuddIL1QWznhHNGsRMAfI00QqogzJ
         3gNYKUQ56izeOX6nxJ5sCrFK4MyN98v7XlrshKgO5o3u9GTuAONRY4gliEu1DnXzeMDv
         cIif2AD0WLPF6kAyvN9cT7PE+x927yHWIGO7Zui9gHqBDyMKK/YGptT4xYknlzQLnHft
         cBVwGbnyQlv9w1IF0lScLW2eww5cPe59nsVnRC1QvlMNUculI1n3H67ONcZKt1dC/eiw
         cH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723407879; x=1724012679;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuYp6e/IcFOWO1Lvs+4x5nSa6kYnIOk0v8u1g+wL6ko=;
        b=iJqXSiL2HbjoyMMcwU/fteFXCA3MC7Uh98rih3xisQa0sm/D0pjw3jCCir31L/AAh4
         rgbEtLPdgPBniZZUX0Y3dno+kV75vVycZq0ROIwVj0MH7Z6Oyckuof0b73EvoQOrCQvG
         tUOyee1BsRoIufJfpDCoSp8a/Tu6m1GjasniJLcV2ixh0mtvTovTAGqZER/nfuLpkMv0
         aN6esp5Cp8o9Pc6o2Vty4Uv33yMy07cXCVcFbhdn/hsPwgRNHXDYFpzIEMo5sWd3z0rc
         xE7MhEimGKqVVOippYMJitpPmOfrC8s1UBWFFw4MyK/+LbSitdCSTUJNoGE02WSls7ID
         ILEA==
X-Forwarded-Encrypted: i=1; AJvYcCXf13REg2Lt44CqCqZYqJeS/cmq7gqsF8ehwuX2KNBv+V4pbKyYkSa8cnuMdm6mwe76Sf+s4GGmvziTEPbGTa6ls0U8SBb9H1Xo
X-Gm-Message-State: AOJu0YxysplM5gvHpYRuZRLNbznpHFZzYE8uscIRmNFGAlP64/8/IKt2
	qoUS/oqckW/RoGw8nxC43k0TGgbb7y7D8RPnIkVWVJfS/ct7MVLNZEDeohy5Zw==
X-Google-Smtp-Source: AGHT+IFA63r/xxYc2IBbgbRXl9jp8YQNn3yBx5+fTkInBrjtUZ5WM9pYaba539QHJ3AIkKLBBdIiGg==
X-Received: by 2002:a17:902:f54d:b0:1ff:1cf5:491b with SMTP id d9443c01a7336-200bb7e0202mr3505935ad.0.1723407878857;
        Sun, 11 Aug 2024 13:24:38 -0700 (PDT)
Received: from [2620:0:1008:15:49ba:9fa:21c6:8a73] ([2620:0:1008:15:49ba:9fa:21c6:8a73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a8d462sm2709760b3a.169.2024.08.11.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 13:24:37 -0700 (PDT)
Date: Sun, 11 Aug 2024 13:24:37 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
    hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
    muchun.song@linux.dev, nphamcs@gmail.com, rppt@kernel.org, 
    souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
    dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
    david@redhat.com, yosryahmed@google.com
Subject: Re: [PATCH v5 2/3] mm: add system wide stats items category
In-Reply-To: <20240809191020.1142142-3-pasha.tatashin@soleen.com>
Message-ID: <d5face34-4972-228c-3c6d-ae9ebe3be1e1@google.com>
References: <20240809191020.1142142-1-pasha.tatashin@soleen.com> <20240809191020.1142142-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 9 Aug 2024, Pasha Tatashin wrote:

> /proc/vmstat contains events and stats, events can only grow, but stats
> can grow and shrink.
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
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: David Rientjes <rientjes@google.com>
