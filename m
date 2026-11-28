Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795847028;
	b=opscKHEPPsVNzqmqRVpAeuui+KmfMvpeONC7QxWTM9Zf5zdUX8PQ6lY0WJ9fZYZpdz4Q
	 fAjSmeSyq391XwPtD3GHdV3oXFXPRO/2KrbiR18kQVs4nB0ujsTAMvtUWPp3ptY6aULBN
	 y9Fua62vBBvy67jzS2hvwc6PQYa8CdEh8SfrR3Qzo/xs/QVc9tXuCpGIrXakqJo0p+6We
	 H/mtce03T88bmpfuchaGcgnu+BV0/1Ib+kY9ByPd5hf3nm30Pd3D47wcGsgExKegiNolJ
	 EEVYFO9yX0pb0iQgrxwahwDHKUHka92a9GNXVKpLlQXD7+cW0sE3cv4QWwZ0Xw6N67A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847028;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=bifl+lHj4VlEQUd5RIz1W58CFQdPbXhML5v+Ye4SNcI=;
	b=CqF33rj5QJq5f3phO4Po3BrxEEK0dSOccbYgfLSliHkDZD03VnQVAb0gJQv0k8Hi3Y9G
	 UYW/U8N/nUAGRu1vGG8Fnc3IN/i8W+oYuK6wfjRWAb1G5zIlOl3IevrDFs4pOYdxNCwOb
	 IUFIkN1ISGFhVr1ij++kzq3Qk+nZ7jEd2l74NZc0aVLmk5IBP4UdCXdoxUXDCjAcuZpZ/
	 s8jBGKL7eLiW/rBJIPg7qbGwsge2GPiWwT8OGM59/Mpz+08q1q1Rxpq4ZK4CYQnttJ59I
	 oDiSUO/OoMff+3059BoavVrjzNIoXR+xlDcGzBV396IlGY9Mne4+BGNNq/K0JX21khw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epoOHbvg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92E606A31C
	for <linux-cxl@vger.kernel.org>; Sat, 28 Nov 2026 06:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B92E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epoOHbvg
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b2f59de176so6319582b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 27 Nov 2026 22:23:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795847028; cv=none;
        d=google.com; s=arc-20260327;
        b=T4q7OYGml+QXT7o7aszuKsN9UmDnjDN2FjjJcB0b3LM2MEQRW7rrriSRIWYiQgfyIL
         9GiCNHKvWseAOT7BuKTtwJb2qvLzw8z4TtmzLGgWCbde+W/xIuHaeKD+ddWIl/nIXR8b
         TGYhf/oSHsdH/+ByGHZ6PRD36Mf/jRjLNO0ECn7wrtOtOKLmpyHD98aKYNdGhaT2KN0i
         d/6gsFHb94kCQcB2nf1ab96TIP/N6TA8yPigneM7s+HxnXmMkP+v4yGMRwku0QO+FzGp
         6QF+sdxs9dCtDMSrln3WVuktqIRyMVkiRWiVrKw6a3p6xuI7gLdlwFMZ3kOlCs+Gl7Fl
         WCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bifl+lHj4VlEQUd5RIz1W58CFQdPbXhML5v+Ye4SNcI=;
        fh=T3RW0f5Q2xm3gqhbTEMIQq7w8WS1MTemLc9dJupEdvg=;
        b=WByRgnfzBpBQxLKr3tS9n555YZz8evwqQaIaKhMRbQ9w8lVhYwlGXxmYY5FHKGDa1K
         AfrD5BXJ720hvo3kECunKOoSy9JMPg8dcB38DvRlYD1o8XMUAV7q4Tfg7/7lx8YTMAtf
         +SBMUQ37WuFp4znVCZrHbQyFidDBC6hXKqjsFGVETzhTWPWepMcwRprOFH78bWtaQ9CB
         TBOOZR1rTfp0DToHMRE+oJcR1c0o7JK1PVHzCk2SGetZWtMa9pwQ32BoyDxjsmCWBbQI
         AZOQwoPvs/MZmqHEr8TaoNLpnrBPfVbBSi2CTbImbrwDCrEfvPqk0f5HpN0NdHwhq17/
         ULzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795847028; x=1796451828; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bifl+lHj4VlEQUd5RIz1W58CFQdPbXhML5v+Ye4SNcI=;
        b=epoOHbvgTSvaSgSSp9B/OKfgg9ODRjIHQoG6sL0sjAV84mSSfhgW896LGhraeaZtRY
         hXHCljcHpJbvD4jgu7aWvIVp0bMRp8xRVod5CGNccnZ8QNVvsKq7tcJDxrapzjoj+HZM
         6RLGbXUgorxUYRYxfWP8RpT/3vsHDpF/BuwW+2YnL1Qa71Lc9KmaTGo35xyDutR+YWsO
         PM3rY4hibUHQGKx93HzKDVFfWa1Jh1TiklNCQY4N2qPRrqGEQwIfhANes57ZvhS97egK
         LPhHXEzs2g4n88N8532jwW46kncz9GtotgU1nZ0kLGgs8bewAcwdJXLPD2bCra5biUcA
         2lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847028; x=1796451828;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bifl+lHj4VlEQUd5RIz1W58CFQdPbXhML5v+Ye4SNcI=;
        b=P7fH8FmUzPccoFbl/8+YEfeomh2YmF6rvTWHnyrB33NwnQIXpQHflPVQxLwSaGmVwI
         oeADijg1nhICm/essq5vHFi9rABeXT6QiuKg2EKMjfcT0wR7h61aiCT4HGUmFWWFx61d
         OGtGMXwTC4vOVT5UsFtfvCuCBwfvjvr4ou/woHzX60qKYPp9puGZ1V0YCA4YQkZXngEf
         NfLm3VvPyYgbi7uKNcMd6BDVXFBgY0/bG8s5vDQY2SI+dGP0wEBKz1Ve6zhg1dZBaYZj
         pkf67Z7VPJScD+8sG1v48rmvKk9kNB6tJSCuz8rbhj2+yX30ZON/snFok1s/EYHP1d4f
         qfwQ==
