Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563151D9A48
	for <linux-cxl@vger.kernel.org>; Tue,  5 Nov 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840494; cv=none; b=kdwlICjZDREQ5Mgod3ZtZcxFkPLN38VQZ4yATgZe8eRmmXtZ4kEzXLq03pZYivcMXbq2mjosQkwWe/sQ6vsTBzSkKH0xdpl5kv5Zb1IT5HCGa6FJJd1M1YiIffB36zCAnFS1D0MNaZRKvvuCm4mWu9INJDwAuECsknEDssDX0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840494; c=relaxed/simple;
	bh=mrJzt8kZ9d/WkvrY9dYNAZMbtTkqdrnzqD0Sz7VWnlk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC+pQCsag8nJObYgG9B7C+jrqon0D1hFsGPcREEhHHRoN0p1c07oY1kxR/z8aCe5CkjimN91BEVPTa6nY1NgQQGiqRwUkp5OSmiOgIBKo7wQhTcsvfjGuQiJAe5h/9CoHv0uT3D1+ZOwZI0IqvWhY1Ug8Z+TgFcbMF8JPDr/2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbJiTGoT; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbJiTGoT"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e2bd7d8aaf8so5328177276.3
        for <linux-cxl@vger.kernel.org>; Tue, 05 Nov 2024 13:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730840492; x=1731445292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0V3nCXvKfMGVThLxqeeI6xHXpbgfrthGNbpv5LxWmok=;
        b=fbJiTGoT4ADx+PltpYgzbTvLSFHSw6FnXENcdcyGwdipHy1yH9xdKoe5JHbdJzBGw+
         O4rmuVUxTFDtbd75QBf/8qCwvlaObvKpz3MQFZ9PPzwyFcoRJGXgOIqP3LcFMoNDhVny
         wuG9trzkdmNxtn6iA3tSaBEKRDlmNl8SlSVsq4hmc+5RQhMvmLuYzD0/RHxo0rs2d2gX
         4vJTXoKWRvdUxx59H72E4pXkyMrUu8MrCu+LPDz8lJ7lnJK7m9LenaqZeZ6SEgV/b4wg
         lunnmQ6n69ekqkFxu9FX0eEgR2ks/t/s1HiocigLDkUIvHuQdFVWwvwKqS/wobrQ+UVK
         d1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840492; x=1731445292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V3nCXvKfMGVThLxqeeI6xHXpbgfrthGNbpv5LxWmok=;
        b=iVodFpEEp/f7q2YHZtIkfyvVC0/O6WMj+z74O0DfMajNXm9zQurovrNrGmF5du1u/K
         dcoNZMHsirqfFLzEu0D0h1vHzTW45gi0OQd4/JxZ3jL25/m17ycf7Gd1lSnDhNj+I1q/
         Xz0mREOFwWt/aqbhCfnvetg57H8Ge84GPoAWQEY8OtqhdWfXYUkO7aaGiXuzfuOkOSMX
         sBlA7xMj8o+B+sFlQ+Z5M6EXMPD4fyhA7l9c6wUbv75ETAI/TQYKg9Wu+SumOhE6MvFD
         PY6yv2lLyVlKDgTa0ASvB3/7VYmLi1k+p6S0W3L0NRLuvaS1Id4Xe7TfryuYUHUWAFZ4
         RH0A==
X-Gm-Message-State: AOJu0YyP0pYxZI2EWe3nuoWNug4FEqxJ3BN5NwTSwRb9Wol3ilsC+D4e
	i932nyvTvmCpUFUIQsvg8DU5dcRCoyTpbF5+8ojP3x0t5TdGhQy+xOHG/w==
X-Google-Smtp-Source: AGHT+IFbzPKzfW1H+8vc8LwCUl2CWaB9C2O5YZzw1zu3k06C1fw++IPRi5u9ZYNFust3TOiScEaGJA==
X-Received: by 2002:a0d:c603:0:b0:6ea:7950:e75 with SMTP id 00721157ae682-6ea79500fbamr106050917b3.24.1730840492129;
        Tue, 05 Nov 2024 13:01:32 -0800 (PST)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea94102de3sm12090487b3.52.2024.11.05.13.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 13:01:31 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:01:30 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
	Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 03/10] hw/cxl: Check input length is large enough in
 cmd_events_clear_records()
Message-ID: <ZyqHqsFQzjDaEP8w@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-4-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-4-Jonathan.Cameron@huawei.com>

On Fri, Nov 01, 2024 at 01:39:10PM +0000, Jonathan Cameron wrote:
> Buggy software might write a message that is too short for
> either the header, or the header + the event data that is specified
> in the header.  This may result in accesses beyond the range of the
> message allocated as a duplicate of the incoming message buffer.
> 
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-mailbox-utils.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index e63140aefe..3cb499a24f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -266,6 +266,12 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
>      CXLClearEventPayload *pl;
>  
>      pl = (CXLClearEventPayload *)payload_in;
> +
> +    if (len_in < sizeof(*pl) ||
> +        len_in < sizeof(*pl) + sizeof(*pl->handle) * pl->nr_recs) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
> +
>      *len_out = 0;
>      return cxl_event_clear_records(cxlds, pl);
>  }
> -- 
> 2.43.0
> 

-- 
Fan Ni
