Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793845221;
	b=2hw52fM0zf8ZlYdTnQAGKNZX0mzYO+iwTzEtZXJe6Hj9KgeruypOFriKokjyWBISrvAr
	 H4/oqeIL/S9WIMkU8PskEP6PIZBGVxQH7lAW/OHfsQO4LcjLz3gtMve0zYnLpOxLcofgJ
	 PZXIItxhZhuPI+5DIBCsSIWj6dN140A5nrGJdSuFHcGtPVr7uq3gT3nh97PY+haER6z3x
	 U7CO227Jq/lvialvBVQW/rGw+ZOvj8hhefFkdgCa5ANZpp3AEgypTmjE+5RkF5Ir48az4
	 FGTRQ+oGOO+1p/cK0q6sOvfw1Hj4sgysDLv4eTH0s0nXJTedh0EK6t7Ge/bDLf0ywZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793845221;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:Subject:
	 To:CC:References:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Language:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy;
	bh=QXVr8YhrKV9VcyijQjizzwZyWuJ1oTxmJiKYv/ulIec=;
	b=UWDu4t8kyubHgasL3SiERz/+kNhJY5GK9wNNNWMY3xjNCRrmMEQHK6um+teFiwT94PfH
	 9tFvQ+UZM1TipZ7BQgFpY4bILSWGhCEaLpY6Bjb9emquFthMeDUtsNqTUu6HUwvQRsrls
	 4gyyC15n/T7bs2Xy8InnUmh0quAfJaN6B84HvvZQgtPx3ADEEdL5BwWQs1kWDwf8Ja7rO
	 aHmEs3+Q0UFGDTOroo8/uRoy9yHmq/h5OKRuyIqiXrVDsu70qZ52e9DvlU3QF8NZSgSma
	 LZsIuVkifoX1u44KG8ZAzKsAxpS4mTJrrTZ9+sxohT/NXKrr0z9C3/D6JiT/Pfm83Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G2aJXLUF;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26A606A31B;
	Thu,  5 Nov 2026 02:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A26A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=G2aJXLUF
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QXVr8YhrKV9VcyijQjizzwZyWuJ1oTxmJiKYv/ulIec=;
	b=G2aJXLUF5S0BrDAXyM02zD5jsRtUpHg+yrWNK0+biluxAozaa5+RsVZDl9lntB2rZ7SZ6d7F+
	nsr8haXbtymLbFSi9NlX//LllLRTuenIYtgOBZ/onSvDI1QpKsVahubkP76vkgs7CcuyoNdHU65
	eUez7muOL1YeHouX2J8iZhc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jKmHJ0F8vz12LHX;
	Thu,  5 Nov 2026 10:20:12 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id C04E74057D;
	Thu,  5 Nov 2026 10:20:10 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 5 Nov 2026 10:20:07 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH] mm: split out memory-failure declarations from internal.h
To: Breno Leitao <leitao@debian.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-cxl@vger.kernel.org>, <kernel-team@meta.com>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Xu Xin <xu.xin@linux.dev>, Chengming Zhou
	<chengming.zhou@linux.dev>, Oscar Salvador <osalvador@suse.de>, Johannes
 Weiner <hannes@cmpxchg.org>, Brendan Jackman <brendan.jackman@linux.dev>, Zi
 Yan <ziy@nvidia.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
	<harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang
	<lance.yang@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt
	<shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, Barry Song
	<baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
	<yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He
	<baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>
References: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
Message-ID: <b74ed30f-3c01-b41e-1963-d37d40078191@huawei.com>
Date: Thu, 5 Nov 2026 10:20:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104-memory-failure-split-v1-1-3b0a85f0b7e7@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/11/5 0:45, Breno Leitao wrote:
> mm/internal.h carries the memory failure declarations, but only seven
> of the 81 .c files that include it use them.
> 
> Move memory failure declarations to a new mm/memory-failure.h and
> include that from those seven files that need them.
> 
> Move the block as is, including take_page_off_buddy(),
> put_page_back_buddy() and page_mapped_in_vma(): they live in
> page_alloc.c and page_vma_mapped.c, but are built only for
> CONFIG_MEMORY_FAILURE and called only from memory-failure.c.
> 
> Keep the declarations private to mm/.
> 
> No functional change.
> 
> Suggested-by: Mike Rapoport <rppt@kernel.org>
> Link: https://lore.kernel.org/all/aumt-4kfGGtoXuh-@kernel.org/
> Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM. Thanks for your patch.

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
