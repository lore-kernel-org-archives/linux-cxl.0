Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0779A2C0303
	for <linux-cxl@vger.kernel.org>; Mon,  9 Mar 2026 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079015; cv=none; b=BTf1NuTrHGQXej14Cq4aovCCjuXI2yJNtU04BVR8RLMuUkW+X9p71HYOOEbILAhX+hsNGn0LHaYP5REPMOu2lgrPHRDxvwjtYXllT2ElVfZyA9Cy2VXIav6BSvKy5vdRVStWAIFyiFWSLMFJvhwg883y0IbvuACXVAV9vhlKWhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079015; c=relaxed/simple;
	bh=sn92/2Ldhf+zHySyOoq2V+6Wa1pGnvnxj2agDNoqdwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8eQOEj4jOufAQK22n6G6HJGg7kbuU1p/AaED6MlJMd3mwEAdnpamQz7LS0LA3tbZyw6UwpM1tLF9kYjac2OU7BW7eLm5uzZ00dl0yRyMyvdkhzjXljp0RrRMveiJcTH0TwkBRdvfxWEQ9b3QlszbvYTc2H3BYvHiwDMgY1yHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b941ec6a368so491158366b.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Mar 2026 10:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773079011; x=1773683811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w634s1uDPScTjvYq46t7ldkcRJSN/38V/ESXjexiv/Y=;
        b=jSYziRQA1VXmlfMh+VLRPTZqsSALRV3ro+3SJK86TxTCeQxpNqmQo3jcmq3MXNMqMb
         8KSGaLCTIxOVOEAGSqe3GZZfuLE0bCqaEjeYCJKjutwhemwuIs6ZVws27wucc5eDc49c
         6h2rXdxJO48ZZi+rOn/+IOBmY2/3uGL9VJcMJ4kjrjsSVrtSjgGECxTcbzhOMwpa0pRL
         IRunhz2lWh3VsfV/JWo5fwF4trsBjfLvnDyzybBpM+7IZL3UHDPEQFeYaRjMab8f/Evb
         tnlRa58UG6otbBUAAyoOmPhWA1UWbu0EnDRjm/Wu+IeA7KQ8DB4QCtBSEzDHHoahuMc6
         7yPg==
X-Forwarded-Encrypted: i=1; AJvYcCXtoNuiqYfKADhQgQYyKcouH9PUcclW7jcH4WBOoarXHmrOpeAfMYIcgL2bhgVg7BC8OojWkCKZGEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYqAriN1dn/nt5tpd0sQWXze1JSxFNr2WOOSv+MRmei//0lWuv
	oFY75p7N/IzfHUd7o+jt+0QI82bijfod9KnkwrlPIH/B5JCiKLCbEkH8iClSj4xgffg=
X-Gm-Gg: ATEYQzzWArSXih6S0+pPm66oQ2qZ0PWFbRuEtnjiOKZk2YyynqCvteMoI+J2jd5z6bf
	fpwq2j4RYu1d39DnITIgCQPRaReZA6VLo9Jmv0zQdLZylXCYw8X7Jv5n4OcxmpwlwIkgpc3FIFY
	fOAzy27ICQLJItlq1EyhHSj9hlUWGNrh/Ot8lD1HEquS4wi5WWr7YfqHy+A+FRcyvM9x4hJzxMK
	oqtN9NSDTsVDkz1Bh6IM6WOkmenx+JXC2kmj6iPnm8W8rWuaJVq06YZLn7S0PoNPYWAUSfCAmgC
	tUCUflTTKyQUfoROAv4t9P8+/BmaUO4hDSRA6jOcZoClhf1pAAxHiugTOm2Hpxr3AOur+wsTfnT
	eKXfKyP30oJ0kTzRngg6/DOX7wBVPtgRf7o5Mw/ylQ3uy4EA6fnEhnbdC1yULOLrS6WICMgPIdN
	61dXpLb9eGUBL7D6u0uADweKEeMoxHunjIMIkvujwqGurFfZrpqwcsB+8=
X-Received: by 2002:a17:907:7f9e:b0:b96:f657:45ca with SMTP id a640c23a62f3a-b96f6576930mr262169966b.17.1773079010882;
        Mon, 09 Mar 2026 10:56:50 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f15e017sm402098266b.57.2026.03.09.10.56.49
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:56:50 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439af7d77f0so7687046f8f.0
        for <linux-cxl@vger.kernel.org>; Mon, 09 Mar 2026 10:56:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKtH3OKoXqtu7kQtR9fGIBEzerb35Rg/mPe94LTzWkE69+c0bNO/Mk9F1sAEltkno70ve13aergA0=@vger.kernel.org
X-Received: by 2002:a05:6000:400d:b0:439:bc89:6b18 with SMTP id
 ffacd0b85a97d-439da354cf0mr22501595f8f.9.1773079009565; Mon, 09 Mar 2026
 10:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308185958.2453707-2-iam@sung-woo.kim> <20260309120053.000031cc@huawei.com>
In-Reply-To: <20260309120053.000031cc@huawei.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 9 Mar 2026 13:56:33 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJLeyWDKBEgrH+ouK1XZM91f9zabmFcHHnmcKC3y__sCg@mail.gmail.com>
X-Gm-Features: AaiRm50427xY_3IYbW49QATLgLy8gFaVR76Q7Nxs3bvkfkU1FrFW9O8oyeRIFkY
Message-ID: <CAJNyHpJLeyWDKBEgrH+ouK1XZM91f9zabmFcHHnmcKC3y__sCg@mail.gmail.com>
Subject: Re: [PATCH] cxl/region: Fix a race bug in delete_region_store
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Ben Widawsky <bwidawsk@kernel.org>, daveti@purdue.edu, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:00=E2=80=AFAM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Sun, 8 Mar 2026 14:59:58 -0400
> Sungwoo Kim <iam@sung-woo.kim> wrote:
>
> > A race exists when two concurrent sysfs writes to delete_region specify
> > the same region name. Both calls succeed in cxl_find_region_by_name()
> > (which only does device_find_child_by_name and takes a reference), and
> > both then proceed to call devm_release_action(). The first call atomica=
lly
> > removes and releases the devres entry successfully. The second call fin=
ds
> > no matching entry, causing devres_release() to return -ENOENT, which tr=
ips
> > the WARN_ON.
> >
> > Fix this by replacing devm_release_action() with devm_remove_action_now=
arn()
> > followed by a manual call to unregister_region(). devm_remove_action_no=
warn()
> > removes the devres tracking entry and returns an error code.
>
> Naive question (or just me being lazy).  Why can't we take the
> write lock on cxl_rwsem.region?

Thanks for your review. I've just tested your suggestion, but it
caused an ABBA deadlock:

task 1:
create_pmem_region_store
  __device_attach()         ...dev_lock()
    cxl_region_can_probe()  ...lock(cxl_rwsem.region)

task 2:
delete_region_store()       ...lock(cxl_rwsem.region)
  unregister_region()
    device_del()            ...dev_lock()

One way to avoid a deadlock might be to not add an additional lock.
