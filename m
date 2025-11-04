Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CDD26ED5F
	for <linux-cxl@vger.kernel.org>; Tue,  4 Nov 2025 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246781; cv=none; b=WuaLqwQAyOjtByE65zeB0iZwMfm8o+SSyYEIsPo4WAlMxMd4A7eZ1lhPG3I3tUOy9O4HPQaIYzOOFrvyXd43XysHqWmv3ccvkriODQNE51XcZYSapHzBqwuFlZCETnBKWlHyquY1kCJH0+EI3CtvfOd0Q/JQEOViBLH3dxlk9Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246781; c=relaxed/simple;
	bh=UxkusRXVNJvyT+UehTNAwsc2HHL0Trxxus4bsQMBt+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCmDXpYGENNlHBY8czyKJlwCIJKKYrRa3bq1EDV3Z8Eg40nLfMbErm3tu53mGBv05ScdMA5+L80ztzXEmdJXCaall8l8Tv4tymGvMMk7MFj3ZpLH0+BE9DiIFqOx0VgoWW6QINg5Kwj1QsDWpUJT6/qblAM/zXtQvKD7P7AoE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HqGZde9F; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HqGZde9F"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59390875930so6233647e87.1
        for <linux-cxl@vger.kernel.org>; Tue, 04 Nov 2025 00:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762246778; x=1762851578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxkusRXVNJvyT+UehTNAwsc2HHL0Trxxus4bsQMBt+0=;
        b=HqGZde9Fy1PaHcjpeu5QteVadx83rr7KV16SytqVy4mj5i4H06Nw8LLU8zpLhJ7CX/
         M8l/JOAYsaRgThJA+rVCTTeVEB0y76KeCX0xqQ8OK0o61eWkC9uaIvrtcxQdhVOOB30b
         JtHEpkTX+u62KM9DiB1DgOy2E0GZmORn31/GQDWj3ytwcBaahV/k2a+XJvCJC6pRtU3P
         v5mO/WcszmRMAE9MAAJIhLaSPH9N3vsacG9T2wAJTdYil7Ujn4dU5KV63z0+QFcXuItQ
         8iTYdh07aVQdcxDqLzhjVnsfw6C6KS1gTQRXKKSLRXBj6eBkrlhU6r3JIbJjWCO9Tcp6
         wp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246778; x=1762851578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxkusRXVNJvyT+UehTNAwsc2HHL0Trxxus4bsQMBt+0=;
        b=VDcD+J3tALrUWs3UmUNm5xlRxtfKoL0djeaMhh4GZ85GUWC0TGBIExWQ5U9yBswWwM
         Qnr3saKaLeWGvD3cjm7KSQeNaBHhlu9gbADFIorcEQWiXF5IORj1lE8VaytJum9mC2GE
         YA3rYiiQ8HqYHRhpko+e3jJglIeC0mZLVqUrl8ChJRcXpAXSmtk9SMLlH1+Sm8etMBlC
         zcixt8yC1DcZdMXgUXcyu5j32CfuItB9hzALfKB7KH14F2MfKysJsEuACBS1h9O6uJ1c
         d1P9t1FLM2fPjxWINXJayKxEQYRjNUjA58I28BQl0g8hPHrBtS6rVKg+O/Q5WqTtr94R
         m3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJCLa06reNtPgTZYW/ridnlF0Ukm+FwlZK84iP4NGtOtykRUmbP04WPsg7xl5HdeStVmAHsSxK27c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1oJi8JrWqUwLVTV+Zyy+ccFvPrRuVRquMDPE19KlqcuyTv30y
	tZ2aupUVIISE6ZNmWqjOK68v0UkCZMi1R2w31ej/P71wjhj4jfRrMYzoGYfOK3jVCncQMpsH8ve
	/XtSbCB8iHCZ8j+6pdMu1+mZuzRQnL6QJVPCp1su5rg==
X-Gm-Gg: ASbGncs359grYQMDMSUjLtFGB0DJGo30JfAQfYB5p3Lg//nYWkKOQ2pUMr4mHz+dRVQ
	mJc4I5vz8/c89ir80Xn2aJ/NnTd95KXoNhOxfN5ky7rgX5y7oDI+THLllCmiviuMtu8PdOTqQ0o
	CSVedyaLp7m8ZrQoQ3AEFapGxygai94UBtS8X40Q9R64NelLtp++aJEqxIDrqvro5SyEcz+Gwcg
	5DppyswObxUCjsW6jQFFi1KCfSDO9GFkt0FHYLvhFOlNq84ymvVIAj+aG0QYMhmCgMCzQKpj6kN
	4WDQiG5BfbaLcpoIZA==
X-Google-Smtp-Source: AGHT+IGjk1SAjYkuiQ7qycG+PgZZ5SAGtlLaKEvEytUgoQ6BsXQzZeq96mRxtvmS863uKW1GFE6sCVKI432dNQaI1ks=
X-Received: by 2002:a05:6512:3c92:b0:594:1957:a36b with SMTP id
 2adb3069b0e04-5941d50ced0mr5077478e87.2.1762246777907; Tue, 04 Nov 2025
 00:59:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030163839.307752-1-marco.crivellari@suse.com> <ce2f5f34-8855-41eb-9f4e-6bdaaaae90b4@intel.com>
In-Reply-To: <ce2f5f34-8855-41eb-9f4e-6bdaaaae90b4@intel.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Nov 2025 09:59:26 +0100
X-Gm-Features: AWmQ_bkwe7q6tEVvGqave46mFQeHk4xgGvAOwza9vHqA3CoFvmblPyoEwhYxTeo
Message-ID: <CAAofZF6fhO=9WaUYdOEEmbKe+kSw8Ycky+kWf-FikwbHuC0ysw@mail.gmail.com>
Subject: Re: [PATCH] cxl/pci: replace use of system_wq with system_percpu_wq
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 12:44=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> w=
rote:
>[...]
> Applied to cxl/next
> 952e9057e66c17a9718232664368ffdaca468f93

Many thanks Dave!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
