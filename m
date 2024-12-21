Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE4290F
	for <linux-cxl@vger.kernel.org>; Sat, 21 Dec 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807949; cv=none; b=guT5yskcqyKGGJI0wNT6eGeWEjO7F7DBe8nZUqE8kL/ZE/C5Ob7uPY0OxavTNSuA+P3LoQUexls7oh0qkwp7CKo69M/YMwRWW7u0LhmiSNOVXSYA2PQFkqtqv3PUgtAgO6tZFAFqos9nJX20tGzZzWFZF/bxaGk6nIoBmVzjCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807949; c=relaxed/simple;
	bh=09+evprXpASzR+FyZVSc+FI8IIks2DEop/kzphhO0Rc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spRJwcCGdW5EMqbxrdQRH4RZvsaQjzjSfFczC/z3XLvNq7Oyx66lfzO/WlxN8HKvfYitZAUL928RtAo2631V3UQaIfML8HUan9AAzrKi3bNha89WbdtU1PJ0ftRmKs9r/OUqSSM6S7eCctnqRZNBAxCYvsuQRv7u0crulYEnWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvkZVg9P; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvkZVg9P"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so2684690a12.1
        for <linux-cxl@vger.kernel.org>; Sat, 21 Dec 2024 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734807947; x=1735412747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JPsVkPT3ViJh4ujo2k9w5Jfz8kRs2+CUlaQ3ekXs9G4=;
        b=CvkZVg9Pl3Fefz/ze5gOAXOLJC/5j8VsQ8pf//bG/DJ0/TWtrQTILwv1BfbdYkjMgd
         ch7oQGOiBPbCvIHyOLsOZQBkL2V6JdA0+YOe/aNRe8IzN5WbvuV7fdpHyFtLL5z2LYef
         B20KX8kmUeqF+VbgboMGU8/8DsCIbhyUp0wj6hfRpzJAp6bF62elcSsLjmkVqQMYGJO0
         v1fG9VEVqQgbJljkWoNAXDLzV5GEUTPhd5tvT4hQYZKoVOT1STtasqu2mZotZAh+fw0o
         Egb/HbtnR4XE91YAzCRF3u3E2jFi7eaFxu/D6c1ABdQYZ7uNwBUS8KitqJ0UAJXrEXmD
         j8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734807947; x=1735412747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPsVkPT3ViJh4ujo2k9w5Jfz8kRs2+CUlaQ3ekXs9G4=;
        b=CzOvQbt4S9fk9UpwUiGdX95YMFe4wie9QBa5pl2WXM6bkOXBazs0B/1GaIqsBUQylc
         MhO/yjAI5HVjHUA63ZAi8f5D7zFPhA4gtC9Ri8zt52M+DjxEcl4C8TsVr2kVRh17GUMC
         nOQAnltjhmYGQYZaqA7et3sOzctnW3ea96IdeSE/NOn/gIlpSQovrZ5keNetp3ecXMgS
         /R604ayiQmU+Kb/unet9UK0DWmz3OTxptuDZ4P9G333swNvmzsOLGSQTVL3Ykw1pj2dE
         BWYGXsbbhI9NDAhSko8RMT+TUwIN6tWX/wkGKDBdgIJ4+P8SaYtqskGYtjFCj5MGIgh1
         n3ww==
X-Forwarded-Encrypted: i=1; AJvYcCWZEOH4/wsXdOeJUyy9DA+rQPoh4aiJoCu3ZQSIowhi0skD3COYe0krSiLQ1VbzlNfp5IUf76gGhd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGhIKTk4cYXRc4fgpWUJIhlf9FUAIBgG+iMP7ust2MhHSnks4
	rAm9O9HcIKjN+jl98QZ8fkVeadA68FaxPfRx+qjxCu0ajD3oC9Ng
X-Gm-Gg: ASbGncteBZbFQ2bpXaQZXRqRLbZ+r/I/kZKWII7jOQAZUzQmkVTqUlbpZOtlmcErMOZ
	iWO3F9e2uvtc738lLNXj/K4Se7uhoa9MBx0rnRIkJngaQBCBnPAlGkOAISQYV+KPadk8dp2HRJD
	VqFwTxqSsB4z9AD1Q0x4EwXM+xpee3LwA8PWKuQub39b/8cZPflMMwDtUUQ4koeLD94wuaHRcSL
	aCcM4lo/DKPNrF8hUWP7hr96w0ZciHmKtcQhtfrf0+s+KQ=
X-Google-Smtp-Source: AGHT+IH9Cx0uzUC7UUuD8796opyAjS+WeRFB91COtAXIa/8liVy2YcLQmgeWFs8Ec8X/82TARe/k+A==
X-Received: by 2002:a17:90b:544f:b0:2ee:d433:7c54 with SMTP id 98e67ed59e1d1-2f452e372e2mr11713098a91.19.1734807946928;
        Sat, 21 Dec 2024 11:05:46 -0800 (PST)
Received: from gpd ([2601:646:8f03:9fee:1eca:6066:421d:7396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm5359314a91.51.2024.12.21.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2024 11:05:46 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Sat, 21 Dec 2024 11:05:44 -0800
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl: Fix mbox cmd enum order
Message-ID: <Z2cRiNEmM-lNy8Qt@gpd>
References: <20241220160026.204055-1-dave@stgolabs.net>
 <20241220160026.204055-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220160026.204055-2-dave@stgolabs.net>

On Fri, Dec 20, 2024 at 08:00:24AM -0800, Davidlohr Bueso wrote:
> Move the out of place commands into their proper place.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35b8..f6f993e7bc4f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -86,11 +86,6 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> -    SANITIZE    = 0x44,
> -        #define OVERWRITE     0x0
> -        #define SECURE_ERASE  0x1
> -    PERSISTENT_MEM = 0x45,
> -        #define GET_SECURITY_STATE     0x0
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> @@ -98,6 +93,11 @@ enum {
>          #define GET_SCAN_MEDIA_CAPABILITIES 0x3
>          #define SCAN_MEDIA             0x4
>          #define GET_SCAN_MEDIA_RESULTS 0x5
> +    SANITIZE    = 0x44,
> +        #define OVERWRITE     0x0
> +        #define SECURE_ERASE  0x1
> +    PERSISTENT_MEM = 0x45,
> +        #define GET_SECURITY_STATE     0x0
>      DCD_CONFIG  = 0x48,
>          #define GET_DC_CONFIG          0x0
>          #define GET_DYN_CAP_EXT_LIST   0x1
> -- 
> 2.39.5
> 
