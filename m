Received: from sg-1-101.ptr.blmpb.com (sg-1-101.ptr.blmpb.com [118.26.132.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2B6410D09
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905632; cv=none; b=SqCsCqY/2MzOR8KBKsQDNJE8VHT9fo6/5jNr3kCA+yNAiPkvR6pWAMW9B4c3pPj01onyIKBSnYT58kyaCRWSzi3yBzDMxTV2CPxhd2WULKn0Mk4GRXZNz2F/cru3a6OWvZ1uB4v3r0JjKwLeKl+FGBhyLM5U87xRevoBPOoFJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905632; c=relaxed/simple;
	bh=Y8w4+BdTy001uShPE7SVF7VvvXq4NVGP8qWYzo9Nwiw=;
	h=Content-Type:From:Date:Mime-Version:References:In-Reply-To:
	 Message-Id:To:Subject:Cc; b=F/YOEkKCPfYDqx3m1w1Ht2pFI3jF4N6pOL8NNw2UP38pAEqAFVAM5IVKAwg00ffkpub1yUmgcU3C6h5EtzL0uuFEu0G5zLnmvRAXVUPusN9A/J6C6ipLpk80L/WUqdQ7cqaUVIpy0qhKYq4cQCt95t5SDaEDVTSxwyzH30TxdHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=nwjJgEYI; arc=none smtp.client-ip=118.26.132.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="nwjJgEYI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1768905617; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Y8w4+BdTy001uShPE7SVF7VvvXq4NVGP8qWYzo9Nwiw=;
 b=nwjJgEYIkR/EkpwgeU678wMUKG59wPyGPfiWUlCFoujwJV2aDy/5f84BDN78CWeanzc3fS
 g5emaoUJLPpBtpbYS88OMXlBj+LFQFvnABAqpDfZOauOpsf0xI8UKc6HodXS1uVtpxr85c
 WRpVGefUu5iJJWHJiZ3ymjotP9OoKsEJBAcluGOUuBtaKgCLQNf1kp/2ZPoL28XLKv97W1
 SzC6SWfh3UQdMyn9b64Ei/zpUloRy0XvBfnGHLxElp8gVYMEdNDUyhumzdTqYNlcLCQ7l7
 MC1n58xwMYRCpY80s3iVTIgjAilY4v3vhbsR+R0SF+1yTtZg1/oVtR1GngYhdQ==
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Tue, 20 Jan 2026 18:39:48 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <20260120094744.5d92e34a@pumpkin>
In-Reply-To: <20260120094744.5d92e34a@pumpkin>
X-Mailer: git-send-email 2.45.2
Message-Id: <20260120103949.7673-1-lizhe.67@bytedance.com>
To: <david.laight.linux@gmail.com>
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2696f5b8f+133131+vger.kernel.org+lizhe.67@bytedance.com>
Cc: <akpm@linux-foundation.org>, <ankur.a.arora@oracle.com>, 
	<dan.j.williams@intel.com>, <dave@stgolabs.net>, <david@kernel.org>, 
	<fvdl@google.com>, <gourry@gourry.net>, <joao.m.martins@oracle.com>, 
	<jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mhocko@suse.com>, <mjguzik@gmail.com>, 
	<muchun.song@linux.dev>, <osalvador@suse.de>, <raghavendra.kt@amd.com>, 
	<wangzhou1@hisilicon.com>, <zhanjie9@hisilicon.com>

On Tue, 20 Jan 2026 09:47:44 +0000, david.laight.linux@gmail.com wrote:

> On Tue, 20 Jan 2026 14:27:06 +0800
> "Li Zhe" <lizhe.67@bytedance.com> wrote:
>=20
> > In light of the preceding discussion, we appear to have reached the
> > following understanding:
> >=20
> > (1) At present we prefer to mitigate slow application startup (e.g.,
> > VM creation) by zeroing huge pages at the moment they are freed
> > (init_on_free). The principal benefit is that user space gains the
> > performance improvement without deploying any additional user space
> > daemon.
>=20
> Am I missing something?
> If userspace does:
> $ program_a; program_b
> and pages used by program_a are zeroed when it exits you get the delay
> for zeroing all the pages it used before program_b starts.
> OTOH if the zeroing is deferred program_b only needs to zero the pages
> it needs to start (and there may be some lurking).

Under the init_on-free approach, improving the speed of zeroing may
indeed prove necessary.

However, I believe we should first reach consensus on adopting
=E2=80=9Cinit_on_free=E2=80=9D as the solution to slow application startup =
before
turning to performance tuning.

Thanks,
Zhe
