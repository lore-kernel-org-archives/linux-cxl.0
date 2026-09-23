Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D8414A3B
	for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185281; cv=none; b=ZkNixTNho1v514S/o/1NZjlazCQQobxT42jqAlieJjuxiUYH6MVIDynT+WwW10ZfEaNWtfyUjwkvKf7XwLl2b5hLHEKkO+waKilCUCJRtMW7NQwDb7eNzzyJuQ651Vlm58bsvIjWMp7PaRRlzxO5M7UMP2h49BDnbo3GmJVPFV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185281; c=relaxed/simple;
	bh=8m7eP/1UtYiDAiJtdBf49/o6VBNsOWV+uJv+8Zp1JU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXaK5yv/Lwmm5wWTWLjAQhLxjz/mRNRVL0pSdKH9ZcLDbVFkas+CnQ7G+zmvPRc3NouIih5evqr7aUrAQqQXOzp974ASiQ4TS3OA2ASPlVNFN+tAeDcoO977kvjdw6SMcLDR9qvpTiJe7IW9EmpEt8OmZcsNXExIbh4y8G5i9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqmCfQ3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqmCfQ3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E001F000FF;
	Wed, 23 Sep 2026 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790185277;
	bh=ujqYjfNckY5MGqDqjM20DTRpZNxO+UhIh9NJz24RskY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eqmCfQ3ow8Eh9Fh6Wgnax1RlJStQbmko+QKQTuYS8HRefhjmMIQipDdksi+vd0lDE
	 S0eWGEQA0p7C/PZY73adfypnOWzlfJoALUBpMq6FMqnXPw/5+UeJtrvg8593Mk4nb7
	 du0u4MNEfVoPFfj0ufyw3ryQd6ouhtKh7yB41d+71nfcz2aastzKEFzGawPR1uE/qv
	 yKHFLgbqw5sjkeGNkbsrGRvWNRnLph7ysyi0OscsLd7rbbUCbzqvkjovM/NG0o0QbT
	 M6ZKLt91MsuYsyD8uh+VuoZpJHBJDStMwtLh/zNSqTo5qobc4vEHbdTDXFoP42Vhok
	 ymNSZVDbHiu2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] cxl/core: Add CXL.cache device struct
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ben Cheatham" <Benjamin.Cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260923173342.5584-2-Benjamin.Cheatham@amd.com>
References: <20260923173342.5584-1-Benjamin.Cheatham@amd.com>
 <20260923173342.5584-2-Benjamin.Cheatham@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 17:41:17 +0000
Message-Id: <20260923174117.A6E001F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cxl: unused 'attach' parameter in __devm_cxl_add_cachedev()
--

commit 16ca3df82e8ba8b03985c5445d288c9759b9ba65
Author: Ben Cheatham <Benjamin.Cheatham@amd.com>

cxl/core: Add CXL.cache device struct

Add a new CXL.cache device (struct cxl_cachedev) that is the cache
analogue to struct cxl_memdev. This device will be created by CXL type
1 & 2 endpoint drivers to enable and manage the cache capabilities of
the underlying PCIe device via the CXL core.

> diff --git a/drivers/cxl/core/cachedev.c b/drivers/cxl/core/cachedev.c
> new file mode 100644
> index 0000000000000..3a7a60165f621
> --- /dev/null
> +++ b/drivers/cxl/core/cachedev.c
[ ... ]
> +struct cxl_cachedev *__devm_cxl_add_cachedev(struct cxl_dev_state *cxlds,
> +					     void *attach)

[Severity: Low]
Is it intentional that the attach parameter is completely ignored in the
implementation of __devm_cxl_add_cachedev() in drivers/cxl/core/cachedev.c?
Any data passed to it is silently discarded, which might cause API confusio=
n.
Does it perhaps stem from an incomplete copy of __devm_cxl_add_memdev()?

> +{
> +	struct device *dev;
> +	int rc;
> +
> +	struct cxl_cachedev *cxlcd __free(put_cxlcd) =3D
> +		cxl_cachedev_alloc(cxlds);
[ ... ]
> diff --git a/drivers/cxl/cxlcache.h b/drivers/cxl/cxlcache.h
> new file mode 100644
> index 0000000000000..6ca887e078a1e
> --- /dev/null
> +++ b/drivers/cxl/cxlcache.h
[ ... ]
> +struct cxl_cachedev {
> +	struct device dev;
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_port *endpoint;
> +	int id;
> +	int depth;
> +};

[Severity: Low]
Should struct cxl_cachedev in drivers/cxl/cxlcache.h have an attach member
to store the attachment data provided to __devm_cxl_add_cachedev()?

> +
> +bool is_cxl_cachedev(const struct device *dev);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923173342.5584=
-1-Benjamin.Cheatham@amd.com?part=3D1
