Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D1260A4B
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884487; cv=none; b=JWPqoL1dlCEi2x97neUA/i+/YUsu+H/g7kYcAP0MMEm+hEkyx1M3eJp3x8NbUzTw78n/3SfawF2sc/SV/33iWSZjKSHkCXqaK74h0rn6OM085o5hANFGPvh2KvYtreDzS4bnNAhEghuFYkeJitqn9t5fo8HWeUQqrxKBS0TVB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884487; c=relaxed/simple;
	bh=x3SebGT4/hVZ6ltP0nnoHVJ04fj2Ha3ZkDNmZkkZT7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh6uDZA7D88imzNrWMJjhfv54qYLE0oj1jRxpy0yIHhqAU3OjKOvPyGWnsd2DOEZQ8+XZ/E3yBTBTlldekSki5hHEw7c1yaVv12Nv5FMhfaf0MCtcYOIr9JQCVPmBCE7CJrojpRUUutlhpeubQVr/37PuYXIhFj9VvQ8hqVI9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d586gfzg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d586gfzg"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08f9d0ef3so69914785a.2
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741884485; x=1742489285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6gWJHqAH2Ne74hFxjKFTiD545xNbJagX+7KeghzOK3g=;
        b=d586gfzgfJyhVxd4XNlQfktvSGS84dn9PeUraszwv1OEJx7IcCbtFXDxvjLQhY5cVu
         My0MM1JnR4vDVmoLA792wLE8Qy0EFhS5MFeUhwrTtpnVxrOUDiL8TiqEdbBEqz/tOD+u
         FkdETLEl7q2fVDZti1IggUUOuBH9b8rDGOp2mRjbhkw+mdCUXtAj6saoVlePaaivG95a
         RxpvGKs+YOyqPPRwkMFPZRxyzlZGzSUkVNqPzrJ+AUfFC7UZoxDF0Z3YfVbZd4nTleba
         c2Erep2ekCflJVOnd3n7XiiPVH7YvCOUJzB/B9bj1cyHS/TKyf0jhXatHk0UqgYWXkkZ
         aYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884485; x=1742489285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gWJHqAH2Ne74hFxjKFTiD545xNbJagX+7KeghzOK3g=;
        b=fD2uQj9TClYwoqa29OPK49w65VP2b8OWkQmjCjCVuuxtMJY8yU9zpUASGce5CgO2gA
         EPyADhPGNPyFR+Sw4dxU3RZMvTj1nyyPEkm630cnJr62y2F27rsncuIF2aNq09k8LSIe
         wxEjU3322SYNRqhlBHqoYoz2D9QpmazUdLbDTJVRrsf9lo5bpaBVqqg8CEvmHiaVoGtG
         sAe+TvEaifZ+jLXduZWrqWfp4zZhczQEZ87wxT1AAgW1K1EGy+bXVIS1u0wrn5kg+H4+
         sbweLws9LIO798K+GtqHMZRYNDd/zYQ/qiTM7wJrBDgIGoDxEujOt+LxgVCg11rx+xNt
         L+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVxM+h/jDLLnYU/gydynQSKab+1jCtl5LaKxy2FlRpQGk8yG8evxFGgoMnCol3sCEgGCSZacDnPj80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOxHPNk9ztc+QlXA0ft9of5KDIs8K4QlWmht02IaLekCg/p4Q
	hcamf+QtHs/FUTudEzB7j70ozlJD9ed2zmYbhlv6JHXH8nXg6nmVMZnezX91xF8=
X-Gm-Gg: ASbGncuTYlpMU0WD2BefZ5jEijBTMLQauj/jakGYHJwOrwB87XVQmOlejuuqDxUyLNb
	qaxVgHuJY/xGrblFnkhAlvXabEH/D8Q9ZI96eOhPx1WOXDa5xIeSHtxStpr68yBI5S5HTA3ZOIo
	9cZGuO3lTKwBor7zLWnHg8ERzmexy6qppguDBjkvLUaFGL9tSBDbrOmH/0C8eeexD3UmEjKyXIk
	wcYWFZ6itqjWqZ+iAk16yBp/f5vQHIXtna3WKjE+9VrCTX24HmgRGp1zh99rKiLOZBiOlUvn53i
	qBsWM9BXZOulOoylkioPENnsclR5IAKIckKjHLVbzq2c+P4CB/0e3rgMW/+o81UHrnOIQE8R17y
	Kwp1gKzWS/TugBW2hizH1g7UnZAc=
