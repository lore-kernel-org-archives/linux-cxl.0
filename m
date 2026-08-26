Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794B39FCBC
	for <linux-cxl@vger.kernel.org>; Wed, 26 Aug 2026 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770690; cv=none; b=ry80aFYU4d/25UQfrcebQ0nrYITKyk3lc+zTCv6Fu3ytSh2XfG583j+3jcwLSvy5dVae4U7OtqFy2FTYW1MO2suT6c4wPqskMw4PeyfbH/KEBzAdbUm777AXBR52/oIdzHrNAlvEyiha2sEzUeogW+m8x4LWuGx6A+cgA8TWQj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770690; c=relaxed/simple;
	bh=M1d8MDRDI5/9PonCB4HgOuNgQS9ixKE8D+QbKtBHTH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jMBtcvLf42o07IbFPT3j392jEf88tm1CcrUbUPFvWmU8IVDUovHZ4He4bz1BT3uT5QadfwHvtezhNTJjYAMJQvlamUSsNZmkpvl5RMdMH1nm8/rEg/A8YMpCT/iGgxKdmnql9tC8nuMvHC2X5cAAbDipaXBrSA7DuCTzKwn2t50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5i0fnhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5i0fnhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA01F000E9;
	Wed, 26 Aug 2026 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787770679;
	bh=yxRZdSZ36uVElsViZFCsxNM7UY1ID8Jl14Bs/u9vsnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5i0fnhiduSPaqD+ygs6gxKjx2zmjPKbYtw1lgT8yQqJfodD6yiAh4dJP6SP3XBSe
	 N3gIgHBt08LtZyLhHjTIpFL0v13rsZrYLJjce63+5k6qklnpsNN3CBEBAn1hkfgTwx
	 7CvSu24Bh0GsAkHcTPx9svsuCRugUry1YBFJEyO7f+4hjrC5GA+/Q4P6ju53v5z2x7
	 6rF0i4Y+Pxs2IhyeU6qaVkx8nWrh9q+VMsVLgmdiQhokKrLyd0cnyWlMrvjUDOaBVU
	 S47+hk2OhqvBfmZSVUsTvSOZ/Nt7/3rqSypo5ZUHM5CjV8/QCHU7bLgNqoGafxM276
	 5UfpeXPp2LkRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] cxl/events: Bound the event log drain loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260826184417.1042-1-anisa.su@samsung.com>
References: <cover.1787768932.git.anisa.su@samsung.com>
 <20260826184417.1042-1-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 18:57:58 +0000
Message-Id: <20260826185759.24DA01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] TOCTOU race during IRQ setup causes spurious warnings and alters=
 thread polling logic

Pre-existing issues:
- [Critical] Out-of-bounds Read & Information Leak via unvalidated record_c=
ount
- [High] Unbounded inner loop allows CXL device to cause soft lockup
- [High] Unconditional IRQ_HANDLED return defeats spurious interrupt detect=
ion
--

commit bfe23a43bdb497b440f694e603125e0a9dc270f5
Author: Anisa Su <anisa.su887@gmail.com>

cxl/events: Bound the event log drain loop

This commit bounds the event log drain loop based on the work completed
instead of waiting for the Event Status register to clear. It modifies
cxl_event_thread() to stop on the first error and drop any log that returns
no records while its status bit is set. The goal is to prevent infinite
spinning when a misbehaving device fails to clear the status bits.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01a..ca2114a17ff4f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

[ ... ]

