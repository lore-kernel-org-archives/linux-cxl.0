Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D60428470
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384374; cv=none; b=XUkV7r3xjQ5B7h0tlSCFF8/ECYtFMhL+g2HMgCqdEwh9zD7ybA+Da1yk/1LWzIr99X2AtfXbp/BNUu4E39ZRYMo0h/Cgln+0cpli9VmGPqGVaoBR+nIaiB3tM2z7ECb8O48R9GaN79+glKDnNjqnsPpDlzmjTl92PAreQlb73pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384374; c=relaxed/simple;
	bh=wkjR01BepCnVnaMjug35GZEThZ0Qh8AtsLMqcKixOwA=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=UYV+JF83lmkyydq0wWGjRbR6qjenPaS8XBkWIE6L2OQUdVRvcIdXpg7ndiKTmbOY/hcu0TQJD9xQe4G9w1Gti7u/mV0hbD0wxkguwItOAgvJi0bLfCHM1lWVygiEEbvmlbJmZQwF5MXItibWDd9MI2JQRX5zc3QPH7yHLhihGsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PLvWtj2K; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PLvWtj2K"
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777384360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fSaI5CrYdlz9JeGFiodMZfSS16RBwlLh/md29GdDRjs=;
	b=PLvWtj2Ke2MahB3td0bSGKYKjTzfkG+IvdHc1FUgCX5pZrEliuin0HPmkbSev4lLE1xuZ5
	91c8CAMRZ0kVk2DQQYcrCZ6+kVutWaRLe9qP695l/CbKNZBaIi7FtiDooLIuzfl5nTt5wO
	JurL+V4bVaPPf1q+1buipgPYlsOsd5E=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison accounting lookup
Message-Id: <94F5B89A-008A-4EDB-920F-31B4895C2699@linux.dev>
Date: Tue, 28 Apr 2026 21:52:23 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>, Dan Williams <djbw@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rafael J Wysocki <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT

=EF=BB=BF


> On Apr 28, 2026, at 20:34, Miaohe Lin <linmiaohe@huawei.com> wrote:
> =EF=BB=BFOn 2026/4/28 19:40, Muchun Song wrote:
>>=20
>>=20
>>> On Apr 28, 2026, at 19:37, Miaohe Lin <linmiaohe@huawei.com> wrote:
>>> On 2026/4/28 16:52, Muchun Song wrote:
>>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
>>>> find_memory_block_by_id(), which requires device_hotplug_lock to
>>>> serialize the xarray lookup against memory block removal.
>>>> Take device_hotplug_lock around the lookup and nr_hwpoison update so
>>>> the memory block cannot disappear between xa_load() and get_device().
>>>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block hwpoison c=
ounter")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> Thanks for update.
>>>> ---
>>>> drivers/base/memory.c | 10 ++++++++--
>>>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>>> index 6981b55d582a..f76aee29e9a5 100644
>>>> --- a/drivers/base/memory.c
>>>> +++ b/drivers/base/memory.c
>>>> @@ -1228,23 +1228,29 @@ int walk_dynamic_memory_groups(int nid, walk_me=
mory_groups_func_t func,
>>>> void memblk_nr_poison_inc(unsigned long pfn)
>>>> {
>>>>    const unsigned long block_id =3D pfn_to_block_id(pfn);
>>>> -    struct memory_block *mem =3D find_memory_block_by_id(block_id);
>>>> +    struct memory_block *mem;
>>>> +    lock_device_hotplug();
>>> memblk_nr_poison_inc() and memblk_nr_poison_sub() are both called from m=
emory_failure() context.
>>> I'm afraid if memory_failure() is triggered while lock_device_hotplug is=
 held, it will lead to
>>> deadlock. Or am I miss something?
>>=20
>> I am curious is there any place where memory_failure() is called with hol=
ding lock_device_hotplug?
>=20
> Sorry for dumb scenario, I was a bit too presumptuous. But there might be a=
nother possible deadlock:
>=20
> remove_memory
>  lock_device_hotplug <-- first called here
>  try_remove_memory
>    remove_memory_block_devices
>      num_poisoned_pages_sub

Passing pfn =3D -1 here.

>        memblk_nr_poison_sub
>          lock_device_hotplug <-- deadlock here

No. Can=E2=80=99t reach here. No deadlock.

Thanks.

>=20
> Hope I'm not mistaken again. :)
>=20
> Thank.
> .
