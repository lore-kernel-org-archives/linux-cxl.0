Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E20375F73
	for <linux-cxl@vger.kernel.org>; Wed,  4 Mar 2026 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663611; cv=none; b=NwE5zNBYRzuleTZc2t7JCqsf45enTcyHv4TQp3S8jIu0Oud5UBlHylQEVcUl8EBZcycCs5lN5wWCXkAWJm5Jr2WlehxN7x0sArHvkhW4RRZFQWq7P5U+aqrViOEibJcxHoQHUoC/id/L6TInyGaN+ZlpxGGoRAL+FeHy1xdW57I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663611; c=relaxed/simple;
	bh=prulmfQJPM5sB8UVZonMzpxbfN/QSE7fFKzD055GD44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueg0zQKRfyQpe8eZxDDjTFr9M4XPjz+7jQKuSbIlmpX8ICMi6kICtT+euWESe6DE/yXtgHnGNB+nNPg3gV3RDF5SQp28kASYOYfykqz3HwI2kqlKKCP9/dY8DKxeD2NJkO5JFki3l2mXCJkElW1M8LghUWZ5MTA+sCvSatQcnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Jb1PorJb; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Jb1PorJb"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899efe93d4eso51498416d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 04 Mar 2026 14:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1772663609; x=1773268409; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yqt1lwHlXdfsdp5rB//PPPVMKmDVYi0PoyC8O+e52Kk=;
        b=Jb1PorJbTBNCm8VlzIUw4A4KTVk17CZUCIKxuLnbGm+tlNTFFJth76/A/PrKAgYrQ7
         YKhyiAgpt2PYEgmIk8L+XbdlgKVQ10AvZ2UzmlIF6IGbnJOZs2m7khHu6HebB+Smqm5/
         nmPeJPXKNkVvDmym976BthXIOkW1iKmXczh4uLlOAQPKEAczrzdtcN9tv1IwCCA9IVGk
         WBr4wfu50+ZcY2nUkGAyQwNjf1vauNV4SdPUJrt5aq5w0cFtTDnPpHvGS5ef4XsNmu+A
         oSagnZXTqG6U2X23xrwGoDQ9X7X5ygtPGm2wDaPzmVYME3Yrwv1rLSAH4Vznl6xTRugJ
         3Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772663609; x=1773268409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqt1lwHlXdfsdp5rB//PPPVMKmDVYi0PoyC8O+e52Kk=;
        b=ilvnd5GiCH/OjCRqbdi3txwm79DQYVxKjvhN8/9HF/E/l6nN28xWMo47ueBOofFEr0
         v4hAmBC2/NJLOy0PbEgb9giR5+vqufGVfiH6IKlREDncvD512L6B0s0rzvpWwonintoX
         vpW/6CXPpnBhoTxuVDsxzFMxr4urYQXAwMmsKDxK989yb5EUrqR6SfT0n0q7vSKJcW9d
         wghXZ15wq4W1hRflBhvUCTBPuhaGSisHkqFHseul5y7bA5oNRBHNLFXw9bwREu7Ta9t4
         ka4oFa1I65OTMyXiJZZ/nHzu/5pQgTkXgRKKsQ4+9hiwWwpm9lgP4D+1b9VXvRCIES0S
         Jn2g==
X-Forwarded-Encrypted: i=1; AJvYcCWWvV4Lb9EncoH9lbso5vP9Z5lxAAOV8Y277r5y57xNKQEoZLFTR0l6rfeHCmagpMWx5i9Z+ox9pFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywce6cnCsY1qoZVjbhwnvFLNYH7gw/nTVVfBS97ZEKmz8VLoCYh
	0/syktsSGgsfOEla6bzgjQ4pbSRqXSA1T5KubkSKL+PXnrzuq6zI2jHMC78G+uNOVG4=
X-Gm-Gg: ATEYQzyknzyh4Q4kQvh8mm8Yr/x5/VGzB5yCcKETUaD82Kd6Cc4O3kAOoApB47SDrX/
	kgINcuv0xp2Farv0XAsVEbY4IMeumECWAsLN/1Ydmro7Tm3gesMtTJQod4Hb1T6JjC6Stf1EdiW
	JHh+l3KO3yJ6+BcLK+xhWI3/oZOSkz+8kkVttqOHDsXRrXsMMxWQ3g6GfC7tpCXi6uNLxoX2lPf
	od3LTjiE1jNdIQMQE0wFOot+lDSFQ3RqL2vR4i1mXEP9tAj7uwySIEuabxmQkt7hzv5NTbt9LfR
	d5h0qJZ/0F9lIc99741xZNiWH/ZNqs6DythR8tO+EWE6TOG6frqpmINA03r2mOJdoD0pCDGCBHk
	CEfxw8sqpWtxzZpsSq4MBVjeeFPWf20NYAg8CIpqvl10MiyhlI63zdTrFMlR+/jE/FbSmAD554V
	L+YO8BSsjr2PT68dYINFP8+s+JYEUytjaa3OIVHhKts8R0B6lbz/Vc4O4wH73NEQpWKBqYEQSUu
	VjIjh8vWqI8egqotZA8
X-Received: by 2002:ad4:5946:0:b0:89a:9b1:a225 with SMTP id 6a1803df08f44-89a199852b9mr56252546d6.12.1772663609341;
        Wed, 04 Mar 2026 14:33:29 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5074481c0e5sm183664431cf.0.2026.03.04.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:33:28 -0800 (PST)
Date: Wed, 4 Mar 2026 17:33:26 -0500
From: Gregory Price <gourry@gourry.net>
To: Kai Huang <kai.huang@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
	alison.schofield@intel.com, akpm@linux-foundation.org,
	nunodasneves@linux.microsoft.com, xueshuai@linux.alibaba.com,
	thorsten.blum@linux.dev, wangyuquan1236@phytium.com.cn,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: NUMA: Only parse CFMWS at boot when CXL_ACPI is on
Message-ID: <aaizNh-0LEvRQMCy@gourry-fedora-PF4VCD3F>
References: <20260304213342.5776-1-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304213342.5776-1-kai.huang@intel.com>

On Thu, Mar 05, 2026 at 10:33:42AM +1300, Kai Huang wrote:
> Increasing the 'nr_node_ids' has side effects.  For instance, it is
> widely used by the kernel for "highest possible NUMA node" based memory
> allocations.  It also impacts userspace ABIs, e.g., some NUMA memory
> related system calls such as 'get_mempolicy' which requires 'maxnode'
> not being smaller than the 'nr_node_ids'.
> 

Is this a Linux issue or a Firmware issue?

Is GNR exporting more CFMWS than it should?

Is your SRAT missing entries for CFMWS that are otherwise present?

Are the CFMWS empty? (is that even valid)

> E.g., on the aforementioned GNR platform, the "Slab" in /proc/meminfo is
> reduced with this change (when CXL_ACPI is off):
> 
> 	w/ this change		w/o
> 
> Slab	900488 kB		923660 kB
> 

This is a good effect, but I still question the premise.

We don't usually want #ifdef's inside of .c files if we can avoid it.

~Gregory
