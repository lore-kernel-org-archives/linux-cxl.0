Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27A3CF5E
	for <linux-cxl@vger.kernel.org>; Thu, 25 Jul 2024 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721935346; cv=none; b=Aw0nR2kkY9TrjHVd2MDcWQ/Sslw4H3loEBeHjXNBkM8F5lx9yrYCnAPrNvJ2Z32pWBFcX/nQJdY0oiN1FLyYbsMo75HNjFjBBRYh8odTeDWizGuXv1wNMi9iQblrKeL5bg+w79Q+6UZLm3jijrAwYvrENaTYz0ebDAMMezysi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721935346; c=relaxed/simple;
	bh=fmeHloxeHOgn40k7He3+RXXjEeMTSM32MF04CBVoJB4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xkw+nfKckaPmKb7YzOJR/MMYKyyYuuk8BDnigUiIRzdH3AxCyowzv/ncgEPupRYdpoJRbzt/jl5R1f4oxmW99z2pE+Qxj4g3GlX4UgXB3gCrcyd6smXPFe5lNerZH32lZq1YE/ykUZESyt2uOIgE5q9q5ZPcODVoAx02MCfS38M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgJESA4P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgJESA4P"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fee6435a34so4525205ad.0
        for <linux-cxl@vger.kernel.org>; Thu, 25 Jul 2024 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721935344; x=1722540144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5AgIC8M+mSDoG8S1la9gEv75TPyLAajBHhXa0YRYkI=;
        b=mgJESA4PX0OF1+IOm98SbBun3Yyyl9gJEKtGywWyLbwwyaRAWnvzD1b+9BoDlsnqTu
         0LRBQBCDeG5eoklnzOE91yYzScNl+id/JDlJP0TnX36yEwgV7TmNCT+7B1NIFrE7LWDm
         u0qV9S9FEox0Lg6DfOVvc0KFSyr0aW8+I7bsdD+MjK4WGuQzrrKLN6nrr6tj4JHbOFV8
         YXv2ULgBlef1nOGDpc6kVXa+o0yzxFVESGN+PN46QwVOETnxqc89YmcS4iVUOyWkIdPK
         EOjBxrnfRi/bDLWdDq2WzmjTxFVGbk9nynWf9GHr1csAY/dkRvqMQUQtp0PF2UvEu37C
         bA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721935344; x=1722540144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5AgIC8M+mSDoG8S1la9gEv75TPyLAajBHhXa0YRYkI=;
        b=C0io/r5jdRkV/PCUTuQGIXrDvhxAjgK+uotikMLkmbGetVwmKy1GteAfFHcy5Ixl+y
         Wg+NlR5hm3Q8k/foOjR8HFx848RkfH/mvSZkEJ40q1IrMLhdJUxyUxeIYHWjFll66NhX
         Gc6T/Px4KiN4+dFy0zsb8kIOId1VRdReGLkN1gcrODKjX8BzH+E1BiNCmjgElLljBlrL
         r4DECwSs/PY7tk2FAsJ1dcWxzwgP+ijC35tH7BZcaYhBCGHQ5+IjdGA7hxKgvAt/evl7
         529xmVxGWcMmYVz6LXWgUIq/LHlrAWdnAf1pqGzutVKNAVhB+OHeW0q0DjiGTJECkYN2
         5xQA==
X-Forwarded-Encrypted: i=1; AJvYcCXgcAf1tEAh5X55iqjHkkLRtPabIeTTmR+cMh5hIaRZXyFdVDbYS7Pm2lxLQimENAztOpjEnqSQmWJt84Q2o6B1Rg0HE+upbqYz
X-Gm-Message-State: AOJu0Yzj0xwAdysp3sY5da9yEaBfs0APKtTCtnE3yYuySDbnQXnNUTwy
	nOFGTKlOvcjETchC6gKytr8ODa+eCMHHTnnh8ra1KHV9YuOWJEiL
X-Google-Smtp-Source: AGHT+IETDvJnBhB8TU68dhcjyeHDQae5qz3pV9dlFOX8cIjeTmnC28aE/MqCumXczQ2nvWDmgnWr8w==
X-Received: by 2002:a17:902:e749:b0:1fd:9d0c:99a2 with SMTP id d9443c01a7336-1fed3ad7beamr51244285ad.54.1721935344094;
        Thu, 25 Jul 2024 12:22:24 -0700 (PDT)
Received: from debian ([2601:646:8f03:9fee:712d:3b8b:71f1:cced])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f36cc2sm17754715ad.215.2024.07.25.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 12:22:23 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan.ni@samsung.com>
Date: Thu, 25 Jul 2024 12:22:05 -0700
To: alison.schofield@intel.com
Cc: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] cxl/list: add firmware_version to default memdev
 listing
Message-ID: <ZqKl3cVFTnbaBHpJ@debian>
References: <20240725073050.219952-1-alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725073050.219952-1-alison.schofield@intel.com>

On Thu, Jul 25, 2024 at 12:30:50AM -0700, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl list users may discover the firmware revision of a memory
> device by using the -F option to cxl list. That option uses
> the CXL GET_FW_INFO command and emits this json:
> 
> "firmware":{
>       "num_slots":2,
>       "active_slot":1,
>       "staged_slot":1,
>       "online_activate_capable":false,
>       "slot_1_version":"BWFW VERSION 0",
>       "fw_update_in_progress":false
>     }
> 
> Since device support for GET_FW_INFO is optional, the above method
> is not guaranteed. However, the IDENTIFY command is mandatory and
> provides the current firmware revision.
> 
> Accessors already exist for retrieval from sysfs so simply add
> the new json member to the default memdev listing.
> 
> This means users of the -F option will get the same info twice if
> GET_FW_INFO is supported.
> 
> [
>   {
>     "memdev":"mem9",
>     "pmem_size":268435456,
>     "serial":0,
>     "host":"0000:c0:00.0"
>     "firmware_version":"BWFW VERSION 00",
>   }
> ]
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  cxl/json.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index 0c27abaea0bd..0b0b186a2594 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -577,6 +577,7 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
>  	const char *devname = cxl_memdev_get_devname(memdev);
>  	struct json_object *jdev, *jobj;
>  	unsigned long long serial, size;
> +	const char *fw_version;
>  	int numa_node;
>  	int qos_class;
>  
> @@ -646,6 +647,13 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
>  	if (jobj)
>  		json_object_object_add(jdev, "host", jobj);
>  
> +	fw_version = cxl_memdev_get_firmware_version(memdev);
> +	if (fw_version) {
> +		jobj = json_object_new_string(fw_version);
> +		if (jobj)
> +			json_object_object_add(jdev, "firmware_version", jobj);
> +	}
> +
>  	if (!cxl_memdev_is_enabled(memdev)) {
>  		jobj = json_object_new_string("disabled");
>  		if (jobj)
> -- 
> 2.37.3
> 
