Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720576;
	b=wriXRgp8Ot7zR+QKkhzzRw51tzzAp7SoCI1EHWtPAavHKdnUSZa9ymBuXAJ2clbw+2By
	 lONs7O+OV0LJKLFJeoc5GSGobNELfktIJzlN5q8DCoJZWAqBxT5Gekz6c6XmWY/R6GAw8
	 TVdemEncAeM753FYI7U1z+rN/sxqZziyG2c+e4Jum9AFtkGbpjgVR2LBp5VnBcjiNQGOE
	 wUeHYdrRoP5eIZBxlVP9GGDoQrj6tBOQyd1RHYlvMFqfISJygVR+gDnFxMLePiMhd5m3K
	 9FgtHfYGP2+vp89MSG+dHSHZo99Nnmh4JWqQfHZlBCNNrylT7W8OWw9348Hak7M2aOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=qSBKQkoV/2gEOYXQ7dyktjSocPAeCSzJyj2oztarUE4=;
	b=igDz0XKVHZoq+wMqIrKYxVbHjVcKEhHt3xA+/71M14N7J9x6sq6dulR95rmKCJZ14+Kj
	 KKQMVo5BAGpf3WN3oPutAY45fv9mhSh489btwqnXbgKeabw8AHOzovhZwt4v0O3aVh7zW
	 ALjPu2sDHKtb5OKHIyvUXUuTONDFa4vREYwoSkTdJmAHjR4pSJvhXbjtZb0MJnfWajfG6
	 AmuSgA8LTf6cN+YCo6PTC3VcvUSVetoAJOaKvA8kPlMVPCcT+GV3p4n5RVjzG4PXbzwkB
	 DAUIKCzesooCLPvxL7iIpqaOL/PQ5IZdKj0oDMQx7q6l5jRt0NkcqQbUpIqsu1SfQvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KsG6Gnke;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE06D606A319
	for <linux-cxl@vger.kernel.org>; Fri, 23 Oct 2026 01:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE06D606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KsG6Gnke
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917a04338c1so3238076d6.0
        for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 18:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792720575; x=1793325375; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qSBKQkoV/2gEOYXQ7dyktjSocPAeCSzJyj2oztarUE4=;
        b=KsG6Gnke8+uOe0OPFEJ3cUB9Hn8wPgXYMSekDEEMnKqIgcPj5m4iWSQN7KH4xE/TrY
         kVovdH3tkBv8poJ0MPxsuVNNpNxH0zh8EnjjNOPJPdV1Zkcyr2EyOwPZYnlENtruQV2r
         Gjq1bSOcu1blsuHhurQ0N93i3XUeFCcHklxU60JfvQm2XZsOI2+XL9wxAEej0tmfOxyX
         xXj0iR2HzqsrMqXqY7HbUPF75hYc40kcWLyCcxtmFjVK/goQC3dMKH8/RHxZkEx6R3tE
         OaTI7B/2uZZzylO9MKU211VmhCyjF+nYyF0MjtHpr0KQtUtjsq0qsc8m5C+MUNsHA4qA
         F44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792720575; x=1793325375;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSBKQkoV/2gEOYXQ7dyktjSocPAeCSzJyj2oztarUE4=;
        b=ERI7zMSpyYgSUglZfNlxD/70XASv+eko0I9TMI5sOizg6aSY0g/+x43PMEYCbUGbO0
         XLBRiasaT+z3mlIn1SHcd13COsIrpx30iJAi7zU0LZktPziQMbce/NcFM5nmshP3Rz7g
         0hGyrQvBMv5CYZTWYpvZcFG0Zi+sBHAewBBend1L1DiXu/INDW/2R2p4U0P+yP4jXhut
         2urjXtrWAgHOBm48kCV7mPghKwabFGFLGtFor4+1ZMliPlSXP0kR63Ep3wN1ZKaAmKjg
         NoQvoHNvGQhGkr8h6BJ1ZYRMPj9kBc3qSXcm/oS88SQKLPtsaPqojkjQDNZwTsy3ufNn
         b9iw==
X-Forwarded-Encrypted: i=1; AKwUvBy2gSiBu/X8SKeBuvwl4tRr5NOicHG209Zr3zKqbZNS8wvfV+rRWJ8NmX1qe5NiaJ3SQzGXjW5F+I0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKe1bAgVjDmSB4fYYh/E6FMP1PEiFiHr0t2HYrTRiABJ6WbcjjL
	T8nyAJSxV8RwbLdcVChBw/THe+CcZbgDzdB4F0R8CjY3HMhd839XjpyMKyHFiifRZEA=
X-Gm-Gg: AYBFou0QDeJZWj3uizoX0p6qksfcTag/eFO1bvpuWLEyVsWFgJvNdKVNVU2cIxQAZSf
	pOwlXm2IkdwQftrBtIx+FmUqYrxCHnJDo+6ajukea0Wdwi4OVwxshDUiCaGeHVXG9N5/qyTfK2g
	KXJQAQsP2/TCQylGZ4jEmOAeMzet3ph8oJYaGyWuqDPGl0VAoYfBxBqTeu2lzUX6ehMH3hrozcK
	Bwe/D0oqadzVprQ6ioihOsQdB8FJ1zh8eHewTutTMY1i38gfF5o5o4Orareju96703w73+fHezd
	FbaeMm7Mqsud64T/xOKmfYVccMIZrgTEL6ag90SdH8pD/L1PQExXILxY6XscO3OTdNvpg/qSHCM
	CWSmQ8XN5lxdJyzyWbz4f3obpFujYxIe8Imx8DEYeYt7ctZOTlzMX8b5SiqhRkCvInwq9twvPZb
	WcT2Afk4G4P9I4rGVve8NiA9tzaKSpHo8DwsofqFW5xY1ly8EKtnzJfJnJSP2E9F+dBUzriNptM
	F1Mzsfw0BS1CCe14RZJevBCY+2GVz6ytPYEnfOx+JkVRQDH6MXYtEg5nQHFIZ1thsG6CKQv9Dga
	U1jq/J8fH78d5UlapPb8brzQZ64=
X-Received: by 2002:a05:6214:c4d:b0:917:84c2:67ba with SMTP id 6a1803df08f44-91c3a9d6ec0mr9891546d6.34.1792720574666;
        Thu, 22 Oct 2026 18:56:14 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c396af371sm7558586d6.7.2026.10.22.18.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 18:56:14 -0700 (PDT)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] daxctl: offline whole-device memory via atomic
 unplug when available
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org
In-Reply-To: <179272009864.802238.3707618429496053322.b4-reply@b4>
References: <20261016214248.443247-1-gourry@gourry.net>
 <20261016214248.443247-4-gourry@gourry.net>
 <atly9gd-Rsf-AoqB@aschofie-mobl2.lan>
 <179268760050.4072493.10054383256417425305.b4-reply@b4>
 <atqHe2AK6Tka4t6f@aschofie-mobl2.lan>
 <179272009864.802238.3707618429496053322.b4-reply@b4>
Date: Thu, 22 Oct 2026 21:56:13 -0400
Message-Id: <179272057300.1197960.3345278232450834067.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-22 21:48 -0400, Gregory Price (Meta) wrote:
> The intent here was to try to get drivers creating dax/kmem to actively
> set a default and effectively deprecate the global hotplug auto-online
> setting (because a single auto-online setting for all devices does not
> make much sense).
> 

there may be a path here to allow offline->online to keep userland
clean, let me propose something before i iterate this series further.

-- 
~Gregory