X-Gm-Message-State: APuU4Z/b1AMLKI1QXrKQuKLHUJg+jiQt5gQ7UFcyL83pFCBXDzPPz6LG
	gLfjZAeVhPP/NwOKrTj9szq5y2XgB/WwjfuaflUgz8GhX0GBYieWIMIKcgOlQY8x2jHzM3tYwRr
	q/ICp9KKTJsia0mCAE2FSucAZ1NuwgIQ=
X-Gm-Gg: AZFdTZcBnbpkUXqEnguzl3BXum5zETnqh0WmTShz7XBdjCBtP7nO6uuZX7O1bZRuhYv
	JIZ2X81EMdB5VXb0bbi2gMRK4LI3qauV6ZbkrYNGOuwrYnDO6EXek+071NKIsCB2JjQDToCCuEP
	dOZDUF1zmMyTTZTSrZzoFQPjK6zVc1qDC4a6RIocQr92WPzr7lHV+/GuKWRSgIhWLXKfe3ovfy6
	lE4zBzSulU0P8ANXSoleiRAdoNBvcbTJUNe0bosZq5hOH0DZCCxMlMIfoDL3nvZhXGRI785vc0J
	yJWw7fVPSdrMxDHKYCr9zGe5AY0KZhxGRXDz43gYhk2iJ1PGK6PNjPSnGHlSnJb3NnwOUPUpnST
	ORfgp2Y+spO2lAcRHiO0b83W2ULkSKrXivYG8s7A=
X-Received: by 2002:a05:6a00:886:b0:899:632a:9613 with SMTP id
 d2e1a72fcca58-8c87ca50951mr24077311b3a.40.1795847027861; Fri, 27 Nov 2026
 22:23:47 -0800 (PST)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125124358.3583223-1-unsung0317@gmail.com> <20261127195133.dwixro55ocba7qes@offworld>
In-Reply-To: <20261127195133.dwixro55ocba7qes@offworld>
From: us l <unsung0317@gmail.com>
Date: Sat, 28 Nov 2026 15:23:36 +0900
X-Gm-Features: Aa3M54oiMFCzGYO5bErVRz-bBLO8e-H5B0TxvoYo6kimM27hOupWCY0s_J545lg
Message-ID: <CAKKLb66AZd_Gjk664_Cs4gTL_x=zmvmHePC0T-d-Lb3S_Ogx2w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] cxl/memdev: Activate firmware without a reset
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, 
	Dan Williams <djbw@kernel.org>, John Groves <jgroves@micron.com>
Content-Type: text/plain; charset="UTF-8"

Hello Davidlohr,

Thanks for the review and for pointing me to your series. I read
the June 2025 thread and the sashiko report.

On the use case: online activation is part of CXL r3.2, but the
kernel only issues offline activation, so there is no way to use
it today. The motivation is the same as for nvdimm runtime firmware
activation: updating memory device firmware should not require a
reboot. This series is a first step and only allows it when the
device is not decoding memory. I do not have hardware that
supports it; testing so far is QEMU only.

On the ABI: v2 will add a CXL counterpart of
Documentation/driver-api/nvdimm/firmware-activate.rst and keep the
ABI entry short. On placement, see question 1 below.

On timeouts: agreed. v2 drops patch 1 and builds on your series,
with Activate FW handled asynchronously like sanitize. What remains
on my side is the "not decoding" check before starting and refusing
decoder commits while the activation runs. Both sashiko findings
are valid; they come from the timeout handling, which goes away
with this.

On the base: v2 will be based on Linus' latest and tested on
cxl/next with QEMU built from master.

Questions:

1. I looked at placing the attribute under memX/firmware/. That
   directory is the firmware loader's class directory: the upload
   files live in memX/firmware/memX/ and their set is fixed by the
   loader core, and a memdev attribute group named "firmware"
   would collide with it. So it would need either loader core
   support for driver attributes, or keeping it on the memdev, as
   intel-m10-bmc-sec-update does with its "security" group. Which
   would you prefer?

2. Once the command runs asynchronously, the caller gets success
   right away and the result in the background command status is
   not kept. For online activation, userspace needs to wait for
   completion and see whether it succeeded, as with the sanitize
   state and the nvdimm result attribute. Would you prefer to
   record the result in your series, or should I add it on top?

3. Is there a branch with your rebased series that I could build
   on until you resend?

Thanks,

Unsung
