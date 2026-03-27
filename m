Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76396344046
	for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 16:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629359; cv=none; b=c9ZCPxhoYbi40+CCd1/B7hQ7clngxmrIQI494D5ggI/E/Xj8n1SGXgmvWRDZ2Ip+9R/qNY2ercvVbjmmOgEdnu0NPYCiiqNLSYl0u9UILwePlc6Gn8LKBvEhqGb4khidtxrMeOE7i17pLUFLU+k2ee2D2RzGGhKJxPG6WWvDzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629359; c=relaxed/simple;
	bh=JP6d7rerXcP3iNyYWzVvAQPGzzNSa0eOrrJVazTTkk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKzo88fAj6R4j1Y7684Gqb0Q8YfJVLgRQAszBJ8FqOhj5xmR64cK8Hf3b30iDNOVe1KrtK3ytYKNfTtMB6sf1asl0h4UVN3xHFpBDOczBsYiigjcAKQ5OVoUqz60uvkr3F4Cl0BXbQIUirRzXB8NXVfOgUBH3GogXZdr8/SyixU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvqOTXMg; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvqOTXMg"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4138136f02eso1503365fac.2
        for <linux-cxl@vger.kernel.org>; Fri, 27 Mar 2026 09:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774629357; x=1775234157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cggqE8m4apbWV5U3IAU0wJMWI3EIoJebO/B0glalUlg=;
        b=mvqOTXMg+vp89eZpF+9u96mb0AIt6CBs4J/qGZ4Gj5cOkkg5cao/zmaj3W/zZYbLAJ
         ovcxght/wA9hW4qIB+AIYsNnv74HWZahJQ6R624l6OxjYSmVWcrZfBsU26jwNfB3SGGG
         wIyz8iBXU8kuCO8J5ULI8JXBqCoB/ObvTgfc8zdA7eOelHYgyMs+b5ElIuvH32z/zpgX
         qWbH9Za8ZuCd01l/ChZnMRASYMotaCciB5LHBxu2pDor1vDMO3T7JaA/T2Lrvea9gmLK
         6Z8+GZ3AWO5iJErCi+NhKgmZ2mNDscTNHxJEOYYcJVHePsQybElVs1w4/ftVEzTSln0I
         h6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629357; x=1775234157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cggqE8m4apbWV5U3IAU0wJMWI3EIoJebO/B0glalUlg=;
        b=D9F72BSY3hol0xqD83j20vnN+I1yfI/E8Td9Aceoob7vOuJGIak1lWOsk0gzpGUDqP
         OenevRnaEvf9UY5AOlSXsOaa1MymROtN1NWczQ+gsIMI8NRUhxze+mTKc+72DeHvnBbH
         AmNcXYsPYMvV2ZBvDTURIKbEZAHa+DU+m5JLyPzAoeYEfb7oW54Da6hpJ/YpLtmowCdN
         SWqM3jLgAZVsei8cR653UKqGt0mDWaRxWbEsOo7a7+r6MZWj5k8Tl1Cpf4laRrB7ZupO
         byJVJqM3LMPOVRj5slv1m2lGFnV3bP2jPQQO+n3mdjRAwVtQVf9wgFHczj+NMOXl/pDH
         9drA==
X-Forwarded-Encrypted: i=1; AJvYcCVeP/4LuYCGfaW9LCbSHrWsJOaIcW0yDyaaebLtt3tyw3ATBqeBFxj4jADkzngMxmyLq4QBfW21HC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPcWK6E4FuKXkTmH1p2G2DrTcuqmUBLC51NHn7lhZ8Pj7xJvEp
	Qi+vQWM4ZGVACfZo0JHN76Zf7qhxRA5jMpfy9aKuqwopCiWbWR5mqJ5Z
