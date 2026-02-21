Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685831D7995
	for <linux-cxl@vger.kernel.org>; Sat, 21 Feb 2026 05:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771651067; cv=none; b=VlH04p0SmQbThb1mrZ51l2NzlRWpOYtmJ6eQRtIAFAE4VATQ+hN22IFwhnqI2WvdO9XlQ2A0ErB2cOJ/F/tVlNICL1bMPYkFX7L4TF2s+yPF2NvZMAC9o1rbqjizG1T+hrsSMrDuDDQFIDf+Ld9uTmnAnj8vhQE2avPPXeb23rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771651067; c=relaxed/simple;
	bh=66noGg5dY/W/Bn+Kjrp7TLTkcjSOBfqOyKopCG0tFZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMYkzShQblNs+VA1lDLnKAZzYlIv3zcsi9Qa2Vnpt88wxyXN9aC7FJDZ256wcOz4o+g0L9h4Wohgzh7vYQLC4nwb4R0aLiRhWNKfHjR+RBi9tPW3UyO7DHZPJFxbXnYk0qaE5zRDgndAxg5kDECI1EwwSRsnb+yBFW9sJiXpgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=uxZXHrnF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="uxZXHrnF"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-896f8feee14so34407156d6.0
        for <linux-cxl@vger.kernel.org>; Fri, 20 Feb 2026 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771651065; x=1772255865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bx5NmX9Sd7HgKShD/7XTFV5vcmQMTx+Y7QyMmF0n7b4=;
        b=uxZXHrnFr25wXXN95OYf3X0/wKEB1bxscTYcCLnRMD/0Fv4/tp/lTfRDyMfjcd+s6W
         U/iJudTYtENcSc+Xe4fesEb8Inqd1a9aA7iVArAG8kXkC9WzYZ+m9/hEUEM5hoEOjyLm
         D95SgA6BPtZ+FzbNOUEaojEIwPeLJpmq/Y1XhktNnf50GoN44bpJprl9dTi/d3Emx0X1
         Cs2zG6HEUn5OC+y2dh9bwYf/a3B28NmDusC34mAKIHGkPIY+HLYza7fc9Cb6yWRimFT/
         +YFf4yHZwvPidYyiXRtVWZfSkRM4mDgrOSKJoTbf0LRjq9XqISAOJ/t3yyCoWEoDUqY3
         3Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771651065; x=1772255865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx5NmX9Sd7HgKShD/7XTFV5vcmQMTx+Y7QyMmF0n7b4=;
        b=PNjxA642uYHjjcGkjfbd/MXd5WVj78XtK8SeSNZZYuug0joKEuK6dRdIW6iUks3pTi
         wFAR5xw+Jb+cjSZh8X9EvE4RqWLcG1dEqlJnqy+Lc5R5xodeDiHm6sH2ZUaDIkru3gk/
         sRIpWGfRxOcCrApUOZ3ZG6R+n/ZmkHDQUHjk+5P6iRUTqCBniDgeq3N4HAC+VJszKgTV
         FutgdXZ8Nd3KuFdru/4wqcMvjjiN97tMX1yF2bU8/Frsjxobgw2GJg2ezofotMnomxeF
         AlSuLh8GgEwxmYoYfMbiTtbHiBLm5wL6NGxPll7y3KerX/sOv6zRhYS2blYIFTXNHtkU
         BV0g==
X-Gm-Message-State: AOJu0Yw7Q35o2oOskeF+2vRJQ4xa0iwJUcWOPjkhWJ2ncNokDsKdsDTW
	Uz9n2AT276bLfaluq3RDd+ABAUtokJbViKGCw9483GRmZt5L0YcJm36n1evDH1M3zwiajlgkmyR
	cea20
X-Gm-Gg: AZuq6aIm3PpafJThIsvoohxQxpm3nXAaor21WGGoQfRAxWEUGlUBQmfZSdIzFNIw/sW
	GRryWhO8ikYcjABLxX4KikRE8HAqYn91cN8K8hmOqAAlqUUmeIeniJ3uSL4IVgOmgrFF7vUpipq
	pGr2zi7EYmtxrCmLneVgSgHuYj8hSKAXfeGg0l6PMJbSiRlv4vns8attjBbGADoa3l/eckH/SXg
	dT7pC4jxU5eh92mEroQmUbq0gUryVr6xGP0XrLaY1HRywu3piFM0nIE5NmWHsG/tqcplAycGIcB
	yzv+w5DQ+ebtIxG+p2To+uFFNHcIxVa+9dXWg2GmUonue5gApXmixDQ1lxWRQrr44u7cUGxO8ej
	M26VUNYQUpLdws6NkRtRHssavLWD1X2PLbPMqLNIEAitmSMKDik+cR7IXummErIrHTfLAaTaFPk
	XzNf4gcYTeG24w0qQHtoVHdfhc+ZmpbElpTYoCXcHV0BRzRzyL0VFsLxhbdHkyxLd4mqDYHH/Ua
	WM7kr41bw==
X-Received: by 2002:a05:6214:21ea:b0:895:7864:f69a with SMTP id 6a1803df08f44-89979eedb2amr33510776d6.46.1771651065029;
        Fri, 20 Feb 2026 21:17:45 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d064007sm140530885a.19.2026.02.20.21.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 21:17:44 -0800 (PST)
Date: Sat, 21 Feb 2026 00:17:42 -0500
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH 1/2] cxl/region: fix region leak when attach_target fails
 in cxl_add_to_region
Message-ID: <aZk_9iYMh2QPYNDz@gourry-fedora-PF4VCD3F>
References: <20260221043013.1420169-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221043013.1420169-1-gourry@gourry.net>

On Fri, Feb 20, 2026 at 11:30:12PM -0500, Gregory Price wrote:
> cxl_add_to_region() ignores the return value of attach_target().  When
> attach_target() fails (e.g. cxl_port_setup_targets() returns -ENXIO),
> the auto-discovered region remains registered with its HPA resource
> consumed but never reaches COMMIT state.  Subsequent region creation
> attempts fail with -ENOSPC because the HPA range is already reserved.
> 
> Track whether this call to cxl_add_to_region() created the region, and
> call drop_region() on attach_target() failure to unregister it and
> release the HPA resource.  Pre-existing regions are left alone since
> other endpoints may already be attached.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

BAH - disregard this patch, it uses drop_region which is introduced by
Alejandro here:

https://lore.kernel.org/linux-cxl/20260201155438.2664640-20-alejandro.lucero-palau@amd.com/

