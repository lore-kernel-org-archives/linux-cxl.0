Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC933DEC2
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680710; cv=none; b=qWrBgzRNTFH5WQ+LDXIq8dyHW0dviluRA7dhNmDKKkMO0Odu3WvWl+Sx4lKE2YssiV8BPMye/NZD1PdQgOf8+r9lZY2t0S1UIFVMhvxIqrZzTon36kNB9TSAjdHIwLVPGCL4iRHJkrlYBdAqtrSkN117uDTd/1M9JJSWuQqDjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680710; c=relaxed/simple;
	bh=UrMgJUctrCnJPLhhMg7ogYyGztWRdUtawCZFul04CVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jyZR74AI2zX08G/ourTLL1TaMEJCKWkQ63coeMxWSyNqCwETBPra9xrtaa9AYqKWnN6FvRKiNHdHPiHRYPK6f8XXQO+tpGudgR96BSwyjjP2aYPVsnY6KycsHACXGbo1kRDC+v9QjriDozbINEWDOfLm6pmqULHGo14Iw8eu3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bx8vDvmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bx8vDvmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9A31F00893;
	Fri,  5 Jun 2026 17:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680706;
	bh=YRexrnuy7L5+DeaPjzKdT7D9koEurGbpbYBKuubCFMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bx8vDvmyqVkPlCZRKAwMmERgPJakCthfPU2Ei2B3hcd8TSFqh5zpCLPG4N8EY0OLZ
	 Dk9PNaK51l6n7PN8q+PKk+PkaWWdyYfuvF51LvYg6IMwC3ZAiL1fihVRJyqMB69hYB
	 kO/hu6T0/bWcEyl0R4VwS7ZEPD+ue5xJ36NEp9vujMjfwTbt7VokxC2cQ6AHWaIs0X
	 4rWrF2fqPr/kkMomMUpYF1m3QBzZMYGfOSUo9YkbUcolvqlYyNmnRgfMVm413hQJNm
	 V8IjPUsSjE9c+d0QEzKn8R8NRXYcuK8YrI6mH9pVl9JRhnObBBrf55cAghj63OLMRe
	 /avR5LDtW4HZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/test: Fix integer overflow in mock LSA bounds
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605171238.3857744-1-dave.jiang@intel.com>
References: <20260605171238.3857744-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:31:45 +0000
Message-Id: <20260605173146.2B9A31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer underflow in `mock_transfer_fw()` allows massive out-o=
f-bounds memory write and kernel panic.
- [High] Unpatched identical integer overflow in `mock_get_log()` bounds ch=
eck allows out-of-bounds read and kernel crash.
- [High] Uninitialized memory leak via `vmalloc()` in `mock_get_lsa()`.
--

commit b6be4918eaf54ec33c636f5e1951da3320c032b5
Author: Dave Jiang <dave.jiang@intel.com>
Subject: cxl/test: Fix integer overflow in mock LSA bounds checks

mock_get_lsa() and mock_set_lsa() validate the requested LSA range with
"offset + length > LSA_SIZE". The addition is evaluated modulo 2^32, so a
large offset combined with a small length wraps around and passes the check.
This commit rewrites the checks to avoid overflow.

Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.ke=
rnel.org/

> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32c..f27a83da738fc 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1053,7 +1053,7 @@ static int mock_get_lsa(struct cxl_mockmem_data *md=
ata,
>  		return -EINVAL;
>  	offset =3D le32_to_cpu(get_lsa->offset);
>  	length =3D le32_to_cpu(get_lsa->length);
> -	if (offset + length > LSA_SIZE)
> +	if (offset > LSA_SIZE || length > LSA_SIZE - offset)
>  		return -EINVAL;
>  	if (length > cmd->size_out)
>  		return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but the lsa memory buffer return=
ed
shortly after this bounds check contains uninitialized kernel memory.

In cxl_mock_mem_probe(), the memory for the mock Label Storage Area (mdata-=
>lsa)
is allocated using vmalloc():

tools/testing/cxl/test/mem.c:cxl_mock_mem_probe() {
    ...
    mdata->lsa =3D vmalloc(LSA_SIZE);
    ...
}

Unlike vzalloc(), vmalloc() does not zero the allocated memory. When
mock_get_lsa() uses memcpy() to copy this memory into the output payload, it
leaks up to 128KB of whatever was previously stored in those physical pages=
 by
the kernel to userspace.

Does this code leak uninitialized memory to userspace? Should vmalloc() be
changed to vzalloc()?

[Severity: High]
This is a pre-existing issue, but mock_get_log() has an identical unpatched
integer overflow.

Both offset and length are user-controlled u32 values. The bounds check is
vulnerable to 32-bit integer wrap-around:

tools/testing/cxl/test/mem.c:mock_get_log() {
    ...
    u32 offset =3D le32_to_cpu(gl->offset);
    u32 length =3D le32_to_cpu(gl->length);
    ...
    if (offset + length > sizeof(mock_cel))
        return -EINVAL;
    ...
    memcpy(cmd->payload_out, data + offset, length);
    ...
}

A large offset combined with a small length wraps around, bypassing the che=
ck
and causing an out-of-bounds read during the memcpy().

Should mock_get_log() be updated with the same bounds checking logic?

> @@ -1073,7 +1073,7 @@ static int mock_set_lsa(struct cxl_mockmem_data *md=
ata,
>  		return -EINVAL;
>  	offset =3D le32_to_cpu(set_lsa->offset);
>  	length =3D cmd->size_in - sizeof(*set_lsa);
> -	if (offset + length > LSA_SIZE)
> +	if (offset > LSA_SIZE || length > LSA_SIZE - offset)
>  		return -EINVAL;
> =20
>  	memcpy(lsa + offset, &set_lsa->data[0], length);

[Severity: Critical]
This isn't a bug introduced by this patch, but mock_transfer_fw() suffers f=
rom a
similar 64-bit integer wrap-around that can bypass bounds checks.

The length is calculated without verifying that cmd->size_in >=3D
sizeof(*transfer):

tools/testing/cxl/test/mem.c:mock_transfer_fw() {
    ...
    size_t offset, length;

    offset =3D le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_ALIGNMENT;
    length =3D cmd->size_in - sizeof(*transfer);
    if (offset + length > FW_SIZE)
        return -EINVAL;
    ...
    memcpy(fw + offset, transfer->data, length);
    ...
}

If userspace triggers this with a small size_in (e.g., 8 bytes), the size_t
(64-bit) length underflows to a massive value. If offset is carefully chose=
n,
offset + length wraps around in 64-bit arithmetic to a small value, passing=
 the
bounds check. The function then attempts to memcpy() an extremely large num=
ber
of bytes, causing a kernel panic.

Can this check be tightened to ensure cmd->size_in is large enough to preve=
nt
the underflow?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605171238.3857=
744-1-dave.jiang@intel.com?part=3D1
