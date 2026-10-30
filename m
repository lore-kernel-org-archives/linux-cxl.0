Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.248.84.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342118;
	b=pBFGGr4A+bAjL8wLbsAc+SPdkEjIcMNeqwAqbJBI/NE3EWOiT0ov8Pro1zP+Ci+DbOdf
	 jIBq75QjqZr7khKUrpi6oev8pZoW5S78sYO/V225xrHO3olrlVUKJF19wBVHZ7XDZay+B
	 xTCxPWuCgLkFuJDRjWLrWawWa0Ktdkoj/o2KEu6DJvDp+w2GYgaVsgQIhiTF35BcH//+M
	 Z5PFm7c8NKPsIlH4fpW9vUGIMbbK/cDxXx+EsXKLe+AI4C7V+mjBOPHhbG8Xt0l9BcyTA
	 ynlY+VxIN3vgAU0lCFdVuiGLlsjK3nbNAjFgIr+TjmV3Wmf+fnls0n80uaPl6o7Qoyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342118;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aio3IJjfBbH+CxWKmgS3Mqr4D2Kbrp0sWicok66Ts4c=;
	b=3xG7tY81qxXcMCEVmK3RQyWpuKKikJb4YYDayhCRdaDNs907TuR8O3xrb2xPg9CkYNtS
	 teu9znRjK8ZgHRw12Xj4HTz4RMpLVkOWnIR39ojU20DyBb3vgBdbV+XiLayoYQEe2sbns
	 QgUmRfuz74KuWjMv8F2CWI6ecXwmu5wgEfbWqZkU3ISH30mcwQ5dAXrHhBERRE4WYGdj1
	 wDxDH9UQENeE0cZ9XULrFfzvXOVTlOQc13b6J253mMqQooqARr+v7bzkRgsvSQMpczXqR
	 44hjrvUzn6P0oblTIt4L9HCtfUkwUAaHcE42Ri7MwHx39wGYSI43WCvQgpouPG4L5hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tls.msk.ru;
	spf=pass smtp.mailfrom=tls.msk.ru;
	dkim=pass header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b="UNs4/6EG";
	arc=none smtp.remote-ip=212.248.84.144
Received: from isrv.corpit.ru (isrv.corpit.ru [212.248.84.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58182606A31A
	for <linux-cxl@vger.kernel.org>; Fri, 30 Oct 2026 06:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58182606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tls.msk.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=UNs4/6EG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
	t=1793342104; bh=6731h3+ujd/myX06y5bK3DkN8Lvanfed0M3yzMI/1/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UNs4/6EGiUQrp7K27j03TLu3m0xonlLk4OET4/pPhdA90gsj4byccyKO7FwWkPmNU
	 e0ASXJHpMk1WxSlQqERdgRZglcFupWi3ELkc+8sMQ7x1aME4E6EvUJ37XmEDDk983E
	 vccwFmNn0J6ACKw+RILYgBqqai2oRfNAyPNdxf3pu2TfZtNGQ7vBVlgys+9qw4FwtR
	 nXDy9bCPaU+VWGsYJp6CXK+ABkXhDdB8APKDg4zG1vYS292TqTwBwAPnCPwiujCz0q
	 6B5ra8+em9kUPz0p9src6vq70djihmkELX9Ke7bYNKFVOLtLj0qGoJHJ9NbHnNFZP/
	 vgE72DNTb4NRA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id E9EBD1E2740;
	Fri, 30 Oct 2026 09:35:04 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
	by tsrv.corpit.ru (Postfix) with ESMTP id A3E8144EC5D;
	Fri, 30 Oct 2026 09:35:04 +0300 (MSK)
Message-ID: <379a2300-b1af-4b32-9d10-7a8347c22476@tls.msk.ru>
Date: Fri, 30 Oct 2026 09:35:04 +0300
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] hw/cxl: fix Type-3 device reset resource leaks and
 convert to three-phase
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: jic23@kernel.org, linux-cxl@vger.kernel.org, philmd@oss.qualcomm.com,
 qemu-stable@nongnu.org
References: <20260729144645.1552511-1-junjie.cao@intel.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20260729144645.1552511-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 17:46, Junjie Cao wrote:
> The CXL Type-3 device reset path (ct3d_reset) has several issues:
> 
> 1) Resource leaks:
> 2) Incomplete state cleanup:
> 3) Deprecated API usage:
> 
> This series fixes the issues incrementally:
>    - Patches 1-2: fix resource leaks (deterministic bugs)
>    - Patch 3: mechanical conversion to three-phase reset
>    - Patch 4: factor the primary CCI teardown into a
>      cxl_destroy_mailbox_t3() helper pairing cxl_initialize_mailbox_t3()
>    - Patches 5-7: clean up device state on reset

> Junjie Cao (7):
>    hw/cxl: fix timer leak in cxl_destroy_cci()
>    hw/cxl: destroy primary CCI before re-initialization on reset
>    hw/cxl: convert cxl-type3 to three-phase reset
>    hw/cxl: add cxl_destroy_mailbox_t3() as the mailbox teardown
>      counterpart
>    hw/cxl: discard in-flight sanitize state on mailbox teardown
>    hw/cxl: clear event logs, scan media and interrupt policy on reset
>    hw/cxl: clear poison lists and feature transfer state on reset
Hi!

This patch series has been Cc'ed to qemu-stable@.  It is interesting how
it's been Cc'ed, and I think there's some error here.  From whole series,
only patch 2 (destroy primary CCI before re-initialization on reset) is
tagged for-stable.  Patch 1, which is a fix, is not tagged, and not Cc'ed
to qemu-stable@ either.  The rest - patches 3-7 - has been Cc'ed to the
qemu-stable mailing list, but are not tagged for-stable.

 From this list, I'm only picking up patch 2, and only for 11.1.x series.
The other active stable series, 10.0.x, - apparently it's not needed there.

FWIW.

Thanks,

/mjt
