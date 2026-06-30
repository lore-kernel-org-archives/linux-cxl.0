Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E22609FD
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827513; cv=none; b=VQsc1wWandwfI5TA9mGy4HOZF4mALmR/CCQ+kb1v18/oFgy4qA3GUbNTBhxGNwpK4beFC1xEsS6Kbzh+2NthW+j413kA2WkxyuyGprYGV7FB95H1wsB+yYJrFdfJiDiyz8niSDnzVHq5Hb/vRxw+qWyrFpQrJLyXXa9eZgPFMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827513; c=relaxed/simple;
	bh=CgCHn30jHkswvrwnw+7TueSGOC2gvnvV19+xF/VB0/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ei3bNAYaRfUy8fEJKu/if12bQ707CS9DI/fjqLoMrdmD+RJ3XxHw56oj8NkFo7tKNwKxfOqS6CD6EMa1IS0E354vBFf/eD+tSzYBwfPqkTrAOtIV9bPIvo9Tzg4fKIoiPw+qtOPQmaeulRv5k+C+ERIKr4Sl+BNtY7Ca9O1X3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN0oKE7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN0oKE7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07021F000E9;
	Tue, 30 Jun 2026 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782827512;
	bh=QWJd/ArA6jLIE6MQpR1qFGXeqJU1RJYhUYuGnY/NbkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UN0oKE7O3/4Ub8bqNQCw1p/ZiOjUbmZP6E2IT6z3jF93Wq6yz6cOlWEia6l/qdJ5L
	 Dwdram+RpXGvizX8jg+mDEwkl6y2MdQ7+prr07pNMZMKvEqFDXZSjMn27wbOh85YNp
	 3VBJdvcz5Cgl1tsZDBFBKXga5s0JbITKLrV0NjviCSEb76bPQ1Xi7I7iNBS7PjGbDB
	 y7wenohX7u9YTXDJlOMhDYTeeO+fTnKtC8bi5FbhOBcvmb0eMwzugHdiW/YdcTcW2B
	 chFOQhQcqmq4Q4bc6MIszEJUXw4UptCwH0mmRwd0/Fqdz9sLmCLR4SyuDWAIztRmY7
	 KFfPsgTiP2Agg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier
 block
Reply-To: sashiko-reviews@lists.linux.dev
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
 <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:51:51 +0000
Message-Id: <20260630135151.D07021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow during the ACPI HMAT locality table size calculat=
ion bypasses bounds checking and allows out-of-bounds memory reads.
--

commit 69d5452dda77c729836d9ff08f4b38f9cff8d91b
Author: Alejandro Lucero <alucerop@amd.com>

acpi/hmat: preserve hmat_adist_nb notifier block

Remove __meminitdata from hmat_adist_nb declaration preserving it even
when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
registrations using register_mt_adistance_algorithm() will find a
notifier chain likely corrupted. This is the case when a CXL Type2
driver will load after kernel initialization and a CXL region created from
its committed HDM decoders registers an mt_adistance_algorithm notifier.

> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 9792dc3947561..3006789ae31fe 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a regression where an integer
overflow during the ACPI HMAT locality table size calculation could bypass
bounds checking.

When parsing the locality table, total_size is declared as a 32-bit unsigned
integer:

drivers/acpi/numa/hmat.c:hmat_parse_locality() {
	...
	unsigned int init, targ, total_size, ipds, tpds;
	...
	ipds =3D hmat_loc->number_of_initiator_Pds;
	tpds =3D hmat_loc->number_of_target_Pds;
	total_size =3D sizeof(*hmat_loc) + sizeof(*entries) * ipds * tpds +
		     sizeof(*inits) * ipds + sizeof(*targs) * tpds;
	if (hmat_loc->header.length < total_size) {
		pr_notice("Unexpected locality header length:%u, minimum required:%u\n",
			 hmat_loc->header.length, total_size);
		return -EINVAL;
	}
	...

If abnormally large values are provided for ipds and tpds, could the
intermediate arithmetic be truncated when assigned to total_size?

If this wraps around 32-bit boundaries, wouldn't it result in a small
total_size that bypasses the hmat_loc->header.length check?

Later loops use the unbounded ipds and tpds variables:

drivers/acpi/numa/hmat.c:hmat_parse_locality() {
	...
	for (init =3D 0; init < ipds; init++) {
		alloc_memory_initiator(inits[init]);
		for (targ =3D 0; targ < tpds; targ++) {
			value =3D hmat_normalize(entries[init * tpds + targ],
					       hmat_loc->entry_base_unit,
					       type);
	...
}

Does this lead to out-of-bounds memory reads if the total_size calculation
overflows?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630143507.3019=
3-1-alejandro.lucero-palau@amd.com?part=3D1
