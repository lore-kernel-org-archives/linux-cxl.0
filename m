Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECA4204F6B
	for <linux-cxl@vger.kernel.org>; Tue,  1 Apr 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518663; cv=none; b=diQg/+8w83GjmUVwNAJReugcULH8tUjgfGTUBBxr7B+ZZX3rZz8CHSpPnjt7y6w5ulObPQVIsZcEHPAhu40Ez/uUZqiAgNQwuHbevLxDMsIfSJpLThfzXeW4Woebp7naLuM98IeGDm7IIcG6RJiDKyq2flDJMhooXOxI/FnrApo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518663; c=relaxed/simple;
	bh=eiIdxMyFX8RWJTV9imHd+E2JMVAxGUjJHomwrwPuLMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD66jkYPfCkm2lYrZ6jHVq2BGpbjrembjMDca4Gv8+gTPPn5GMGm3p6FSrV2FnxJAxFh4SAlcdx7MrZvfGhxeIQp01tx/sJKBpBlbG0Ds/nTBjN28ZbMIqh6cnBbYhtoOOTk2IJKljpylrbRviN5o1vHeCLqY/xoNqS3Jo4Ym6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VUnYkLWm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VUnYkLWm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5e39d1db2so331654185a.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 07:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743518660; x=1744123460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7FWXvvIBXjd612osNxdIWGLZO1JiputvQXiNVM/ceGs=;
        b=VUnYkLWmn8QDgsZ+Nc8mjvjH224Hz+qQkdxk1pv3o3plsYGLdJeEimY3rjvGUrfALo
         9eN6IHxSkodixx6gbRmAnNvwPmTf5NrcMfzuuaevFw/N3ZDqSG1fQNTCTAzU2C//fKKZ
         Zf4B6xQMAEp1R75FmS6j6g1bqjippmaRH/nRARNr/HsiFPnfpknMb9OqvF9nNLwFy6fU
         zx3a+fqEB+92AIyzJTuk+ms/HUyAh0hLofkdmtfVNkEsRO5X1X2SGPG0kERPfDAght98
         LNrrDy0o5pBegSgj53wijsBwj4TxCXaefQWFsEMdNR2u4ohtYiwqOziDEhgnAb4GDBWG
         nP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743518660; x=1744123460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7FWXvvIBXjd612osNxdIWGLZO1JiputvQXiNVM/ceGs=;
        b=UiMwe+vswM0ehFJu9E3oimRJhExgzG6RJt0gF2ylM8pTp5cSAPzg7GN2jwEjW+TBRC
         LxOktwH1JPwRvMcbmPxwUCbHIoNGuc6mem+DJUD9x6CMxm3PR6b+JZJR+893QPhDEItq
         NRIQqlw7z8Y9Szp92sU7s0WQkeLVZ12jplkk24NuiilEwQQ+VNyeTqWpxL0Kp7W7ERjn
         imUNDGQBoXLiLfT49M310u10kb6qSLUI3185WqdpvSBF8UOZIm4jKPcSF9d8DkgC6X0I
         bWPFyr17X0grHlFi+b/fGYjDPfqISvhpNINlm+EgytWpDJSGmpGeLNXYadlxIesxzwt1
         28Sg==
X-Gm-Message-State: AOJu0YyjZhvjRo9MxMxXGED75qFkWbhjJpGt6dLPZhoRV6DT98uEnZjg
	nGH8kU5YpqW0cJfNcErE5njQJ2J1Os6/q9y4uItTF6YVx54EUgqzT4mdoahZgqU=
X-Gm-Gg: ASbGncuw6LdjW8a9ku2Z387AuzWZhbDBaEA2rY2Jy9/Fg9qUYQxNHJKQRHLzGic4aRg
	cBRm+PU5IIn2EpmBOhHCgcN+zgv20SgDJfLZjGKm+JvgRDWWSv6dK8h/p1Q99OMl0MoUl7Gp1gu
	dSqm4x4U9yc37XY7tw9ARgqZWUqqgA/hK6GPurfY8CsaFJygSH8l2V2FgSYovExK/PTRn66BHmr
	0YoYBmWQ2K7CCuBjt0rXd3QCru9spqrx4sXImO7mXfd1Qi4nyk1DRD5bn5rFiaoc3ttRTO5ZKiH
	kxhESnKl7UwJ/Q6vMgh2h4KLsg9uNTHvER4IkFz0QWlLoeoUf+OqjoqIQdDVQaZXiYQ3uiBaGx2
	PgtIojqzuve2L53v9nkR+mxdefPKmure2Nl2dHg==
X-Google-Smtp-Source: AGHT+IHWAViNpa9KNwFeFv6Mk2L5a71FCOjF9YatoVlMWR+lTPKcPhRsuUJPd37s2vaScZLIZyzR/g==
X-Received: by 2002:a05:620a:4492:b0:7c5:5286:4369 with SMTP id af79cd13be357-7c69072eecemr1663920685a.28.1743518659907;
        Tue, 01 Apr 2025 07:44:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9627e9bsm62509246d6.15.2025.04.01.07.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:44:19 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:44:17 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com
Subject: Re: [PATCH] DAX: warn when kmem regions are truncated for memory
 block alignment.
Message-ID: <Z-v7waimV3OZq_1H@gourry-fedora-PF4VCD3F>
References: <20250321180731.568460-1-gourry@gourry.net>
 <88bce46e-a703-4935-b10e-638e33ea91b3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88bce46e-a703-4935-b10e-638e33ea91b3@redhat.com>

On Tue, Apr 01, 2025 at 11:47:32AM +0200, David Hildenbrand wrote:
> 
> Can't that be done a bit simpler?

Yes, this is better, lets do this.  Thank you!

> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index e97d47f42ee2e..23a68ff809cdf 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -67,8 +67,8 @@ static void kmem_put_memory_types(void)
>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
> +       unsigned long total_len = 0, orig_len = 0;
>         struct device *dev = &dev_dax->dev;
> -       unsigned long total_len = 0;
>         struct dax_kmem_data *data;
>         struct memory_dev_type *mtype;
>         int i, rc, mapped = 0;
> @@ -97,6 +97,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>         for (i = 0; i < dev_dax->nr_range; i++) {
>                 struct range range;
> +               orig_len += range_len(&dev_dax->ranges[i].range);
>                 rc = dax_kmem_range(dev_dax, i, &range);
>                 if (rc) {
>                         dev_info(dev, "mapping%d: %#llx-%#llx too small after alignment\n",
> @@ -109,6 +110,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>         if (!total_len) {
>                 dev_warn(dev, "rejecting DAX region without any memory after alignment\n");
>                 return -EINVAL;
> +       } else if (total_len != orig_len) {
> +               dev_warn(dev, "DAX region truncated by %lu bytes due to alignment\n",
> +                        orig_len - total_len);
>         }
>         init_node_memory_type(numa_node, mtype);
> 
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
