Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B3F2F1FDE
	for <linux-cxl@vger.kernel.org>; Thu, 13 Aug 2026 04:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593703; cv=none; b=C9+yvUsBDixCzSaAqnkU9H2w4pq59Fua+1a4PmlbIZ358AvyB+Wg9VH1/xY4MI+SgUlAMZR5xJLSHRpBOshR2hGuwQ3jtbTYI8nKzxWJthNfeemQsBnWkjQTw0sW/ThuqJbTVebUMR6Fmqh3ewRoH8y6H5Y/Z5cuEcrlPY36eO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593703; c=relaxed/simple;
	bh=GxSrdVwDfIB3EeqqJPuuaCXp2peFgErAynz8pw2fBmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Si3x0fRZ4QOygJm1Xr/S4kKGB+gnBgSIqCz7jpU9WjBa5b21JwUD/UERJUfSFQzh4L/adfxBpRzn2lOuIjZGh3JCZj9by0yZkaSECrGoTF71dfZpba9vl+59wv8u7OqN1J0k+69NRnyYKTl/lE93pdHDbyVNeRD27hXRce+06lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwr7h+xI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwr7h+xI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C181F00A3A;
	Thu, 13 Aug 2026 04:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593702;
	bh=CMrUZ09yVZ5LMB0GPwT6D1fvWvtlukm+ZqwZysrx1KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Zwr7h+xIhOfjxDNx1Nf9SYbYIkz+6aP+BjS8GFBG0HOQBzumYbssnyvGdGFJfTcEp
	 RE45lHsyxIDBQk8fVqmxMNkcSbP1lG63re4IVRkgLJp9vLH9vr6IV/SsXY5HtjNTkO
	 Aqh1HxbJyCozKOV15XFs8PfzGLKJK8cqcImj0ffsl4qY5HKn/933Wm9Bo82jAlG7t+
	 dfUHJb8vTKfr7qOagLhYn9GJWGgC8ERQpioegXgCR7DlIuxL7kDPT2XBzWXMJgY/xz
	 PL1+qxtDPe25LwwZwEyHFtrFnNytmjBr5sQHolBlAbJKLjNiSKY/+xbHsB1VElhZWS
	 uFw+IHn/+IARw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/7] cxl/memdev: Don't overwrite the error from an
 earlier partition poison query
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Cheng" <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260813034538.13189-6-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-6-icheng@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:01:41 +0000
Message-Id: <20260813040141.D0C181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `cxlmd->endpoint` in `cxl_trigger_poison_list()=
` leads to a TOCTOU Use-After-Free if the device is concurrently unbound.
- [High] Missing bounds check on `po->count` in `cxl_mem_get_poison()` allo=
ws an out-of-bounds read of kernel memory.
- [Medium] `cxl_mem_get_poison()` fails to update the payload offset when r=
etrieving subsequent poison records, resulting in duplicated traces and dro=
pped records.
--

--- Patch [5]: [PATCH v5 5/7] cxl/memdev: Don't overwrite the error from an=
 earlier partition poison query ---
commit 68fad9eb0dea3e233e2489fa05fad1099307f601
Author: Richard Cheng <icheng@nvidia.com>

cxl/memdev: Don't overwrite the error from an earlier partition poison query

cxl_get_poison_by_memdev() currently doesn't check the loop result, allowing
successful partition scans to overwrite earlier failures. This patch breaks
the loop on any unhandled error to properly report failures.

> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b3419df586b9c..e39b3d13fd566 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev=
 *cxlmd)
>  		 */
>  		if (rc =3D=3D -EFAULT && cxlds->part[i].mode =3D=3D CXL_PARTMODE_RAM)
>  			rc =3D 0;
> +		if (rc)
> +			break;
>  	}
>  	return rc;
>  }

While reviewing this, I noticed a few pre-existing issues in related code:

drivers/cxl/core/memdev.c:cxl_trigger_poison_list() {
    ...
    int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
    {
        struct cxl_port *port;
        int rc;

        port =3D cxlmd->endpoint;
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but when a root user writes to t=
he
trigger_poison_list sysfs attribute of a cxl_memdev device, it calls
cxl_trigger_poison_list(), which reads cxlmd->endpoint locklessly.

Concurrently, the parent CXL port can be unbound.

The unbind triggers the devm callback delete_endpoint(), which clears
cxlmd->endpoint to NULL and releases the port's reference, freeing it.

Since the sysfs thread has already loaded the pointer, it proceeds to use t=
he
freed port pointer in calls to cxl_num_decoders_committed(port) and
cxl_get_poison_by_endpoint(port).

Does lockless access to cxlmd->endpoint in cxl_trigger_poison_list() lead t=
o a
TOCTOU Use-After-Free if the device is concurrently unbound?


drivers/cxl/core/mbox.c:cxl_mem_get_poison() {
    ...
        if (!le16_to_cpu(po->count)) {
            dev_dbg(&cxlmd->dev, "Poison empty payload!\n");
            break;
        }

        for (int i =3D 0; i < le16_to_cpu(po->count); i++)
            trace_cxl_poison(cxlmd, cxlr, &po->record[i],
                     po->flags, po->overflow_ts,
                     CXL_POISON_TRACE_LIST);
    ...
}

[Severity: High]
This is a pre-existing issue, but in cxl_mem_get_poison(), the driver sends=
 a
GET_POISON_LIST command.

While cxl_internal_send_cmd() validates that the returned payload is at lea=
st
the size of the response header, it does not validate that it is large enou=
gh
to contain le16_to_cpu(po->count) records.

A malicious or buggy CXL device could return a small payload (e.g., 24 byte=
s)
but a large po->count (e.g., 65535).

The driver iterates po->count times, reading po->record[i] from the
mds->poison.list_out buffer (which is allocated as cxl_mbox->payload_size).
This will read past the end of the allocation.

Is there a missing bounds check on po->count in cxl_mem_get_poison() that
allows an out-of-bounds read of kernel memory?


drivers/cxl/core/mbox.c:cxl_mem_get_poison() {
    ...
    po =3D mds->poison.list_out;
    pi.offset =3D cpu_to_le64(offset);
    pi.length =3D cpu_to_le64(len / CXL_POISON_LEN_MULT);

    do {
        struct cxl_mbox_cmd mbox_cmd =3D (struct cxl_mbox_cmd){
            .opcode =3D CXL_MBOX_OP_GET_POISON,
            .size_in =3D sizeof(pi),
            .payload_in =3D &pi,
            .size_out =3D cxl_mbox->payload_size,
            .payload_out =3D po,
            .min_out =3D struct_size(po, record, 0),
        };

        rc =3D cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
    ...
}

[Severity: Medium]
This isn't a bug introduced by this patch, but according to the CXL 3.0
specification, if the device sets the 'More Poison Records' flag, the host
must issue subsequent Get Poison List commands with an updated Offset and
Length.

In cxl_mem_get_poison(), pi.offset and pi.length are populated before the
do-while loop.

Because they are never updated inside the loop, the driver sends the identi=
cal
payload in every iteration.

A stateless CXL device will respond with the identical first chunk of poison
records, continuously setting the MORE flag.

The driver will log these duplicate records until it artificially hits
mds->poison.max_errors, dropping the remaining records.

Does cxl_mem_get_poison() fail to update the payload offset when retrieving
subsequent poison records, resulting in duplicated traces and dropped recor=
ds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813034538.1318=
9-1-icheng@nvidia.com?part=3D5
