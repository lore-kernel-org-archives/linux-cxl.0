Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660604;
	b=G1dmGs6Bk6oQrYtEhCRHQp4lExYdPgcDcW7m3ygvf28l6kG+yL6UBufzN1xt5+uN1emY
	 YtEHrTnjuTR0H/HIDHdjXl08giTOF0W2sJMK5DNsYE9EmsawHO7aw7R8x9V7SA9ee8aMU
	 A83osusuwdCWdQyQqPIXbpmFFugZAdiaKSxihfmhZTwhur9KMWH8vR5W7h92bv/CzeR3s
	 kmXFEWk/5xRseWqISLg3wdWduQoadXDGeVd2ZDjrLh2hEimZyrwGetmvG+CwbKTTDOdbx
	 +Fhc1h9WaJ8NTfeMcDRtL5UESzKfz2Qq7D4t+NHWiZzJdTeKmm1lMcnHLcdwDgGhs6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660604;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=K/aHZfwOuM3vv3+Mu5WDfRhGgSzCzcwBQ2N9xkpTI/8=;
	b=odcZNhfYybOCJlElNPXRfeW2SOveMJtom2UFhs36gJ92ybqsKnRrw9/TjquRQfkESaJs
	 11ohUOQT3x2zYYnbealoNuRw8AuSSXVLDsZaCazZroFCEls2rCVyDzigDy3qvnihKr4yj
	 bsvc7BnXf+zVKRrXhFI4kMRAzKi28jY2BHGPP9TaREtt/U1apQU37igJ9XGVgl1ehHsd/
	 8fAlqT9jaH0gcjGKZH5flcXYzDwdD2t5n61uu6sEsIdgoCqo2K5rdBVmZPW1/uJ8LSeXm
	 50GG+sWoVQB/wNG2ArPcqScwmxRz9klpT6JoxzmskRTv2UV7ZtC41QtIYxCXhgqvueA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6014606A321
	for <linux-cxl@vger.kernel.org>; Thu, 26 Nov 2026 02:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6014606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3863db981d4so9164802eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 25 Nov 2026 18:36:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660603; x=1796265403;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/aHZfwOuM3vv3+Mu5WDfRhGgSzCzcwBQ2N9xkpTI/8=;
        b=CPdnu36uqtWnDhTsAFLjE2Kq51PPBCmAEnJfIXNFvaULFNe8ZUW0xQTG3SBet5ECSk
         ra/9Y7KGTjWUa8t7/3WXH6RMlrrrqq2K+arCLm8Y+BKUkzlKRs/kC5W1jyf54JPs2L/Q
         7YaorC5ug4RacQYerjzz1pZNlCfLsLOmo3ZC5SuAfLswlDctGrWpS4wLggRIqVVkr1bs
         CYVke/+8sk+rM4g6wWFfJld06T2bUiMH53AcJWwDn1Ak7aI7AxPTCeZlRnsuMWs8iBG4
         Kd1/dKB12XXLoYwBLokjO9i7RoJBAKGc40Phpaf2ofpUJS95ZN4IsXDrbl9Zk6QoK9pU
         O0wA==
X-Forwarded-Encrypted: i=1; AL+hErFGgAFT1PnVSV1WB9FXgu4QjLkX3DCHXK8S9//TuBFKM6/h9rR8hDidAMnLjmeXl5h1nXH2/LmAfCw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9z+WC95YZVvEx7l+6dnwd2CcVjU0/BNa15XgMIQ+tG7nR2uAnY
	tl6Sbeqna3ztz9rpwB1qQQbRfdSlyJgAeY/+XHb8zhYNJcHo9IUz6OvJpAYvZe1fFG8X
X-Gm-Gg: AZFdTZfWUbmSNwsLpmRQa9PHm+/2r365+caWN151Kl6brDIKks/Rx0UP6KbX093TIhZ
	xFEvTIrUZCBy5ETloWI+4xs8dzfOYWNyOEVX36Py5yv3XZJ/Sl42awn/dO26mZO7gWK6TQFh2W/
	K2D4yWeSnQluUjUl+XMPZFnMqGavcSU8GmjQJnpO6EVxhgoLYvtAzZ8dtiIrZsoV4FfSMoQiNu6
	CSlV2NbyVXVcBRKsNV0gk8qw5U1GCHo3/632d3V9tfZSo4SSr9R8mgJDGQzdmnjBaDfACUdy2NT
	mrX3G31oy9sFVuQuPm0DTCOYL6MHfWEYszXMdl6G14rTiFBQT9VN0P7qJxB555l1x8+5ODjlJy2
	7IB7V9iukQBkUqgdf1bmKC5FPLZJudNmWzRJhNfX+By4oUbEEoRW6csrMOrYmmPPZpe1TFiL7ZR
	OBr+hQksfJUDKtRjxw3o46PskeWf3u9P3s7xmosUsr5tD3mtZlefWQ6jGelLOrXsIqvfSabIb1X
	CJKo0CXoCe/dNWOO5jx3HKRnBLlYYiWEtX5gcfFkhrgmzP64WurFw2poxUNQ1hjfrDTe9zwok1l
	Y51hzCXTj9lvf26BEh3SjBoewVouLsfwqCHPTFfHroMiox6diA==
X-Received: by 2002:a05:7301:391c:b0:379:f7aa:1013 with SMTP id 5a478bee46e88-3856fd59fcemr20034878eec.15.1795660602731;
        Wed, 25 Nov 2026 18:36:42 -0800 (PST)
Received: from alanui-MacBookPro.local ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm26703230eec.27.2026.11.25.18.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2026 18:36:41 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] cxl/edac: Skip event records marked NOT_REPAIRABLE
Date: Thu, 26 Nov 2026 11:35:32 +0900
Message-ID: <20261126023520.39368-r3-ai@linux.com>
In-Reply-To: <av0ENg0EwkGRVY1R@aschofie-mobl2.lan>
References: <20261108022022.3352-1-ai@linux.com>
 <20261108022022.3352-3-ai@linux.com> <av0ENg0EwkGRVY1R@aschofie-mobl2.lan>
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

On Tue, 17 Nov 2026 17:49:42 -0800, Alison Schofield wrote:
> How about writing "so these records cannot satisfy the cached-event requirement
> for an online repair"? Offline repairs skip these lookups, so the current wording
> sounds broader than the check.

Right, the lookups only run when the memory is online. v6 uses your
wording:

  Skip NOT_REPAIRABLE records in both lookups, so these records cannot
  satisfy the cached-event requirement for an online repair. The trace
  events already show dpa_flags='NOT_REPAIRABLE' for them, so user
  space can tell before it asks for a repair.

v6: https://lore.kernel.org/r/20261126023520.39368-1-ai@linux.com

Thanks for the reviews.

Jongwon
