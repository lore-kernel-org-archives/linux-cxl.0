Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733F626B081
	for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884008; cv=none; b=F9gy52SE4Pl7vhDGVloR2foXtB5ZBzJ+qPEscmKbU3+nY8P1W30Dm78E5bYybG6SDVQ5og6lf4Rje5kdO2rTFupA8dycv2ZG8ju5CtEyk4yR8vbeAtDuJvGVCr3nXp+VkzEPJcZympXtWJ2YdU/AVEQVG7uN5nTs6YCzJmkotYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884008; c=relaxed/simple;
	bh=GWLwb/in/ljzG15bf2lZCq2gdMYjM1TmRRBfkCLRuqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIKYZV3uKtOwwryOROq6DNLeOyW3ZXtIBx0dpF0UL9GNyGK1z7Nl5Nd8FcMhPZvgy5M3IJnQ04H9p/43vt77y+XyJVP0yE5t35K0ktdIr/xBeOUjs1yic1D0ByqUBwNb9lbHUvYSSLLMdViCSKM74p8nkVeTu9jex8qWJZ+RtqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=rWqf+0PM; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="rWqf+0PM"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a304a8edso11575071cf.3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Mar 2025 09:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741884005; x=1742488805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU1db5kv6b5O3y8o3SsJx1lUw+kz3Y+K2K5M1PC6NRk=;
        b=rWqf+0PMKiCEcaZkh/n/kSfZHXtA7YK7bKZ5XT9cGoHGO4qPuc5/gUpqrb+O6nUW78
         6CrObp3C3UZqq35+BOgM2pJDk56a6Phf7jcgiCLWEG/u5sKv+8Q6wMymR1DAaIzPBTJp
         hCmqiYrRxiFdmziM/xnKCrGEw+0lLH/rkaDtl3OXpWsTUJrkKHxxFnlf1rRw1OKtHtLu
         A6XKWLEkAxrIkgE6JEMvKLI/24Y3IRWPQtBSulPjFM6etFLU6sUHRee8QfDdElDxZ/L2
         QnGa/LjUwYQKYVFNIdK0y9EyVUP0a9doLQ4f9Nq4iGDfWzl7RNIvfCLCN1gv7R2LPAP5
         NR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884005; x=1742488805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU1db5kv6b5O3y8o3SsJx1lUw+kz3Y+K2K5M1PC6NRk=;
        b=ipv6ZSVi/m+ZfBfGLCecpPlUlz2tJhdxAlV6EQ1LsFn2RAlwNXBfDXvbJHe7krr/dx
         Gp0AuXVLEIQuDRZpa0vRd0shnMxHfGxNq1EE0x1saOfjuGjdUhT3ySOihsOmDS0+jPJq
         j2gj/wtSWo4IG9JF8+PxJVWqICjGUXhR6rL0V2GV6+itGxSHJBcvtKwUOTKiRF60kl+A
         VT3kJO535VFZJ4MkY6DJY8Ng5X0aiQvSdNJdlrjMvmoLAeBf67z/+z5NoOdIJdRQQd/V
         sGMSS+8/wpGLrjkhnRWK/7X3FH4rX9QGrbhEPnduli7MGoUaqE2HB1rfiqhnp7jF9hqQ
         KvfA==
X-Forwarded-Encrypted: i=1; AJvYcCUyPBUMofc9SFpKB6SWhnh9oL1lWekVZ4jD3uk0XsaA+h2tWURtmUnSQoawzsdIuzDx5iIoBhSe0mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLNwfGnSbidxpU2KHSspbpHr7DQKbDnto9GoiHsnXBK1kx22FR
	f0zDh6rR8n2gJ5oSeiE8snmvq5Fo/0R9gWHjTgGiX5GgHIwE5IV5zskCuRsUq9I=
X-Gm-Gg: ASbGncvvf28cOKTHIfCvEuj3IdNcpGg/2fDHczgVvtJe2eTuJzKn6DnOgdye1cueEmh
	YtDssbE2W93PKiLGfsFVP18VFBy15/orcgF+/Uit/tVN7KAbAbwi+II6t+mhtL9QatKFJXLIrgo
	9LuB+7JrPZhCCDCCNrZtV4x18vcLoVIpBZQU0byaxVIem2gPhUwaEhqo2TQ0RSbLhaKQSZCFkLS
	qBZ0mHQGZPd5osmgq9mp3X9HhH/glVdC0IwU3jzAuwsV8Pa6cwBxrF4UkxicVJiH5K1H7VRj3Us
	UEhCkcN0d2b+Z5fKeHbbU+Rt2T51NaKdrcwwA2AbXAQNtedncCf/cmyNBfkF65ii0VOClA2eqSz
	2bCDfcybzhFQPOiFpZNxyHRAfokY=
X-Google-Smtp-Source: AGHT+IFkbHVcwllGuGBIJA3zC1/en1QL/cRzQlTpw+FJ8AJ/Tz+liHnNiv/rq/e44ltwNEtCG6qzGw==
X-Received: by 2002:a05:6214:f62:b0:6e8:9526:5788 with SMTP id 6a1803df08f44-6ea23b41e51mr182171836d6.0.1741884005199;
        Thu, 13 Mar 2025 09:40:05 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade24ea07sm11488136d6.66.2025.03.13.09.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:40:04 -0700 (PDT)
Date: Thu, 13 Mar 2025 12:40:02 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v2 3/4] mm/mempolicy: Enable sysfs support for memory
 hotplug in weighted interleave
Message-ID: <Z9MKYlJW9WtotzR3@gourry-fedora-PF4VCD3F>
References: <Z9Gy-No6pXFWZAyc@gourry-fedora-PF4VCD3F>
 <20250313063416.703-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313063416.703-1-rakie.kim@sk.com>

On Thu, Mar 13, 2025 at 03:34:10PM +0900, Rakie Kim wrote:
> On Wed, 12 Mar 2025 12:14:48 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> Given that this adjustment is part of integrating the refactored
> structure, I believe this patch does not need to be split into two.
> However, I would appreciate any further input you may have on this.
>

Another way of saying this is: can you please change the ordering of
patch 2 and 3 and place the functional changes into "make mempolicy
support memory hotplug" patch.

It's a little odd to "make mempolicy support memory hotplug" and then
follow that up with a patch that says "now make it REALLY support it".

Patch 2 should read:
   "Refactor weighted_interleave sysfs to allow node structure to be
    dynamic"
Patch 3 should read:
   "Make weighted interleave sysfs structure support memory hotplug"

I think you'll find the patches end up looking much cleaner this way as
well.

~Gregory
