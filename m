Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C59951022
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929434; cv=none; b=RQpaSBagbqc1JU18tG7FDwUdqqs9XtxT/u69mZr61qggnw6/CtxbYw7JGlZ9UEiwRSKlW25kBHMkalKj2DXZxFOJ3fLgXO17Q1ebon0XG/UUjNkDsFNoGoqrYdVEd01+CCrr4oYNcJH5C1RpyQ80glGH2RS9paCpn3WJX23bu9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929434; c=relaxed/simple;
	bh=CkTc3uqUV4oAWU25vKzur3uX0jgjdH9NEyqWGZX2ofM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gC5ubLma/nhEMNrq9fn3sBkkxnR6NPUrHJUB30cODtzoYj91MLNZe4AFr/p+l7+pBEkThZ+nZJpWj1lxARCfeOKyNXmci6JC77yO+foo5Qn7DmCTBuRKlaaHuqW5hJYwLV3NtWVwCTwJfFH5MHoGcHk2ly7LFhly/hUAdYGnfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TSS0uqVA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TSS0uqVA"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so2731414e87.2
        for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761929430; x=1762534230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HECjj7h2ccCzw3YUDexJtN/DN7YGJtXB8c7kq1Ybt8w=;
        b=TSS0uqVAgglLe5OBHsXx4Xwp88Tr8auE90Zf6D0y/NTmlq795OW7U+XmEj5ofTI4uV
         IV+1FUXQZLxixWWsW20yremn4kZrWHgFUHSAJdM1gnGBJS7kTRLB1kve8hHCErFOxu3i
         IKM6ogLi92qfHYe5+xUmbJONVXGk1F3zPJbjOfALZtYEVOLV5clHr6Si37IMEamSlhb2
         miMznn7Jp8P9p8H7A+0qbnlOQv9NXJApcgU6564Hfn+8XC9IXp0qk0pGvpI5xSckrsS3
         pfngGuT1SCbwAvW0MpAIOGMyF1BYafZ19Nc34xJ7HyFztuYbK4f6r4fparsFouCMumbt
         ndaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761929430; x=1762534230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HECjj7h2ccCzw3YUDexJtN/DN7YGJtXB8c7kq1Ybt8w=;
        b=vUvMAaDm/VrUu+XmPVguPTjXZS2gJHkxiwy9TRkiycJu+dYetJ9Bh2H5ZpYvfXz5Ck
         mmRJRW8ZW7tkASLsPQlRYd3ZBQ68moupHWRZ8zbIY22B198sNqHearBZBfeG8TbupTPK
         TqoOnN+/Y+YaD3krbjIUutjKc+ZgR1knUzR7DvhvdF56W6gs4DQdHBlE0AuqV6eCEkw5
         sUtrEEeg6E0A543JkojKWo3WQokVg/UFX9fBVCt051J2rKmMYTzJYGe0yyUR13qKxrP+
         Ta2CAxkQ5gz3rlxqCk5gzjhTV+qm5/ykvPCBPah4K8lyzwDtkdZCXPqK+S4o8ykAC8Wi
         dpNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQN6CGrMIZkKaMZIZNgAvbb2kBafCVkf4ZAMdQW0C3k6EFAdjjD3XJ4PlJuAFpO9rGvTy0chp3HOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZ6QXaucDYdl5tzYBVc+Kb0wn+JniH43jSI9YORVRaUlWOmRt
	d8HgpyhQIm+0KRqegWbVlXrSV9xwxWjqZd2tt9/3fGzwEa0F15m3BkMkpS5JbDOwKSlux5ZFNLZ
	rEX808uVQFUbjsxYtFtQiQ2AyfpHuquvarRaT5nMjHQ==
X-Gm-Gg: ASbGncv2tTnoo0AVuOJM4osCMpXzshmTWuacL0q2LSFP9KLAggbY+fEcj3vz9+rgGCP
	jpa+rNrxH1twh/nHtQ4ZRGqvu94jQotxZPoItfT6CZ37bareTovtE/wVh5vJzhlPUt1KMknGILA
	XpBgG/NMm6jzo+mntcc1iiAy54FJ/HwsWuITFA7Y78rEG7GvLCgj9W4z3KhWqQiYD6c35Fogcrv
	7mgC/haWtfDdPw8NUatRDISz4zLELv7hnMh0XFW7kV6BgTYaxnsFXrhOcCsmNf1GxxtsOfzlzTn
	nI+EBtXgyiZ8DzYreQ==
X-Google-Smtp-Source: AGHT+IHNkQkcVReeJSmIh2XeLdh1w6k92Iktx8NubjHPcdvXGpM8QNJ8YlcYkfCdWLOlRt0JgryZEzVytwgIdb8m41o=
X-Received: by 2002:a05:6512:3b89:b0:592:fa1b:a952 with SMTP id
 2adb3069b0e04-5941d54f494mr1593682e87.49.1761929430131; Fri, 31 Oct 2025
 09:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163839.307752-1-marco.crivellari@suse.com> <6904cc6cb4123_23741210067@iweiny-mobl.notmuch>
In-Reply-To: <6904cc6cb4123_23741210067@iweiny-mobl.notmuch>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 17:50:19 +0100
X-Gm-Features: AWmQ_bls58IN4Jraq6j6gpOUUrBCJuzYEiIJWhONPPwjCeljWuU0Ihmpll3Qlq8
Message-ID: <CAAofZF48WB10W-wQtUAOghBvBAQEc9bkJqKLir7Qzr4pkhLOWQ@mail.gmail.com>
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
To: Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 3:47=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>[...]
> A reference to:
>
> commit 128ea9f6ccfb6960293ae4212f4f97165e42222d
> Author: Marco Crivellari <marco.crivellari@suse.com>
> Date:   Sat Jun 14 15:35:29 2025 +0200
>
>     workqueue: Add system_percpu_wq and system_dfl_wq
>
> ...
>
> Would have been nice just to save reviewers time.  Regardless.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Many thanks, and sorry for the trouble!


--

Marco Crivellari

L3 Support Engineer, Technology & Product
