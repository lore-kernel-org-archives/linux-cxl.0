Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3752D46C0
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782857683; cv=none; b=Z9p9VUohIYAeZWuDT5w5mbHCxNuqfNZnYPwJYuWlpwuOGJ+H0NrJOeGvSdlozSdva3gsvHKC7YbNjFOjwLNviPQtdFFJnkLuO8ZVAUJUk/n3H2j89c/kFTz7wTGEPpoukfFzo/9pSwMHspEHncoxaY/5jaNDNEI1BvryEMJ22G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782857683; c=relaxed/simple;
	bh=OHho8xisLBkXPsux52lTSAnNEXH9FZ3N849yTj8opFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sji4+787B17GaUacbmg00LmF+BzFqhv5/TonKT33gURX3uhDXfWfWqE6KLKMdXMLHHWJg0ezPuIRdVAl79ov1Clgd5wPmqOv7N3FtUlXkcbAcWFjw5jOAgBTsUH7SWE33ehr4Qe9JUYxO3WBt4jXsfxFkF/k4904Nux72ueYX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=iJuRD3X5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="iJuRD3X5"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e67555e24so106918085a.3
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782857681; x=1783462481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvvq7XwN+0vU39EaqWqw5+H08MVeyEUcwD3F1pdYD7Y=;
        b=iJuRD3X5LQ9ohMnkNlThLBpo+UQ9qaC0RrFMo9qr3Kmk4KwTm4/WYQOHwCwAJ52nlx
         8tkMbRNtk/jB0fGP7+MMlzX+g22mriw3rAFTh/AR5j3U7aY6Bi2a7EGE5VxoetPTLfU5
         1vhZcPsiMO/cGhW5krAdqO3TN4vs7dmncABS9OI4weB9/202nDHDJ86tF1Njr4sPARQv
         Bf1k6bml2tBVGk/df9rPXOuDywaIk8j7U8/JtX/Ymf8biiCxFBe0KP274D9Su/ZQ9OPF
         8PEA+2gVslEOmg5e1PvmQX3rK9CLX1PSV94fxD5Wg5iA7ze+T4Sn0S0MKssgyTkhJjXf
         irKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782857681; x=1783462481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zvvq7XwN+0vU39EaqWqw5+H08MVeyEUcwD3F1pdYD7Y=;
        b=oLC+3dJfTJU+fF6GzwiBgok0SeI7ztRJCOmCbptzU5+qsjktK/jIg0Ea0byzXzH1tV
         9eP/k3Fbp7ODZyvp0lLhW5vGJEXsiDHXnyieBWK5d3O3RLgJA2Xw3JakG6+EmE64n/Qx
         fLfBHTc/LNWJNgZvO8k7Lfk+X75PHcXllmo/u+XI0kacCBwvzthNgUJFNA1R1rhbzerZ
         t3oAsg3/dVUjFPdUq3WMinYrBgf+3aNggcNdEVHA+v4fMzrNwg8Rn+Ds/gWC+1yzuid2
         Uw3E3t2oKxfQ9/XWAXKqSv/Nw7FNY2V842eKP1YZu5Br8xNtasvpi+JpVSsiDEq9xagd
         xxJA==
X-Forwarded-Encrypted: i=1; AFNElJ+iNPXTtyCzGKWt4Xco9yw39p3rjfzvUYR3wDuNxvU5pqrx73gpPCuqC0LRR2ejFs6Peq5Cy9/wuA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBtGr2nM5Cn1fsvNZMWibr0aMfUs3L+hjuCgFCGrVh8zgCnruN
	HnRZdIHbuSBxIBbMjUobALUniEsKt4Pwu0bktqiOQ1BpSmCcCzYGq9t3gK72EEc3yUo=
X-Gm-Gg: AfdE7ckBA+pDreycqIwN9JP0ZYaG6uyKK8qeNbN8Hw9OITcUvuMhmUMQGj8Kubih0z5
	HswGCM+MlKBaTMiv83pzGtAQ1Hbo8zDcOmJnOubICziZHrZuzYxfUBd67Af/wVJjN5re79Nz5un
	6NtlkuloTjiY9CinnqZ9bt9Izyo0gPA4aSLMJWpss7SiczDDjix+7piVaRBr7uJAyqHiGj5YyaA
	FxRnZzAxpfksgMhhW1vBL+BPgi7Mfc2Qcn+TR38Btyb1SpImjP7jU1t/Do5a0y6/WipxQX5KZKh
	1b+Pg/XVad4X1l6M+ZJCW2Ew1ApfdX7ThAzRPURr8wddYeYDZ7nP3DbTTP8N3UvRqNVw1PTyddl
	ypRlhnlIZSD5zBULuvTV4etQ8kNjxGbHWrNhcg9O5HV6UOgiqjbtTZn4XOTP4DEu5q/wcSWny0c
	IMKK3GheVuIb8s/knn29Sma4UNNaRdMbgH1ibHcTpeykdnzQmY+lyMICQe6VpiLPpspIRhJrWjf
	Nz0Auc=
X-Received: by 2002:a05:620a:6cc6:b0:915:b852:4361 with SMTP id af79cd13be357-92e624e3088mr975087285a.20.1782857681333;
        Tue, 30 Jun 2026 15:14:41 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6213b953sm346810685a.2.2026.06.30.15.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 15:14:40 -0700 (PDT)
Date: Tue, 30 Jun 2026 18:14:30 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com,
	david@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, djbw@kernel.org,
	vishal.l.verma@intel.com, dave.jiang@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	shuah@kernel.org, iweiny@kernel.org,
	Smita.KoralahalliChannabasappa@amd.com, apopple@nvidia.com,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v6 09/10] dax/kmem: add sysfs interface for atomic
 whole-device hotplug
Message-ID: <akQ_xlJtXNgnGUdf@gourry-fedora-PF4VCD3F>
References: <20260630211842.2252800-1-gourry@gourry.net>
 <20260630211842.2252800-10-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Ha7M+e+kLoFbO4pS"
Content-Disposition: inline
In-Reply-To: <20260630211842.2252800-10-gourry@gourry.net>


--Ha7M+e+kLoFbO4pS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 05:18:41PM -0400, Gregory Price wrote:
> There is no atomic mechanism to offline and remove an entire
> multi-block DAX kmem device.  This is presently done in two steps:

... snip snip snip ...

Sashiko pointed out a false-positive, but adding a fixup patch
here that adds additional consistency.

On total failure - release all resources.  This makes the sysfs
interface consistent with the probe failure path.

Just attaching a fixup here, since technically it's not a bug,
could fold in separately

~Gregory

--Ha7M+e+kLoFbO4pS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename=0001-fixup-dax-kmem-add-sysfs-interface-for-atomic-whole-.patch

From e341860c83fd5d5e8549d8adbf71a484c8990c5f Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Tue, 30 Jun 2026 14:49:06 -0700
Subject: [PATCH] fixup! dax/kmem: add sysfs interface for atomic whole-device
 hotplug

---
 drivers/dax/kmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 19effe0da3dc..f597d8a99c1f 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -380,8 +380,11 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
 		return rc;
 
 	rc = dax_kmem_do_hotplug(dev_dax, data, online_type);
-	if (rc < 0)
+	if (rc < 0) {
+		/* Total failure, drop the reservations we took. */
+		dax_kmem_cleanup_resources(dev_dax, data);
 		return rc;
+	}
 
 	data->state = online_type;
 	return len;
-- 
2.53.0-Meta


--Ha7M+e+kLoFbO4pS--
