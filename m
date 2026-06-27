Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24F91D5CD1
	for <linux-cxl@vger.kernel.org>; Sat, 27 Jun 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782548640; cv=none; b=rT/xlpePG115eYbQae9I7msHXvM0fQyEiPIug3x4GxgEMOiTE0cd/iUcIr4Cjm38SyQ9MjYrGyhaPVFWIU3UVBMPFv3Q/qBtSj7EK/VDWESy0DtMXuuxPJNHhMED6umwJe+fMJV96F7Bn3bjslw9+Jx5lsxn9Uldmv5cTEzSteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782548640; c=relaxed/simple;
	bh=pHyJuhYl/jaNnPl2SnkFl+8Jum7fL0oJDja08WRHig4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2p5iME+ZsSh7dC7BRKhLIPpyN3ysDtTFTzcJVNn2++FAAH9YLljIEqgAJyIZo4q2KmZ1CAhcKTezqPfpnaS0qWjpFyAQHoiYlUNaSTzNuAKrGV9to/MRQprKMkwey3F5OAHk5vdLKj3owuT/iqAJ1n6AoTKz0DII8OlfNy3i94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=H0gmiNq9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="H0gmiNq9"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92120eb916aso183576585a.1
        for <linux-cxl@vger.kernel.org>; Sat, 27 Jun 2026 01:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782548638; x=1783153438; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qcCGwXLwtMV8RI4Wg+2Z1TCVKqOFak4eb3FLVCz7QhM=;
        b=H0gmiNq9AqOzXQOuybjVrCS0AKwAZb5Jqy+zMpxbmye02eq4Z8XXqpfaGCq9/ZX4Ei
         j+nrZlQJG0fU54EudXDJ6UGxCHG+CVViqhcDa691/nae0XsboPhYRqmFbOE+LwAqx1aR
         MSpd01uUr/2w4Y131lwNGqT3PXh6XfezPAhsjgEjh/cHvYSOtjbX7M+r7hOuhccEt2Mw
         icWwrdGQFol8w8fLemh+IuIUgANtMJgrr2i+NhbSDYjBnPZK3TdeC+pd+9SE5Fbcpwq3
         GzMTl0aHPk9jPBpX0hWStkHZOaadWWKU26ePs/CaXZXXY/N1NJ5nwu+iv5J/U0A8mCV3
         /BNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782548638; x=1783153438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcCGwXLwtMV8RI4Wg+2Z1TCVKqOFak4eb3FLVCz7QhM=;
        b=HZmrD6RIBa+whl52UdvAgOq+awYzRqZa7gNUkqcIO5V47CtLx/Bv9SK+8o5DavHj3S
         uhB0i8lHU16jmgKescj9tJVaUpM4VqsDLthHLl+dK2yhjekSkNau8kpe1xUVd4w93ran
         s0FPdwetVYwPksn9fFa4MheQxPd2aRPMpyjJ0knaDzxrpItH+PLQn2DKaJbZFmwRYv0A
         QXW52sUaBDf+cq1AXUvqiLZYT0dqZmLicXwhyvFJrsKeB6aHztvAbeFkEfgkoCvOz9AV
         Ul71ELHWQcAOkGU9ZH9w0PJLDZCPsulCkf2y6s6xe4qKU8Lq1oIb9t+I81gzD2uslYLI
         dS+A==
X-Forwarded-Encrypted: i=1; AFNElJ8k5BM+f2cy8gohKJBJQOGU28vPWWqzErDAFcdpG1EX5M/rWUPfxcJcMOqnVICFSgLEl59jDkJf4+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIe/XF+MNyCLJBvg3TPhCH9ko32/8p2+NqWcsivOqcj0DDzHnA
	Rwf0deRL3t1RulxrcyWqL8sUyI8PCPbvGoDHMwG9Zx7HYuAAoLDoEpnsWLkdKNcnrPg=
X-Gm-Gg: AfdE7cm9QdAbWXx4kQMmPrPvcpCzISEA/b+zeGkO17udNl4InLlrpU0nQ85viffSog4
	tJquxl/lGhb8HJhQU8Wb9rU+FLHFMaVxtzwJa01LEPlnA+z110D7RpBiv0dBW3Kweb9cJu+j26X
	8Lt72ENEZtwq88ryUWUek3QgTwb/Quh+YlKcxWXHvZpildRlxD89TYdo4GChr9BKrsd6ayYRxHD
	oTj1TOfEYoOfPwTJJIFEmKSQPqx37G+Q5a3DsPZ3fqoksIJTOg1/4msxF0jl7CZJEH3fuyM8rY6
	2ZodO/Z40GHvIaJUc4lSWGX8InRIa2jmoZmToaxi/bJpE98VypPRwJ3+Td2xmrhHUxt+Drhpeyr
	K2Uyp4JQGZ8QAZeG7iayBhKFjAxCHwptXl7SREDt2usG9JaqmHDapupAKHNtD1YnPvhfl2Gsvy4
	r70aMrlY8wsNK+KSoZrqEkYriuQy8ZAvLcQna0jtrcRzCz2aE4jii1J8pctua1iyI4Icr2JJQGR
	YU9euA=
X-Received: by 2002:a05:620a:28d3:b0:915:f163:a8 with SMTP id af79cd13be357-9293d0ba9a5mr1471270785a.53.1782548637840;
        Sat, 27 Jun 2026 01:23:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-926004ac1b8sm1375302685a.36.2026.06.27.01.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 01:23:56 -0700 (PDT)
Date: Sat, 27 Jun 2026 04:23:52 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, akpm@linux-foundation.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, hannes@cmpxchg.org, mgorman@techsingularity.net,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/vmstat: flush per-cpu node stats when a node goes
 offline
Message-ID: <aj-ImLdFnKk7K6Fc@gourry-fedora-PF4VCD3F>
References: <20260627073107.523499-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627073107.523499-1-gourry@gourry.net>

On Sat, Jun 27, 2026 at 03:31:07AM -0400, Gregory Price wrote:
>  
>  	/*
>  	 * all memory/cpu of this node are removed, we can offline this
> -	 * node now.
> +	 * node now.  Fold any pending per-cpu vmstat diffs into the global
> +	 * counters first: once the node leaves the online set the periodic
> +	 * fold skips it, orphaning the residual on a later online.
>  	 */
> +	sync_vm_stats();

Sashiko points out this can deadlock on concurrent cpu hotplug, which
after a quick look seems accurate.

Has also made me realize the sync code is also racy with cpu hotplug
as well as it iterates per-online-cpu.

There are probably more races like this out there.

Will need to give this a little more thought.

>  	node_set_offline(nid);
>  	unregister_node(nid);
>  }
