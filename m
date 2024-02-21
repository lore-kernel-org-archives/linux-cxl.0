Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A038563D
	for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708554127; cv=none; b=MSykt1qdoByjAfYfH4BiXEse88L8stUVARCIpyAD+gxFqUKMSGxa9VlZ6IVskWAu5J/0T5jhCXFz3Ais3EArPmnD6AYbwA7ifQApwiASpjuwprIvte+oPwA7iKjnSFBZWzk/n8xQFCstU7GtmbrwAxQL0xjHuYigQW63d8p8BCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708554127; c=relaxed/simple;
	bh=tCwNJSEA0m8LCMcet+nUV73x6hOA788FdagPzHLQc+g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEismFrBk714bYyoD41pEkL1MMxR4x9EIt9pnEdHId0npvxLbgK8MmTEkf2rD06WIsKeDR2BtvEkrN+Qs93VtyXUaV4rHmARlIKgP1HVHuNIrKwN4zRLL3X3SjxypHQedqsL1973raGFRtyPxBjxUsztrA0DgPF8f3x5NUZUSuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op1pKYiD; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op1pKYiD"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e47c503fb5so2031710b3a.2
        for <linux-cxl@vger.kernel.org>; Wed, 21 Feb 2024 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708554125; x=1709158925; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q/PnaOwqVbcHGb/A3Q8ZzkQufGjjKSkGSQi76MFXAs0=;
        b=Op1pKYiDB/lREu02kWZhJCj9fhS9P5BKvDWJ8k/QraqMQ5mdPWkNsV8G9efxLzINlD
         /pAetub8HsKJAJrruyAeTCxaLrdjJR8kdJ6Q/aXR1D5X12LNZ7p9c1gIgS7rMisJAV76
         934Vl8n9NVVqkcUdZAwdSj/7jMBFjZNqnfmEP4Tku52KC8PceNpf8loC5pTv5FDMmXgr
         aOElZsdE7OSX0IkTLDOxGflAWt7QZbXN3bmyTEQ9Sdju9buDempFN68cz9zvz+HdyhMs
         hQu0JDsa47TBy2XgpvP0hgJgXfxvVDNChPBCxaGCCWFgFyxq7I+hY3BiAZ02pGUizQhc
         JUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708554125; x=1709158925;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/PnaOwqVbcHGb/A3Q8ZzkQufGjjKSkGSQi76MFXAs0=;
        b=QR7FUoio9sT+8ZqukHgmRwRMVhdMgxLt0lQSwI0PE7LSObCAlH5D4THzU94uHkzVGF
         0fMFn/YRU6CLOQLBh2ZBc8O1wt4GIjy4yg1NKqRnxOiAq+lbf39htFl72yXsceUL7COl
         EVfLuFG/WkXV2yQaU2ve31Cpa7BZ5RLwgfOrm0WYHVWo9Uj9cAdbVshbyy+KEVuTmpFY
         3mgoSzecmDw+iFc5hcNRJOP9eCsncJpAFnQeLvmLF4MwVA1+BigAhiuLIV346Ah5ObQN
         OAl/xKVfKUsPSkR5ygKetkjxxo62ht6uRKqvOWKh2qBnWI7aj2mAoOJA3T3agce3W7AO
         tQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjkSkZaCaHSG9G1CGpRy7yliOy/jSnV0PJJ65IFTIIpMdf9u1lJl3CyVvBmCPLZfevQ94I/t+Q4OcW1uXEF5G5mpR8L/ouBtff
X-Gm-Message-State: AOJu0YzyfvkNy1+5QLqdWFNSYHC/hH2gNbcqucBGhpWukbLBINw3sCGk
	7ZSK/Bw5Ol6aE8JQmDjoXHubJ8B27/761us80FhNuxXGwjmMKPwI
X-Google-Smtp-Source: AGHT+IHwURnOx6QyZcZrkDLAflwFBQLraM1k3g9+2oQZu9DUxd+ecXDo6UBD9GZ2wROSr9YhnDCdUQ==
X-Received: by 2002:a05:6a21:9102:b0:1a0:b05d:2d04 with SMTP id tn2-20020a056a21910200b001a0b05d2d04mr7815249pzb.26.1708554125276;
        Wed, 21 Feb 2024 14:22:05 -0800 (PST)
Received: from debian ([2601:641:300:14de:11c8:8961:5acd:73dd])
        by smtp.gmail.com with ESMTPSA id t33-20020a056a0013a100b006e3635c5641sm8708717pfg.25.2024.02.21.14.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:22:05 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 21 Feb 2024 14:21:54 -0800
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, gregory.price@memverge.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl/cxl-mailbox-utils: remove unneeded mailbox output
 payload space zeroing
Message-ID: <ZdZ3gvK-ExEYkNSI@debian>
References: <20240221185425.1088766-1-nifan.cxl@gmail.com>
 <5c0bbc43-b5bb-41b8-8c4c-3d58efb687ce@linaro.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0bbc43-b5bb-41b8-8c4c-3d58efb687ce@linaro.org>

On Wed, Feb 21, 2024 at 09:59:49PM +0100, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 21/2/24 19:53, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > The whole mailbox output payload space is already zeroed after copying
> > out the input payload, which happens before processing the specific mailbox
> > command:
> > https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204
> 
> Since "latest" isn't stable, this link won't be accurate in 6 months.
> 
> Please use the current release:
> https://elixir.bootlin.com/qemu/v8.2.1/source/hw/cxl/cxl-device-utils.c#L204
> 

Thanks, Philippe. 

Just sent out v2 as you suggested.
https://lore.kernel.org/linux-cxl/20240221221824.1092966-1-nifan.cxl@gmail.com/T/#u

Fan

> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c | 7 -------
> >   1 file changed, 7 deletions(-)
> 
