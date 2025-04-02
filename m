Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB9E2309B9
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743571422; cv=none; b=DwQeRZObZBI5qa0wxypmD4LrpkJsCcrOqLr03qiVXHYYR5anLEqMenzqe6v3os9KOI/ZJk8Pr1upSa67t9RoD/oGI7ooPb6hGC73u+f0/2GEllH+Yal/fLaR2oDpneraUt7sWyZFOG3t/JAJN+PXxSBsWqX73v1Aq9+ryszjiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743571422; c=relaxed/simple;
	bh=+UmaRoDqvDW86/fEtlINGKafVKZHUZdnazmF5EYjlN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1K4KpDg/ngjhVarhMcTfWHZZEDU0a1FL1bMuqzzsRjTpEj16y8KmfIcotx3lALDAh/HRUW7hY8Wp2VcFDIhB4qrVZCVdX1NIv3YPO743Qi2eDjLtAEMD30EtOYqUy4IHwP01f22LelqyXRXDtEpz/4qZFxJExLq2QhKkaybDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=f+oE8L0v; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="f+oE8L0v"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4774193fdffso98700201cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 01 Apr 2025 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743571419; x=1744176219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//DbTDEcSvt5t441A9CDCqGLvkxicVZgky98zyXoT0s=;
        b=f+oE8L0v2GR++FZtQQDdGmFdkCZ8Y7TrP+5YTcJLke0QmuaVevG6ve039nGVv5z1Q5
         ZJoTCnjdSjHFYhMnduaI1fJtJ7R87AHu9Spz7vXALWfpwuhaLCD6RyN+GxRQdlxYa1mE
         du5dT5zYdv6B12fy0vC5BeUO1aY9zsZYtFdihIQOKitXo+nUAmuWX8seGAJqjDauMs7C
         z/XqahbctlszYvNOkrz0ZQ2QDq6tzDUrmOedhtURTJHcMp8+Y5ss1zD+hfQNXATsQo3H
         6fia3jBNgJkUogQGQOmg2wPxpLAzif1FdLB/xhoNF7N42GK2ixAYF1Sique7blAcBdXH
         t5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743571419; x=1744176219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//DbTDEcSvt5t441A9CDCqGLvkxicVZgky98zyXoT0s=;
        b=Iwx07qgmUbTLL2x5DzeCOZXhcFh7NhEfiD/Xng015qoVeRaBsmxw3PuVDdDPt1Bt23
         Y4mYST8tJf7YxwaDHZijoxH7UJrXV5NhXMBGkEuflAotJiCHItsEewUmahJ7fM/2WVGt
         Ng9hd1jAidFkLK190rV4VR9lF+IYYeTlqvAkoMyLCaib8iidSryuqVjrtq2N7DZfdRnS
         oPJWgaWkYc2eVuXRIU1/ukhO+uV4bVmByuDByJCvVaOP64A88o1ZGwAtG9Se19qRG4NC
         w3YO/BvqOl5rGCse8gKAoPh6tof2xtVQIHQt/y8ZVmyKJVNdwO4XIyaBnecRctHY+2U2
         3vIg==
X-Forwarded-Encrypted: i=1; AJvYcCVp3JmJWsKoHkpEet3mquX9T5PY7zE+IseFDleSn+S5t81tQTl6cdBsgKOoo2A+wr5Iembv4NqqPjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyobYYahi7TcAWaIzho51+3iHjTdUo+K3a/Y+z+8gcQcrqNU9GD
	NFVRF7xjg0gvknJ1C+WqI+y7ake7sNarYfwGCWnKNgJpKPnDZfbaBxZEPbTDfhY=
X-Gm-Gg: ASbGnctSPKUAKEPNKOkLYP08hDxarrl2CJH4lRaNX6sU97duNic1QEBKSdJheAEupdr
	uDWsyd0JgqVx7zlD9ocGxKQY5o1GQeSCK+CASnhcRbWLVA3FWc9AolndVH3aVvV+Hyqo0UINaQz
	A6vl6vY10kRVeANAls0smfjUHXmdzYeBOr2oiOlJlfpMjW+X1rEazgPo3RUhe1vcKAU3+njpZ6V
	JoRKLyS7bGLUZFj2lk7i9nOpNAA1WARhnm/uY1lqyBLe1TErKhg6t25hNVFsGa4hoAManMbrje8
	htlEi8RdnAdembSzGeb3okvB9rH9+TlTLtyZ1V4KQag4iVCJSl+TlKS0DtZGTlD21TdP5NB8viC
	j/thKhvHz4B/kIHR9nUKcZHbaj9s=
X-Google-Smtp-Source: AGHT+IFsnRLFii7aJks49fGZdpRukd6mP6AgJi3iKowJwSiUR6ljlZas0sjb3UYH+V9YHKOEbrIUgw==
X-Received: by 2002:ac8:5712:0:b0:476:8fcb:9aa3 with SMTP id d75a77b69052e-477e4b59073mr247210131cf.13.1743571419473;
        Tue, 01 Apr 2025 22:23:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-477831a4472sm75294181cf.75.2025.04.01.22.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 22:23:39 -0700 (PDT)
Date: Wed, 2 Apr 2025 01:23:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>, Rakie Kim <rakie.kim@sk.com>,
	kernel_team@skhynix.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v5 3/3] mm/mempolicy: Support memory hotplug in weighted
 interleave
Message-ID: <Z-zJ2YlvXtP4ziyH@gourry-fedora-PF4VCD3F>
References: <20250402014906.1086-1-rakie.kim@sk.com>
 <20250402014906.1086-4-rakie.kim@sk.com>
 <5462e706-5b29-495d-9af9-1945e8a5445e@sk.com>
 <20250401213439.4e7a124d94aa42603d31d45e@linux-foundation.org>
 <Z-zIBM4zQ0LbGPYZ@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-zIBM4zQ0LbGPYZ@gourry-fedora-PF4VCD3F>

On Wed, Apr 02, 2025 at 01:15:48AM -0400, Gregory Price wrote:
> On Tue, Apr 01, 2025 at 09:34:39PM -0700, Andrew Morton wrote:
> > 
> > Do we need to backport all three patches into -stable?  If so, all three
> > should have Fixes:.  Preferably they all have the same Fixes: so we
> > aren't backporting untested patch combinations.
> >
> 
> Patches 2 and 3 aren't fixes, they're desired behavioral changes
> to the feature. An interface being confusing doesn't mean it's broken.
>

Just some added clarity:

The behavioral change in sysfs change goes from N_POSSIBLE nodes always
being exposed - to sysfs entries coming and going as nodes transition
between having memory and not having memory.

I can see the argument for wanting this backported as a fix to ensure
userspace software is consistent across LTS.

So for backporting: all or nothing - and all the fixes tags should be
the same.

~Gregory
