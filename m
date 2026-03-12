Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A4F372676
	for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331960; cv=none; b=MFCZaiTeWCyKN8RncGYXRufchlBoMMGbgts94TJLePs7QL1dzLYMJ6YYlEPDK4L4WjfpFNf1hGUyyjo76W3m8rrnFOS0t4EFX9IFIZm0HbM1oio+ja/kXb//zLkDemPGvY7CCHHyEr5dGTudL978n+5hk1fh53LZ/2Z1YDZzTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331960; c=relaxed/simple;
	bh=QFNTUuS3UHbUvEbopqTlsYwnr+9/iPu55Tr5OmgmngE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUWtN8eFgH2Eex+/Ad4l5zid6LT9yucd5SdjMLVDBcagYdpA0U212X7aeBD7CWvfV7vhXh8IzPIH7HWrZBjvRADMiAoysosRcOne3vuvhpMlRvqxVywDQBJ8YcJCXzMMAmuBpArF1IQTNiqS7Me+W/0xvpIh5uBH/Y/i16jBrwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LpfcC0x5; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LpfcC0x5"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50917e02532so14437431cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1773331958; x=1773936758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N9REPqpkPd4ZOpUT732fDGd7EIcOVaG5zQj2KdASHAk=;
        b=LpfcC0x5z98JICJ/WkcSSCLrg1Ai0idvmya3Cj6vezGyYm5iqffhMPB5VmcUF4ED+6
         cmeiaCS3wGAyojQ23BlrzRlvLEd1Swufk2jpqzfLv/HR7bV6fQ0BreD1ArAVm7UVXYVs
         RfwnkgVDYUy5ePEgtds2+ls2nK9EUMvIKdcuBXFJHSjql9EEs84Pq4C0nDZOGDk9rguw
         40avHpeB2tCeavpffR0vdCwDrnzVl9FdUv5/1SPcPymrF8mMWNZjojXCM3vtdE0PFLfi
         hHlyrNlICUnV60YQLVApejp/x+CkEYpB4Ljum4BRwAiP7SY5F7XGuTCy46o+zL/jiDJZ
         ee+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331958; x=1773936758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9REPqpkPd4ZOpUT732fDGd7EIcOVaG5zQj2KdASHAk=;
        b=SpgeHsNaJTXYZAL60DblgAR5E3fTShEfl369S4sfIIFGBK3b+e2GWYo45WdyfHeoUX
         tJuLDDAf/rvAwrTfEU9ftkWmHq7P0AYj4qmG9qqoxCh05i840aG/fBhZWYXpZAJWqRTK
         U0RBARLrISbkaSGP3lXuq0gBZxfAqnok7fv0vrzv7R7aWOcM5Ydv+8NwXJVuAzPYUOcs
         RW1D0FVUtKpTCbD0mtNJaSRwH5vy2hOfazVRaGuYwll5+ph2hVbsJLCD7oN1JrQB5I/1
         5nJ0THxlOoElURaAYV5Io/d0zZ8R+7WBDogZNWAVGKkzw5ycPXrOYCZjSeK18R7feXjo
         w/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPCDC4E6s+C69l4uOOEIjhVbwGQyFkd6bqrvbfMkEMr4lvNIEF5sVBx8A9JGnxDiAMg7n3xJL74bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzukUenS8wZddSrVUQ5jDRo1nfj2ydQU8q5z0eFf/rwt0jrmytL
	S1Vq+SvPWjCibX+jx+2cJX8WKhxgjMz3LzyO7tNeH5tZmD+iqR3DO6GgwRmtbEATqyM=
X-Gm-Gg: ATEYQzyEbzRYY+0wsxTxuD1rXg8egkMQ1g6aVQOYfZlA+qftxJQ8TGNL6vZVhtAk0pN
	ljia0w+p5wiRY4oZji7WsG/Po806RXFHGwrMzB8LidjsoBA3h5Vk6yE82mkf1ETMvVF3kd90Y1G
	of6ANxH+kE4PWlHnWQfURlOr3Y5XmQE8Qc/N46iehDw7kDP3DasyTCVem8AC16VZgN64QTr1T2K
	Hwt9LnH98/TtxBT/F/tCcPvFsZzOodtd9tEsj2LxAxMrF2wWtjeUJN/9nxlt4faRVEg4V4yzhd2
	S1Ga7Vm+7K+WrpMao8YRM+POoqYml5v+o8sirKlgfuMzGhsIoEupZDDgmQItKhP82NwLEDfppl1
	KK+hfmO8hlBoCnYrfAXmTfLfWDrYdiqCrqGoxWdylrImPxmv3/VKYNy5fONo7rDCj9nBKsbz558
	paV85wK8djNv0VlOiSlGbAmB/UwRhFKWXx6Ihy6miwaX/qooBg1ikh3SVIkJqoebJmuc02yCbu5
	pDvxz5pqA==
X-Received: by 2002:ac8:5851:0:b0:509:5f4:4ea4 with SMTP id d75a77b69052e-50939f52461mr92570071cf.13.1773331958188;
        Thu, 12 Mar 2026 09:12:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8e0ecsm35572931cf.5.2026.03.12.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 09:12:37 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:12:35 -0400
From: Gregory Price <gourry@gourry.net>
To: YeeLi <seven.yi.lee@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, linux-mm@kvack.org,
	joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org,
	Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org,
	dave.jiang@intel.com
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node
 bandwidth
Message-ID: <abLl84pc7tavuieW@gourry-fedora-PF4VCD3F>
References: <20260312091207.2016518-1-seven.yi.lee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312091207.2016518-1-seven.yi.lee@gmail.com>

On Thu, Mar 12, 2026 at 05:12:07PM +0800, YeeLi wrote:
> From: yeeli <seven.yi.lee@gmail.com>
> 
> If the bandwidth reported by firmware or the device deviates from the
> actual measured bandwidth, administrators also lack a clear way to adjust
> the per-node weight values.
> 

If userland is setting the raw bandwidth stat, why can't they do a tiny
bit of math to figure out the preferred weighting and just write the
weights?

> 
> Userspace can write a single bandwidth value (in MB/s) to override both
> read_bandwidth and write_bandwidth for the corresponding NUMA node. The
> value is then propagated to the internal node_bw_table via
> mempolicy_set_node_perf().
> 
> This interface is intended for debugging and experimentation only.
> 

Should be posted as [RFC] then, I don't think we want this upstream.

~Gregory
