Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DB228A416;
	Mon, 21 Jul 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110378; cv=none; b=RnukfuM2pOtl6jV1PGEYWZCRDolJdEleixebVepASomYFK/6r/W4xVmisZL1IpaQF6Rt82LVBqwdx/nNG+WGB43LDprqmVeFetrD9m/gOXFXaZFpx9fIqjbiWYBjfyZFw2tSq0KaRIq8LPy1QZyWh5YyjVUEB3dIrDb801q7d1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110378; c=relaxed/simple;
	bh=GMNImZ6UhNC7BnyEyQPomdtUQNIjA/djSkZ6Ig7tqFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QouuYOu0N9ZMzOGmTzr/q0eWTwLHeqE0jtMOuoGuYhWbX1U9Bgq7Zz3TGRwRQhNc45qLPHhGWTWrOqRkBsuFIZGDnrHexeJBzYXxNVnn1u3I/O/uUE1HNPmR48Dk0svjVO9aGOrXWRAS81pux8pAL/B0fswPno9La0NGwJmg3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSZrxL54; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSZrxL54"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e23e9aeefso30598307b3.2;
        Mon, 21 Jul 2025 08:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753110376; x=1753715176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZDizuzT7tm9BOmZRFnC2TguJF0RAWZik9mT25MuBHs=;
        b=bSZrxL54UqRUyJBimRzVyXXV6HEBl31Ku2Y7yCHe48lDUcRE18eF6ykXZdpeLd1ZSx
         3rb24kq+RLaSZmO5yNrFS4y8iLtX2KZlTq4ZVmaF7+SZ8H0N1e2Rny6PY32kC9AjS6Nv
         aIvPMFpemaOP2/wLnnJ+sinrRHHZW/8xYpLuWu4d+iuBDlF3p2MQBUiLOBb0vF9mDiYB
         c8+vZuu2f8bm1rSKnSCWx2t24eh06LooN9MRBgH/DGtPhIdjCGRdg7s6I3ktTkB0TLil
         OXLfOO5elF5YXUAU8cxrwhPdHg9nkX1bIpi93qT2vZXN7SP7UjJVaIdKNKC47/BO4zYm
         jfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110376; x=1753715176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZDizuzT7tm9BOmZRFnC2TguJF0RAWZik9mT25MuBHs=;
        b=P8t+pFrEagLioi1zB+xDutpRBSpfGdGUvu426LwycYQ3R/FByPAuGyb+m0WLneLyF+
         0OSgdg6DS3JdGfqBzYKlZ7tc5oMc7pAs6te7kqXgtAsHJGFZRWkzO0CznmAGWeWEtR94
         HecF9DzpMC5kwHVpWBM8k9lhVfbuMOMxJ2W4ZIzhQG4w6dV8RMN+kJzpJMiQVSvV/KDo
         kiM84btwQyPuOXzFbtYqsi86a5t1bUi1Jd2XbdwZ7vfBwDgNVvdhSj/4QCOSbAnxnnJs
         cnIpSc1OuZsvvPgIVQv0SHdNO2lv82b7NH3DqXDgqYj/MdJRnYf1WQNOaC4PIOs9Y9lI
         emvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOqwAHGp418nXkjEBWKkxbG56ZWgMuzNajvWcU4bgqGr4+goMkICN5JNicSjd+JCMGeFS8aS7nHJI=@vger.kernel.org, AJvYcCXORIUDM2id/e/Wt7R5WJMB/6F7PXi+Iteqzz4Emi3JvWjDHaPuLRcPlZVMpnXb/6FXvNSLIh1yJqp1qwwi@vger.kernel.org
X-Gm-Message-State: AOJu0YySiCUonevDRK417Ib6ZDfItJ2K7sjPUKupuch4JcFB23/UKr4i
	P+CbrTlIKr77Bhx1ag31qT0FbH7k87zEHIY3Cx+c6XZGtoPs/ETKHT6e
