Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416522D12EC;
	Wed, 17 Jun 2026 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781705350; cv=none; b=FpBrIuvlI7EIuhllgYtqWstPLCunp1iGEhWL1rEVMCwCNJT+HNk5DdluivJzaTN3Yd6plCmjuFglzwmbaS7vYRgeB9NEn6CbE4ifyJMgai2e5Vb7jAh/c0wIAgkhNZ+1WnkhNVNBrY4BPvTc3OD6WkZzKY9C+HIld9HwXkp5hXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781705350; c=relaxed/simple;
	bh=pElGO8DdnWVpirRLkNCQR3lp7A6U4z0APfRAFyJC7HE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fNNNdu7paLD2vqwdlojFZivZ8h4I0KtBKeHhyCDHAhRUj+93PCIJgfU4uCE910VAkqvntvNkBmbDpL6qVGHxokDlfvdEQ7f+5+5nMEcOHKHk91r6n5s4frt36dFaPJGxUPT9CCDQzxmh9diH5okZv0SpOKcQj4jOWb/6hjrg00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkYUgmRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkYUgmRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FEA81F000E9;
	Wed, 17 Jun 2026 14:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781705348;
	bh=ojOXwpqpQjyswucugg131KVRIK8IRPfBz6xWmqwJKps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkYUgmRRTc382uGxguAYxa0xkPCHbVi0Ri5uENjbyLSkqkrvl9j9qnw/HijU9TWfl
	 5/owiIcRNA9pOw475yd5fKmNK/O9AZCsfokxn0ni5JonVZDzVUH/SGfgQQEWwP0tGz
	 DKyjBh4Hi1M9mhWTTMH+0dPoSv29bMldomQLfEd7DmH4LG8GDf6i1UQdgaQZ6Cstvi
	 KHltgGswRjQZTc2mzKrCrzgQffIGnuEGdhNvU75cen4u4pCVGLmPAC68EtVlVet+nn
	 O+BJXLutL8Ula349sq4kOUhftgi9Mr+fQzpWizvC1ka9BdzC7g3daXJhvX6VCzKt8B
	 5LC/zyq9qvhGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] ACPI: APEI: GHES: share macros via a private
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ahmed Tiba" <ahmed.tiba@arm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-1-91f725174aa0@arm.com>
References: <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com>
 <20260617-topics-ahmtib01-ras_ffh_arm_internal_review-v6-1-91f725174aa0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 14:09:08 +0000
Message-Id: <20260617140908.9FEA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing irq_work_sync() during GHES device unbind leads to a Use-A=
fter-Free of `struct ghes`.
--

commit e704c2dde2d2667b464a2f5a2c5c45ed826cc539
Author: Ahmed Tiba <ahmed.tiba@arm.com>

ACPI: APEI: GHES: share macros via a private header

This commit moves CPER helper macros and function prototypes out of
ghes.c and into a private header. This allows these helpers to be
shared with other firmware-first error sources.

> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..4f67f46410c46 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
[ ... ]
> @@ -313,7 +255,7 @@ static struct ghes *ghes_new(struct acpi_hest_generic=
 *generic)
>  	return ERR_PTR(rc);
>  }
> =20
> -static void ghes_fini(struct ghes *ghes)
> +void ghes_fini(struct ghes *ghes)
>  {

[Severity: High]
This is a pre-existing issue, but does ghes_remove() need to call
irq_work_sync() before freeing the ghes structure to prevent a
use-after-free?

When unbinding a GHES device, ghes_remove() unregisters the error
notification handlers and calls synchronize_rcu(). While this ensures no new
handlers will execute, it does not wait for any already-scheduled irq_work
to complete:

drivers/acpi/apei/ghes.c:ghes_remove() {
	...
	ghes_fini(ghes);
	...
	kfree(ghes);
}

If irq_work_queue(&ghes_proc_irq_work) was called just before the handler w=
as
unregistered, the work remains pending. When the asynchronous work runs, it
dequeues the node and dereferences the freed ghes pointer:

drivers/acpi/apei/ghes.c:ghes_proc_in_irq() {
	...
	estatus_node =3D llist_entry(llnode, struct ghes_estatus_node, llnode);
	estatus =3D GHES_ESTATUS_FROM_NODE(estatus_node);
	...
	ghes_do_proc(estatus_node->ghes, estatus);
}

Could this lead to a use-after-free when ghes_do_proc() accesses ghes->dev
and ghes->generic?

>  	kfree(ghes->estatus);
>  	apei_unmap_generic_address(&ghes->generic->error_status_address);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-topics-ahm=
tib01-ras_ffh_arm_internal_review-v6-0-91f725174aa0@arm.com?part=3D1
