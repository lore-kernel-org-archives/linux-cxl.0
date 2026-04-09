Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5181A285
	for <linux-cxl@vger.kernel.org>; Thu,  9 Apr 2026 09:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775726904; cv=none; b=ZyVyxs8DBQVenPLBiO/LgLv/K79R2mmYJAnJkYQQWN9mQfBgzkYA4bs/w4gm41meyHV7VF1jtbspTzklcdfWfUHmb4lZRMScdOK+gR0MlD5OeObrZb6bAblJBGixo5LtqRTLm2LY+nGOuqHCbbCtWqkk1Zn0hSkECWITnFdtoAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775726904; c=relaxed/simple;
	bh=K2JpJFTu4zPMHGNh0ht4DTdv2jUw4nPbWQBx5nhGmS8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ts65ooAJmV1ffPB6edmMFru+z/fRHiCraWvnJRk8znviHKZtOdmpMj+Qd5oCmsaCvEZAXM89N9A59+MY7Gti8rikWG/DlFU0cCjYzequD+MaVSvekPiqDajYhGXR4SLkCw9Si6swWGELyOflAaPlqgD7MxTts3wap6zcxS6musw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CZHX2LZJ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZHX2LZJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso659781f8f.2
        for <linux-cxl@vger.kernel.org>; Thu, 09 Apr 2026 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775726901; x=1776331701; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zzELohW/bUBQ0NR/GcWVWevr0Zo7GfxS5HNBO/h97QU=;
        b=CZHX2LZJSoPadl85bZ00rnWryBUFLT4aw4QX4pDg7N/6NpbiOoctCEoEEPbvnV9HRs
         BI6nB9hZ6idNXKLDjmOige2hnSJ10WRC7gDZHqVV2nTm0H+fdrE2u7iCdBK3rRS9RByU
         mvKPBHo/bE+LRcMksGq8PKrEbRcdBxy6Oog7+Swq8k/dxo0U0nvOIXU+OT6sALzomHwB
         I6ieAoefdx2shfS988VIkq5YAZqinxMSlzCTuk2LJXHPzXeAh7Y2MFlCudldD/PzHVyE
         KsoE8MvSPdHbT8/BYV27ye2K6iePkd0o67XwYd1bPhiYYBwgVDa3vLfDBa2nQyVu5zb4
         rMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775726901; x=1776331701;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzELohW/bUBQ0NR/GcWVWevr0Zo7GfxS5HNBO/h97QU=;
        b=S/VtQkODzXutI1DjGmBAP2BqNTrFa9WxHHAD0hpIxfzUeSVjYXD+E7HmTxajvORLbQ
         NSMmo/cukjRLsS9oY8IhxwGFingw+ylG/MJgXhwLZLxPd5l2rjI2mNmYLM9N71UJ6Oi3
         1lWYsH/+4MT5OcKQkUlBhbXs+1Q4L8HvlinUvqu61fwyCshlOntXhXW2+oZoVNjQxmXf
         A3xeyD7PkwlftiuuDR24luM8YF2oF2AmQPcyluvil5AjsFzqKlE09vHXD1cmqa/HRCRt
         bKN8+gQ3l14Uk5dV7xnUAepUvCuGua8E1XFPNgQzCisj8iVjKXMxbikZP+Z60cLsMxO1
         FasA==
X-Forwarded-Encrypted: i=1; AJvYcCUGB6nPl+YeV3UX+1Sew5PcWVvmNtasHUNYWhmHhan/0dj4WewvxwuTyXjVH2jGQSY+2e/rWlXdido=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5aKM9ypd6SzVzUKh+xhLAxzErKzQ6NBYc59i047LyALYw5eA4
	Un1ksB9+z5avdd3/+k4noW4b9O+i7LUKBY/lipvzGMLJxgHm93q+fXC3
X-Gm-Gg: AeBDieuu5KShrqat1m7PQKJOHNv+HXoXTHWX+ZIx2TNuLr9BujKhKozNYMJap5XscqO
	6tKM+Nil5BbE/2740eJDpXRhvrWdNtlWoh/TtGp1+SzMwSNgecg6SCB7KaAuB2ZvXn2V0RpNucT
	ieYlQ5g2HrmEowreOdYy4ME6ETZ6osC09X4DYN9CCibQIoP6xowB4/9EfNvTdHzMbBzgpkJNjbm
	tvBm0hHKjzF20XsAkkCBvW8KlQJ4foitV7YxIPH52bSQWVDGZVFYc5iHuCaeUJxC8P/teGr1Lmj
	GesQ7JAxfh3WMPEUPh3XepsULdfSjvXLfkk6d0cOxcaIvQe4rBSAWs29wW/Qb9TMEd9T0wMT1GK
	ID8JqItTzdEUDODSLW4wqatWuWtqntVYaBeV8GF4AEF7WqQZWqeiBMFEH4kJFgKxoL7OjHaDqUY
	6a/BcuEMzTp5K4Cf9JW/Q2U2CuJwZg/w==
X-Received: by 2002:a05:6000:22c4:b0:43c:f66e:f24 with SMTP id ffacd0b85a97d-43d5a17cfa4mr3528664f8f.35.1775726901268;
        Thu, 09 Apr 2026 02:28:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c50a7sm65395917f8f.15.2026.04.09.02.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 02:28:20 -0700 (PDT)
Date: Thu, 9 Apr 2026 12:28:17 +0300
From: Dan Carpenter <error27@gmail.com>
To: John Groves <John@groves.net>
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: [bug report] dax: Add dax_operations for use by fs-dax on fsdev dax
Message-ID: <addxMYPgp5t3oysP@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello John Groves,

This email is a free service from the Smatch-CI project
(smatch.sf.net).

Commit 099c81a1f0ab ("dax: Add dax_operations for use by fs-dax on
fsdev dax") from Mar 27, 2026 (linux-next), leads to the following
Smatch static checker warning:

	drivers/dax/fsdev.c:86 fsdev_dax_zero_page_range()
	error: uninitialized symbol 'kaddr'.

drivers/dax/fsdev.c
    79 static int fsdev_dax_zero_page_range(struct dax_device *dax_dev,
    80                         pgoff_t pgoff, size_t nr_pages)
    81 {
    82         void *kaddr;
    83 
    84         WARN_ONCE(nr_pages > 1, "%s: nr_pages > 1\n", __func__);
    85         __fsdev_dax_direct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);

The checker thinks __fsdev_dax_direct_access() can return -1.

--> 86         fsdev_write_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);
                               ^^^^^
which means kaddr is uninitialized

    87         return 0;
    88 }

regards,
dan carpenter