X-Gm-Gg: ASbGncsUshlvYeMTOhcBRqRICfklfUM/yZw5ev4xT36Yb/vAWoE794QlLXzXKXPX05q
	RrPIuwGckcpDFv1XXYuTuUZttf00GMn2t3/zbR5kh73UEL+4AIAgy2o9F995LhQqDfJlH+5p/+X
	n0oPkV/PBZG6iy/znRqTCOsssq8LrUkl4DfSkcLh2cKEwY1Iz1eDz8+x2iAnbOc+8St/Vxo+0Lb
	L22cwyd/GlaveBj5yATDyWZouIsT3A78dimZzh5d8t0pwmkj+pgdJ5Y19/UYXmaIQ+4r7GcP9gm
	VQnXD1IdXhyV5xt25qR/Ca1RlSnvb/gsvfVwe21f/iycaOSQOg01fCd2hMIsaPm1O5H3bH8xr3P
	Egu/mW+PME44eChaB436Qwg==
X-Google-Smtp-Source: AGHT+IFomIjkq0qMCixrOuPI85oyfNufkGUbdXZ9hS+1p6+uSlzEE9C4RweAknYGkTSEkUbGmSg/Og==
X-Received: by 2002:a05:690c:748a:b0:70e:142d:9c6e with SMTP id 00721157ae682-71952318708mr153027427b3.32.1753110375038;
        Mon, 21 Jul 2025 08:06:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310b045sm19561527b3.3.2025.07.21.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:06:14 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 08/20] cxl/region: Rework memregion id allocation and move it to register_region()
Date: Mon, 21 Jul 2025 08:06:11 -0700
Message-ID: <20250721150613.315209-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250715191143.1023512-9-rrichter@amd.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Jul 2025 21:11:31 +0200 Robert Richter <rrichter@amd.com> wrote:

> Make the atomic_cmpxchg() loop an inner loop of register_region().
> Simplify calling of __create_region() by modifying the @port_id
> function argument to accept a value of -1 to indicates that an
> available memregion id should be assigned to the region.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---

Hello Robert,

Thank you again for this patchset!

>  drivers/cxl/core/region.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 57ee758bdece..34ffd726859e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2504,18 +2504,34 @@ static int register_region(struct cxl_region *cxlr, int id)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct device *dev = &cxlr->dev;
> -	int rc;
> +	int old, match, rc;
>  
>  	rc = memregion_alloc(GFP_KERNEL);
>  	if (rc < 0)
>  		return rc;
>  
> -	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
> +	if (id < 0)
> +		match = atomic_read(&cxlrd->region_id);
> +	else
> +		match = id;
> +
> +	for (; match >= 0;) {

Is there a reason we use a for loop with no initialization or update step?
(would a while loop suffice?)

> +		old = atomic_cmpxchg(&cxlrd->region_id, match, rc);
> +		if (old == match)
> +			break;
> +		if (id >= 0)
> +			break;
> +		match = old;
> +	}

Also, if I understand correctly, there seem to be 2 ways this loop is used.
There's the loop for when id < 0, in which case the loop will iterate at most
twice, and the loop for when id >= 0, in which case the loop will always
iterate once. The two break statements also seem to be unique to each use case.

Would it make sense to avoid using the while loop? I think that the following
code achieves the same functionality as the code above (untested), but
does not create an illusion of being able to be stuck in an infinite loop.

match = id < 0 ? atomic_read(&cxlrd->region_id) : id;

old = atomic_cmpxchg(&cxlrd->region_id, match, rc);
if (id < 0 && match != old)  {
	match = atomic_cmpxchg(&cxlrd->region_id, old, rc);
}


Of course, please let me know if this is incorrect, or you feel that this is
even more difficult to read : -) I think that the error handling below
should also behave the same way as before.

> +
> +	if (match < 0 || match != old) {
>  		memregion_free(rc);
> +		if (match < 0)
> +			return -ENXIO;
>  		return -EBUSY;
>  	}
>  
> -	cxlr->id = id;
> +	cxlr->id = old;
>  
>  	rc = dev_set_name(dev, "region%d", cxlr->id);
>  	if (rc)

[...snip...]

Thank you again for the patch! Have a great day!
Joshua

Sent using hkml (https://github.com/sjp38/hackermail)
