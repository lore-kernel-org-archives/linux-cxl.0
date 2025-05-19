Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD99158218;
	Mon, 19 May 2025 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692519; cv=none; b=X44L+zhX5+D+lv2uu3iNncUrc5kFAyTmgw7EsSPkArXUvIBB9L5kpEvfCw8Y3kuicEGPSF+7Fo3ok6/SWXp79Peev4ecvKanN39cxg6RPz1Z3KuZAFYK2SWicIYkoJ6iJLJrnDtCFXvLvIBXYzwZcy+mAdAmLRp+l7dtHRIOgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692519; c=relaxed/simple;
	bh=NXLbEHYo4m6t20pqiqx66riKkPjEjawJYQFhTJ3IRww=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcVMlRbq/SK/RXoV/9IybvoawuP3TM/FFIfzpXpSJPm+GHKPFRAsq9KMBMGtXHqOMV+1jC0qnMkxRdQAsc0QuvK+ViRHv05JxgnpkFsYMqZuGFESl8PknYXNU3V8mAAfE8iyU18bWXTlxXtvN+g2ffa/p6WeeYPTwaFNEkWN4bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSBjAK61; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSBjAK61"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af51596da56so3606349a12.0;
        Mon, 19 May 2025 15:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747692517; x=1748297317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=khpaGwtvwUrlM9wOt818HVjaJgNp4NlwFwcILDUTRJk=;
        b=JSBjAK61x84s6siQUzMnszMlCjUzdzE+eA6d/s3Om6mNh0FRB9TF16K+s4QHzQUso6
         71JYqx20zRkaJv6/DKuwrFjMWka49jbjq0GWmk83kLas67ysZApcn9WHQHGqp5XJkaJq
         TjGjh3dZXCcBYpDuhoEaAJQRJiTeXqWjtWofBpPfum+9jqhEsDDWhaSDsENfHBsyPSP3
         Ar2zjcfRxpn3NC9lJnrF+nzMfX58mJJJYxwZGoa+mPA4DkdO0OMHRBSHihIm//GKwD5F
         784wcI+y1ashZ33xXPzYTh8/sP0TUBRsA1D3r92t/V7Jp/aZMSBPP39uAq+tXPjRg2bH
         EQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747692517; x=1748297317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khpaGwtvwUrlM9wOt818HVjaJgNp4NlwFwcILDUTRJk=;
        b=EcvF7KjiYH9eqsuetGFihw9MO6C3tXU9Dz7B9hCEG3ViZE5qI2RL9HU/VQXgvArdDC
         y2YgXp2ghOrfjpDsswxlsb6uvN98NhFHERloeGPgAIX0hmgnbUxC/g1NX3OqakR8Uk6u
         M+YSrmmilL17ucQ/H+4VVL/aYVll8gOu5M0p3OJyriUbJ0cGOZMroGykM4UngbnDL37f
         22vhsdss6voBuUGioIlj34CLiqHFoa2iowv/qowJqADL0ur3SKvBOMA0WrmYlYhxQr+j
         3bb4ZmncIY66qF5TMV9iCDQgm2oshdAuPyXG2XbPdDmakKaxtfzH0hKMzOmryZY49EVo
         X6Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWAxAOJWC/SotXhdZywLS97rqH72WiP/EZHQfuXZ2gL8XwBSDpTkULakUW7V6BlQoPIUH3TqR9nTbk=@vger.kernel.org, AJvYcCX5Da9+W52ZKnvkK0UgB/7sJ6plz02h2Djhb8j3IhwTSgqG1l/q/544KWnmIAUmrOPFpSihYo7RbPNVAWfF@vger.kernel.org
X-Gm-Message-State: AOJu0YwBv0jeXTdxvxk8gra1EXCHfVIMkYbauGAkujSmhmLDLH8SbRQh
	+qrV5kz7ykNn5FkW51JBVE6tlJ0yoqSoO4IpuC05P8mGf3aOtMh/cAXL
X-Gm-Gg: ASbGncvf1NpEn/9h32iRqI1OwVV1/evQeYAqOqOpkWms3ayZAYeEpId5vP0kTJ3YVxb
	Ri4BWLChT1f+zl81sGZpsApzlnhdk3DV9O9GvJOtUvLm5Qq0RKO4A81wZMEYPZmt2020nvCc7FD
	+XUr5a9kdablCqJEAqp/9Igu1YViIl3rgb0+NKM7Q2beo3rx9No9H0hbD614dgu0RalK/gbMYYs
	DgPf8MXj399/rlpvMhMMMrferE6Hjh1UYXoyCJJX5Sd+wOiw2XHwHewWE7AqvxNQ9mjCUKO+Kd1
	FMuPg4R5Nhhd1Eozfc1oTr5S5CsxFi3RQC3Xim76
X-Google-Smtp-Source: AGHT+IEQfa3nYqAo/VzPr9y6VNpGaDp92/thk150Wh83mO/zRXlVK86M5zd+fCizIgILlbVmYdo9Rw==
X-Received: by 2002:a17:902:e54c:b0:224:216e:3342 with SMTP id d9443c01a7336-231d45ab600mr215267235ad.43.1747692516713;
        Mon, 19 May 2025 15:08:36 -0700 (PDT)
Received: from lg ([2607:fb90:37e1:860:c7f5:c0ef:9850:e442])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adbef3sm64812855ad.61.2025.05.19.15.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 15:08:36 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Mon, 19 May 2025 15:08:32 -0700
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/feature: Remove redundant code of get supported
 features
Message-ID: <aCur4HRH-WT2sj8t@lg>
References: <20250516143220.35302-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516143220.35302-1-ming.li@zohomail.com>

On Fri, May 16, 2025 at 10:32:20PM +0800, Li Ming wrote:
> In cxlctl_get_supported_features(), there is a code block that handles
> the case where the requested is equal to 0. But the code following the
> code block can also handle this situation. So the code block is not
> needed.
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3 v6.15-rc6
> ---
>  drivers/cxl/core/features.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> index 1498e2369c37..2d3a6d36a761 100644
> --- a/drivers/cxl/core/features.c
> +++ b/drivers/cxl/core/features.c
> @@ -416,14 +416,6 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
>  
>  	rpc_out->size = struct_size(feat_out, ents, requested);
>  	feat_out = &rpc_out->get_sup_feats_out;
> -	if (requested == 0) {
> -		feat_out->num_entries = cpu_to_le16(requested);
> -		feat_out->supported_feats =
> -			cpu_to_le16(cxlfs->entries->num_features);
> -		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
> -		*out_len = out_size;
> -		return no_free_ptr(rpc_out);
> -	}
>  
>  	for (i = start, pos = &feat_out->ents[0];
>  	     i < cxlfs->entries->num_features; i++, pos++) {
> -- 
> 2.34.1
> 

-- 
Fan Ni