> @@ -1070,12 +1070,15 @@ static void cxl_mem_get_records_log(struct cxl_me=
mdev_state *mds,
>  	struct cxl_get_event_payload *payload;
>  	u8 log_type =3D type;
>  	u16 nr_rec;
> +	int rc =3D 0;
> +
> +	*drained =3D false;
> =20
>  	mutex_lock(&mds->event.log_lock);
>  	payload =3D mds->event.buf;
> =20
>  	do {
> -		int rc, i;
> +		int i;
>  		struct cxl_mbox_cmd mbox_cmd =3D (struct cxl_mbox_cmd) {
>  			.opcode =3D CXL_MBOX_OP_GET_EVENT_RECORD,
>  			.payload_in =3D &log_type,
> @@ -1096,6 +1099,7 @@ static void cxl_mem_get_records_log(struct cxl_memd=
ev_state *mds,
>  		nr_rec =3D le16_to_cpu(payload->record_count);
>  		if (!nr_rec)
>  			break;
> +		*drained =3D true;

[Severity: Critical]
This is a pre-existing issue, but does this code properly validate the
hardware-provided payload->record_count?

In cxl_mem_get_records_log(), the nr_rec variable is read directly from
payload->record_count without any bounds checking against the payload buffer
capacity. The loop below then uses this untrusted count to read from the
flexible array payload->records[i]:

        for (i =3D 0; i < nr_rec; i++)
                __cxl_event_trace_record(cxlmd, type,
                                         &payload->records[i]);

A maliciously or erroneously large record_count from the device would cause=
 an
out-of-bounds read of kernel memory, leaking it to tracepoints.

Additionally, this same unvalidated count is used later in
cxl_clear_event_record():

        u16 total =3D le16_to_cpu(get_pl->record_count);
        ...
        for (cnt =3D 0; cnt < total; cnt++) {
                struct cxl_event_record_raw *raw =3D &get_pl->records[cnt];
                struct cxl_event_generic *gen =3D &raw->event.generic;

                payload->handles[i++] =3D gen->hdr.handle;

This reads out-of-bounds kernel memory and sends it to the physical device =
via
the CLEAR_EVENT_RECORD command.

> =20
>  		for (i =3D 0; i < nr_rec; i++)
>  			__cxl_event_trace_record(cxlmd, type,

[ ... ]

> @@ -1114,31 +1118,59 @@ static void cxl_mem_get_records_log(struct cxl_me=
mdev_state *mds,
>  	} while (nr_rec);

[Severity: High]
This is a pre-existing issue, but while this patch bounds the outer event l=
og
drain loop in cxl_event_thread(), does it overlook this inner loop?

The do/while loop in cxl_mem_get_records_log() executes unconditionally as =
long
as the device returns a non-zero record_count. A misbehaving or malicious
device that continuously returns a payload with record_count > 0 will trap =
the
kernel thread in this loop indefinitely. This bypasses the new bounds checks
introduced in the outer loop, potentially causing a CPU soft lockup.

> =20
>  	mutex_unlock(&mds->event.log_lock);
> +
> +	return rc;
>  }

[ ... ]

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51dc..9339f37cd6620 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -515,21 +515,46 @@ static irqreturn_t cxl_event_thread(int irq, void *=
id)
>  	struct cxl_dev_id *dev_id =3D id;
>  	struct cxl_dev_state *cxlds =3D dev_id->cxlds;
>  	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
> -	u32 status;
> +	u32 mask =3D CXLDEV_EVENT_STATUS_ALL;
> +
> +	while (mask) {
> +		u32 status, drained, stuck;
> +		int rc;
> =20
> -	do {
>  		/*
>  		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status =3D readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
> -		/* Ignore logs unknown to the driver */
> -		status &=3D CXLDEV_EVENT_STATUS_ALL;
> +		/* Ignore logs unknown to the driver, and logs given up on */
> +		status &=3D mask;
>  		if (!status)
>  			break;
> -		cxl_mem_get_event_records(mds, status);
> +
> +		/*
> +		 * A failed drain leaves the log's status bit set, so another
> +		 * pass would resend the same query forever.
> +		 */
> +		rc =3D cxl_mem_get_event_records(mds, status, &drained);
> +		if (rc)
> +			break;
> +
> +		/*
> +		 * The Event Status register is device owned and read only, so
> +		 * it cannot bound this loop; records read can.  A device that
> +		 * leaves a bit set with an empty log makes no progress, and
> +		 * only the device can clear that state, so stop polling that
> +		 * log rather than spin on it.
> +		 */
> +		stuck =3D status & ~drained;
> +		if (stuck) {
> +			dev_warn_once(cxlds->dev,
> +				      "Event status %#x set with no records to read\n",
> +				      stuck);
> +			mask &=3D ~stuck;
> +		}

[Severity: Medium]
Can this new logic cause spurious warnings and incorrectly stop polling due=
 to
a race with the IRQ setup?

In cxl_event_config(), interrupts are enabled via cxl_event_irqsetup(), and
then cxl_mem_get_event_records() is explicitly called to drain existing log=
s:

        rc =3D cxl_event_irqsetup(mds);
        if (rc)
                return rc;

        cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);

If an interrupt fires immediately after IRQs are enabled but before the
explicit drain, cxl_event_thread() will read the event status register and
might get preempted. While preempted, the probe code completes the drain and
clears the hardware status. When cxl_event_thread() resumes, it calls
cxl_mem_get_event_records() with its now-stale status. The function will
return no records (drained =3D=3D 0), causing this logic to incorrectly con=
clude
the device is stuck, emit the dev_warn_once() warning, and stop polling
those logs.

>  		cond_resched();
> -	} while (status);
> +	}
> =20
>  	return IRQ_HANDLED;

[Severity: High]
This is a pre-existing issue, but should this threaded IRQ handler return
IRQ_NONE if it didn't process any events?

If the handler is woken up but the status register reads 0 on the first
iteration (e.g., due to a spurious interrupt), the loop breaks immediately =
and
unconditionally returns IRQ_HANDLED.

Returning IRQ_HANDLED when no work was done prevents the kernel's core IRQ
subsystem from detecting and disabling a spurious interrupt storm. If a
failing CXL device floods the CPU with MSI interrupts, the kernel will never
disable the vector, which could completely lock up the processing core.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826184417.1042=
-1-anisa.su@samsung.com?part=3D1
