Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660589;
	b=N0mIS5vN/KE1CD8aUO4CQg0YkOZ7DM51TfMQ5zEH1vKrBHNhP8TsOvsHq+IQJaZdw2GB
	 PTJSr62YzHdO/N6tnamqosbgXGD9mog+yPAuO0FNjAXsxTXsJ3TZnuiqRCEx1yya1FdhW
	 WKtRUOGw6CuiTl7YvNrdegwq+wyI1gGBUcmgLOe4dVr9aMndCqIURvUpW6Rf7zn6td8OX
	 HqKMTGUhXwwfsw2FnT2/J3uucbBfq1JC9VweM4KYHTCQCOyR2eORBHY+rTGYmuTKpguui
	 MsSJKXtS+bU4+ppdlDtR42eno1TWik9V7P5vEl011F5KW5iF17SQxtIPK6ZDeq1AsOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660589;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d1im+uobgRkSqSI9/LbjTpbL6FEufZ/cGsj7+yO7PyY=;
	b=mnVstMI0whz79yZ0woLTla02o19ThZYKqHsYjUO0cPB4WD+8O5BUGa/iwV6o1XoaPwzh
	 WOCx0U7u9Vy5pgndP0oCJbMfYYYp5e0PB0HQx6ZSuFyT+MiytS3Xq+3/C/YxjEQojrpPf
	 ILwiCnU3Pb28q2OfcJf/xci57fLTpeqAtAY7gxLJyrWxS0jsYXmJFoUkX/UJFHG5HXwxC
	 Mne7uM5LWZ9V22SvNKg1mCCgAMBZcn6udKfVljpMtNSek1HWbnvqj+fPAabRJi+NdCX9v
	 e0t+qCZgSenIXPOxfvD5t0GLyw8opYIeMuCYplFL/e1m/sAD4jrfzVVuUCRLktZ1alg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276C606A32E
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8276C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so1493381eec.1
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660589; x=1796265389;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d1im+uobgRkSqSI9/LbjTpbL6FEufZ/cGsj7+yO7PyY=;
        b=E0+QWrJwj0BHjIDpGvSSSwIjvUNB0L4scOGusyANhI65+XL9e2Q7cVJzq0sb63q20M
         cnkWcLB4xL3Pkx5tZIRyWanAB89voYMBVXXqcxwz2krGiNM4PnpL74dEYOUQagbi/QRB
         O2chc8TZMi9xXWhCB8r7pZPepyJm6Axlj4Fa25nRpdC5w4Th0NUhGrGm54kCfHe2Kv5g
         XIO/uWX9mpEApEEAEG0hl1ivzmBTlNftnRVfOdOHsomOvY0UXKCMDbRf0Mxa9it7Hl0u
         kSrqqweGx9nLnZU8BuOYHEe6GmOXbeKLcSDI9adPNS3btXjn8avjfWGlbyj162Owbt1g
         tpYw==
X-Forwarded-Encrypted: i=1; AL+hErFPnKtnbna1gF7Zw2vl004aK8AAdITK6gBxZerMXtAYI9s/uMXtPanhec+2F0LunfoawAVFE6gHX+k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uxAHSxdEyMJxOaa/el3ffF2uflwjx7hbNqAISzu9ylhtBlJHL
	sEnkG7zfqdBEGYlJQT7M5vAX9kvjYqET+gLnIbNPu0Y7v1suD0ZIKm3VzUWV2tSkdX3s
X-Gm-Gg: AZFdTZdgyTCHaPDtuxFArXqWekLv1gi7GegXWHp9k3kXAGfKd09xBcsEewPi23B30B6
	X/UcEsNxmDpkBq8Gj+5Jrb77cvjqam05sBlmlrQoKny1Pg45wfOGpNePQXOq1swdhtozuEQUd2H
	xbzJJKt1oJ01dOT8nOehqpNnZ3AaM8yLCUIXvQbMmufyLmjIDqmBrwISCSsiNglVE7zhsO7vzsG
	P5qMrY0NJAn2USN+T4izdoWr1eSwB3rp2eD8/NakS4+BKTOqb7makVflVrLkrTfq2TxyIVJ0SHl
	0dPXoR8VBbF+8smhMzLUx7S8iYtf10H+IO1yvQ4HTziPZXUpy0jJgIWcWpeLMbPkyxgPcet1R9N
	oYPLeikYjhbnVAHGyV94s+NnI3XUwQYr+O8aW/+JakC32YTGiWn0VS3qDligmYIV4jNDqNoGNrx
	pgxtiia0BQaE5gwGtJmoSvB8C21rKrGU3HS+ZAPskKAKk0OkRaTRZncWm0kLWB6JtBi/4OODpVR
	6xJ8KLulWr51RU6kIim+2aaixr/HI0TFZla4TOeVmIp/s1BrJWXpGv72lVVe8g9UmePdm8RIH/j
	I3Vzv6NFWBrbAUa6d1Z5X8u9Dk5CnlK4iITNtVoEb3vVsVwmuA==
X-Received: by 2002:a05:7301:df48:b0:386:a5d0:15d9 with SMTP id 5a478bee46e88-386a5d018c8mr13659833eec.37.1795660588397;
        Wed, 25 Nov 2026 18:36:28 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.36.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:36:28 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Richard Cheng <icheng@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>
Subject: Re: [PATCH v5 2/3] cxl/edac: Skip event records marked NOT_REPAIRABLE
Date: Thu, 26 Nov 2026 11:35:30 +0900
Message-ID: <20261126023520.39368-r1-ai@linux.com>
In-Reply-To: <20261117013017.3e16c98a@jic23-hlaptop>
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-3-ai@linux.com> <20261117013017.3e16c98a@jic23-hlaptop>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, 17 Nov 2026 01:30:17 +0000, Jonathan Cameron wrote:
> It's silly but broken?  I'd argue no. This feels like a useability improvement
> to me rather than something we want to call a fix which suggests backports
> make sense.

OK, I dropped the Fixes tag in v6.

One dependency to note: 3/3 keeps its Fixes tag, and it needs this
patch. Today a NOT_REPAIRABLE record is only missed because its key
still has bit 1 set. With 3/3 alone the masked DPA would find it, so
if 3/3 goes to stable, this patch has to go with it. I wrote this in
the 3/3 changelog. If you would rather keep a Fixes tag here for the
backport, or add "Cc: stable@vger.kernel.org # needs 'cxl/edac: Skip
event records marked NOT_REPAIRABLE'" to 3/3, I can do either.

> A find routine that doesn't return the thing requested seems misnamed.
>
> cxl_check_for_rec_gen_media() or something like that is probably clearer.

Renamed to cxl_check_for_rec_gen_media() in v6.

> I'd split those two conditions as they are completely unrelated.

Done, they are two separate if statements now.

> Hmm. Was assuming there would be guard() available but nope.
> Was proposed but nothing happened with it.
> https://lore.kernel.org/all/20240228135352.14444-1-mschmidt@redhat.com/#r
>
> Maybe worth resurrecting that. +CC Michal.

I'd like to keep the guard out of this series. 1/3 fixes a
use-after-free and has Fixes tags, so it is likely to be backported,
and an xarray.h change would have to go back with it. Once this lands
I can send a follow-up that adds the xa_lock guard and converts these
call sites, unless Michal wants to repost his patch.

v6: https://lore.kernel.org/r/20261126023520.39368-1-ai@linux.com

Thanks,
Jongwon
