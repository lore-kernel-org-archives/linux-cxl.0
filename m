Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CDA21CA12;
	Tue,  4 Feb 2025 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713577; cv=none; b=JGkj7w+BmZ4oi2oe/eC6cCb0T04S1KqZ2kvEegxbjMsCYFfTe3ttSo7vKx2XCMZHctD0CqIzp9zC+2VjGMe3KR92SdysdJ2zzZizehEZYz9V2wX9qbk2j3ERr0wcFqj38Y7tfzIrQwmkBGux3ij+IMGfsxFoTEyesVPloCguzj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713577; c=relaxed/simple;
	bh=fujvvPL1GXNCP2ksz7hLzaGK4jVn8E49P1MfeI92zFo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSUKPdYRVuN/XrPUkaZE+MU1EuCpeAsf3kOgjIU1yS26Ys7SGq228TvTt+ItpL6rbGjhSJEU5FFCj0iN4v+lc0YBUoOve1Jq5PU9lr9rWRyCEX5Gj4li7Q1pO61LDDEvDrMEMHodmKSlPDm/qFXnAIRWbgbwZHts+mlXQesw428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9CPsCDE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9CPsCDE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21f0c4275a1so15665145ad.2;
        Tue, 04 Feb 2025 15:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738713575; x=1739318375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g/q2tyZAAvcVkKzTa+SNYfGvuMycr9gRRASz2xPCLZQ=;
        b=U9CPsCDE1LbHyBL5VXZoVQfSZD+JB8PgiWE3m7u3dYMpKYxtPCLheqOjTh/t5ZW7fx
         N+nWoJhtQE+/VtOAL8uw4wWSQNOTITopNczBKGveQEFMXn76PIHwxSPPvCDsXQQVXnAH
         qt+LlQxOWeQ5tdWRErnhCPqAy7lkmaVEJLyLn85ToNIlPK7cxu3MUkbo2eC1DjwQRMCS
         4W9lyvKcEyCW6OIhfoLxjZUSvMCBxGfj6+pGvQJ4afc00KkTQUHhAy3IVY3Pm2HB4Q05
         GWAitC+gmjEGb6jSiO0/+RJlDpeuwMysT2xmN47qLr/e3YiFXH+VJEGxX/hgUogZqOE6
         sVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713575; x=1739318375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/q2tyZAAvcVkKzTa+SNYfGvuMycr9gRRASz2xPCLZQ=;
        b=v2CBZ7JB8nkhBMoEMQQOPeXwG2SKxWFsLVpyTKZYBH2ky745OHRocg+wxB03ooI5JU
         FSTxLuXq3dHfkfS09EWkMoNfNtyvEiB9ZzKxsYGUGCKEpdzO71+YLos1dowgK2ihvSj0
         SKnYFkDlV7t3hRCKFQQk2bN10GqmqBtKHh9/zxK12+YR0F/ocow44btsMHh74TVVUm7h
         nfaO6qJGvqPGQuQShu2ozLAwHvluO73Mw5bWQY+YYOOUyBEFLFh+PCtq1+9AIk1Axtse
         s6uThaZGsVHPtml+teoHbS3O/jJ1Qyx64No1hYQdh4hEYl5sDjqZbSEcu43VfmE4AXAb
         jE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX2YDMtFAsIlkdcKZ8leH/dCDNTDgLunCD0QL2on/sx7f5PPeh0uIr/QW1pk088sphDpXWDLkYzuz6fZH9@vger.kernel.org, AJvYcCWFQxu16zEQ9UBZrxo8Ty/4/89gcoN10UAdFhjV09UKfi8k5jqnijXay0dWBAW2Hkt01/aDjTy7fCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoy3Hh6Kn7aXjbe9QK17sEt3ua4aAQYvVSPa/MRO+JtjIfROI
	0UC9kBbO4C3AG6opCwFXAjMGVmNfAq9KeEzgaB2vFaEsHH+NzUXD
X-Gm-Gg: ASbGnctyook6c6eid2hGnMsM86oURJMcsgJfROgiwWBwQEacJu6IXVkJ0vqIWJMpUMg
	eDg7T6totgx+Ju7CKkddSnHF658nZ3L6SA8ya5JIVg/hdhfrIY6/SfRwE+h1YMTa+3jbQLaBTFc
	MzhNN1RLp5eRqac67KRov3s8tIVF+1RDLHBbe3CduV+IA5cKt0ez/ZMkPpddxx7XdZzzABECNsv
	CuccFo9rqV9VTt/UOeUiKgs+f8PR42VvK0xzCVMEmOQCj9qNPkCR3p2vakG6YFAh7gt9ERUbooY
	4TmeJg==
X-Google-Smtp-Source: AGHT+IF/zGMrKsIjOqCVrxmYCeByp2EorEdyTzyMGA/Rmeu9LI6wOt1bFMMSlyOMyvL7W6Vyc275Nw==
X-Received: by 2002:a17:903:2301:b0:216:59ed:1ab0 with SMTP id d9443c01a7336-21f17e7421dmr10936335ad.27.1738713574844;
        Tue, 04 Feb 2025 15:59:34 -0800 (PST)
Received: from fan ([2601:646:8f03:9fee:d2af:2257:5cc1:cb1b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f142d4beesm5111325ad.89.2025.02.04.15.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 15:59:34 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 4 Feb 2025 15:59:32 -0800
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] cxl/memdev: Remove unused partition values
Message-ID: <Z6Kp5OaRFKT9DZh_@fan>
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-rfc-rearch-mem-res-v1-1-26d1ca151376@intel.com>

On Tue, Jan 28, 2025 at 12:51:07PM -0600, Ira Weiny wrote:
> The next volatile and next persistent values are unused and are
> cluttering the cxl_memdev_state.
> 
> Remove these values.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  drivers/cxl/core/mbox.c | 4 ----
>  drivers/cxl/cxlmem.h    | 4 ----
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 62bb3653362f5325cfdab7812633328eac50ab30..998e1df36db673c47c4e87b957df9c29bf3f291a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1097,10 +1097,6 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>  	mds->active_persistent_bytes =
>  		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->next_volatile_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> -	mds->next_persistent_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index f218d43dec9fd89f950af667ff033d0802084345..29817f533e5e408243d361c46ddbf0c295b4fda4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -548,8 +548,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
>   * @partition_align_bytes: alignment size for partition-able capacity
>   * @active_volatile_bytes: sum of hard + soft volatile
>   * @active_persistent_bytes: sum of hard + soft persistent
> - * @next_volatile_bytes: volatile capacity change pending device reset
> - * @next_persistent_bytes: persistent capacity change pending device reset
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @security: security driver state info
> @@ -570,8 +568,6 @@ struct cxl_memdev_state {
>  	u64 partition_align_bytes;
>  	u64 active_volatile_bytes;
>  	u64 active_persistent_bytes;
> -	u64 next_volatile_bytes;
> -	u64 next_persistent_bytes;
>  
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> 
> -- 
> 2.48.1
> 

-- 
Fan Ni
