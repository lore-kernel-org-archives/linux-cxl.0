Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1731E0E14
	for <linux-cxl@vger.kernel.org>; Tue,  1 Sep 2026 00:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788223287; cv=none; b=CuM4lGxGio2oGu3zFYlzt012nL9f0VVqaFOSiV9nGb7k21K2nikID0FleKHep3ErB0HPtx4fFZwil8YI3KQsfgrKpjLlJNmolb5QflL55d9/7v/ZZ5MMhgWF+JniALBnshQ2qFcMIIIO7EAPjrRX+ef+5rhA4pofLpD4YvgOR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788223287; c=relaxed/simple;
	bh=JHSppJbPaqRtiX+fYOeIg001EEzVEaPSnprDD8bIBhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZYsYKW/UE0N75W/mPsXgbtH7X0iMZp1EXApIDcthy9iipefTqpbnwJF9u0KKC7EsmWTaH8yMK2s1X9unHwqk7mXH+REX2YN7Hch2Hvo4EVVtOKIj0PpYBcUwDxgjiuAcTFamI+41vkwYnJOA12Rma70nY/WRCBBCoi8x2fvWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcSPer0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcSPer0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B641F000E9;
	Tue,  1 Sep 2026 00:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788223279;
	bh=DF96gJEVnXgjo2ZUdSCMS7qHJ14DYeUUuJp06XBSbRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PcSPer0OGvV2Mp750iirLzX9Mo8Sf6YxkCzxUt+motqSqcZewaiTqS6FAlweo9yKN
	 VId50o2LC9Nc2kSZWrnBDO+iTEBZqxgFg4zzRaoC6HffEPV1gnI8TnrTyOXkR56CmU
	 sgP6Yv6eOim2/V40gJIoxNt55iO/scAALp4lbUTcigDq4+Z3PiyUHb3mDv4xKbpHQ/
	 c/6A9j8dMCwAL5hyh0J+Q9NEmMy8s5wRY49hcU8/N82+nUqZTODV8uVDuPM7b1pGrj
	 smQAna3hCFNqVz27W5HauYdkI8hCdFoiTiysQ7X7skLZ8EE8zDfFZrQldw1OUoninU
	 6U4kl4TFCI2tQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] cxl/events: Bound get records loop in
 cxl_event_thread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anisa Su" <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260901002912.958-2-anisa.su@samsung.com>
References: <20260901002912.958-1-anisa.su@samsung.com>
 <20260901002912.958-2-anisa.su@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 00:41:18 +0000
Message-Id: <20260901004118.E1B641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Error aggregation masks retryable errors, causing transient failur=
es to be permanently abandoned without retry.
- [Medium] False positive hardware warning due to race condition between co=
ncurrent IRQ threads.
--

commit 16c815c8618408dc3d242d5fe42bbf41248f7c71
Author: Anisa Su <anisa.su887@gmail.com>

cxl/events: Bound get records loop in cxl_event_thread()

This commit limits the cxl_event_thread loop by checking completed work
rather than only relying on the hardware Event Status register. It bounds
the retry attempts for retryable errors (-EBUSY, -ETIMEDOUT, -EAGAIN) and
gives up on permanent errors.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 7c6c5b7450a54..2b71a8e1f35f7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
[ ... ]
> @@ -1112,31 +1129,60 @@ static void cxl_mem_get_records_log(struct cxl_me=
mdev_state *mds,
[ ... ]
> +	for (int i =3D 0; i < ARRAY_SIZE(logs); i++) {
> +		bool got_records;
> +		int rc;
> +
> +		if (!(status & logs[i].status))
> +			continue;
> +
> +		rc =3D cxl_mem_get_records_log(mds, logs[i].type, &got_records);
> +		if (got_records && drained)
> +			*drained |=3D logs[i].status;
> +		ret =3D ret ?: rc;

[Severity: High]
Does this error aggregation mask retryable errors?=20

If an earlier log encounters a non-retryable error (like -EIO), it is stored
in ret. If a subsequent log encounters a retryable error (like -EAGAIN), the
earlier error takes precedence due to the ret =3D ret ?: rc logic.

Back in the caller cxl_event_thread(), the loop checks the return code:

    rc =3D cxl_mem_get_event_records(mds, status, &drained);
    if (rc) {
        if (!cxl_event_drain_retryable(rc)) {
            dev_warn(cxlds->dev, "Event log drain failed: %d\n", rc);
            break;
        }
        ...
    }

Will this cause the thread to abort the entire batch and abandon the transi=
ent
error without retrying, permanently losing those hardware events?

> +	}
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
> =20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c2..239df18c9c87b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
[ ... ]
> @@ -509,26 +509,75 @@ static bool cxl_alloc_irq_vectors(struct pci_dev *p=
dev)
[ ... ]
>  static irqreturn_t cxl_event_thread(int irq, void *id)
>  {
[ ... ]
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
[ ... ]
> -		cxl_mem_get_event_records(mds, status);
> +		rc =3D cxl_mem_get_event_records(mds, status, &drained);
[ ... ]
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
Is there a risk of a false positive hardware warning here due to a race
condition?=20

If multiple event logs share an IRQ vector, two concurrent cxl_event_thread
instances could race. If Thread A drains the events, Thread B would receive=
 no
records, and its call to cxl_mem_get_event_records() would return with
drained =3D=3D 0.

Thread B would then evaluate stuck =3D status & ~drained using the stale st=
atus
value read at the beginning of the loop.=20

Could this lead to Thread B incorrectly concluding the device is stuck and
prematurely masking the log for its iteration?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901002912.958-=
1-anisa.su@samsung.com?part=3D1
