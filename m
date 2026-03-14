Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE2B34DB78
	for <linux-cxl@vger.kernel.org>; Sat, 14 Mar 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773520766; cv=none; b=b59ZtoKKIfZecHUag9WayOFUcmzhkuJF+O4UIf+zbjPS54z9I0EE0JNp/e10nkpaVNNrDfGaFm5B1yYU6FRwWemnE8dhbUq7y7fe4BZq0qwaLA5w7eBbslulDwFRm1C70jovVi++5JxHFzAuKFR7P4w9gjyU9HUzIfHb9Q87lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773520766; c=relaxed/simple;
	bh=t0b4Am2SaTc5Rzzo1GzW6/r13JVH+GhSKnA6pfhvMZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrxBRegfjCgqUsTwqqrUQEJIvZLphZaav39RY7beAb5ttBspmPz05sjvm+MrnvFYSFLOlzzBlu/M1UofbQq8zpowrFTEMROptLozKEKdV0YvkZ3QWMyZdpmstHRY4F7IgM+JI5P/aW7jMvp2CfwGdl/i1g5MzB/VtPvE+vDZ1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c7381c4345cso1355109a12.1
        for <linux-cxl@vger.kernel.org>; Sat, 14 Mar 2026 13:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773520765; x=1774125565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXX5VKHaTVlA5Twk1yI3TOmkIkEJcCj90rxXtOUyRQ4=;
        b=R4Wu4rRrAgKCakbfpALCVSs9ljOm8iWILDturBviZr33grVFH/bkKuiGCdFU8C5ont
         PNNLIWUJk2nBwLtQKmOqGRvQgTqNA/WMTcILwJ4y78NHsS+lxYyQTCXKa3ui9qZSyG39
         vlTh2/ngcBzwyXEd3n7ajcDrN5aC5pmSYJgw0+VT/w1O17lemjoRacEk2yzsYS89BVZV
         aiXuG+gpPQQY9tsJ7C+URMoeQbttuNoVQJzEynBrlJ7sR0O4RQcANxrc7pPzd7+8r5oM
         iCatwUecMUcZU9nVfuugr33AeXzo3qORA5m3iGgXh136P41XdgVzsebnOmkPqzrzQxtj
         Uscw==
X-Forwarded-Encrypted: i=1; AJvYcCVTTSEAIN0ATU0fBPbaP0/bE6QF+ygvxRPcQZn/zxH3cBXjPn5lldplawh/Bs32Fx/wsRglrluwmrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqXe+DnTSAHsthWOR1E1O0KJqQjDuvZdhJvZXGPE5TW10oYNR
	oxdzdMkZXGp+j3+u1iVshG7xoYlSStvHn1c/LdMgH4c6b0bYYr9ezcP7
X-Gm-Gg: ATEYQzxCkjKNndj2ePXY/H4jq46vsZSwtJawFb0cbnMcuZfmAkHOmGxsIvv+1mL2pAx
	7nU9O31IrJr8Osf05YhZLqKIvqlqrkPWGGIQMJ6c7j+6zwzfAf9sZP5/Pcg2p/FaBVsdGADDdSf
	EHtLf+9t/jgqakA8S5UMlP7L1w0gpfRRpJnUlg4rXYyB0zLDIkwMgcYQDzgXSUrtRnfwDHmGVEY
	4zkQDPkDdv5/U2fcWwof2Y1413QpTXx926mD5uaYpzPEsENQWhwMvOX9yqgTYygQHjsqVDO0AOa
	6O0cA0XBga3+a1AW69RrPH4yLOBawWEtpCHZKifsAUaIeu/uJYVpk+4T30uEo6qyTOFCob69ECo
	IVgt4ASoxvFf3Fu15LXrenSz6q1ZfcyXbyRJUyeBQfP2Wg7fTMCA0bcsCooc/6+dYJPQbHpv4iX
	tMVxlrkhJMZwNx89t0H388rbJ7yZW0hCPTgxZAKN97n3kP9AHfRPyM5NS8dUCPOrFlLoqV+Xn5e
	TjH3KnW13oTDgThYBqF+P6I8aSg78KWLtY0tFhJqhQEvd2s5SA=
X-Received: by 2002:a17:90b:1d86:b0:35b:92ba:66e4 with SMTP id 98e67ed59e1d1-35b92ba6ab1mr1025801a91.7.1773520765158;
        Sat, 14 Mar 2026 13:39:25 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02ffdfb7sm14869036a91.14.2026.03.14.13.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 13:39:24 -0700 (PDT)
Date: Sun, 15 Mar 2026 05:39:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: smadhavan@nvidia.com
Cc: bhelgaas@google.com, dan.j.williams@intel.com, dave.jiang@intel.com,
	jonathan.cameron@huawei.com, ira.weiny@intel.com,
	vishal.l.verma@intel.com, alison.schofield@intel.com,
	dave@stgolabs.net, alwilliamson@nvidia.com, jeshuas@nvidia.com,
	vsethi@nvidia.com, skancherla@nvidia.com, vaslot@nvidia.com,
	sdonthineni@nvidia.com, mhonap@nvidia.com, vidyas@nvidia.com,
	jan@nvidia.com, mochs@nvidia.com, dschumacher@nvidia.com,
	linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/7] cxl: Add cxl_reset sysfs interface for PCI devices
Message-ID: <20260314203923.GA672783@rocinante>
References: <20260306092322.148765-1-smadhavan@nvidia.com>
 <20260306092322.148765-7-smadhavan@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306092322.148765-7-smadhavan@nvidia.com>

Hello,

> +static ssize_t cxl_reset_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	if (!sysfs_streq(buf, "1"))
> +		return -EINVAL;

Not sure what would the pattern/approach be for CXL sysfs entires, but
perhaps using kstrtobool() would work here?  It handles all the boolean
types user could pass.

Thank you,

	Krzysztof
