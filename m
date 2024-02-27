Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107C14DFFD
	for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067327; cv=none; b=Pm6QIHdO9znY9JZOXbAqDfGTEMIoJTlxnPBtFX5aLbd2gGkFQQo3vDcowcc8qX/xAI6+gkBl3IqbHbs/6zWEhlFkkhyLV6DN4+6buejYFGKHujN4T7tnrIi4XrOAA3bA8ZE3VNkzZma7pEvDkSJliRge0GQKyV8CeHv0sEjXP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067327; c=relaxed/simple;
	bh=cn6YOKUX5dA3ag8i1Tc2HjJMtQinFT7ylVNBEPwuuIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6eM2iNmVt6ultAKecYuCeLMDILtsPlzNAhkhDJ151tx2OUTYUDVOmw3AKEjCzD0ptabBwp4jG4LdhnZ3xydgbMewpPLW1E858hY7n8IT0Eqz6FW5OhoR/n1zn4HgUIIPfVqqZmfAQC+L2xs08qFnqY1Kw2ZmIAfd6ZuXeeioz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QtVGwrYH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QtVGwrYH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a26fa294e56so803738266b.0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 12:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709067323; x=1709672123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UKCWCT93031ctnu4e0l2nLLoQn5zgMFTn2j+yBK/CsE=;
        b=QtVGwrYHR6ZoSVBDdHphTeDow/uQR0Sh+WtDzvuOtOmiGwye3DA9FZ0VmHakoDckVL
         prV4JElEDEL2yYI1HjhVw9IdnXVfVJT/b2wX4AIY0OhjSob2XhHr5Ot0p8ff9gd2fePz
         4Fa5DEflbJRrIcH6w1xEtTjkUNL62g8uA03PI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067323; x=1709672123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UKCWCT93031ctnu4e0l2nLLoQn5zgMFTn2j+yBK/CsE=;
        b=nLxtqEy32noIiLreU4iZ4qg2FWo4iaEgUmxH51ZbuxT0+dprYZ4xzxq8sM4hQia0mw
         g+BG+Kk4Ybh7GimRsOmLLBtnLu34wMY77u7HWZB1mJe5sbO57YWC3vR8vAzikjHG9Bek
         adLDTlBplhJqjdsgsHnJBQT9DDeu48bY/llwYPwMXYd6HfOp9WyhfNmFXYw7nPc2XxtU
         PsyUKjXF3He8Hp9bb/Zo7v61NhXtkRFNdpVA+57kDiUFMnn5CcG79/yh8uDoIAUSIoxM
         Mm8PZ3bFTBjOfIuonH1dPzuffEB/tybOGbUwzWHbBg0fNDBOOm0oszGshBMddoVtJJAF
         iLIg==
X-Forwarded-Encrypted: i=1; AJvYcCWPFauW7OaXM5HWlmZj+6lu74VZo8VTNBbT6Hj7+CdCdG8BhxfUMpZzT3CFgzWW+dktchka6yolvj3fV9aGKzs0nkEKQAxKso6/
X-Gm-Message-State: AOJu0YyrH/cS+q6Pwlqfj21YAYhy0cwxjuuSp083LpXyWy0LOZ3oFYyV
	2+dX9jORDbX63D6shFesXcP9xeV0+3M6lnAY8g/ca26n4juj/2HDO5gkyTxAPXklCZMBkToc7Hk
	D+2uOug==
X-Google-Smtp-Source: AGHT+IGywbPR71gFN4UNR031SZcjpoWYFMnlWZeMl2JRp1RhXMvVrlgYnXJ2tW0MtbvPpH0ExKuJSQ==
X-Received: by 2002:a17:906:b858:b0:a41:3a38:64ac with SMTP id ga24-20020a170906b85800b00a413a3864acmr8270966ejb.52.1709067323613;
        Tue, 27 Feb 2024 12:55:23 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id lu17-20020a170906fad100b00a3e45a18a5asm1122412ejb.61.2024.02.27.12.55.22
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 12:55:22 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26fa294e56so803733466b.0
        for <linux-cxl@vger.kernel.org>; Tue, 27 Feb 2024 12:55:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgKlSbZbJq5Rq9OdhVhrIFASrY5hDQVHANltW8wQa5U8sM75slV17e5EhcJQ+CrQaSK7yd/Rsv7i2034AQdXXttEpuxyG70nxE
X-Received: by 2002:a17:906:aed1:b0:a43:dbd6:6862 with SMTP id
 me17-20020a170906aed100b00a43dbd66862mr957734ejb.73.1709067322332; Tue, 27
 Feb 2024 12:55:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170905252721.2268463.6714121678946763402.stgit@dwillia2-xfh.jf.intel.com>
 <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <170905254443.2268463.935306988251313983.stgit@dwillia2-xfh.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 12:55:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
Message-ID: <CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com>
Subject: Re: [PATCH 3/3] cxl/region: Use cond_guard() in show_targetN()
To: Dan Williams <dan.j.williams@intel.com>
Cc: peterz@infradead.org, gregkh@linuxfoundation.org, 
	Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 08:49, Dan Williams <dan.j.williams@intel.com> wrote:
>
> -       rc = down_read_interruptible(&cxl_region_rwsem);
> -       if (rc)
> -               return rc;
> +       cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);

Yeah, this is an example of how NOT to do things.

If you can't make the syntax be something clean and sane like

        if (!cond_guard(rwsem_read_intr, &cxl_region_rwsem))
                return -EINTR;

then this code should simply not be converted to guards AT ALL.

Note that we have a perfectly fine way to do conditional lock guarding
by simply using helper functions, which actually makes code MORE
READABLE:

        if (!down_read_interruptible(&cxl_region_rwsem))
                return -EINTR;
        rc = do_locked_function();
        up_read(&cxl_region_rwsem);
        return rc;

and notice how there are no special cases, no multiple unlocks, no
NOTHING. And the syntax is clean.

Honestly, if people are going to use 'guard' to write crap code, we
need to really stop that in its tracks.

There is no upside to making up new interfaces that only generate garbage.

This is final. I'm not willing to even entertain this kind of crap.

                     Linus
