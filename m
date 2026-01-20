Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F33C1FD1
	for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902470; cv=none; b=RpDOJc7RfGxUDKE2CLogLCCwtGNbi+fgUWc+BQaPgII/8CYN94S6P4xgL0l+Qn7jY3AAiTz04abIGlMZnOxGFUpDIhKzB3FsJTfJdzAKZ/ofsFx7XAYUuCdG5gElJrpHv1YlbTeiBq+x/JzQxsn+d0hZH7khm9LWcS35og5hnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902470; c=relaxed/simple;
	bh=az0pk7XF+MXDZbPEOSn+H+qwgQwQxsEI2HqTgmnPsKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFd4eeHu6ryqkKfT2pJ7IixBV9EfRhcW1FzjrNcGVsmhzSdzwY0Fv4vbnjdRtVYXyPPS4RtuiAdHe1gd33qFTvsgZAysGdMhWtl5j2fqdUDzGq/fDMgZuc+cfwgk1iOtOTBDKRXSigubkxhybfLlcZv4doN/X1itSvFDH6s82TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csIgs+Qj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csIgs+Qj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so32524615e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jan 2026 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768902467; x=1769507267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJHYoC13I7WYQTapdGtLXxIS4a/VdsM1Ai6iJFeIdCU=;
        b=csIgs+QjkdyOWn7KPnWXGvWbH1a2jjXeAVGQjgPKkP/wTyFjrlGv5lpYVdMjuuYCr0
         R6Bh9awBiCpVK5fW+pft2Rx91hDhgXDrMpRxMIoxEfkmKEJ9hLPw9G3KupxjPJbXbuJU
         1LxJHRxRwVUeQ5Urm7KWj/1VwRQ/2M9T3OnzqhKnoRe7xkkRrLvVxs1FBk8f/jBZGulR
         Mln2CHgkIk1UkdcWK6K9uZZEG0o56AXCpDROg1G9cUTOfBbd5POYTHXLfzc1GAOYZJek
         uS5oCyVXW0o3PjKzsse1MtLtIVwmVNypfC2N3sWJM8ko/rG2GeLOLukWk9q8c/datVXc
         TYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768902467; x=1769507267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJHYoC13I7WYQTapdGtLXxIS4a/VdsM1Ai6iJFeIdCU=;
        b=vUNZ20RjTUoxfi4DI45QY/YPrmz7oQ8JwE4eeEhVzrt5cLZTqkSSBoTip6FG2zopHt
         Hfot3D4Cikbl+I47Ub2I14dT5VdyI4DG0qAa4BF3M8HCaXNl4M89OsOxkP3nl9rSD5CZ
         hn6/A0/y/yogxD1Ek07EO2WZN/yhdJCwsGtXTxv+FKlB16KjgOcZ+EYI01qfUmtAEdyg
         cj03U9ukRES/YM/F8Qmit7rsshVxFAC8F+xuCzgLAkS0jpoH9099ZMdBYmqou9zCircy
         jDY1UD+QzS64pj0BmLQRk9CNLcLZvMt9DOcXWgR/VY7dgC0yMbeS3dm3fq4cBDWf2ixq
         u7Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUWy3vxNvXZ0MfDJkilxbVIuyQr25u1WLhJ6QJ8tLqupNkxOSwgn4f/Y9/DRkDvA5Rk4o5rRKh/33Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgZ4ymmYOHsLc50wz+fNRAJHABbDBjRlHSCni/TZIcr9mweXZ
	ZQ69PDKLNhZ2ClKqCPnsLyYF/ECQJHmw1pJIQkZZIgiap32wo0NrxzA4
X-Gm-Gg: AY/fxX6GWNkq+tCXR6gZGPnGU0cY36uBc2jcX46M3oRjPhYR3FngaH6iUHtda+OJIu/
	ZhnMFnvHr2HxV8bhQcbpCR1n4a6gbymiC26VpoNASQBtrpEOZUM/Fc/c1e1Sdu4L5ygaWj95J9l
	LJIIOg8QCopUpEEfsJq2xcu4AfnMC8+YaG4Z1+QQaST427yh66dV3o9AJj0D7CZbboktLCv9ZAa
	lpVGoZCoFRTLuh65fIYxYonhbuFI7/St2zbN4pVA7rUtfbpOyWeQY6KN/qhpAE4Sz4BXq8/UWCF
	5CVh7Mydc+wcXF9ZBEEpAlrlOQ2KXD21U6q6FdH3VsuwYR5cr+uIU0RamFVYPPa7cGOBKycVA0A
	4Ych1Fmlb6NbnT8LdvZ2FFG03UioErrxuQOXfGX+A+IyL0cKfl47MyU7kLiHpgBmdDgIak7bujF
	Kocj0bVHP3Em2EIcUKNGdlHokIKJBJm6oNCKAhro5iiFGG3F9VOZ1Z
X-Received: by 2002:a05:600c:8b8c:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-4801e2efd61mr177221835e9.4.1768902466290;
        Tue, 20 Jan 2026 01:47:46 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm292458445e9.11.2026.01.20.01.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:47:46 -0800 (PST)
Date: Tue, 20 Jan 2026 09:47:44 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <david@kernel.org>, <akpm@linux-foundation.org>,
 <dan.j.williams@intel.com>, <dave@stgolabs.net>,
 <ankur.a.arora@oracle.com>, <fvdl@google.com>, <gourry@gourry.net>,
 <joao.m.martins@oracle.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <mhocko@suse.com>, <mjguzik@gmail.com>,
 <muchun.song@linux.dev>, <osalvador@suse.de>, <raghavendra.kt@amd.com>,
 <wangzhou1@hisilicon.com>, <zhanjie9@hisilicon.com>
Subject: Re: [PATCH v2 0/8] Introduce a huge-page pre-zeroing mechanism
Message-ID: <20260120094744.5d92e34a@pumpkin>
In-Reply-To: <20260120062706.91078-1-lizhe.67@bytedance.com>
References: <87wm1ih5kb.fsf@oracle.com>
	<20260120062706.91078-1-lizhe.67@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 14:27:06 +0800
"Li Zhe" <lizhe.67@bytedance.com> wrote:

> In light of the preceding discussion, we appear to have reached the
> following understanding:
> 
> (1) At present we prefer to mitigate slow application startup (e.g.,
> VM creation) by zeroing huge pages at the moment they are freed
> (init_on_free). The principal benefit is that user space gains the
> performance improvement without deploying any additional user space
> daemon.

Am I missing something?
If userspace does:
$ program_a; program_b
and pages used by program_a are zeroed when it exits you get the delay
for zeroing all the pages it used before program_b starts.
OTOH if the zeroing is deferred program_b only needs to zero the pages
it needs to start (and there may be some lurking).

The only real gain has to come from zeroing pages when the system is idle.
That will give plenty of zeroed pages needed for starting a web browser
from the desktop and also speed up single-threaded things like 'make -j1'.

	David
