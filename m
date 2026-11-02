Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618556;
	b=tfHijTFzAAJvHh4BxIkgx8VBJ+RCVj10lrmFd+R3LW+ob6SvcsyTYLzIngetNQdsYPFb
	 YVCBhtiriFGPnYO8WLaPEQsqleCvFM+GFcOIsfzitTW5CX/uWJaA50QKz/vSGp72+7ILx
	 IsCPgzu4Pg3V9/MNWOBlLXjzlNfGbryXRZ4QRlbJ9lCR/Lzhc/K5BQRctOjzlGaGNqOzi
	 SQCHS6KRVXg07oGpo9SAJcBhDZhoHyTaBN+PEh6nVIW4FYo4Zg9k6TzrrdnII+u0HuRNB
	 I4RXzi7MJIGQYmbLXD/Sunf8amkgEKaP0kcQYc+vgY4rV051u44TsclNyygeItswtrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618556;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=;
	b=PEdaqclTmcTtmM4ocHi6duV/evivHWKDQdfXe6VW0Uhxt/cgjMvOGxeiAYKASmKI6jfe
	 zz5aol5tgTVDTUWyJMUDhcZC1aiTFcD8DNJyB23MYfiXrRSwoBW23vUgaO1Kj2eUvFp3a
	 x52pZwjGc/oEMZE4gsrjqzBKWAa1Uw6aDOm92DyTaIFokl09u3Qmw1AeAME/wFfqYq34Y
	 yfq4A8gRjc79BV9E2kfj3sSOaQ8dhcaQvpGPYK260fdnGJwUPfgNfgDIeZf6H8qxFeIZV
	 lF009SWN2m7V1fkBxErVsGxx78a3mJiYEXIhvLN9UV824SVzCpFlofgtTPWKraVhXdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dNl8kU2Z;
	arc=none smtp.remote-ip=91.218.175.51
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6873F60A5BD4
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 11:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6873F60A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dNl8kU2Z
X-Envelope-To: linux-cxl@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rlYYUg5m282yLIStEKkIHTozLzxeQHV9wO/ECVNrg9o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793618553; v=1; x=1794223353;
 b=dNl8kU2ZZnY7p+1AZb5FkPRPxnYNE0pNnRkYzfMXhsQ6nzU8z5o/GWyH69JI2jndGu8pOXov
 iCXfD2V18rj7VtN0dm54SEJgnoT8r9LSk12pObDE1JIpBZph6bgTHoxZAQEPzv45DOvyDH48795
 PK/VAB0uVps+jfwrxgnpYmZo=
X-Envelope-To: linux-cxl@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0a735c2090dc6b54;
	Mon, 02 Nov 2026 11:22:32 +0000
X-Mizu-Trace-ID: 0a735c2090dc6b54
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org,
	skhawaja@google.com,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 20/47] mm/gup: fix clearing folios in memfd_pin_folios()
Date: Mon,  2 Nov 2026 19:22:27 +0800
Message-ID: <20261102112227.62593-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-20-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-20-d6437171ecc3@kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:39:49AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.

Right, just make sure the folios are initialized before handing them to
callers. They shouldn't have to care whether shmem deferred the clearing ;)

>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
>Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
>Tested-by: Samiullah Khawaja <skhawaja@google.com>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>