X-Gm-Gg: ATEYQzyuFPOtA1cwS8TwmUVZ+hq+ZjJ0yUUsBYxLsuUODBXKn7YF9wWi7gTKo96o34U
	2yxM7o2ZvMvNHs7uDcqZCsQhbbtksFMK/dpe3a2YZUagbs9O1Z6qxKM9Bs9H9nKV/RuadTPFPAH
	4CYVBjrvFnBaQwGA7bB/DoAuNUUnCqffFm6KDgjDjbEl0CJDQ4/iwMEjva+zqlDkHHWm64efF9/
	NRQQb1ClJoWolIbicNQwBp1N9mlSb/Js/d6iWiXstR/8D433U2hsK2GivAbu+6Z5+Ak4hFg0ZI7
	49ECnUT0DvIjzRufDJJveKyAI2pjIAF9Z8Xc6kJAtMPaoCOO9NmqOAj2BkUmgEzyFaKk+rcz8Mk
	RNoOWahWsmwDNRldhZ88t/dHIrMdTyRHmpikT7T4XvrUSwa6FTEHBba1VNgCbfgyWdmt36HYlUL
	N81bPD3VPAyquJSKfSwVQbwg==
X-Received: by 2002:a05:6870:1799:b0:41c:1bc2:d219 with SMTP id 586e51a60fabf-41cec35946emr1519816fac.37.1774629357141;
        Fri, 27 Mar 2026 09:35:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41cc775b12dsm5303329fac.3.2026.03.27.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:35:56 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Hao Li <hao.li@linux.dev>,
	david@kernel.org,
	osalvador@suse.de,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	harry.yoo@oracle.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during hotplug
Date: Fri, 27 Mar 2026 09:35:54 -0700
Message-ID: <20260327163554.42487-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2356614e-d9b8-4639-8e2a-96c5e4eaef61@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Mar 2026 15:44:18 +0100 "Vlastimil Babka (SUSE)" <vbabka@kernel.org> wrote:

> On 3/27/26 15:38, Joshua Hahn wrote:
> > On Fri, 27 Mar 2026 20:42:47 +0800 Hao Li <hao.li@linux.dev> wrote:
> > 
> > Hello Hao,
> > 
> > I hope you are doing well, thank you for the patch!
> > 
> >> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> >> hotplug currently only updates N_MEMORY. As a result, a node that gains
> >> normal memory via hotplug can remain invisible to users iterating over
> >> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> >> incorrectly marked as such.
> > 
> > The second part feels more important than the second part, doing a quick
> > glance through the code I can see a few N_NORMAL_MEMORY iterators that
> 
> Note in practice it's unlikely that a node would hotplug normal memory,
> start using it, and then manage to successfully hotremove it, due to
> unmovable allocations. Most likely only ZONE_MOVABLE memory can get hotremoved.

Hello Vlastimil! I hope you are doing well.

Yup, makes sense : -)

> > are in some hot paths like shrink_memcg. Iterating over nodes that don't
> > contain any NORMAL memory seems like an inefficiency rather than a bug
> > though. 
> 
> Ignoring nodes that have normal memory, just because it was hotplugged, will
> result also just in some form of inefficiency, or can the consequences be worse?

Aaaahh yeah, seems like ignoring the hotplugged normal memory would be a bigger
problem. struct zswap_entries allocated from slab allocator on hotplugged
nodes would just get ignored by shrink_memcg, seems like a much bigger
issue than iterating through extra nodes :P thanks for calling this out.

> >> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> >> offline_pages(). Set the bit when a node that currently lacks normal
> >> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> >> offlining removes the last present pages from zones <= ZONE_NORMAL.
> >> 
> >> This restores the intended semantics without bringing back the old
> >> status_change_nid_normal notifier plumbing which was removed in
> >> 8d2882a8edb8.
> 
> But commit 8d2882a8edb8 didn't introduce the current state, or did it?

I don't mean to speak on Hao's behalf, but as far as I can tell I think this
would have been the commit to introduce the state, since 
node_states_check_changes_online would set status_change_nid_normal to nid,
then nodes_states_set_node would come around and set it to N_NORMAL_MEMORY.
Maybe I'm missing something? :0

Thanks for the reply, Vlastimil. I hope you have a great day : -)
Joshua
