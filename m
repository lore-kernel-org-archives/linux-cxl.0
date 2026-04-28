Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17A733064A
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368121; cv=none; b=Od7G+PTCZvJ19hAnwQUozBXIzx8tXJLv3eawvuswYZBPVipdWRdMluZsgQVI++XtZtAXdTvgPAkSfPZ49VUASARKT4BxF1ExpAactF9x28yQpHzHDrVMT9jCRzsKVyvXP9SiXYunJ7HlEdpGhk8+D00s+NRl/oDPSTK1dC94HTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368121; c=relaxed/simple;
	bh=xwdhCIsDzsUndt0fN1DFv5y4ol6vuXneCPXfkJ3rv3I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fRDhBM8JXdQKO6sKwLhQJP8tJm3AAlrycJb3e0jZQ+dKKwEnRie0NxnX36x1+W9p3vrjIuXIkSWNg4tlC/CHD9TaVg1hjWUDMPjFme0gbRLyCnwSqz5Qd+NFJZSSh9gnBEms0s0MpstPMivLfYKQWlnDOrj0j29/ftZ3yxCuvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTVmlSyp; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTVmlSyp"
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777368114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwdhCIsDzsUndt0fN1DFv5y4ol6vuXneCPXfkJ3rv3I=;
	b=VTVmlSyp8aaq5f+XaDvS0eCOTZ71PIuGmarywfT1eOlsw3168ofTjyocykCuCTxym/Z0kv
	uvn14YRvzKs0CdBkfTeGlN38AUcIlktOHnJQpMfKaWBnyICUchCrgy5EO80eEPug/YhDHT
	jk5BeXB8BaVebZN/UatMguhrgiXPS4g=
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afB7Go7JqhIpjU5J@localhost.localdomain>
Date: Tue, 28 Apr 2026 17:21:00 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4542EE05-E18A-486F-ADF7-E72F71D9A327@linux.dev>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
 <20260428085219.1316047-4-songmuchun@bytedance.com>
 <afB7Go7JqhIpjU5J@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 17:17, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Tue, Apr 28, 2026 at 04:52:19PM +0800, Muchun Song wrote:
>> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
>> find_memory_block_by_id(), which requires device_hotplug_lock to
>> serialize the xarray lookup against memory block removal.
>>=20
>> Take device_hotplug_lock around the lookup and nr_hwpoison update so
>> the memory block cannot disappear between xa_load() and get_device().
>>=20
>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block =
hwpoison counter")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> It might have made sense to join both patches? Anyway:

Either way works for me. I=E2=80=99ve been following the 'one thing per
patch' principle. If I still need to update v3, I can merge them;
otherwise, I=E2=80=99d prefer to keep it as is. I'm a little lazy. :)

>=20
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs

