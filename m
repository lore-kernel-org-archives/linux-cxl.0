Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2823D9DD4
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 07:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784272038; cv=none; b=OiaFk3t6OLvxsNoHvXjp9JW1B65B21b7np9SAyv6zkL1x1+D0DAtcFtL1mJl6UVmBhA5puDeDPe/t2fNFBLhGaKB+GpxPzSwnQ2NwkRpRJStSB4XaSUVJikBMwjReTGVpE0irN7M7zNovW9fVVZj3yKlhKz9DCqU8sHnIQ9T+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784272038; c=relaxed/simple;
	bh=d0zAOKCo+rJkdmai6Ca3aCG/TcgkcR4kF8rJtJ0IURg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kKTTZam5SeTgIvcFx8XehZkvvYEiJ7nNBSb6aWK7Trrrgri3m2m7Wfz81S8kSiJB7B2lXRa+LN9Dx+2mttliF+oa2uuoOLEt8Hz1Rw17+/k6L3nS553XMRMFvPEtSd88wghVamXykcHIw/MltRAT9FnjHNOQa5cBBD59nH6HjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FYcbXjoS; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FYcbXjoS"
Message-ID: <4d7ee6c9-ea5d-40d5-9af0-5c15b3c2cab0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784272033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0VorFQubA72e/tCA00Fb2KLrFZdh25LwjH5MvlC2w0=;
	b=FYcbXjoSXSnpuaPUdr5wOGZcmcE+/jk7JT8DQzKA+ZKQFQ3nafMenU+ozew9SvtnyWa6w6
	oFfczig9lfYag1nidAQh9OO0xfrwQnRNPSZGoO12c2OuAUHUtmIEy36w1Z/wAV/XQiD3u5
	/aKrCXzpCOj80LUY8XMujoxAlc4X86g=
Date: Fri, 17 Jul 2026 15:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: hongfu.li@linux.dev, david@kernel.org, osalvador@suse.de,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Hongfu Li <lihongfu@kylinos.cn>
Subject: Re: [PATCH] mm: add missing alloc_percpu() NULL check in hotplug init
To: Mike Rapoport <rppt@kernel.org>
References: <20260717052938.58447-1-hongfu.li@linux.dev>
 <alnPz-r76FU6t5Uc@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hongfu Li <hongfu.li@linux.dev>
In-Reply-To: <alnPz-r76FU6t5Uc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/17/26 2:46 PM, Mike Rapoport wrote:
> On Fri, Jul 17, 2026 at 01:29:38PM +0800, Hongfu Li wrote:
>> From: Hongfu Li <lihongfu@kylinos.cn>
>>
>> No NULL check is done for alloc_percpu() when initializing per-CPU
>> nodestats. Allocation failure leads to NULL pointer dereference
>> during later memset.
>>
>> Make function return int, check alloc_percpu() result and return
>> -ENOMEM on error. The caller chain already propagates this error
>> correctly.
> I already applied a fix from Gregory:
>
> https://patch.msgid.link/20260701221613.2818148-1-gourry@gourry.net
>
> It'll be unstreamed soon.

Got it, I'll drop this patch as Gregory's fix is already on the way 
upstream.
