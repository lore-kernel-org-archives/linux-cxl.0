Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793463734;
	b=w/Q4m/pdiDdioWeNAROwmO4xkn9i4OlT+zSAxsDWek0ODtbb87ZMdhUVcEk6hszyt4KK
	 BQARSPTYJtF6NT+5xGZ2cMLegglR4JLCvnrStg5LNr8v9xV49L80FUuZ28EOVVzKYp3tK
	 tFSGKs12ZgSm2PtL0uPzCQOCtYO3zVPARfcumHOzeZjA6KnLTSmvEBnrWd4apVkABpjpH
	 p2Rd5VbDqnjOdeXrbyRByGZZgSfrkzSzIJL3qhSk8L8otoO8kGCjYkzTfD3iGjkfLU9jx
	 k6BwHxpSotEgpqU0oIA4S54bC0e1LhSOkjoZyRUv66qd9KtaTJ+oDHiyusNl74fzSaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793463734;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9wgzJrAl2KJExltmuq2h6/rxlvK+zvnwdsHBWSX6TDM=;
	b=qfudc0IcjfWMLj8OzbOm8XevZvJkBQ61LweIj06a3hfQNDOQ4pCHAQGJEWpOaWyi8ic4
	 wg3aDiPpmSzuhCrmzwkOFhcg1kwdVfumS9ae6gmBQAneJ0TKSVpQ+c/mJteWqgS/fUdgj
	 APsJ8rtvl9yryGoNoWzfE+hL8wDfvy0duqNri6Ma14WxF70sahg0ahCflPuRnBHFReYnq
	 hsK4y4nrbkG7hSGcTk2TddqIIxovjhAbPAktfnfdySB44Dt+tY4jm8a3wo1znaj1C6dZR
	 yA8J+qetw2Eaw4oHEsk9B6H85bW/K1LJAtPL5xkU9s4mExlUOaUlV9CI9GVAtBnDoAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckk3B1ms;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C079606A31A
	for <linux-cxl@vger.kernel.org>; Sat, 31 Oct 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ckk3B1ms
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA951F000C1;
	Sat, 31 Oct 2026 16:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793463733;
	bh=9wgzJrAl2KJExltmuq2h6/rxlvK+zvnwdsHBWSX6TDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ckk3B1ms8czM00/wr6eki6Qo7Ga7vYvNQDpnkXYPO4kpWdx08BPR6tHRjS0Pfr4UB
	 GXtsji42yCOZSsXlwdKS4Qi8JFxk4eziMI/cwrxO3QY7T1Fjy6ZFl832btua89AwxN
	 DZQXbcHQrmQPoWqglUPawRCpbWOoxFRKuM4IEIbzz9QjQjC3hpwhSs1bwwQDzndaYx
	 77SQKftE41owojPvScUNfOEijW1DOhhAK/dZ7XrKQyQdZXzniX7wUzCrv/y3Fcj2Qs
	 /bJwl0DL5H/innlqLLa5q35v8Iu+q9mwo13mv7u+EoRl159Gg+MugcjDhahTlviCy8
	 j0/mlzIYsyi9w==
Message-ID: <sashiko-outbox-192042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/edac: Mask DPA flags in the event record cache
 key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jongwon Lee" <ai@linux.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20261031161121.15948-1-ai@linux.com>
References: <20261031161121.15948-1-ai@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 16:22:13 +0000
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] cxl/edac: use-after-free race in cxl_find_rec_gen_media() and cxl_=
find_rec_dram()
--

commit 5617c750af672417152a61a535a4548061ad0978
Author: Jongwon Lee <ai@linux.com>

cxl/edac: Mask DPA flags in the event record cache key

This commit masks the low flag bits from the event record DPA when storing
General Media and DRAM error records in the xarray cache so lookups using t=
he
masked DPA from trace events succeed. It also rejects repair requests when =
the
cached event record has the CXL_DPA_NOT_REPAIRABLE flag set.

> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 34b81e8dfbbb6..b3dfc33ca6740 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -918,6 +918,21 @@ struct cxl_mem_repair_attrbs {
>  	enum cxl_mem_repair_type repair_type;
>  };
> =20
> +/*
> + * The low bits of the event record DPA are flags (VOLATILE, NOT_REPAIRA=
BLE).
> + * Records are looked up by the DPA user space writes back, which comes =
from
> + * the trace event and has the flags masked off, so key them the same wa=
y.
> + */
> +static unsigned long cxl_rec_key(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_MASK;
> +}
> +
> +static bool cxl_rec_not_repairable(const struct cxl_event_media_hdr *hdr)
> +{
> +	return le64_to_cpu(hdr->phys_addr) & CXL_DPA_NOT_REPAIRABLE;
> +}
> +
>  static struct cxl_event_gen_media *
>  cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  		       struct cxl_mem_repair_attrbs *attrbs)
> @@ -929,7 +944,7 @@ cxl_find_rec_gen_media(struct cxl_memdev *cxlmd,
>  		return NULL;
> =20
>  	rec =3D xa_load(&array_rec->rec_gen_media, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;
> =20
>  	if (attrbs->repair_type =3D=3D CXL_PPR)
> @@ -950,7 +965,7 @@ cxl_find_rec_dram(struct cxl_memdev *cxlmd,
>  		return NULL;
> =20
>  	rec =3D xa_load(&array_rec->rec_dram, attrbs->dpa);
> -	if (!rec)
> +	if (!rec || cxl_rec_not_repairable(&rec->media_hdr))
>  		return NULL;

[Severity: High]
Can cxl_find_rec_gen_media() and cxl_find_rec_dram() race with concurrent
event record insertion and trigger a use-after-free when dereferencing rec?

On the event reporting path, drivers/cxl/core/mbox.c:cxl_event_trace_record=
()
acquires device_lock(&cxlmd->dev) and shared read locks on cxl_rwsem.region
and cxl_rwsem.dpa before storing and freeing records:

drivers/cxl/core/mbox.c:cxl_event_trace_record()
    guard(device)(&cxlmd->dev);
    guard(rwsem_read)(&cxl_rwsem.region);
    guard(rwsem_read)(&cxl_rwsem.dpa);
    ...
    cxl_store_rec_gen_media() / cxl_store_rec_dram()
        old_rec =3D xa_store(..., cxl_rec_key(&rec->media_hdr), rec, GFP_KE=
RNEL);
        ...
        kfree(old_rec);
        cxl_del_expired_gmedia_recs() / cxl_del_expired_dram_recs()
        cxl_del_overflow_old_recs()

On the EDAC sysfs repair path, cxl_do_ppr() -> cxl_mem_perform_ppr() and
cxl_do_mem_sparing() -> cxl_mem_perform_sparing() only take shared read loc=
ks
on cxl_rwsem.region and cxl_rwsem.dpa, without holding device_lock(&cxlmd->=
dev)
or the xarray lock.

Because both paths hold cxl_rwsem.region and cxl_rwsem.dpa in shared read
mode, they can run concurrently. xa_load() drops rcu_read_lock() before
returning rec, and the store path frees displaced, expired, or overflowed
records immediately with kfree().

Previously, cxl_find_rec_gen_media() and its caller cxl_mem_perform_ppr()
only checked whether the returned pointer was non-NULL without dereferencing
it. With this change, cxl_find_rec_gen_media() now dereferences
rec->media_hdr.phys_addr in cxl_rec_not_repairable(), cxl_find_rec_dram() a=
dds
another unlocked dereference of rec->media_hdr.phys_addr before its existing
field accesses, and masking the DPA flags in cxl_rec_key() makes same-DPA
events with different flag bits collide and free old_rec in xa_store().

Should the lookup and record inspection in cxl_find_rec_gen_media() and
cxl_find_rec_dram() be serialized with cxl_store_rec_gen_media() and
cxl_store_rec_dram() (for example using xa_lock or RCU-safe freeing)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031161121.1594=
8-1-ai@linux.com?part=3D1
