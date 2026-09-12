Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063E37702C
	for <linux-cxl@vger.kernel.org>; Sat, 12 Sep 2026 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789206489; cv=none; b=Qgp4MGEWT3uYhq7DpoP6DZSPDDsXalsnm27cfoxwuec0MQuLzk0M9fUm/0xI4LNQFRJdWBtZ2qoiOrip3oIjFaXawvl4AmSIR5uZQQkDwa1OOc0okDUXYI8z7WBQ60ORzCx2qrwwZTkTrvnZ0JPq8YmnYNt+P5RWid6uP1G3rNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789206489; c=relaxed/simple;
	bh=gWjq/mEZiyCL/MHVajCZ2S3FZ+tHuqYpOb1VXeQU1Y0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FjJYkWaAsAgOY6AiQjn0PnQ4CS+du6YLI0MN1K0ULvrR4sLo11Uc/QCbmShaHyNEBBIfURAFbqAyac4CxA5YIbanjvNn9a4wCeNlxpU5J0Y2ikxs/mHWd4k9yMlK9+d/utweF6DE1kuCcD/BjqZ7QY13g4jzWXhvlsyM4SJxG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVczPglG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVczPglG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E461F000FF;
	Sat, 12 Sep 2026 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789206487;
	bh=Na8xhxj8vcIfDJrP3zSS2beGc4rfBFmvMEyoQR+9OBg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVczPglGDTsNOooDDS+DQHuzPrKhHtc+MYX06tNelZB+K8IwC0BJPkVdY9Vs/1CHU
	 DyhGewlcbpIv4p3HY1Zertet8TLbaqZzknyQ9VtSOSksnCsTYdATgCC+IbAKs3lOeQ
	 GGPFEKM2U5l3z5lKjX+7TSZn2sLLtx4qwtdBpPP0Bk0v/9UVA8DhcV+S/jaJVsPGbN
	 IJyosRwL9AcXqqfTtxM7PEUOGCMN2Z42PGbbIaMK8RI3n7fsebQGsvWpM2Q3hwKgU1
	 IdFso/gqTmi7xt5fzrFqn2F+Xbidx3sAbDXp5vEQEH7Tpb/VmknCZ6lxT12JN5i91+
	 eig6xhgEg3jVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] cxl/events: Return IRQ_NONE when no event is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shaikh Kamaluddin" <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
References: <20260912093815.14455-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 09:48:06 +0000
Message-Id: <20260912094807.65E461F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The threaded IRQ handler `cxl_event_thread()` can enter an infinit=
e loop if mailbox commands fail to clear event records on the device, or if=
 a PCIe surprise removal causes the MMIO read to persistently return all 1s=
 (~0U).
- [High] The driver blindly trusts the `record_count` and `count` fields re=
turned by the device in mailbox payloads, leading to out-of-bounds kernel m=
emory reads and potential information leaks.
--

commit 659b756fc25aa4e783ce4a882044a537d7b5d643
Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>

cxl/events: Return IRQ_NONE when no event is pending

This patch tracks whether the CXL event handler claimed the interrupt and
returns IRQ_NONE when no supported event is detected. This allows the gener=
ic
spurious-interrupt detector to identify and disable the affected IRQ during
interrupt storms where no handler claims the event.

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51dc..8b560cae91f2e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
[ ... ]
> @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>  	struct cxl_dev_id *dev_id =3D id;
>  	struct cxl_dev_state *cxlds =3D dev_id->cxlds;
>  	struct cxl_memdev_state *mds =3D to_cxl_memdev_state(cxlds);
> +	bool handled =3D false;
>  	u32 status;
> =20
>  	do {
>  		/*
>  		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
>  		 * ignore the reserved upper 32 bits
>  		 */
>  		status =3D readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
>  		/* Ignore logs unknown to the driver */
>  		status &=3D CXLDEV_EVENT_STATUS_ALL;
>  		if (!status)
>  			break;

[Severity: High]
This is a pre-existing issue, but can this loop become infinite if a PCIe
surprise removal or fatal device error occurs?

If readl() returns all 1s (~0U), status & CXLDEV_EVENT_STATUS_ALL will
still evaluate to a non-zero value, passing the if (!status) check. The
handler will then call into cxl_mem_get_event_records() where mailbox
commands will fail on the removed device, exiting without clearing the
hardware event status.

Since status is never cleared and the error handling doesn't break the
loop, this evaluates to true at the while (status) condition and repeats
indefinitely. Does this IRQF_ONESHOT threaded handler need to check for ~0U
to avoid monopolizing a CPU and preventing device teardown during hotplug
removal?

> +
> +		handled =3D true;
>  		cxl_mem_get_event_records(mds, status);

[Severity: High]
This isn't a bug introduced by this patch, but does this code blindly trust
the record_count returned by the device hardware?

When cxl_mem_get_event_records() calls into cxl_mem_get_records_log(), the
driver reads the count directly from the untrusted payload:

drivers/cxl/core/mbox.c:cxl_mem_get_records_log() {
    ...
    nr_rec =3D le16_to_cpu(payload->record_count);
    ...
    for (i =3D 0; i < nr_rec; i++)
        __cxl_event_trace_record(cxlmd, type, &payload->records[i]);
    ...
}

If a compromised or malicious CXL device returns an artificially large
record_count, could this read out-of-bounds kernel memory and leak it to
userspace via tracing?=20

The same pattern appears in cxl_clear_event_record() and
cxl_mem_get_poison(), where the untrusted count is used as a loop bound.
Should the payload size be validated against mbox_cmd.size_out or the
maximum allocated buffer size before iterating?

>  		cond_resched();
>  	} while (status);
> =20
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912093815.1445=
5-1-shaikhkamal2012@gmail.com?part=3D1
