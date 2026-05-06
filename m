Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8794534B2
	for <linux-cxl@vger.kernel.org>; Wed,  6 May 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078632; cv=none; b=E+JmrcfBVMhEzPK3hBq9tArs0zWHZsKQnOegdO+eXg/tFbix1nPa/PvydEM3RDVMig9Iw//oCO0GqvWfN44ZsK4Y80Y1/zLDZje2kQ+on0mV9XSKAALo/Nw3PNKRuU4W3D2pHDvSVrNHem/mEmx7+vhrqk+w7XojnAm+TPeB2/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078632; c=relaxed/simple;
	bh=8rYhAkFOKY6K/j1/wpxkQvi3y7Z+5CCbQC0nxatTUIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVH6q0/3xED/ld39HZ3+asuqJS+FjV5cJ9ilTf3/MWPAx2Caq3GunSX2NuG0gSPN9d5oo8tj03DekeEMXiwJxC00hqSxHbVjmMOP6U30GvgkjVVEOZicDHGPxjwTQc7LPVeolqk9XSiQFdhhqhcpoCptzsMwKBBBH8qp3lfmJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tseGfhns; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tseGfhns"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44b052142e1so2824388f8f.1
        for <linux-cxl@vger.kernel.org>; Wed, 06 May 2026 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1778078629; x=1778683429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=tseGfhns4w+9L4TQ8ZT857uRRltMFzAQPmLZhCRY+EGmJq0t6AvhRuFIS2LcdgEwPw
         IWWfpzomqpb0AW+jcMqK3qZCRTT8gRjmbviSTyqQ9dMYRHQFRW81+DujnCHOO82yJrHH
         A7OG/wPvOgIRDnKkRY3WkOYZb6YW3Z4q0qxKjyamqlQJHbSw+MaIKDosfAiIEjx3/L36
         ca3De28TBjvihOBZqV3zY6GzNWXzsQYt7aLjFeVdNuIBq9wBxCiI0VNz/TLwO9dtHXlE
         gwXigjF6RVNMwLpkFJ53l9nzqb/23+nhDiUX5xhcdKIgKb31heeP4FOx84OfNNVTOGQi
         2rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778078629; x=1778683429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yrKfSuIFibBSjAR8E2oWzOhR6JQ9Zhv+MqRJc3mpQs=;
        b=g3jovP/C8JK2v8XCwr7HSvL3aWs8ZVIkwBLLVRV09mvOUq9HHzkyG8JVO9AqTanBLb
         gYoDIo+hONcrlJ9q0n4E/MrABFCXk8xNuo9McYjxju2ZgLWs3oY/gdnyxIni5oqZBptC
         idzDKJXbU7ic2ddgrPCxanodYLnSlcW6oybRakTEud397WI5YXY/hmJL8XKfcMTNq7S0
         IfxXTM1c9shsAgL3qbDJWroZsKniJ7r0QqvZUCj6AjtveluP9Dt4SUVNXbYzwTKAgpW/
         Cs2TDKFxjbIwHVEK5CWDsygutXT9nlyVmYSzlZ6TTPeVbINWdqM2SVdpFdbVj4OzOT+V
         ysLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C9hflGXygfaFy6yd+CjSzMWPoJMhPeziTQqE0Bmmb23WEDya9fuGnnQOGzL0qpmNwXWjiAVwmOhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ZMLVupPS6pFAJfwi5eq57nMJ9kA7CSwyqwM3D5C95bp5Rxls
	QOiYE513+Z9UuS69jEb466ugVFd1hjqnJ1Ye24M9BKysJniI4qvLujh5eKTPElUrUh8=
X-Gm-Gg: AeBDieuBidNZCk74MyX+Ek/KqaJkJXqO56n2nJ+9hSKxuJtDmY9DlX72g+0ja21Tbnj
	TrwAWMlLvXG4Lpmit2B/66i0x2CIevYZV+bl+nrwi2YuldzOp0XE7wIsIA62aDaBGxdtwWaZT4g
	pA54iwwTH59nLNAlzzgeMHj5BT7dUX46bVH7qSnWPDS9as9x8+UO1aGLl5YK216AiMysZC6p5/n
	3A4BmrJB5NMbmqo5RnnTQZ7K27WVQ1hu4MH3mQGHchCN2ylqaFQPiD3tbsYntF6Eq2R5j1m4/Dj
	Rd+26scPbKoaRNFpvNbO/MCdK9PEwiXPrGr7nMSH4eIqy1792XLJLeVOeUbACr+n0ma31VAhLZj
	T1Syvg4ITkGc46A1xWqNZuXgg7wz3Xu4NtzQluHA69soM0Q0ei58+Jpe6b0hUnXIb7pRE6hBqC5
	M1lENY5QXv/cEQW9YAhWVqmf6S+zv9y3juzTzNzDTUHbOrTw==
X-Received: by 2002:a05:6000:3106:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-4515b524457mr6633850f8f.11.1778078628705;
        Wed, 06 May 2026 07:43:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([185.194.185.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960fd6sm13732451f8f.31.2026.05.06.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:43:47 -0700 (PDT)
Date: Wed, 6 May 2026 15:43:35 +0100
From: Gregory Price <gourry@gourry.net>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev, kernel-team@meta.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	yury.norov@gmail.com, linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, muchun.song@linux.dev, xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev, jannh@google.com, linmiaohe@huawei.com,
	nao.horiguchi@gmail.com, pfalcato@suse.de, rientjes@google.com,
	shakeel.butt@linux.dev, riel@surriel.com, harry.yoo@oracle.com,
	cl@gentwo.org, roman.gushchin@linux.dev, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, zhengqi.arch@bytedance.com, terry.bowman@amd.com
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <aftTlyHYNr0B9yL3@gourry-fedora-PF4VCD3F>
References: <20260222084842.1824063-1-gourry@gourry.net>
 <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b704b05e-3e65-4a73-84c0-21557b0cc38f@amd.com>

On Wed, Feb 25, 2026 at 12:40:09PM +0000, Alejandro Lucero Palau wrote:
> 
> I can see the nid param is just a "preferred nid" with alloc pages. Using
> __GFP_PRIVATE will restrict the allocation to private nodes but I think the
> idea here is:
> 
> 
> 1) I own this node
> 
> 2) Do not give me memory from another private node but from mine.
> 
> 

I mildly mis-read this question, apologies.

Multiple private nodes in the nodemask are ignored, because the nodemask
is a filter function for the fallback lists - and private nodes never
show up in the fallback lists (except for their own).

So for example

Nodes:  Normal(A,B), Private(C,D)

Fallback lists:
   A:   [A,B]
   B:   [B,A]
   C:   [C,A,B]
   D:   [D,B,A]

            combination                       |  possible result
----------------------------------------------------------------
__GFP_PRIVATE + pref_node(C) + nodemask(NULL) = (C or A or B)
__GFP_PRIVATE + pref_node(C) + nodemask(C,D)  = C
GFP_PRIVATE + pref_node(C) + nodemask(ALL)    = C

Basically private nodes are completely ignored in the nodemask, so you
cannot do fallback allocations to other private nodes.

There is no good abstraction (that I have found) to communicate
multi-private-node allocations simply because this would imply needing
private nodes to be in the fallback lists for other nodes.

Maybe there is a possibility of modifying fallback lists explicitly, but
I think that is out of scope for the first implementation.

~Gregory