X-Google-Smtp-Source: AGHT+IHxF9ffTb10hBbkPjF4Gy9uvvCTgZFfxO5Mi/avamJ3LWPv9XNw4u9cLuY8UUZaXI1bajEgNQ==
X-Received: by 2002:a05:620a:618c:b0:7c5:64a5:d17e with SMTP id af79cd13be357-7c579f1eebbmr83505385a.25.1741884484673;
        Thu, 13 Mar 2025 09:48:04 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f525sm118401585a.20.2025.03.13.09.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:48:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:48:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM] CXL Boot to Bash - Section 4: Interleave
Message-ID: <Z9MMQjjw_QaOCxvD@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z9DQnjPWbkjqrI9n@gourry-fedora-PF4VCD3F>
 <Z9KX4/zF6/yFdWLQ@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9KX4/zF6/yFdWLQ@phytium.com.cn>

On Thu, Mar 13, 2025 at 04:31:31PM +0800, Yuquan Wang wrote:
> On Tue, Mar 11, 2025 at 08:09:02PM -0400, Gregory Price wrote:
> >              Window size : 0000000080000000   <- 2GB
> 
> I think is "Window size : 0000000100000000   <- 4GB" here.
>

Quite right. I am planning to migrate this all to a github somewhere
after LSF for edits, so i'll take all the feedback and incorporate it
then.

> > There are two targets at each level.  The host bridge has a granularity
> > of 512 to capture its parent's ways and granularity (`2*256`).
> > 
> > Each decoder is programmed with the total number of targets (4) and the
> > overall granularity (256B).
> 
> Is there any relationship between endpoints'decoder setup(IW&IG) and
> others decoder?
>

I'm sure there's a mathematical relationship that dictates this up the
heirarchy, but each endpoint decoder needs to be programmed with the
same interleave weight and granularity of all other endpoints.

Technically unbalanced configurations are possible, but Linux does not
support them.

> Hi, Gregory
> 
> Seeing this, I have an assumption to discuss.
> 
> If the same system uses tables like below:
> 
> CFMWS:
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>      Window base address : 0000000300000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
>             First Target : 00000007           <- Host Bridge 7
> 
>          Subtable Type : 01 [CXL Fixed Memory Window Structure]
>      Window base address : 0000000400000000   <- Memory Region
>              Window size : 0000000080000000   <- 2GB
>             First Target : 00000007           <- Host Bridge 7
> 
> SRAT:
>         Subtable Type : 01 [Memory Affinity]
>      Proximity Domain : 00000000          <- NUMA Node 0
>          Base Address : 0000000300000000  <- Physical Memory Region
> 
>         Subtable Type : 01 [Memory Affinity]
>      Proximity Domain : 00000001          <- NUMA Node 1
>          Base Address : 0000000400000000  <- Physical Memory Region
> 
> 
> The first 2GB cxl memory region would locate at node0 with DRAM.
> 
> NUMA Structure:
> 
>         ---------     --------   |            ----------
>         | cpu0  |-----| DRAM |---|------------| Node 0 |
>         ---------     --------   |   /        ----------
>             |                    |  /first 2GB
>          -------                 | /          ----------
>          | HB0 |-----------------|------------| Node 1 |
>          -------                 |second 2GB  ----------
>         /       \                |
>    CXL Dev     CXL Dev           |
> ```
> 
> Is above configuration and structure valid?
>

This is correct, the association between memory and numa node is pretty
much purely logical.

I'm not sure WHY you'd want to do this, but yeah you can do this
(assuming you can get the BIOS to produce that SRAT).

~Gregory
