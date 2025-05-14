Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD49917C98
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 01:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747186854; cv=none; b=TeFeIYp4uE6wQvG6+mGWgeyl4nWAHt0viUUNsXe3uY/XlVqtZzsPdWxPSnhv1bYncRrw60ddOWoov9LMIlCuhNM4ihPIP9HHRIVaUskUaNzAXdSLfj8eLksLskYhScSR9biL198Vouj+DBuUzO9DZbm3L0JuEJxtO0rPrRNL9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747186854; c=relaxed/simple;
	bh=wSs4qzJRThIZ4ITGFk8H6aZ3hRo4/7xMG5JnGxWWzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWWpwfwSt5RFBSX3dr9Fjh7QGn81S203NJ+fia1uDuAoTeFEZ8fW/hBHEi1+n5y1uNp7DktaLyitq6UbN1AOjFZQbEtKJ4xWjW4k8PQ8e717NHhc519zYVzInPe/2H0eQzKZYTWEcGflcyj2aPPQTQm3DlYtFqEQYco/KvGB7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=k0Vhsvxg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="k0Vhsvxg"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769b16d4fbso35623691cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747186851; x=1747791651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dM3MoQuvOTM1F9DBzWivSAzXb9v8wfnRaJdyB6k1Z0I=;
        b=k0VhsvxgPXNQsb2zIDCj/t2vR0ctuSc2jdRSM8IvI0EmvtoWQcqN8Yx2LGgFFfdbp3
         ENnOMNdJius5PSuUWxa+qtELL9SGK6TiNgUoZ/9uj3Ny4TWphPHQ2wrVXEBL6eNbYRVr
         PVKwdObLC45FUHsduYg4zSasPJ2lnxK3iNnjb9RWUYvd/WhP49rLew6JwRay2g/4/LIz
         MYvoB9vDiCRkr1Udt92A2VjAhhIBANW9Me2wL8laUXs5VbJh6HNm/0cA1CD/cWlvxnHe
         YR+qafeg/gixrHiLOw5Ce/aHiwpt1vPFIRRmWqfiuwD0tWaxG/mM2WVrE/UUpvDpx2mc
         gdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747186851; x=1747791651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dM3MoQuvOTM1F9DBzWivSAzXb9v8wfnRaJdyB6k1Z0I=;
        b=dLu7rNI8a3Q0MiywvxowUufiRvJeBxcnCTEuP5ux6QlH9kTwmlSh9ewAmyfZn2Y02J
         F54jVfQp4Vl3HWq+H9w+8piA5M3R/hHNVgLjK+jmXcGOyvAV7XANnShhzrXyyBVNdEeP
         6E2Y1Kjwqpzgq3ShiFc2+pn/uQyXWrsuz8viuU+6jesxjc3M9TXrQ8Nh8cI5PjEDH+Hq
         xam8gKpDB8hYinHezAt6XZgaGdfGIU6flhIznd3IFzm6FvOM9tPu4mOiF0MiqixFL1wj
         0g1SyWay95lnxxl57GLMKRqmAstwHBspAdwDnb7KnImp3StsXWCRLudNY917q7xiZQLv
         P0sA==
X-Gm-Message-State: AOJu0Yy9kJLEZuSbYolb3gYQS3lxZuU4kpuL0u5Ntqf/TM4U1iDlArJ1
	NmJInq02CJoGBXO0Sqc+JFsem1K6zrENK/Fxd2Kj6KZAXlnk8Rl/JR1IwhgXZZs=
X-Gm-Gg: ASbGncsujoL4GYSbK9Q7J0xu3HSus35yWK/8ge7ZgLjN4HvSENrUCNuwRHqPSXWBhXw
	BRUFF2YwbBKweUFdMDhBsqqardQI9K9sNnk+YBX3GQ7TP2T0bhg6o5xeYSXOjo3gp5hnvi6Bx/R
	g/ISzwksBKban8tXoHBFqJVL8yr7kHJ7qpKaZOxpOdZ6CGg80xFmUP3KuPnrPvQJToTa9xs3jYB
	wn8aEKNjJyzxflRiWM4Z7xL70I7M8Q4x6WdtcDQgMSbohPRayfP6tKsgzW3o5k1LGNT4X0TZfd6
	EZYiLaB176twpRR2Tn3sJRwfVFutTU1gRxRoFQgsK9cqMaaAjPssKSGGRrhuW01oEwt3JueJgaY
	xX0qT8NaR+bNeXlB9FqSPB1FAbcTViYQ=
X-Google-Smtp-Source: AGHT+IGkuZVhDlpAxMsrbKog6PxEnAzEB7qZVwOtdBVa6QDKeNFAi3gY8l3G/NJ89SC3hJbE3cq8xQ==
X-Received: by 2002:a05:622a:1e8f:b0:476:8cad:72d9 with SMTP id d75a77b69052e-49495cdb700mr27368201cf.33.1747186851403;
        Tue, 13 May 2025 18:40:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494524b9c4fsm73784971cf.41.2025.05.13.18.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 18:40:51 -0700 (PDT)
Date: Tue, 13 May 2025 21:40:49 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 2/4] cxl: docs/platform/acpi/srat fix memory table
 misalignment
Message-ID: <aCP0oeBo--WC6qV-@gourry-fedora-PF4VCD3F>
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514003133.584401-3-dave.jiang@intel.com>

On Tue, May 13, 2025 at 05:31:31PM -0700, Dave Jiang wrote:
> Fix the misalignment in the SRAT table example.
> 

This misalignment was intentional, but i don't have a strong feeling
either way. 

(This is how it comes out of iasl -d)

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/platform/acpi/srat.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/platform/acpi/srat.rst b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> index 56d7bbb18c3b..cc7687645de7 100644
> --- a/Documentation/driver-api/cxl/platform/acpi/srat.rst
> +++ b/Documentation/driver-api/cxl/platform/acpi/srat.rst
> @@ -39,6 +39,6 @@ Example ::
>          Address Length : 0000003CA0000000
>               Reserved2 : 00000000
>   Flags (decoded below) : 0000000B
> -              Enabled : 1
> -        Hot Pluggable : 1
> -         Non-Volatile : 0
> +               Enabled : 1
> +         Hot Pluggable : 1
> +          Non-Volatile : 0
> -- 
> 2.49.0
> 
