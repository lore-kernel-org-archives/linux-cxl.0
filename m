Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD73B3888
	for <linux-cxl@vger.kernel.org>; Sun,  6 Sep 2026 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710944; cv=none; b=lTcgTnxM/73SbSiyDJY/TSqNe0gN/SvyvK/kGGoGdMPuKzhRxGffKenGJRCOcbCxd1aaWcJ6cS03uu7EwlffA1ra24Bt+M6jWh0i3tIEqFkSOkZHy6jSJtPYqhAfKJTExmqaOcab/WSLkjZzQyOjc/7kIOsTNEewOBYIwamXCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710944; c=relaxed/simple;
	bh=JdHhtnL0hTJrXTXKUz01pje81QrUPSbvKQysGFcnIJk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eQiQ+9JdHeiljZUl4+WhsXpmTZozPJ0DmmYI7d6MD+GYC4mDPXMgalzAIxmGanTdC7fQkOGwHqieABt9ahhk5vbs2ORRQl4MCzpi3jbGkp7c7CZtw9bMTZZiWfrJ59+ns+9sUlscjcoVqrKJVcF55Pfp+e0KMcqLwebubei6MZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlkK7I9q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlkK7I9q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F851F00A3A;
	Sun,  6 Sep 2026 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710941;
	bh=7sJ41YPEqOrNzOmF5ANQYqjYRtQybEN4P8nQp929iTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PlkK7I9qqbnKBHmYm5xcCt42Pk3myd1hTRuouD/8a4IDsLRYte5/nP9rbN/5T7K3x
	 EHJXDMZ8trxv049JcS4AqiV7b0mQTPKNXbEAbXf1qI7SV3njHfA2MibqwRql8G6JJx
	 XJlS7p4xE0t66cPCy0OxJ51aX5ppRobMrJypOuCjC4Hy2Fudcwg9aP+Z5O6FyvwO/m
	 b/c3EZ8vU56Hrc7zJol7SnvooyT5dL0MIFqEiOCwabIBIfyCEoxF15dVpN0w4OtP6y
	 Cw/fZUHLCqWnrkzAT3Ux7zvpttxFWCNjwoxb9PpKFLeKx9Nvti0jSMdBxRXu86MsAJ
	 NWxWCXIcQ8Zuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] cxl/events: Return IRQ_NONE when no event is pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shaikh Kamaluddin" <shaikhkamal2012@gmail.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
References: <20260906155705.13252-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:09:00 +0000
Message-Id: <20260906160901.49F851F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `cxl_event_thread` can enter an infinite loop on device surpri=
se removal or mailbox hardware failure, hanging the CPU and permanently mas=
king a shared IRQ line.
--

commit f6cda8d59c7a077a8328222a63290241e9b118c0
Author: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
cxl/events: Return IRQ_NONE when no event is pending

This commit tracks whether at least one supported event status bit was obse=
rved
during interrupt handling. It returns IRQ_NONE when there was no event to
service, allowing the shared interrupt handler to behave correctly.

> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c7c91e8dc51dc..8b560cae91f2e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -515,6 +515,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)

[ ... ]

>  		status &=3D CXLDEV_EVENT_STATUS_ALL;
>  		if (!status)
>  			break;
> +
> +		handled =3D true;
>  		cxl_mem_get_event_records(mds, status);
>  		cond_resched();
>  	} while (status);

[Severity: High]
This is a pre-existing issue, but can cxl_event_thread() get stuck in an
infinite loop here?

If a CXL device undergoes a surprise removal or a mailbox failure,
cxl_mem_get_records_log() can abort early without clearing the hardware
event status:

drivers/cxl/core/mbox.c:cxl_mem_get_records_log() {
    ...
		if (rc) {
			dev_err_ratelimited(dev,
				"Event log '%d': Failed to query event records : %d",
				type, rc);
			break;
		}
    ...
}

Because the local status variable evaluated in the while condition remains
non-zero, the loop will restart. If the memory-mapped read at the top of the
loop then returns 0xFFFFFFFF or the stuck status, the loop will spin endles=
sly,
permanently masking the shared interrupt line.

Should we add a mechanism to break out of this loop or track whether the
hardware status is actively being cleared?

> =20
> -	return IRQ_HANDLED;
> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906155705.1325=
2-1-shaikhkamal2012@gmail.com?part=3D1
