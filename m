Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4230566F
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 21:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695105; cv=none; b=Gsh3x5RUtlY2YgLdtA2HQizDhz8pn6gbblzbx+v6Nu2k4w4OaSGoT3fEhOCLKzYJbt3RasoDafd4iNPDoF8fmLCRabJKJmQTb/zLiHHmBsiQF6yQyqGKP+AuQbD9BqF1lFo8smB9hRBsHODXvVQ0IuunSWuroiSWclqhEdAd+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695105; c=relaxed/simple;
	bh=TvbYZ0hhqMvFQEaI8b+Qz6GGk+4Mu/hdU4o9P47DNAw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oO2HG05+G90vHKRnPQLTLhIEHjD9ln0+EsV7BBXD02Ua0yCrjUwBN2Ctwsvj+HQWNS2hmfjCpasMfYZqJ97tAMrQvQAAR84zbZsyg+DmwLvdcsKO0v3aT7Abh2GJV86YH77BpsD1gkSialg6ADL8EvMgTOHTTRE/nhHvifdqr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH9eH+/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH9eH+/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18F01F00893;
	Fri,  5 Jun 2026 21:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780695103;
	bh=QmTGlJD57Selri8f6eP+cUldQWCyPxPjglD2hTDtCDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AH9eH+/14uAdzKgmWvGOIrq8Dtsp44hPpO25TNcAArEHD39JnefxzlQMSGSUHR02a
	 8mxJSDDdLJJrNbbunc0oe95x1JEhhowdM/VXJDK2u2+3clPto5pwRYJvv2I+F2zWSi
	 RlPtyShJzaTflQvvj7zYZp/FhtKewnFvT5iwnoqs45VOeTfZkW2nvIQlfzLFhHqfUR
	 ZbKGSV6jbGv1sQcNcaSz2RZuAXKXCEKvGt6KFkD0wLbV3a3UJqiovGopJNQxyUhwPR
	 Q/uLmgxMMAhecwQyWpWezGm+48auKnual2MPqBiY6wlPh2YHbL4bLK0UZyw5KaGqz8
	 axWSNBe5hT9xg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/9] dax: plumb hotplug online_type through dax
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gregory Price" <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260605211911.2160954-7-gourry@gourry.net>
References: <20260605211911.2160954-7-gourry@gourry.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 21:31:43 +0000
Message-Id: <20260605213143.A18F01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The default auto-online policy is captured at DAX device creation =
time rather than at driver bind time, breaking dynamic sysfs policy changes.
--

commit d528bb5263ccfd880f3665a7e5e92516c3faabd8
Author: Gregory Price <gourry@gourry.net>

dax: plumb hotplug online_type through dax

This commit adds an online_type field to the DAX device creation path to
allow drivers to specify an auto-online policy when using the kmem driver.
Existing callers are updated to initialize this field to the system default
policy.

> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 492573b47f662..6611fe399f59e 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -394,6 +395,7 @@ static ssize_t create_store(struct device *dev, struc=
t device_attribute *attr,
>  			.size =3D 0,
>  			.id =3D -1,
>  			.memmap_on_memory =3D false,
> +			.online_type =3D mhp_get_default_online_type(),
>  		};
>  		struct dev_dax *dev_dax =3D __devm_create_dev_dax(&data);

[ ... ]

> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 592171ec10f49..41ccb618a1464 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -172,8 +172,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		 * Ensure that future kexec'd kernels will not treat
>  		 * this as RAM automatically.
>  		 */
> -		rc =3D add_memory_driver_managed(data->mgid, range.start,
> -				range_len(&range), kmem_name, mhp_flags);
> +		rc =3D __add_memory_driver_managed(data->mgid, range.start,
> +				range_len(&range), kmem_name, mhp_flags,
> +				dev_dax->online_type);

[Severity: High]
Does capturing the auto-online policy at device creation time break dynamic
sysfs policy changes?

DAX devices are typically created early during boot, when the global
auto-online policy is still the kernel default. Previously,
add_memory_driver_managed() dynamically evaluated the policy when the dax_k=
mem
driver was bound. This allowed userspace to configure the auto-online policy
dynamically before binding the driver.

By caching the policy during device creation in create_store() (and other
creation paths) and consuming it later in dev_dax_kmem_probe(), the kmem dr=
iver
might use a stale policy and ignore runtime changes to the global policy.

Will this cause memory blocks to unintentionally remain offline if the poli=
cy
was changed after device creation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605211911.2160=
954-1-gourry@gourry.net?part=3D6
