Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C675D2FF15D
	for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339938; cv=none; b=PexTlUki7xW4nvQ6ymqSE2kBq25tGY6dY6qGw1f1Pm+HWfuycwXPgf/27+d+o7tKQEO/OHG9HdbLGPoboVqbPRtrDQFwCBJ8SltBT4MJMetFWVKIxpzlEbrV23S+l46Ua2bZZ1isGyroJ4IcuTETxqIjDXdcOD6XtEvmaEDZnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339938; c=relaxed/simple;
	bh=S8tX1I3NnXmp83ECQLkp0HtMupL6iB6KWNRunTE4S4g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pH93SnYX0Y7NCZwtSFp0Ky2Sqf0GzbPuu1Mv8VRNw89dh4mApJ+ti1FmPHPenAL5zL3OSUYS8Q9gBwA4VcUb9epaxpgCX/RWZh2hpUDq9jB3I5Jt0yXGXp+yyEVKiI6ELEw+VAMhCA8fhxe7UOh1A2i+lEpnFSX6l4/d6ZxD9t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ty+4ChrG; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mclapinski.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ty+4ChrG"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-63c299835ebso5489439a12.0
        for <linux-cxl@vger.kernel.org>; Fri, 24 Oct 2025 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761339934; x=1761944734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyDskZ6zQPcCI/8YHZiXytq5M9mCn+dOU7TwJSjkxw=;
        b=Ty+4ChrGfh8VhUR6/DPJYhGnDEmmB3lPuUe5QvOzHWiylfnHAgJn4MP/3pS5I9h4pU
         vM3+6EPHP8kT2D1ofr0ejx5Gw0N5PNg47bOx9v9ZbRSBU3danb2W9oRT5Qf3VRhR7tFH
         V5sLS8X9Mq/VM8J5mq8gzZVMgXPu980+uNTmRleB0HtIvyQpa4zDV/IRefwquhmjLtAG
         4LvlznSfFyI/WkFSybH9gfiVmU+TYtFAMHYwA2oAm58yxrMjXRitIZNs2MnVU8iq3Ye9
         QqhHz/utC9va7kmeufpLYCFOzZOxaBK8jbAUkeZdhaPwTbHJMeF8pe9pqIm/dIIIxotN
         TWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339934; x=1761944734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyyDskZ6zQPcCI/8YHZiXytq5M9mCn+dOU7TwJSjkxw=;
        b=KwBNrOA9hy2n9c0/uOwNyrLaPU0XbZW/0ZDzidM9cz6iwXQhjq64TdDHBBcbyadQLg
         V5hHmCgZZYNL2mqqm01YnZXxKPAe1GJ1DKS3xDY5L3NFezeeVnBwfVIvEMOwvbfz7D4L
         G65HB8M0m/YMwvmIHkYS4bms1sNQ/QbGzX4ED+uMOSeOG/UgitKsM/khZuUAo2kRYliu
         4X0f019WWpW7PPn9Kt0ivQPtKQGdK1mg2zRaKBQ+xFrqvR519ul8+kBh8P2a+VyWNUPQ
         fpB265bXlne8RVhK8KKKsKwO9tlx+IXINSnEOZ9oDEm8QRCaMHTWR1zgI/D+DjO3aUvd
         rzsg==
X-Forwarded-Encrypted: i=1; AJvYcCUr8AuiWbeE5tg5dFPLcc32d9m7AuA+lGnctYCV7EtzJkSgWfulI0ar0AIZUkEjU58Mb3D4nySzQXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGXs+eUKgu9NVayX5ZycjFkkJgf8IKV3v2THhgjgKHSuLLqPVR
	7CpJXDQaCW9IEUHxu7qZWDliNXngkXkQCAh4Y7gDsNNduJm19h7M21X4O9DX9EPm6eOT3NUDxmp
	rt+oJsIWpiqmvbaJfZMSm8w==
X-Google-Smtp-Source: AGHT+IFgqdh0PGBfpPjLJUmHPsb/alPmW29UdHjvj2vTXlQfjvz+HF6Nq2nius5r1WBMT4eb//7EEJZR468bGx9T
X-Received: from edi26.prod.google.com ([2002:a05:6402:305a:b0:63b:da80:b28a])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d446:0:b0:63b:fc79:393 with SMTP id 4fb4d7f45d1cf-63e5eb4b580mr2513452a12.14.1761339934347;
 Fri, 24 Oct 2025 14:05:34 -0700 (PDT)
Date: Fri, 24 Oct 2025 23:05:14 +0200
In-Reply-To: <20251024210518.2126504-1-mclapinski@google.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024210518.2126504-1-mclapinski@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024210518.2126504-2-mclapinski@google.com>
Subject: [PATCH v3 1/5] dax: add PROBE_PREFER_ASYNCHRONOUS to the pmem driver
From: Michal Clapinski <mclapinski@google.com>
To: Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/pmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index bee93066a849..737654e8c5e8 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -77,6 +77,7 @@ static struct nd_device_driver dax_pmem_driver = {
 	.probe = dax_pmem_probe,
 	.drv = {
 		.name = "dax_pmem",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.type = ND_DRIVER_DAX_PMEM,
 };
-- 
2.51.1.821.gb6fe4d2222-goog

